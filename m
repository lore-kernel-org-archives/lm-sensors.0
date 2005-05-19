From: akpm@osdl.org (Andrew Morton)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <20050322131056.41e94b40.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> Unable to haUnable to handle kernel paging request at virtual address f8e813d4
>  c020c94d
>  *pde = 00000000
>  Oops: 0002 [#1]
>  CPU:     0
>  EIP:      0060:[<c020c94d>}    Not tainted VLI
>  Using defaults from ksymoops -t elf32-i386 -a i386
>  EFLAGS: 00010202   (2.6.12-rc1)
>  eax: f8e81000 ebx: f7c00240 ecx: f7c00538 edx: 0000003f
>  esi: 00000001 edi: 00000001 epb: f7c21db0 esp: f7c21da8
>  Warning (Oops_set_regs): garbage 'epb: f7c21db0 esp: f7c21da8' at end
>  of register line ignored
>  ds: 007b es: 007b ss: 0068
>  Stack: f7c00708 00000001 f7c21dc4 c027f225 f7c00538 00000000 f7c00540 f7c21e20
>             c027fcca f7c00708 00000000 f7c21e35 ffffffff c0334220
>  30000000 f7c23530
>             f7c21e08 c0115d41 c17fca20 f7c21e08 c17fca20 00000086
>  f7c21e20 f7c00540
>  Call trace:
>  [<c010400f>] show_stack+0x7f/0xa0
>  [<c01041aa>] show_registers+0x15a/0x1c0
>  [<c01043ac>] die+0xfc/0x190
>  [<c011438b>] do_page_fault+0x31b/0x670
>  [<c0103c43>] error_code+0x2b/0x30
>  [<c027f225>] i2c_start+0x25/0x60
>  [<c027fcca>] bit_xfer+0x1a/0x690
>  [<c027bb88>] i2c_transfer+0x68/0xb0
>  [<c027cb79>] i2c_smbus_xfer_emulated+0xb9/0x3b0
>  [<c027cf9f>] i2c_smbus_xfer+0x12f/0x220
>  [<c027e0ba>] i2c_detect+0x23a/0x500
>  [<c027ef91>] eeprom_attach_adapter+0x21/0x30
>  [<c027b243>] i2c_add_driver+0xd3/0x100
>  [<c0466452>] eeprom_init+0x12/0x40
>  [<c044c8ab>] do_initcalls+0x2b/0xc0
>  [<c0100302>] init+0x32/0x130
>  [<c0101301>] kernel_thread_helper+0x5/0x14

aargh.  That's a totally different crash :(

Were you using this patch?


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
