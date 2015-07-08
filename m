From: George Joseph <george.joseph@fairview5.com>
Date: Wed, 08 Jul 2015 01:16:53 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71882fg): Add support for f81768d
Message-Id: <1436318213-30778-1-git-send-email-george.joseph@fairview5.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>

Add f81768d (id 0x1210) currently found on Jetway motherboards.
It has 11 voltages but otherwise needed no special handling
in this driver.

Signed-off-by: George Joseph <george.joseph@fairview5.com>
---
 drivers/hwmon/f71882fg.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index e4ff21f..4c9ec5c 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -59,6 +59,7 @@
 #define SIO_F71889E_ID		0x0909	/* Chipset ID */
 #define SIO_F71889A_ID		0x1005	/* Chipset ID */
 #define SIO_F8000_ID		0x0581	/* Chipset ID */
+#define SIO_F81768D_ID		0x1210	/* Chipset ID */
 #define SIO_F81865_ID		0x0704	/* Chipset ID */
 #define SIO_F81866_ID		0x1010	/* Chipset ID */
 
@@ -107,7 +108,7 @@
 
 #define	F71882FG_REG_START		0x01
 
-#define F71882FG_MAX_INS		10
+#define F71882FG_MAX_INS		11
 
 #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
 
@@ -116,7 +117,7 @@ module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
 enum chips { f71808e, f71808a, f71858fg, f71862fg, f71868a, f71869, f71869a,
-	f71882fg, f71889fg, f71889ed, f71889a, f8000, f81865f, f81866a};
+	f71882fg, f71889fg, f71889ed, f71889a, f8000, f81768d, f81865f, f81866a};
 
 static const char *const f71882fg_names[] = {
 	"f71808e",
@@ -131,25 +132,27 @@ static const char *const f71882fg_names[] = {
 	"f71889ed",
 	"f71889a",
 	"f8000",
+	"f81768d",
 	"f81865f",
 	"f81866a",
 };
 
 static const char f71882fg_has_in[][F71882FG_MAX_INS] = {
-	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1, 0 },
-	[f71808a]	= { 1, 1, 1, 1, 0, 0, 0, 1, 1, 0 },
-	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 },
-	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
-	[f71868a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
-	[f71869]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
-	[f71869a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
-	[f71882fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
-	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
-	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
-	[f71889a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
-	[f8000]		= { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 },
-	[f81865f]	= { 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
-	[f81866a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0 },
+	[f71808a]	= { 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0 },
+	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
+	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71868a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71869]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71869a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71882fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71889a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f8000]		= { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
+	[f81768d]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f81865f]	= { 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
+	[f81866a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
 };
 
 static const char f71882fg_has_in1_alarm[] = {
@@ -165,6 +168,7 @@ static const char f71882fg_has_in1_alarm[] = {
 	[f71889ed]	= 1,
 	[f71889a]	= 1,
 	[f8000]		= 0,
+	[f81768d]	= 1,
 	[f81865f]	= 1,
 	[f81866a]	= 1,
 };
@@ -182,6 +186,7 @@ static const char f71882fg_fan_has_beep[] = {
 	[f71889ed]	= 1,
 	[f71889a]	= 1,
 	[f8000]		= 0,
+	[f81768d]	= 1,
 	[f81865f]	= 1,
 	[f81866a]	= 1,
 };
@@ -199,6 +204,7 @@ static const char f71882fg_nr_fans[] = {
 	[f71889ed]	= 3,
 	[f71889a]	= 3,
 	[f8000]		= 3, /* +1 fan which is monitor only */
+	[f81768d]	= 3,
 	[f81865f]	= 2,
 	[f81866a]	= 3,
 };
@@ -216,6 +222,7 @@ static const char f71882fg_temp_has_beep[] = {
 	[f71889ed]	= 1,
 	[f71889a]	= 1,
 	[f8000]		= 0,
+	[f81768d]	= 1,
 	[f81865f]	= 1,
 	[f81866a]	= 1,
 };
@@ -233,6 +240,7 @@ static const char f71882fg_nr_temps[] = {
 	[f71889ed]	= 3,
 	[f71889a]	= 3,
 	[f8000]		= 3,
+	[f81768d]	= 3,
 	[f81865f]	= 2,
 	[f81866a]	= 3,
 };
@@ -569,6 +577,7 @@ static struct sensor_device_attribute_2 fxxxx_in_attr[] = {
 	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
 	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
 	SENSOR_ATTR_2(in9_input, S_IRUGO, show_in, NULL, 0, 9),
+	SENSOR_ATTR_2(in10_input, S_IRUGO, show_in, NULL, 0, 10),
 };
 
 /* For models with in1 alarm capability */
@@ -2668,6 +2677,9 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 	case SIO_F8000_ID:
 		sio_data->type = f8000;
 		break;
+	case SIO_F81768D_ID:
+		sio_data->type = f81768d;
+		break;
 	case SIO_F81865_ID:
 		sio_data->type = f81865f;
 		break;
-- 
2.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
