From: akpm@osdl.org (Andrew Morton)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <20050322020826.1c5ca019.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"Jean Delvare" <khali@linux-fr.org> wrote:
>
> 
> Hi Andrew,
> 
> > > >>EIP; c02f094f <i2c_detect+f/500>   <==> > >
> > > >>ebx; f7c076fc <pg0+376a46fc/3fa9b400>
> > > >>edx; f7c07558 <pg0+376a4558/3fa9b400>
> > > >>esi; c047c8e0 <eeprom_driver+0/e0>
> > >
> > > Trace; c0104d7f <show_stack+7f/a0>
> > > Trace; c0104f1a <show_registers+15a/1c0>
> > > Trace; c0105184 <die+164/2e0>
> > > Trace; c0119936 <do_page_fault+356/68d>
> > > Trace; c0104853 <error_code+4f/54>
> > > Trace; c02f1aa1 <eeprom_attach_adapter+21/30>
> > > Trace; c02ee704 <i2c_add_driver+b4/e0>
> > > Trace; c050a652 <eeprom_init+12/40>
> > > Trace; c04ee8ab <do_initcalls+2b/c0>
> > > Trace; c0100302 <init+32/130>
> > > Trace; c0101351 <kernel_thread_helper+5/14>
> >
> > Ah.  adapter->algo is NULL in i2c_detect().
> 
> Forgive a possibly stupid question, but how did you manage to come to
> this conclusion from the stack above alone? Is there any magic I am not
> aware of?

Well it oopsed at one of the first statements in i2c_detect(), and the
faulting address was 0x00000020.  And the offset of i2c_algorithm.id is 32.
So adapter->algo is NULL in i2c_is_isa_adapter().

> My first impression was that the adapter itself was missing, like it had
> been deleted without being removed from the main i2c adapters list.
> 
> Anyway, this test at leasted proved one thing: the i2c-dev driver isn't
> involved in the oops per se. Using a different i2c chip driver (eeprom
> here) triggers it as well. This tends to confirm that the problem is
> related to a specific i2c adapter driver.

I'd say so.

> > I don't think i2c_adapters are allowed to do that.
> 
> Correct, they are not.
> 
> > It could have been any old adapter, registered at some earlier time.
> 
> Except that we have a strong suspicion that it is nvidiafb, instead of
> just any old adapter.

Could be.

