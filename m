From: jalonz@coldworld.net (Jalon Q. Zimmerman)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: lm_sensors2  i2c-nforce2.c  diff to compile with kernel 2.5.74(-mm1)
Message-Id: <3F07A4D6.7020401@coldworld.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I dont know if this has been done already, but I thought it might 
possibly help.

I pulled lm_sensors2 from CVS and modified "i2c-nforce2.c" to compile 
cleanly in kernel 2.5.74-mm1.

I dropped "i2c-nforce2.c" in "/usr/src/linux/drivers/i2c/busses/" and 
hacked the local Makefile to compile it.

I am unable to compile working userspace lm_sensors utils with this 
kernel, so I cant test it. I assume this is normal until a new 
lm_sensors and i2c is released?

This is the first C patch I ever sent anyone so I hope its ok. If I 
could have created the patch with better diff arguments, etc. please let 
me know.

Thanks

:)

Jalon

-------------- next part --------------
--- /usr/local/src/lm_sensors2/kernel/busses/i2c-nforce2.c      2003-06-27 12:15:24.000000000 -0400
+++ /usr/src/linux-2.5.74-mm1/drivers/i2c/busses/i2c-nforce2.c  2003-07-04 23:51:24.000000000 -0400
@@ -41,7 +41,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <asm/io.h>
-#include "version.h"
+#include <linux/version.h>
 
 #ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
@@ -336,7 +336,8 @@
 #ifdef I2C_HW_SMBUS_AMD8111
        smbus->adapter.owner = THIS_MODULE;
 #endif
-       sprintf(smbus->adapter.name, "SMBus nForce2 adapter at %04x", smbus->base);
+
+       snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE, "SMBus nForce2 adapter at %04x", smbus->base);
        smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2;
        smbus->adapter.algo = &smbus_algorithm;
        smbus->adapter.algo_data = smbus;
@@ -409,7 +410,7 @@
 
 int __init nforce2_init(void)
 {
-       printk(KERN_INFO "i2c-nforce2.o version %s (%s)\n", LM_VERSION, LM_DATE);
+       printk(KERN_INFO "i2c-nforce2.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
        return pci_module_init(&nforce2_driver);
 }
