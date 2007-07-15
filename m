From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jul 2007 08:36:06 +0000
Subject: [lm-sensors] [PATCH] hwmon/f71805f: List the F71805F/FG as supported
Message-Id: <20070715103606.3375e2bb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Fintek F71806F/FG is compatible with the F71872F/FG, so it is
already supported by the f71805f hardware monitoring driver. In fact,
both chips have the same chip ID, so the driver can't even
differentiate between them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/f71805f |    7 +++++++
 drivers/hwmon/Kconfig       |    6 +++---
 drivers/hwmon/f71805f.c     |    5 ++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

--- linux-2.6.23-pre.orig/Documentation/hwmon/f71805f	2007-07-14 22:20:47.000000000 +0200
+++ linux-2.6.23-pre/Documentation/hwmon/f71805f	2007-07-15 09:49:49.000000000 +0200
@@ -6,6 +6,10 @@ Supported chips:
     Prefix: 'f71805f'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: Available from the Fintek website
+  * Fintek F71806F/FG
+    Prefix: 'f71872f'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Available from the Fintek website
   * Fintek F71872F/FG
     Prefix: 'f71872f'
     Addresses scanned: none, address read from Super I/O config space
@@ -38,6 +42,9 @@ The Fintek F71872F/FG Super I/O chip is 
 additional internal voltages monitored (VSB and battery). It also features
 6 VID inputs. The VID inputs are not yet supported by this driver.
 
+The Fintek F71806F/FG Super-I/O chip is essentially the same as the
+F71872F/FG, and is undistinguishable therefrom.
+
 The driver assumes that no more than one chip is present, which seems
 reasonable.
 
--- linux-2.6.23-pre.orig/drivers/hwmon/Kconfig	2007-07-14 22:20:48.000000000 +0200
+++ linux-2.6.23-pre/drivers/hwmon/Kconfig	2007-07-15 09:49:49.000000000 +0200
@@ -189,12 +189,12 @@ config SENSORS_DS1621
 	  will be called ds1621.
 
 config SENSORS_F71805F
-	tristate "Fintek F71805F/FG and F71872F/FG"
+	tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
 	depends on EXPERIMENTAL
 	help
 	  If you say yes here you get support for hardware monitoring
-	  features of the Fintek F71805F/FG and F71872F/FG Super-I/O
-	  chips.
+	  features of the Fintek F71805F/FG, F71806F/FG and F71872F/FG
+	  Super-I/O chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called f71805f.
--- linux-2.6.23-pre.orig/drivers/hwmon/f71805f.c	2007-07-14 22:20:47.000000000 +0200
+++ linux-2.6.23-pre/drivers/hwmon/f71805f.c	2007-07-15 09:49:49.000000000 +0200
@@ -10,6 +10,9 @@
  * The F71872F/FG is almost the same, with two more voltages monitored,
  * and 6 VID inputs.
  *
+ * The F71806F/FG is essentially the same as the F71872F/FG. It even has
+ * the same chip ID, so the driver can't differentiate between.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -1485,7 +1488,7 @@ static int __init f71805f_find(int sioad
 
 	static const char *names[] = {
 		"F71805F/FG",
-		"F71872F/FG",
+		"F71872F/FG or F71806F/FG",
 	};
 
 	superio_enter(sioaddr);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
