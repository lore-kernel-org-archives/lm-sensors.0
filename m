From: Peter Hung <hpeter@gmail.com>
Date: Tue, 07 Jul 2015 08:22:36 +0000
Subject: [lm-sensors] [PATCH V3 1/3] hwmon:f71882fg add f81866/f71868 SuperIO support
Message-Id: <1436257358-31360-2-git-send-email-hpeter+linux_kernel@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436257358-31360-1-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1436257358-31360-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>

Add New Fintek SuperIO F81866(0x1010) & F71868(0x1106)
with H/W Monitor functions.

We increased F71882FG_MAX_INS from 9 to 10 to read
F71868 10 voltage sets.

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/hwmon/f71882fg.c | 53 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 2e5c6f4..3a7185a 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -51,6 +51,7 @@
 #define SIO_F71808A_ID		0x1001	/* Chipset ID */
 #define SIO_F71858_ID		0x0507  /* Chipset ID */
 #define SIO_F71862_ID		0x0601	/* Chipset ID */
+#define SIO_F71868_ID		0x1106	/* Chipset ID */
 #define SIO_F71869_ID		0x0814	/* Chipset ID */
 #define SIO_F71869A_ID		0x1007	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
@@ -59,6 +60,7 @@
 #define SIO_F71889A_ID		0x1005	/* Chipset ID */
 #define SIO_F8000_ID		0x0581	/* Chipset ID */
 #define SIO_F81865_ID		0x0704	/* Chipset ID */
+#define SIO_F81866_ID		0x1010	/* Chipset ID */
 
 #define REGION_LENGTH		8
 #define ADDR_REG_OFFSET		5
@@ -101,7 +103,7 @@
 
 #define	F71882FG_REG_START		0x01
 
-#define F71882FG_MAX_INS		9
+#define F71882FG_MAX_INS		10
 
 #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
 
