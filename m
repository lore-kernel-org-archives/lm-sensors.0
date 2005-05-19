From: akpm@osdl.org (Andrew Morton)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <20050321224137.1bb92f5b.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> On Fri, 18 Mar 2005 13:07:08 +0100 (CET), Jean Delvare
> <khali@linux-fr.org> wrote:
> 
> > Miles, could you please try to modify your oopsing configuration in the
> > following way:
> >   CONFIG_I2C_CHARDEV=n
> >   CONFIG_SENSORS_EEPROM=y
> > I would expect if to oops in i2c_add_driver() as well.
> 
> I had to copy this by hand, but I think I got it all down correctly.

Is worthwhile.

> 
> >>EIP; c02f094f <i2c_detect+f/500>   <==> 
> >>ebx; f7c076fc <pg0+376a46fc/3fa9b400>
> >>edx; f7c07558 <pg0+376a4558/3fa9b400>
> >>esi; c047c8e0 <eeprom_driver+0/e0>
> 
> Trace; c0104d7f <show_stack+7f/a0>
> Trace; c0104f1a <show_registers+15a/1c0>
> Trace; c0105184 <die+164/2e0>
> Trace; c0119936 <do_page_fault+356/68d>
> Trace; c0104853 <error_code+4f/54>
> Trace; c02f1aa1 <eeprom_attach_adapter+21/30>
> Trace; c02ee704 <i2c_add_driver+b4/e0>
> Trace; c050a652 <eeprom_init+12/40>
> Trace; c04ee8ab <do_initcalls+2b/c0>
> Trace; c0100302 <init+32/130>
> Trace; c0101351 <kernel_thread_helper+5/14>

Ah.  adapter->algo is NULL in i2c_detect().  I don't think i2c_adapters are
allowed to do that.  It could have been any old adapter, registered at some
earlier time.


If I'm right, this debug patch should point us at the culprit.

diff -puN drivers/i2c/i2c-core.c~a drivers/i2c/i2c-core.c
--- 25/drivers/i2c/i2c-core.c~a	2005-03-21 22:38:00.000000000 -0800
+++ 25-akpm/drivers/i2c/i2c-core.c	2005-03-21 22:39:27.000000000 -0800
@@ -150,6 +150,13 @@ int i2c_add_adapter(struct i2c_adapter *
 	struct list_head   *item;
 	struct i2c_driver  *driver;
 
+	if (adap->algo = NULL) {
+		printk("%s: adap->algo is NULL\n", __FUNCTION__);
+		dump_stack();
+		for ( ; ; )
+			;
+	}
+
 	down(&core_lists);
 
 	if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) = 0) {
_

