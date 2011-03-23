From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Mar 2011 20:50:04 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (f71882fg) Document all supported
Message-Id: <20110323215004.5b9ab7b0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The list of supported devices was not always well documented in all
places. Clarify and list all devices in documentation, Kconfig and
the driver itself.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/hwmon/f71882fg |   11 +++++++++++
 drivers/hwmon/Kconfig        |   14 +++++++++++---
 drivers/hwmon/f71882fg.c     |    2 +-
 3 files changed, 23 insertions(+), 4 deletions(-)

--- linux-2.6.39-rc0.orig/Documentation/hwmon/f71882fg	2011-03-23 10:34:22.000000000 +0100
+++ linux-2.6.39-rc0/Documentation/hwmon/f71882fg	2011-03-23 21:16:41.000000000 +0100
@@ -2,6 +2,10 @@ Kernel driver f71882fg
 ===========
 
 Supported chips:
+  * Fintek F71808E
+    Prefix: 'f71808e'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Not public
   * Fintek F71858FG
     Prefix: 'f71858fg'
     Addresses scanned: none, address read from Super I/O config space
@@ -30,6 +34,13 @@ Supported chips:
     Prefix: 'f8000'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: Not public
+  * Fintek F81801U
+    Prefix: 'f71889fg'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Not public
+    Note: This is the 64-pin variant of the F71889FG, they have the
+	  same device ID and are fully compatible as far as hardware
+	  monitoring is concerned.
 
 Author: Hans de Goede <hdegoede@redhat.com>
 
--- linux-2.6.39-rc0.orig/drivers/hwmon/Kconfig	2011-03-23 14:38:41.000000000 +0100
+++ linux-2.6.39-rc0/drivers/hwmon/Kconfig	2011-03-23 21:11:03.000000000 +0100
@@ -315,11 +315,19 @@ config SENSORS_F71805F
 	  will be called f71805f.
 
 config SENSORS_F71882FG
-	tristate "Fintek F71858FG, F71862FG, F71882FG, F71889FG and F8000"
+	tristate "Fintek F71882FG and compatibles"
 	help
 	  If you say yes here you get support for hardware monitoring
-	  features of the Fintek F71858FG, F71862FG/71863FG, F71882FG/F71883FG,
-	  F71889FG and F8000 Super-I/O chips.
+	  features of many Fintek Super-I/O (LPC) chips. The currently
+	  supported chips are:
+	    F71808E
+	    F71858FG
+	    F71862FG and F71863FG
+	    F71869F and F71869E
+	    F71882FG and F71883FG
+	    F71889FG and F81801U
+	    F71889ED
+	    F8000
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called f71882fg.
--- linux-2.6.39-rc0.orig/drivers/hwmon/f71882fg.c	2011-03-23 18:58:55.000000000 +0100
+++ linux-2.6.39-rc0/drivers/hwmon/f71882fg.c	2011-03-23 21:09:41.000000000 +0100
@@ -114,7 +114,7 @@ static const char *f71882fg_names[] = {
 	"f71862fg",
 	"f71869", /* Both f71869f and f71869e, reg. compatible and same id */
 	"f71882fg",
-	"f71889fg",
+	"f71889fg", /* f81801u too, same id */
 	"f71889ed",
 	"f8000",
 };


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
