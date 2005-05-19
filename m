From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [patch 2/9]Four new i2c drivers and __init/__exit cleanup to i2c
Message-Id: <3D85E7E8.5EEC1499@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This specific change set was for i2c-pport.c and 2.5.34.
I propose the following changes to satisfy 2.5 kernel
requirements.  Of course the #include changes and 
MODULE_LICENSE will not be checked into CVS.

The request to abandon udelay for sleep was not addressed.

Anyone see a problem with 2.2 or 2.4 and these changes?
Regards,
Albert
--- i2c-pport.c 2002-09-12 02:55:47.000000000 -0400
+++ /usr/src/linux/drivers/i2c/i2c-pport.c      2002-09-16 09:30:00.000000000 -0400
@@ -36,12 +36,10 @@
 #include <linux/ioport.h>
 #include <asm/io.h>
 #include <linux/errno.h>
-#include "i2c.h"
-#include "i2c-algo-bit.h"
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
 
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
-#endif
 
 #define DEFAULT_BASE 0x378
 static int base=0;
@@ -112,9 +110,7 @@
 
 static int bit_pport_init(void)
 {
-       //release_region( (base+2) ,1);
-
-       if (check_region((base+2),1) < 0 ) {
+       if (request_region((base+2),1, "i2c (PPORT adapter)") < 0 ) {
                return -ENODEV; 
        } else {
 
@@ -148,11 +144,6 @@
        return 0;
 }
 
-static void __exit bit_pport_exit(void)
-{
-       release_region((base+2),1);
-}
-
 static int bit_pport_reg(struct i2c_client *client)
 {
        return 0;
@@ -231,24 +222,16 @@
 }
 
 
-EXPORT_NO_SYMBOLS;
+static void __exit i2c_bitpport_exit(void)
+{
+       i2c_bit_del_bus(&bit_pport_ops);
+       release_region((base+2),1);
+}
 
-#ifdef MODULE
 MODULE_AUTHOR("Daniel Smolik <marvin@sitour.cz>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for Primitive parallel port adapter")
 ;
-
 MODULE_PARM(base, "i");
 
-int init_module(void)
-{
-       return i2c_bitpport_init();
-}
-
-void cleanup_module(void)
-{
-       i2c_bit_del_bus(&bit_pport_ops);
-       bit_pport_exit();
-}
-
-#endif
+module_init(i2c_bitpport_init);
+module_exit(i2c_bitpport_exit);

Jeff Garzik wrote:
> 
> Albert Cranford wrote:
> 
> > +#ifdef MODULE_LICENSE
> > +MODULE_LICENSE("GPL");
> > +#endif
> 
> kill the ifdef
> 
> > +static int bit_pport_init(void)
> > +{
> > +     //release_region( (base+2) ,1);
> > +
> > +     if (check_region((base+2),1) < 0 ) {
> 
> wrong.  race.  use request_region, and check its return value.
> check_region should never be used.
> 
> > +             return -ENODEV;
> > +     } else {
> > +
> > +             /* test for PPORT adap.         */
> > +
> > +
> > +             PortData=inb(base+2);
> > +             PortData= (PortData SET_SDA) SET_SCL;
> > +             outb(PortData,base+2);
> > +
> > +             if (!(inb(base+2) | 0x06)) {    /* SDA and SCL will be high     */
> > +                     DEBINIT(printk("i2c-pport.o: SDA and SCL was low.\n"));
> > +                     return -ENODEV;
> > +             } else {
> > +
> > +                     /*SCL high and SDA low*/
> > +                     PortData = PortData SET_SCL CLR_SDA;
> > +                     outb(PortData,base+2);
> > +                     udelay(400);
> 
> long udelay in process context, where you should sleep instead
> 
> > +static void bit_pport_inc_use(struct i2c_adapter *adap)
> > +{
> > +#ifdef MODULE
> > +     MOD_INC_USE_COUNT;
> > +#endif
> > +}
> > +
> > +static void bit_pport_dec_use(struct i2c_adapter *adap)
> > +{
> > +#ifdef MODULE
> > +     MOD_DEC_USE_COUNT;
> > +#endif
> 
> kill the ifdef.  use ->owner instead if possible.
> 
> > +#ifdef MODULE
> > +MODULE_AUTHOR("Daniel Smolik <marvin@sitour.cz>");
> > +MODULE_DESCRIPTION("I2C-Bus adapter routines for Primitive parallel port adapter")
> > +;
> > +
> > +MODULE_PARM(base, "i");
> > +
> > +int init_module(void)
> > +{
> > +     return i2c_bitpport_init();
> > +}
> > +
> > +void cleanup_module(void)
> > +{
> > +     i2c_bit_del_bus(&bit_pport_ops);
> > +     bit_pport_exit();
> > +}
> > +
> > +#endif
> 
> kill the ifdef, use module_init, module_exit

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
