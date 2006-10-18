From: greg@kroah.com (Greg KH)
Date: Wed, 18 Oct 2006 20:09:35 +0000
Subject: [lm-sensors] [PATCH 4/8] smsc47m1: List the SMSC LPC47M112 as
Message-Id: <1161202189122-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

The SMSC LPC47M112 Super-I/O chip appears to be compatible with the
LPC47M10x and LPC47M13x as far as hardware monitoring is concerned.
The device ID is even the same, so it's really only a documentation
update.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/hwmon/smsc47m1 |    4 +++-
 drivers/hwmon/Kconfig        |    4 ++--
 drivers/hwmon/smsc47m1.c     |   11 ++++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/smsc47m1 b/Documentation/hwmon/smsc47m1
index c15bbe6..04a1112 100644
--- a/Documentation/hwmon/smsc47m1
+++ b/Documentation/hwmon/smsc47m1
@@ -2,12 +2,14 @@ Kernel driver smsc47m1
 ===========
 
 Supported chips:
-  * SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x and LPC47M192
+  * SMSC LPC47B27x, LPC47M112, LPC47M10x, LPC47M13x, LPC47M14x,
+    LPC47M15x and LPC47M192
     Addresses scanned: none, address read from Super I/O config space
     Prefix: 'smsc47m1'
     Datasheets:
         http://www.smsc.com/main/datasheets/47b27x.pdf
         http://www.smsc.com/main/datasheets/47m10x.pdf
+        http://www.smsc.com/main/datasheets/47m112.pdf
         http://www.smsc.com/main/tools/discontinued/47m13x.pdf
         http://www.smsc.com/main/datasheets/47m14x.pdf
         http://www.smsc.com/main/tools/discontinued/47m15x.pdf
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9b88b25..e0dede7 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -369,8 +369,8 @@ config SENSORS_SMSC47M1
 	help
 	  If you say yes here you get support for the integrated fan
 	  monitoring and control capabilities of the SMSC LPC47B27x,
-	  LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x, LPC47M192 and
-	  LPC47M997 chips.
+	  LPC47M10x, LPC47M112, LPC47M13x, LPC47M14x, LPC47M15x,
+	  LPC47M192 and LPC47M997 chips.
 
 	  The temperature and voltage sensor features of the LPC47M192
 	  and LPC47M997 are supported by another driver, select also
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 47132fd..beb881c 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -2,8 +2,8 @@
     smsc47m1.c - Part of lm_sensors, Linux kernel modules
                  for hardware monitoring
 
-    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x,
-    LPC47M15x, LPC47M192 and LPC47M997 Super-I/O chips.
+    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M112, LPC47M13x,
+    LPC47M14x, LPC47M15x, LPC47M192 and LPC47M997 Super-I/O chips.
 
     Copyright (C) 2002 Mark D. Studebaker <mdsxyz123 at yahoo.com>
     Copyright (C) 2004 Jean Delvare <khali at linux-fr.org>
@@ -380,8 +380,8 @@ static int __init smsc47m1_find(unsigned
 	val = superio_inb(SUPERIO_REG_DEVID);
 
 	/*
-	 * SMSC LPC47M10x/LPC47M13x (device id 0x59), LPC47M14x (device id
-	 * 0x5F) and LPC47B27x (device id 0x51) have fan control.
+	 * SMSC LPC47M10x/LPC47M112/LPC47M13x (device id 0x59), LPC47M14x
+	 * (device id 0x5F) and LPC47B27x (device id 0x51) have fan control.
 	 * The LPC47M15x and LPC47M192 chips "with hardware monitoring block"
 	 * can do much more besides (device id 0x60).
 	 * The LPC47M997 is undocumented, but seems to be compatible with
@@ -390,7 +390,8 @@ static int __init smsc47m1_find(unsigned
 	if (val = 0x51)
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47B27x\n");
 	else if (val = 0x59)
-		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M10x/LPC47M13x\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC "
+		       "LPC47M10x/LPC47M112/LPC47M13x\n");
 	else if (val = 0x5F)
 		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M14x\n");
 	else if (val = 0x60)
-- 
1.4.2.4


