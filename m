From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:15:50 +0000
Subject: [lm-sensors] [PATCH] hwmon: smsc47m1 documentation update
Message-Id: <11305336643038@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: smsc47m1 documentation update

The SMSC LPC47M997 Super-I/O chip seems to be compatible with the
LPC47M192, so it is supported by the smsc47m1 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b890a07f7b002ee473986fa85ae3582de399a4cf
tree d29b5a2d41d0a6ce7b5da57576cb876f53e29eac
parent 90209b42d0498d57a804bf81fea427bf39c5315c
author Jean Delvare <khali@linux-fr.org> Wed, 26 Oct 2005 22:21:24 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:14 -0700

 Documentation/hwmon/smsc47m1 |    7 +++++++
 drivers/hwmon/smsc47m1.c     |    7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/smsc47m1 b/Documentation/hwmon/smsc47m1
index 34e6478..c15bbe6 100644
--- a/Documentation/hwmon/smsc47m1
+++ b/Documentation/hwmon/smsc47m1
@@ -12,6 +12,10 @@ Supported chips:
         http://www.smsc.com/main/datasheets/47m14x.pdf
         http://www.smsc.com/main/tools/discontinued/47m15x.pdf
         http://www.smsc.com/main/datasheets/47m192.pdf
+  * SMSC LPC47M997
+    Addresses scanned: none, address read from Super I/O config space
+    Prefix: 'smsc47m1'
+    Datasheet: none
 
 Authors:
         Mark D. Studebaker <mdsxyz123@yahoo.com>,
@@ -30,6 +34,9 @@ The 47M15x and 47M192 chips contain a fu
 in addition to the fan monitoring and control. The hardware monitoring
 block is not supported by the driver.
 
+No documentation is available for the 47M997, but it has the same device
+ID as the 47M15x and 47M192 chips and seems to be compatible.
+
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
 triggered if the rotation speed has dropped below a programmable limit. Fan
 readings can be divided by a programmable divider (1, 2, 4 or 8) to give
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index bbe93a0..5905c1a 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -3,7 +3,7 @@
                  for hardware monitoring
 
     Supports the SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x,
-    LPC47M15x and LPC47M192 Super-I/O chips.
+    LPC47M15x, LPC47M192 and LPC47M997 Super-I/O chips.
 
     Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
     Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
@@ -356,6 +356,8 @@ static int __init smsc47m1_find(unsigned
 	 * 0x5F) and LPC47B27x (device id 0x51) have fan control.
 	 * The LPC47M15x and LPC47M192 chips "with hardware monitoring block"
 	 * can do much more besides (device id 0x60).
+	 * The LPC47M997 is undocumented, but seems to be compatible with
+	 * the LPC47M192, and has the same device id.
 	 */
 	if (val = 0x51)
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47B27x\n");
@@ -364,7 +366,8 @@ static int __init smsc47m1_find(unsigned
 	else if (val = 0x5F)
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M14x\n");
 	else if (val = 0x60)
-		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M15x/LPC47M192\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC "
+		       "LPC47M15x/LPC47M192/LPC47M997\n");
 	else {
 		superio_exit();
 		return -ENODEV;

