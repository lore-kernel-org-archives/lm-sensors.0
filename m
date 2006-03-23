From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:51 +0000
Subject: [lm-sensors] [PATCH 27/36] i2c: Drop the i2c-frodo bus driver
Message-Id: <11431538312073-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop the i2c-frodo bus driver. It isn't referenced by the build
system, and depends on code which was never included in 2.6 kernels.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/i2c-frodo.c |   85 ----------------------------------------
 include/linux/i2c-id.h         |    1 
 2 files changed, 0 insertions(+), 86 deletions(-)
 delete mode 100644 drivers/i2c/busses/i2c-frodo.c

2f27f46c49c096d86e7e63acd43cad3bc42f2383
diff --git a/drivers/i2c/busses/i2c-frodo.c b/drivers/i2c/busses/i2c-frodo.c
deleted file mode 100644
index b6f52f5..0000000
--- a/drivers/i2c/busses/i2c-frodo.c
+++ /dev/null
@@ -1,85 +0,0 @@
-
-/*
- * linux/drivers/i2c/i2c-frodo.c
- *
- * Author: Abraham van der Merwe <abraham at 2d3d.co.za>
- *
- * An I2C adapter driver for the 2d3D, Inc. StrongARM SA-1110
- * Development board (Frodo).
- *
- * This source code is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-#include <asm/hardware.h>
-
-
-static void frodo_setsda (void *data,int state)
-{
-	if (state)
-		FRODO_CPLD_I2C |= FRODO_I2C_SDA_OUT;
-	else
-		FRODO_CPLD_I2C &= ~FRODO_I2C_SDA_OUT;
-}
-
-static void frodo_setscl (void *data,int state)
-{
-	if (state)
-		FRODO_CPLD_I2C |= FRODO_I2C_SCL_OUT;
-	else
-		FRODO_CPLD_I2C &= ~FRODO_I2C_SCL_OUT;
-}
-
-static int frodo_getsda (void *data)
-{
-	return ((FRODO_CPLD_I2C & FRODO_I2C_SDA_IN) != 0);
-}
-
-static int frodo_getscl (void *data)
-{
-	return ((FRODO_CPLD_I2C & FRODO_I2C_SCL_IN) != 0);
-}
-
-static struct i2c_algo_bit_data bit_frodo_data = {
-	.setsda		= frodo_setsda,
-	.setscl		= frodo_setscl,
-	.getsda		= frodo_getsda,
-	.getscl		= frodo_getscl,
-	.udelay		= 80,
-	.mdelay		= 80,
-	.timeout	= HZ
-};
-
-static struct i2c_adapter frodo_ops = {
-	.owner			= THIS_MODULE,
-	.id			= I2C_HW_B_FRODO,
-	.algo_data		= &bit_frodo_data,
-	.dev			= {
-		.name		= "Frodo adapter driver",
-	},
-};
-
-static int __init i2c_frodo_init (void)
-{
-	return i2c_bit_add_bus(&frodo_ops);
-}
-
-static void __exit i2c_frodo_exit (void)
-{
-	i2c_bit_del_bus(&frodo_ops);
-}
-
-MODULE_AUTHOR ("Abraham van der Merwe <abraham at 2d3d.co.za>");
-MODULE_DESCRIPTION ("I2C-Bus adapter routines for Frodo");
-MODULE_LICENSE ("GPL");
-
-module_init (i2c_frodo_init);
-module_exit (i2c_frodo_exit);
-
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 474c8f4..ec311bc 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -172,7 +172,6 @@
 #define I2C_HW_B_RIVA		0x010010 /* Riva based graphics cards */
 #define I2C_HW_B_IOC		0x010011 /* IOC bit-wiggling */
 #define I2C_HW_B_TSUNA		0x010012 /* DEC Tsunami chipset */
-#define I2C_HW_B_FRODO		0x010013 /* 2d3D SA-1110 Development Board */
 #define I2C_HW_B_OMAHA		0x010014 /* Omaha I2C interface (ARM) */
 #define I2C_HW_B_GUIDE		0x010015 /* Guide bit-basher */
 #define I2C_HW_B_IXP2000	0x010016 /* GPIO on IXP2000 systems */
-- 
1.2.4



