From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 29 May 2011 13:34:46 +0000
Subject: [lm-sensors] [PATCH] hwmon/f71882fg: Add support for the f71869a
Message-Id: <1306676086-6253-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The f71869a is almost the same as the f71869f/e, except that it has
the normal number of temp and pwm zones for a f71882fg derived chip, rather
then the limited number of the f71869f/e.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Max Baldwin <archerseven@gmail.com>
---
 Documentation/hwmon/f71882fg |    4 ++++
 drivers/hwmon/Kconfig        |    2 +-
 drivers/hwmon/f71882fg.c     |   17 +++++++++++++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/f71882fg b/Documentation/hwmon/f71882fg
index 84d2623..de91c0d 100644
--- a/Documentation/hwmon/f71882fg
+++ b/Documentation/hwmon/f71882fg
@@ -22,6 +22,10 @@ Supported chips:
     Prefix: 'f71869'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: Available from the Fintek website
+  * Fintek F71869A
+    Prefix: 'f71869a'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Not public
   * Fintek F71882FG and F71883FG
     Prefix: 'f71882fg'
     Addresses scanned: none, address read from Super I/O config space
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68e5cdf..70b5704 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -333,7 +333,7 @@ config SENSORS_F71882FG
 	    F71858FG
 	    F71862FG
 	    F71863FG
-	    F71869F/E
+	    F71869F/E/A
 	    F71882FG
 	    F71883FG
 	    F71889FG/ED/A
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index f8ef196..2d96ed2 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -52,6 +52,7 @@
 #define SIO_F71858_ID		0x0507  /* Chipset ID */
 #define SIO_F71862_ID		0x0601	/* Chipset ID */
 #define SIO_F71869_ID		0x0814	/* Chipset ID */
+#define SIO_F71869A_ID		0x1007	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
 #define SIO_F71889E_ID		0x0909	/* Chipset ID */
@@ -108,8 +109,8 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-enum chips { f71808e, f71808a, f71858fg, f71862fg, f71869, f71882fg, f71889fg,
-	     f71889ed, f71889a, f8000, f81865f };
+enum chips { f71808e, f71808a, f71858fg, f71862fg, f71869, f71869a, f71882fg,
+	     f71889fg, f71889ed, f71889a, f8000, f81865f };
 
 static const char *f71882fg_names[] = {
 	"f71808e",
@@ -117,6 +118,7 @@ static const char *f71882fg_names[] = {
 	"f71858fg",
 	"f71862fg",
 	"f71869", /* Both f71869f and f71869e, reg. compatible and same id */
+	"f71869a",
 	"f71882fg",
 	"f71889fg", /* f81801u too, same id */
 	"f71889ed",
@@ -131,6 +133,7 @@ static const char f71882fg_has_in[][F71882FG_MAX_INS] = {
 	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
 	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f71869]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f71869a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f71882fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
@@ -145,6 +148,7 @@ static const char f71882fg_has_in1_alarm[] = {
 	[f71858fg]	= 0,
 	[f71862fg]	= 0,
 	[f71869]	= 0,
+	[f71869a]	= 0,
 	[f71882fg]	= 1,
 	[f71889fg]	= 1,
 	[f71889ed]	= 1,
@@ -159,6 +163,7 @@ static const char f71882fg_fan_has_beep[] = {
 	[f71858fg]	= 0,
 	[f71862fg]	= 1,
 	[f71869]	= 1,
+	[f71869a]	= 1,
 	[f71882fg]	= 1,
 	[f71889fg]	= 1,
 	[f71889ed]	= 1,
@@ -173,6 +178,7 @@ static const char f71882fg_nr_fans[] = {
 	[f71858fg]	= 3,
 	[f71862fg]	= 3,
 	[f71869]	= 3,
+	[f71869a]	= 3,
 	[f71882fg]	= 4,
 	[f71889fg]	= 3,
 	[f71889ed]	= 3,
@@ -187,6 +193,7 @@ static const char f71882fg_temp_has_beep[] = {
 	[f71858fg]	= 0,
 	[f71862fg]	= 1,
 	[f71869]	= 1,
+	[f71869a]	= 1,
 	[f71882fg]	= 1,
 	[f71889fg]	= 1,
 	[f71889ed]	= 1,
@@ -201,6 +208,7 @@ static const char f71882fg_nr_temps[] = {
 	[f71858fg]	= 3,
 	[f71862fg]	= 3,
 	[f71869]	= 3,
+	[f71869a]	= 3,
 	[f71882fg]	= 3,
 	[f71889fg]	= 3,
 	[f71889ed]	= 3,
@@ -2243,6 +2251,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		case f71808e:
 		case f71808a:
 		case f71869:
+		case f71869a:
 			/* These always have signed auto point temps */
 			data->auto_point_temp_signed = 1;
 			/* Fall through to select correct fan/pwm reg bank! */
@@ -2305,6 +2314,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		case f71808e:
 		case f71808a:
 		case f71869:
+		case f71869a:
 		case f71889fg:
 		case f71889ed:
 		case f71889a:
@@ -2528,6 +2538,9 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 	case SIO_F71869_ID:
 		sio_data->type = f71869;
 		break;
+	case SIO_F71869A_ID:
+		sio_data->type = f71869a;
+		break;
 	case SIO_F71882_ID:
 		sio_data->type = f71882fg;
 		break;
-- 
1.7.5.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
