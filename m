From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Mar 2011 12:50:49 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71882fg) Add support for the F81865F
Message-Id: <20110325135049.7737bcb6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the Fintek F81865F. It's essentially compatible with
the F71882FG, but has fewer inputs: 7 voltage, 2 temperature and 2 fan
inputs only.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/hwmon/f71882fg |    4 ++++
 drivers/hwmon/Kconfig        |    1 +
 drivers/hwmon/f71882fg.c     |   32 +++++++++++++++++++-------------
 3 files changed, 24 insertions(+), 13 deletions(-)

--- linux-2.6.39-rc0.orig/drivers/hwmon/f71882fg.c	2011-03-24 08:15:44.000000000 +0100
+++ linux-2.6.39-rc0/drivers/hwmon/f71882fg.c	2011-03-25 13:37:32.000000000 +0100
@@ -55,6 +55,7 @@
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
 #define SIO_F71889E_ID		0x0909	/* Chipset ID */
 #define SIO_F8000_ID		0x0581	/* Chipset ID */
+#define SIO_F81865_ID		0x0704	/* Chipset ID */
 
 #define REGION_LENGTH		8
 #define ADDR_REG_OFFSET		5
@@ -106,7 +107,7 @@ module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
 enum chips { f71808e, f71858fg, f71862fg, f71869, f71882fg, f71889fg,
-	     f71889ed, f8000 };
+	     f71889ed, f8000, f81865f };
 
 static const char *f71882fg_names[] = {
 	"f71808e",
@@ -117,9 +118,10 @@ static const char *f71882fg_names[] = {
 	"f71889fg", /* f81801u too, same id */
 	"f71889ed",
 	"f8000",
+	"f81865f",
 };
 
-static const char f71882fg_has_in[8][F71882FG_MAX_INS] = {
+static const char f71882fg_has_in[9][F71882FG_MAX_INS] = {
 	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1 },
 	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
 	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
@@ -128,9 +130,10 @@ static const char f71882fg_has_in[8][F71
 	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f8000]		= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
+	[f81865f]	= { 1, 1, 1, 1, 1, 1, 1, 0, 0 },
 };
 
-static const char f71882fg_has_in1_alarm[8] = {
+static const char f71882fg_has_in1_alarm[9] = {
 	[f71808e]	= 0,
 	[f71858fg]	= 0,
 	[f71862fg]	= 0,
@@ -139,9 +142,10 @@ static const char f71882fg_has_in1_alarm
 	[f71889fg]	= 1,
 	[f71889ed]	= 1,
 	[f8000]		= 0,
+	[f81865f]	= 1,
 };
 
-static const char f71882fg_has_beep[8] = {
+static const char f71882fg_has_beep[9] = {
 	[f71808e]	= 0,
 	[f71858fg]	= 0,
 	[f71862fg]	= 1,
@@ -150,9 +154,10 @@ static const char f71882fg_has_beep[8]  	[f71889fg]	= 1,
 	[f71889ed]	= 1,
 	[f8000]		= 0,
+	[f81865f]	= 1,
 };
 
-static const char f71882fg_nr_fans[8] = {
+static const char f71882fg_nr_fans[9] = {
 	[f71808e]	= 3,
 	[f71858fg]	= 3,
 	[f71862fg]	= 3,
@@ -161,9 +166,10 @@ static const char f71882fg_nr_fans[8]  	[f71889fg]	= 3,
 	[f71889ed]	= 3,
 	[f8000]		= 3,
+	[f81865f]	= 2,
 };
 
-static const char f71882fg_nr_temps[8] = {
+static const char f71882fg_nr_temps[9] = {
 	[f71808e]	= 2,
 	[f71858fg]	= 3,
 	[f71862fg]	= 3,
@@ -172,6 +178,7 @@ static const char f71882fg_nr_temps[8]  	[f71889fg]	= 3,
 	[f71889ed]	= 3,
 	[f8000]		= 3,
+	[f81865f]	= 2,
 };
 
 static struct platform_device *f71882fg_pdev;
@@ -2186,16 +2193,12 @@ static int __devinit f71882fg_probe(stru
 		case f71862fg:
 			err = (data->pwm_enable & 0x15) != 0x15;
 			break;
-		case f71808e:
-		case f71869:
-		case f71882fg:
-		case f71889fg:
-		case f71889ed:
-			err = 0;
-			break;
 		case f8000:
 			err = data->pwm_enable & 0x20;
 			break;
+		default:
+			err = 0;
+			break;
 		}
 		if (err) {
 			dev_err(&pdev->dev,
@@ -2433,6 +2436,9 @@ static int __init f71882fg_find(int sioa
 	case SIO_F8000_ID:
 		sio_data->type = f8000;
 		break;
+	case SIO_F81865_ID:
+		sio_data->type = f81865f;
+		break;
 	default:
 		pr_info("Unsupported Fintek device: %04x\n",
 			(unsigned int)devid);
--- linux-2.6.39-rc0.orig/Documentation/hwmon/f71882fg	2011-03-24 08:15:44.000000000 +0100
+++ linux-2.6.39-rc0/Documentation/hwmon/f71882fg	2011-03-25 13:38:13.000000000 +0100
@@ -41,6 +41,10 @@ Supported chips:
     Note: This is the 64-pin variant of the F71889FG, they have the
 	  same device ID and are fully compatible as far as hardware
 	  monitoring is concerned.
+  * Fintek F81865F
+    Prefix: 'f81865f'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Available from the Fintek website
 
 Author: Hans de Goede <hdegoede@redhat.com>
 
--- linux-2.6.39-rc0.orig/drivers/hwmon/Kconfig	2011-03-24 08:16:44.000000000 +0100
+++ linux-2.6.39-rc0/drivers/hwmon/Kconfig	2011-03-25 13:38:41.000000000 +0100
@@ -330,6 +330,7 @@ config SENSORS_F71882FG
 	    F71889FG/ED
 	    F8000
 	    F81801U
+	    F81865F
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called f71882fg.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
