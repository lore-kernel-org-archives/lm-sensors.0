From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Oct 2009 15:10:54 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627hf) Drop the force_addr module
Message-Id: <20091001171054.423028f8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This module parameter is there to workaround broken BIOS. I'm not even
sure if it was used in the past 5 years, and it gets in the way of
converting the driver to the MFD infrastructure. So tell the users how
they can do the same from user-space.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Rodolfo Giometti <giometti@linux.it>
---
 Documentation/hwmon/w83627hf |   29 +++++++++++++++++++++++++++--
 drivers/hwmon/w83627hf.c     |   11 -----------
 2 files changed, 27 insertions(+), 13 deletions(-)

--- linux-2.6.32-rc1.orig/Documentation/hwmon/w83627hf	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-rc1/Documentation/hwmon/w83627hf	2009-10-01 15:36:04.000000000 +0200
@@ -32,8 +32,6 @@ Authors:
 Module Parameters
 -----------------
 
-* force_addr: int
-  Initialize the ISA address of the sensors
 * force_i2c: int
   Initialize the I2C address of the sensors
 * init: int
@@ -70,3 +68,30 @@ doesn't help, you may just ignore the bo
 For further information on this driver see the w83781d driver documentation.
 
 [1] http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/vid
+
+Forcing the address
+-------------------
+
+The driver used to have a module parameter named force_addr, which could
+be used to force the base I/O address of the hardware monitoring block.
+This was meant as a workaround for mainboards with a broken BIOS. This
+module parameter is gone for technical reasons. If you need this feature,
+you can obtain the same result by using the isaset tool (part of
+lm-sensors) before loading the driver:
+
+# Enter the Super I/O config space
+isaset -y -f 0x2e 0x87
+isaset -y -f 0x2e 0x87
+
+# Select the hwmon logical device
+isaset -y 0x2e 0x2f 0x07 0x0b
+
+# Set the base I/O address (to 0x290 in this example)
+isaset -y 0x2e 0x2f 0x60 0x02
+isaset -y 0x2e 0x2f 0x61 0x90
+
+# Exit the Super-I/O config space
+isaset -y -f 0x2e 0xaa
+
+The above sequence assumes a Super-I/O config space at 0x2e/0x2f, but
+0x4e/0x4f is also possible.
--- linux-2.6.32-rc1.orig/drivers/hwmon/w83627hf.c	2009-10-01 15:28:30.000000000 +0200
+++ linux-2.6.32-rc1/drivers/hwmon/w83627hf.c	2009-10-01 15:36:01.000000000 +0200
@@ -59,10 +59,6 @@ static struct platform_device *pdev;
 #define DRVNAME "w83627hf"
 enum chips { w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
 
-static u16 force_addr;
-module_param(force_addr, ushort, 0);
-MODULE_PARM_DESC(force_addr,
-		 "Initialize the base address of the sensors");
 static u8 force_i2c = 0x1f;
 module_param(force_i2c, byte, 0);
 MODULE_PARM_DESC(force_i2c,
@@ -1169,13 +1165,6 @@ static int __init w83627hf_find(int sioa
 	}
 
 	superio_select(W83627HF_LD_HWM);
-	force_addr &= WINB_ALIGNMENT;
-	if (force_addr) {
-		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
-		       force_addr);
-		superio_outb(WINB_BASE_REG, force_addr >> 8);
-		superio_outb(WINB_BASE_REG + 1, force_addr & 0xff);
-	}
 	val = (superio_inb(WINB_BASE_REG) << 8) |
 	       superio_inb(WINB_BASE_REG + 1);
 	*addr = val & WINB_ALIGNMENT;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
