From: ac9410@bellsouth.net (Albert Cranford)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: [PATCH] 4/4 WIP I2C kernel patches-Makefile and necessary changes
Message-Id: <3CE20B62.1164BAB7@bellsouth.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Patch 4 implements name changes in the Makefile and export
necessary to get elektor.c and philips-par.c to compile inline.
It also fixes compile error in algo-bit.c, renaming
current->need_resched to need_resched.
It also fixes warning in elv.c and velleman.c if compiled
as a module.
--- linux/drivers/i2c/Makefile.orig     2002-05-09 18:21:38.000000000 -0400
+++ linux/drivers/i2c/Makefile  2002-05-14 23:04:24.000000000 -0400
@@ -5,16 +5,16 @@
 O_TARGET := i2c.o
 
 export-objs    := i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
-                  i2c-algo-ite.o i2c-proc.o
+                  i2c-algo-ite.o i2c-proc.o i2c-philips-par.o i2c-elektor.o
 
 obj-$(CONFIG_I2C)              += i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)      += i2c-dev.o
 obj-$(CONFIG_I2C_ALGOBIT)      += i2c-algo-bit.o
-obj-$(CONFIG_I2C_PHILIPSPAR)   += i2c-philips-par.o
-obj-$(CONFIG_I2C_ELV)          += i2c-elv.o
-obj-$(CONFIG_I2C_VELLEMAN)     += i2c-velleman.o
+obj-$(CONFIG_I2C_BITLP)        +=      i2c-philips-par.o
+obj-$(CONFIG_I2C_BITELV)       += i2c-elv.o
+obj-$(CONFIG_I2C_BITVELLE)     += i2c-velleman.o
 obj-$(CONFIG_I2C_ALGOPCF)      += i2c-algo-pcf.o
-obj-$(CONFIG_I2C_ELEKTOR)      += i2c-elektor.o
+obj-$(CONFIG_I2C_PCFISA)       += i2c-elektor.o
 obj-$(CONFIG_ITE_I2C_ALGO)     += i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)     += i2c-adap-ite.o
 obj-$(CONFIG_I2C_PROC)         += i2c-proc.o
--- linux/drivers/i2c/i2c-elektor.c.orig        2002-05-14 23:14:40.000000000 -0400
+++ linux/drivers/i2c/i2c-elektor.c     2002-05-14 23:10:11.000000000 -0400
@@ -295,10 +295,9 @@
 
        return 0;
 }
+EXPORT_SYMBOL(i2c_pcfisa_init);
 
 
-EXPORT_NO_SYMBOLS;
-
 #ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
--- linux/drivers/i2c/i2c-philips-par.c.orig    2002-05-14 23:14:40.000000000 -0400
+++ linux/drivers/i2c/i2c-philips-par.c 2002-05-14 23:10:15.000000000 -0400
@@ -277,6 +277,7 @@
        
        return 0;
 }
+EXPORT_SYMBOL(i2c_bitlp_init);
 
 void __exit i2c_bitlp_exit(void)
 {
@@ -289,8 +290,6 @@
 #endif
 }
 
-EXPORT_NO_SYMBOLS;
-
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for Philips parallel port adapter");
 #ifdef MODULE_LICENSE
--- linux/drivers/i2c/i2c-algo-bit.c.orig       2002-05-15 00:50:12.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-bit.c    2002-05-15 00:55:28.000000000 -0400
@@ -119,8 +119,7 @@
                if (start+adap->timeout <= jiffies) {
                        return -ETIMEDOUT;
                }
-               if (current->need_resched)
-                       schedule();
+               if (need_resched) schedule();
        }
        DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
 #ifdef SLO_IO
--- linux/drivers/i2c/i2c-elv.c.orig    2002-05-15 00:59:01.000000000 -0400
+++ linux/drivers/i2c/i2c-elv.c 2002-05-15 00:59:30.000000000 -0400
@@ -113,10 +113,12 @@
        return 0;
 }
 
+#ifdef MODULE
 static void bit_elv_exit(void)
 {
        release_region( base , (base = 0x3bc)? 3 : 8 );
 }
+#endif
 
 static int bit_elv_reg(struct i2c_client *client)
 {
--- linux/drivers/i2c/i2c-velleman.c.orig       2002-05-15 01:00:52.000000000 -0400
+++ linux/drivers/i2c/i2c-velleman.c    2002-05-15 01:01:20.000000000 -0400
@@ -102,10 +102,12 @@
        return 0;
 }
 
+#ifdef MODULE
 static void bit_velle_exit(void)
 {      
        release_region( base , (base = 0x3bc)? 3 : 8 );
 }
+#endif
 
 
 static int bit_velle_reg(struct i2c_client *client)
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
