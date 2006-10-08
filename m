From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 20:00:44 +0000
Subject: [lm-sensors] [PATCH 4/6] smsc47m1: List the SMSC LPC47M112 as
Message-Id: <20061008220044.4a69d85f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-smsc47m112-documentation.patch

The SMSC LPC47M112 Super-I/O chip appears to be compatible with the
LPC47M10x and LPC47M13x as far as hardware monitoring is concerned.
The device ID is even the same, so it's really only a documentation
update.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/smsc47m1 |    4 +++-
 drivers/hwmon/Kconfig        |    4 ++--
 drivers/hwmon/smsc47m1.c     |   11 ++++++-----
 3 files changed, 11 insertions(+), 8 deletions(-)

--- linux-2.6.18.orig/Documentation/hwmon/smsc47m1	2006-09-23 15:24:09.000000000 +0200
+++ linux-2.6.18/Documentation/hwmon/smsc47m1	2006-09-23 22:17:14.000000000 +0200
@@ -2,12 +2,14 @@
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
--- linux-2.6.18.orig/drivers/hwmon/Kconfig	2006-09-23 21:52:21.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/Kconfig	2006-09-23 22:17:14.000000000 +0200
@@ -369,8 +369,8 @@
 	help
 	  If you say yes here you get support for the integrated fan
 	  monitoring and control capabilities of the SMSC LPC47B27x,
-	  LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x, LPC47M192 and
-	  LPC47M997 chips.
+	  LPC47M10x, LPC47M112, LPC47M13x, LPC47M14x, LPC47M15x,
+	  LPC47M192 and LPC47M997 chips.
 
 	  The temperature and voltage sensor features of the LPC47M192
 	  and LPC47M997 are supported by another driver, select also
--- linux-2.6.18.orig/drivers/hwmon/smsc47m1.c	2006-09-23 20:56:29.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/smsc47m1.c	2006-09-23 22:17:14.000000000 +0200
@@ -2,8 +2,8 @@
     smsc47m1.c - Part of lm_sensors, Linux kernel modules
                  for hardware monitoring
 
-    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x,
-    LPC47M15x, LPC47M192 and LPC47M997 Super-I/O chips.
+    Supports the SMSC LPC47B27x, LPC47M10x, LPC47M112, LPC47M13x,
+    LPC47M14x, LPC47M15x, LPC47M192 and LPC47M997 Super-I/O chips.
 
     Copyright (C) 2002 Mark D. Studebaker <mdsxyz123 at yahoo.com>
     Copyright (C) 2004 Jean Delvare <khali at linux-fr.org>
@@ -380,8 +380,8 @@
 	val = superio_inb(SUPERIO_REG_DEVID);
 
 	/*
-	 * SMSC LPC47M10x/LPC47M13x (device id 0x59), LPC47M14x (device id
-	 * 0x5F) and LPC47B27x (device id 0x51) have fan control.
+	 * SMSC LPC47M10x/LPC47M112/LPC47M13x (device id 0x59), LPC47M14x
+	 * (device id 0x5F) and LPC47B27x (device id 0x51) have fan control.
 	 * The LPC47M15x and LPC47M192 chips "with hardware monitoring block"
 	 * can do much more besides (device id 0x60).
 	 * The LPC47M997 is undocumented, but seems to be compatible with
@@ -390,7 +390,8 @@
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
Jean Delvare

