From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: Add support for the LPC47M15x and LPC47M192 chips
Message-Id: <20050426220943.1cabf69d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This simple patch adds support for the SMSC LPC47M15x and LPC47M192
chips to the smsc47m1 hardware monitoring driver. These chips are
compatible with the other ones already supported by the driver, so I see
no reason not to support them, especially when the Linux 2.4 version of
the driver does already.

I also modified the info printks to name the chips by their real name.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/Kconfig    |    2 +-
 drivers/i2c/chips/smsc47m1.c |   10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

Index: linux-2.6.12-rc3/drivers/i2c/chips/smsc47m1.c
=================================--- linux-2.6.12-rc3.orig/drivers/i2c/chips/smsc47m1.c	2005-04-26 22:04:59.000000000 +0200
+++ linux-2.6.12-rc3/drivers/i2c/chips/smsc47m1.c	2005-04-26 22:05:03.000000000 +0200
@@ -372,14 +372,16 @@
 	 * SMSC LPC47M10x/LPC47M13x (device id 0x59), LPC47M14x (device id
 	 * 0x5F) and LPC47B27x (device id 0x51) have fan control.
 	 * The LPC47M15x and LPC47M192 chips "with hardware monitoring block"
-	 * can do much more besides (device id 0x60, unsupported).
+	 * can do much more besides (device id 0x60).
 	 */
 	if (val = 0x51)
-		printk(KERN_INFO "smsc47m1: Found SMSC47B27x\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47B27x\n");
 	else if (val = 0x59)
-		printk(KERN_INFO "smsc47m1: Found SMSC47M10x/SMSC47M13x\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M10x/LPC47M13x\n");
 	else if (val = 0x5F)
-		printk(KERN_INFO "smsc47m1: Found SMSC47M14x\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M14x\n");
+	else if (val = 0x60)
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M15x/LPC47M192\n");
 	else {
 		superio_exit();
 		return -ENODEV;
Index: linux-2.6.12-rc3/drivers/i2c/chips/Kconfig
=================================--- linux-2.6.12-rc3.orig/drivers/i2c/chips/Kconfig	2005-04-24 10:25:41.000000000 +0200
+++ linux-2.6.12-rc3/drivers/i2c/chips/Kconfig	2005-04-26 22:06:02.000000000 +0200
@@ -307,7 +307,7 @@
 	help
 	  If you say yes here you get support for the integrated fan
 	  monitoring and control capabilities of the SMSC LPC47B27x,
-	  LPC47M10x, LPC47M13x and LPC47M14x chips.
+	  LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x and LPC47M192 chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47m1.


-- 
Jean Delvare
