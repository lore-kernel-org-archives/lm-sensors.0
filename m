From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Oct 2010 15:38:27 +0000
Subject: [lm-sensors] [PATCH v2 2/3] hwmon: (lm90) Introduce capability flag
Message-Id: <1286293108-28890-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm90.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 9df08e1..1913f8a 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -162,6 +162,7 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 #define LM90_HAVE_EMERGENCY	(1 << 4) /* 3rd upper (emergency) limit	*/
 #define LM90_HAVE_EMERGENCY_ALARM (1 << 5)/* emergency alarm		*/
 #define LM90_HAVE_TEMP3		(1 << 6) /* 3rd temperature sensor	*/
+#define LM90_HAVE_BROKEN_ALERT	(1 << 7) /* Broken alert		*/
 
 /*
  * Driver data (common to all clients)
@@ -200,11 +201,13 @@ struct lm90_params {
 
 static const struct lm90_params lm90_params[] = {
 	[adm1032] = {
-		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
+		  | LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
 	},
 	[adt7461] = {
-		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
+		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
+		  | LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
 	},
 	[lm86] = {
@@ -1361,7 +1364,7 @@ static void lm90_alert(struct i2c_client *client, unsigned int flag)
 		/* Disable ALERT# output, because these chips don't implement
 		  SMBus alert correctly; they should only hold the alert line
 		  low briefly. */
-		if ((data->kind = adm1032 || data->kind = adt7461)
+		if ((data->flags & LM90_HAVE_BROKEN_ALERT)
 		 && (alarms & data->alert_alarms)) {
 			dev_dbg(&client->dev, "Disabling ALERT#\n");
 			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
