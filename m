From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 22:21:17 +0000
Subject: [lm-sensors] [PATCH 16/16] hwmon: smsc47m1 documentation update
Message-Id: <20051026222124.66f6138e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-smsc47m1-mention-47m997.patch

The SMSC LPC47M997 Super-I/O chip seems to be compatible with the
LPC47M192, so it is supported by the smsc47m1 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 Documentation/hwmon/smsc47m1 |    7 +++++++
 drivers/hwmon/smsc47m1.c     |    7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc5.orig/Documentation/hwmon/smsc47m1	2005-08-29 20:34:46.000000000 +0200
+++ linux-2.6.14-rc5/Documentation/hwmon/smsc47m1	2005-10-24 19:19:11.000000000 +0200
@@ -12,6 +12,10 @@
         http://www.smsc.com/main/datasheets/47m14x.pdf
         http://www.smsc.com/main/tools/discontinued/47m15x.pdf
         http://www.smsc.com/main/datasheets/47m192.pdf
+  * SMSC LPC47M997
+    Addresses scanned: none, address read from Super I/O config space
+    Prefix: 'smsc47m1'
+    Datasheet: none
 
 Authors:
         Mark D. Studebaker <mdsxyz123@yahoo.com>,
@@ -30,6 +34,9 @@
 in addition to the fan monitoring and control. The hardware monitoring
 block is not supported by the driver.
 
+No documentation is available for the 47M997, but it has the same device
+ID as the 47M15x and 47M192 chips and seems to be compatible.
+
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
 triggered if the rotation speed has dropped below a programmable limit. Fan
 readings can be divided by a programmable divider (1, 2, 4 or 8) to give
--- linux-2.6.14-rc5.orig/drivers/hwmon/smsc47m1.c	2005-10-23 17:35:35.000000000 +0200
+++ linux-2.6.14-rc5/drivers/hwmon/smsc47m1.c	2005-10-24 19:19:12.000000000 +0200
@@ -3,7 +3,7 @@
                  for hardware monitoring
 
     Supports the SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x,
-    LPC47M15x and LPC47M192 Super-I/O chips.
+    LPC47M15x, LPC47M192 and LPC47M997 Super-I/O chips.
 
     Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
     Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
@@ -356,6 +356,8 @@
 	 * 0x5F) and LPC47B27x (device id 0x51) have fan control.
 	 * The LPC47M15x and LPC47M192 chips "with hardware monitoring block"
 	 * can do much more besides (device id 0x60).
+	 * The LPC47M997 is undocumented, but seems to be compatible with
+	 * the LPC47M192, and has the same device id.
 	 */
 	if (val = 0x51)
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47B27x\n");
@@ -364,7 +366,8 @@
 	else if (val = 0x5F)
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M14x\n");
 	else if (val = 0x60)
-		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M15x/LPC47M192\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC "
+		       "LPC47M15x/LPC47M192/LPC47M997\n");
 	else {
 		superio_exit();
 		return -ENODEV;

-- 
Jean Delvare
