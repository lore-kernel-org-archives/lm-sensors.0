From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 25 Mar 2011 13:56:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71882fg) Add support for the F71889A
Message-Id: <1301061386-17844-2-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110325135049.7737bcb6@endymion.delvare>
In-Reply-To: <20110325135049.7737bcb6@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/hwmon/f71882fg |    4 ++++
 drivers/hwmon/Kconfig        |    2 +-
 drivers/hwmon/f71882fg.c     |   24 ++++++++++++++++++------
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/f71882fg b/Documentation/hwmon/f71882fg
index b802a22..df02245 100644
--- a/Documentation/hwmon/f71882fg
+++ b/Documentation/hwmon/f71882fg
@@ -30,6 +30,10 @@ Supported chips:
     Prefix: 'f71889ed'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: Should become available on the Fintek website soon
+  * Fintek F71889A
+    Prefix: 'f71889a'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Should become available on the Fintek website soon
   * Fintek F8000
     Prefix: 'f8000'
     Addresses scanned: none, address read from Super I/O config space
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 504117c..065d01b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -327,7 +327,7 @@ config SENSORS_F71882FG
 	    F71869F/E
 	    F71882FG
 	    F71883FG
-	    F71889FG/ED
+	    F71889FG/ED/A
 	    F8000
 	    F81801U
 	    F81865F
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 41248cd..ca07a32 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -54,6 +54,7 @@
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
 #define SIO_F71889E_ID		0x0909	/* Chipset ID */
+#define SIO_F71889A_ID		0x1005	/* Chipset ID */
 #define SIO_F8000_ID		0x0581	/* Chipset ID */
 #define SIO_F81865_ID		0x0704	/* Chipset ID */
 
@@ -107,7 +108,7 @@ module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
 enum chips { f71808e, f71858fg, f71862fg, f71869, f71882fg, f71889fg,
-	     f71889ed, f8000, f81865f };
+	     f71889ed, f71889a, f8000, f81865f };
 
 static const char *f71882fg_names[] = {
 	"f71808e",
@@ -117,11 +118,12 @@ static const char *f71882fg_names[] = {
 	"f71882fg",
 	"f71889fg", /* f81801u too, same id */
 	"f71889ed",
+	"f71889a",
 	"f8000",
 	"f81865f",
 };
 
-static const char f71882fg_has_in[9][F71882FG_MAX_INS] = {
+static const char f71882fg_has_in[][F71882FG_MAX_INS] = {
 	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1 },
 	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
 	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
@@ -129,11 +131,12 @@ static const char f71882fg_has_in[9][F71882FG_MAX_INS] = {
 	[f71882fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f71889a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f8000]		= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
 	[f81865f]	= { 1, 1, 1, 1, 1, 1, 1, 0, 0 },
 };
 
-static const char f71882fg_has_in1_alarm[9] = {
+static const char f71882fg_has_in1_alarm[] = {
 	[f71808e]	= 0,
 	[f71858fg]	= 0,
 	[f71862fg]	= 0,
@@ -141,11 +144,12 @@ static const char f71882fg_has_in1_alarm[9] = {
 	[f71882fg]	= 1,
 	[f71889fg]	= 1,
 	[f71889ed]	= 1,
+	[f71889a]	= 1,
 	[f8000]		= 0,
 	[f81865f]	= 1,
 };
 
-static const char f71882fg_has_beep[9] = {
+static const char f71882fg_has_beep[] = {
 	[f71808e]	= 0,
 	[f71858fg]	= 0,
 	[f71862fg]	= 1,
@@ -153,11 +157,12 @@ static const char f71882fg_has_beep[9] = {
 	[f71882fg]	= 1,
 	[f71889fg]	= 1,
 	[f71889ed]	= 1,
+	[f71889a]	= 1,
 	[f8000]		= 0,
 	[f81865f]	= 1,
 };
 
-static const char f71882fg_nr_fans[9] = {
+static const char f71882fg_nr_fans[] = {
 	[f71808e]	= 3,
 	[f71858fg]	= 3,
 	[f71862fg]	= 3,
@@ -165,11 +170,12 @@ static const char f71882fg_nr_fans[9] = {
 	[f71882fg]	= 4,
 	[f71889fg]	= 3,
 	[f71889ed]	= 3,
+	[f71889a]	= 3,
 	[f8000]		= 3,
 	[f81865f]	= 2,
 };
 
-static const char f71882fg_nr_temps[9] = {
+static const char f71882fg_nr_temps[] = {
 	[f71808e]	= 2,
 	[f71858fg]	= 3,
 	[f71862fg]	= 3,
@@ -177,6 +183,7 @@ static const char f71882fg_nr_temps[9] = {
 	[f71882fg]	= 3,
 	[f71889fg]	= 3,
 	[f71889ed]	= 3,
+	[f71889a]	= 3,
 	[f8000]		= 3,
 	[f81865f]	= 2,
 };
@@ -2168,6 +2175,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 			/* Fall through to select correct fan/pwm reg bank! */
 		case f71889fg:
 		case f71889ed:
+		case f71889a:
 			reg = f71882fg_read8(data, F71882FG_REG_FAN_FAULT_T);
 			if (reg & F71882FG_FAN_NEG_TEMP_EN)
 				data->auto_point_temp_signed = 1;
@@ -2225,6 +2233,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		case f71869:
 		case f71889fg:
 		case f71889ed:
+		case f71889a:
 			for (i = 0; i < nr_fans; i++) {
 				data->pwm_auto_point_mapping[i]  					f71882fg_read8(data,
@@ -2433,6 +2442,9 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 	case SIO_F71889E_ID:
 		sio_data->type = f71889ed;
 		break;
+	case SIO_F71889A_ID:
+		sio_data->type = f71889a;
+		break;
 	case SIO_F8000_ID:
 		sio_data->type = f8000;
 		break;
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