> > If I'm right, this debug patch should point us at the culprit.
> 
> I doubt it will help (but let's still try). The nvidiafb i2c adapters
> are added by i2c-algo-bit:i2c_bit_add_bus(), which does set
> adapter->algo to &i2c_bit_algo right before it calls i2c_add_adapter. I
> don't think that algo is NULL when the adapter is added. Rather, it
> becomes NULL later, most possibly because adapter itself point to a now
> gone structure. Just my theory though.

urgh.  That explains why the patch didn't work.

Miles, there's a new debug patch below.

> Maybe it would help if Miles could give a try to Tony's patch here and
> report?
> http://archives.andrew.net.au/lm-sensors/msg30044.html

That too.

 25-akpm/drivers/i2c/algos/i2c-algo-bit.c |    6 ++++--
 25-akpm/drivers/i2c/i2c-core.c           |   12 ++++++++++--
 25-akpm/include/linux/i2c-algo-bit.h     |    3 ++-
 25-akpm/include/linux/i2c.h              |    6 +++++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff -puN include/linux/i2c.h~i2c-debugging include/linux/i2c.h
--- 25/include/linux/i2c.h~i2c-debugging	2005-03-22 02:02:53.000000000 -0800
+++ 25-akpm/include/linux/i2c.h	2005-03-22 02:06:50.000000000 -0800
@@ -244,6 +244,8 @@ struct i2c_adapter {
 	char name[I2C_NAME_SIZE];
 	struct completion dev_released;
 	struct completion class_dev_released;
+	char *file;
+	int line;
 };
 #define dev_to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 #define class_dev_to_i2c_adapter(d) container_of(d, struct i2c_adapter, class_dev)
@@ -314,7 +316,9 @@ struct i2c_client_address_data {
 
 /* administration...
  */
-extern int i2c_add_adapter(struct i2c_adapter *);
+#define i2c_add_adapter(a) __i2c_add_adapter(__FILE__, __LINE__, a)
+
+extern int __i2c_add_adapter(char *file, int line, struct i2c_adapter *);
 extern int i2c_del_adapter(struct i2c_adapter *);
 
 extern int i2c_add_driver(struct i2c_driver *);
diff -puN drivers/i2c/i2c-core.c~i2c-debugging drivers/i2c/i2c-core.c
--- 25/drivers/i2c/i2c-core.c~i2c-debugging	2005-03-22 02:02:53.000000000 -0800
+++ 25-akpm/drivers/i2c/i2c-core.c	2005-03-22 02:02:53.000000000 -0800
@@ -144,12 +144,15 @@ static struct device_attribute dev_attr_
  * when a new hw adapter registers. A new device is register to be
  * available for clients.
  */
-int i2c_add_adapter(struct i2c_adapter *adap)
+int __i2c_add_adapter(char *file, int line, struct i2c_adapter *adap)
 {
 	int id, res = 0;
 	struct list_head   *item;
 	struct i2c_driver  *driver;
 
+	adap->file = file;
+	adap->line = line;
+
 	down(&core_lists);
 
 	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) = 0) {
@@ -310,6 +313,11 @@ int i2c_add_driver(struct i2c_driver *dr
 	if (driver->flags & I2C_DF_NOTIFY) {
 		list_for_each(item,&adapters) {
 			adapter = list_entry(item, struct i2c_adapter, list);
+			printk("%s:%d: %p\n", adapter->file, adapter->line,
+					adapter->algo);
+			if (adapter->algo = NULL)
+				for ( ; ; )
+					;
 			driver->attach_adapter(adapter);
 		}
 	}
@@ -1246,7 +1254,7 @@ int i2c_check_functionality (struct i2c_
 	return (func & adap_func) = func;
 }
 
-EXPORT_SYMBOL(i2c_add_adapter);
+EXPORT_SYMBOL(__i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
 EXPORT_SYMBOL(i2c_del_driver);
diff -puN drivers/i2c/algos/i2c-algo-bit.c~i2c-debugging drivers/i2c/algos/i2c-algo-bit.c
--- 25/drivers/i2c/algos/i2c-algo-bit.c~i2c-debugging	2005-03-22 02:03:15.000000000 -0800
+++ 25-akpm/drivers/i2c/algos/i2c-algo-bit.c	2005-03-22 02:04:31.000000000 -0800
@@ -528,10 +528,12 @@ static struct i2c_algorithm i2c_bit_algo
 /* 
  * registering functions to load algorithms at runtime 
  */
-int i2c_bit_add_bus(struct i2c_adapter *adap)
+int __i2c_bit_add_bus(char *file, int line, struct i2c_adapter *adap)
 {
 	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
 
+	adap->file = file;
+	adap->line = line;
 	if (bit_test) {
 		int ret = test_bus(bit_adap, adap->name);
 		if (ret<0)
@@ -558,7 +560,7 @@ int i2c_bit_del_bus(struct i2c_adapter *
 	return i2c_del_adapter(adap);
 }
 
-EXPORT_SYMBOL(i2c_bit_add_bus);
+EXPORT_SYMBOL(__i2c_bit_add_bus);
 EXPORT_SYMBOL(i2c_bit_del_bus);
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
diff -puN include/linux/i2c-algo-bit.h~i2c-debugging include/linux/i2c-algo-bit.h
--- 25/include/linux/i2c-algo-bit.h~i2c-debugging	2005-03-22 02:03:33.000000000 -0800
+++ 25-akpm/include/linux/i2c-algo-bit.h	2005-03-22 02:05:08.000000000 -0800
@@ -48,7 +48,8 @@ struct i2c_algo_bit_data {
 
 #define I2C_BIT_ADAP_MAX	16
 
-int i2c_bit_add_bus(struct i2c_adapter *);
+#define i2c_bit_add_bus(a) __i2c_bit_add_bus(__FILE__, __LINE__, a)
+int __i2c_bit_add_bus(char *file, int line, struct i2c_adapter *);
 int i2c_bit_del_bus(struct i2c_adapter *);
 
 #endif /* _LINUX_I2C_ALGO_BIT_H */
_
