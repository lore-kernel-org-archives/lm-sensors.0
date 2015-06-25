From: Peter Hung <hpeter@gmail.com>
Date: Thu, 25 Jun 2015 07:30:16 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon:f71882fg add f81866/f71868 SuperIO support
Message-Id: <1435217418-26249-2-git-send-email-hpeter+linux_kernel@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435217418-26249-1-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1435217418-26249-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>

Add New Fintek SuperIO F81866(0x1010) & F71868(0x1106)
with H/W Monitor functions.

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/hwmon/f71882fg.c | 50 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 2e5c6f4..10bc8b3 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -59,6 +59,8 @@
 #define SIO_F71889A_ID		0x1005	/* Chipset ID */
 #define SIO_F8000_ID		0x0581	/* Chipset ID */
 #define SIO_F81865_ID		0x0704	/* Chipset ID */
+#define SIO_F81866_ID		0x1010	/* Chipset ID */
+#define SIO_F71868_ID		0x1106	/* Chipset ID */
 
 #define REGION_LENGTH		8
 #define ADDR_REG_OFFSET		5
@@ -101,7 +103,7 @@
 
 #define	F71882FG_REG_START		0x01
 
-#define F71882FG_MAX_INS		9
+#define F71882FG_MAX_INS		10
 
 #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
 
@@ -110,7 +112,7 @@ module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
 enum chips { f71808e, f71808a, f71858fg, f71862fg, f71869, f71869a, f71882fg,
-	     f71889fg, f71889ed, f71889a, f8000, f81865f };
+	     f71889fg, f71889ed, f71889a, f8000, f81865f, f81866a, f71868a };
 
 static const char *const f71882fg_names[] = {
 	"f71808e",
@@ -125,21 +127,25 @@ static const char *const f71882fg_names[] = {
 	"f71889a",
 	"f8000",
 	"f81865f",
+	"f81866a",
+	"f71868a",
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
+	[f71869]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71869a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71882fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f71889a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
+	[f8000]		= { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 },
+	[f81865f]	= { 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
+	[f81866a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
+	[f71868a]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
 };
 
 static const char f71882fg_has_in1_alarm[] = {
@@ -155,6 +161,8 @@ static const char f71882fg_has_in1_alarm[] = {
 	[f71889a]	= 1,
 	[f8000]		= 0,
 	[f81865f]	= 1,
+	[f81866a]	= 1,
+	[f71868a]	= 0,
 };
 
 static const char f71882fg_fan_has_beep[] = {
@@ -170,6 +178,8 @@ static const char f71882fg_fan_has_beep[] = {
 	[f71889a]	= 1,
 	[f8000]		= 0,
 	[f81865f]	= 1,
+	[f81866a]	= 1,
+	[f71868a]	= 1,
 };
 
 static const char f71882fg_nr_fans[] = {
@@ -185,6 +195,8 @@ static const char f71882fg_nr_fans[] = {
 	[f71889a]	= 3,
 	[f8000]		= 3, /* +1 fan which is monitor only */
 	[f81865f]	= 2,
+	[f81866a]	= 3,
+	[f71868a]	= 3,
 };
 
 static const char f71882fg_temp_has_beep[] = {
@@ -200,6 +212,8 @@ static const char f71882fg_temp_has_beep[] = {
 	[f71889a]	= 1,
 	[f8000]		= 0,
 	[f81865f]	= 1,
+	[f81866a]	= 1,
+	[f71868a]	= 1,
 };
 
 static const char f71882fg_nr_temps[] = {
@@ -215,6 +229,8 @@ static const char f71882fg_nr_temps[] = {
 	[f71889a]	= 3,
 	[f8000]		= 3,
 	[f81865f]	= 2,
+	[f81866a]	= 3,
+	[f71868a]	= 3,
 };
 
 static struct platform_device *f71882fg_pdev;
@@ -2575,6 +2591,12 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 	case SIO_F81865_ID:
 		sio_data->type = f81865f;
 		break;
+	case SIO_F81866_ID:
+		sio_data->type = f81866a;
+		break;
+	case SIO_F71868_ID:
+		sio_data->type = f71868a;
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