@@ -109,14 +111,15 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-enum chips { f71808e, f71808a, f71858fg, f71862fg, f71869, f71869a, f71882fg,
-	     f71889fg, f71889ed, f71889a, f8000, f81865f };
+enum chips { f71808e, f71808a, f71858fg, f71862fg, f71868a, f71869, f71869a,
+	f71882fg, f71889fg, f71889ed, f71889a, f8000, f81865f, f81866a};
 
 static const char *const f71882fg_names[] = {
 	"f71808e",
 	"f71808a",
 	"f71858fg",
 	"f71862fg",
+	"f71868a",
 	"f71869", /* Both f71869f and f71869e, reg. compatible and same id */
 	"f71869a",
 	"f71882fg",
@@ -125,21 +128,24 @@ static const char *const f71882fg_names[] = {
 	"f71889a",
 	"f8000",
 	"f81865f",
+	"f81866a",
 };
 
 static const char f71882fg_has_in[][F71882FG_MAX_INS] = {
-	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1 },
-	[f71808a]	= { 1, 1, 1, 1, 0, 0, 0, 1, 1 },
-	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
-	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
-	[f71869]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
-	[f71869a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
-	[f71882fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
-	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
-	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
-	[f71889a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
-	[f8000]		= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
-	[f81865f]	= { 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1, 0 },
+	[f71808a]	= { 1, 1, 1, 1, 0, 0, 0, 1, 1, 0 },
+	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 },
+	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71868a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f71869]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71869a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71882fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71889a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f8000]		= { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 },
+	[f81865f]	= { 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
+	[f81866a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
 };
 
 static const char f71882fg_has_in1_alarm[] = {
@@ -147,6 +153,7 @@ static const char f71882fg_has_in1_alarm[] = {
 	[f71808a]	= 0,
 	[f71858fg]	= 0,
 	[f71862fg]	= 0,
+	[f71868a]	= 0,
 	[f71869]	= 0,
 	[f71869a]	= 0,
 	[f71882fg]	= 1,
@@ -155,6 +162,7 @@ static const char f71882fg_has_in1_alarm[] = {
 	[f71889a]	= 1,
 	[f8000]		= 0,
 	[f81865f]	= 1,
+	[f81866a]	= 1,
 };
 
 static const char f71882fg_fan_has_beep[] = {
@@ -162,6 +170,7 @@ static const char f71882fg_fan_has_beep[] = {
 	[f71808a]	= 0,
 	[f71858fg]	= 0,
 	[f71862fg]	= 1,
+	[f71868a]	= 1,
 	[f71869]	= 1,
 	[f71869a]	= 1,
 	[f71882fg]	= 1,
@@ -170,6 +179,7 @@ static const char f71882fg_fan_has_beep[] = {
 	[f71889a]	= 1,
 	[f8000]		= 0,
 	[f81865f]	= 1,
+	[f81866a]	= 1,
 };
 
 static const char f71882fg_nr_fans[] = {
@@ -177,6 +187,7 @@ static const char f71882fg_nr_fans[] = {
 	[f71808a]	= 2, /* +1 fan which is monitor + simple pwm only */
 	[f71858fg]	= 3,
 	[f71862fg]	= 3,
+	[f71868a]	= 3,
 	[f71869]	= 3,
 	[f71869a]	= 3,
 	[f71882fg]	= 4,
@@ -185,6 +196,7 @@ static const char f71882fg_nr_fans[] = {
 	[f71889a]	= 3,
 	[f8000]		= 3, /* +1 fan which is monitor only */
 	[f81865f]	= 2,
+	[f81866a]	= 3,
 };
 
 static const char f71882fg_temp_has_beep[] = {
@@ -192,6 +204,7 @@ static const char f71882fg_temp_has_beep[] = {
 	[f71808a]	= 1,
 	[f71858fg]	= 0,
 	[f71862fg]	= 1,
+	[f71868a]	= 1,
 	[f71869]	= 1,
 	[f71869a]	= 1,
 	[f71882fg]	= 1,
@@ -200,6 +213,7 @@ static const char f71882fg_temp_has_beep[] = {
 	[f71889a]	= 1,
 	[f8000]		= 0,
 	[f81865f]	= 1,
+	[f81866a]	= 1,
 };
 
 static const char f71882fg_nr_temps[] = {
@@ -207,6 +221,7 @@ static const char f71882fg_nr_temps[] = {
 	[f71808a]	= 2,
 	[f71858fg]	= 3,
 	[f71862fg]	= 3,
+	[f71868a]	= 3,
 	[f71869]	= 3,
 	[f71869a]	= 3,
 	[f71882fg]	= 3,
@@ -215,6 +230,7 @@ static const char f71882fg_nr_temps[] = {
 	[f71889a]	= 3,
 	[f8000]		= 3,
 	[f81865f]	= 2,
+	[f81866a]	= 3,
 };
 
 static struct platform_device *f71882fg_pdev;
@@ -531,6 +547,7 @@ static struct sensor_device_attribute_2 fxxxx_in_attr[] = {
 	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 0, 6),
 	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
 	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
+	SENSOR_ATTR_2(in9_input, S_IRUGO, show_in, NULL, 0, 9),
 };
 
 /* For models with in1 alarm capability */
@@ -2551,6 +2568,9 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 	case SIO_F71862_ID:
 		sio_data->type = f71862fg;
 		break;
+	case SIO_F71868_ID:
+		sio_data->type = f71868a;
+		break;
 	case SIO_F71869_ID:
 		sio_data->type = f71869;
 		break;
@@ -2575,6 +2595,9 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 	case SIO_F81865_ID:
 		sio_data->type = f81865f;
 		break;
+	case SIO_F81866_ID:
+		sio_data->type = f81866a;
+		break;
 	default:
 		pr_info("Unsupported Fintek device: %04x\n",
 			(unsigned int)devid);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
