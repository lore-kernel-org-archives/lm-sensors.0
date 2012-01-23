From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 23 Jan 2012 18:08:56 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm90) Fix multi-line comments
Message-Id: <1327342136-12625-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: improved alignment, s/ma6696/max6696/

 drivers/hwmon/lm90.c |   58 +++++++++++++++++++++++++++++--------------------
 1 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 248f2b4..22efae3 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -308,22 +308,24 @@ struct lm90_data {
 
 	/* registers values */
 	s8 temp8[8];	/* 0: local low limit
-			   1: local high limit
-			   2: local critical limit
-			   3: remote critical limit
-			   4: local emergency limit (max6659 and max6695/96)
-			   5: remote emergency limit (max6659 and max6695/96)
-			   6: remote 2 critical limit (max6695/96 only)
-			   7: remote 2 emergency limit (max6695/96 only) */
+			 * 1: local high limit
+			 * 2: local critical limit
+			 * 3: remote critical limit
+			 * 4: local emergency limit (max6659 and max6695/96)
+			 * 5: remote emergency limit (max6659 and max6695/96)
+			 * 6: remote 2 critical limit (max6695/96 only)
+			 * 7: remote 2 emergency limit (max6695/96 only)
+			 */
 	s16 temp11[8];	/* 0: remote input
-			   1: remote low limit
-			   2: remote high limit
-			   3: remote offset (except max6646, max6657/58/59,
-					     and max6695/96)
-			   4: local input
-			   5: remote 2 input (max6695/96 only)
-			   6: remote 2 low limit (max6695/96 only)
-			   7: remote 2 high limit (ma6695/96 only) */
+			 * 1: remote low limit
+			 * 2: remote high limit
+			 * 3: remote offset (except max6646, max6657/58/59,
+			 *		     and max6695/96)
+			 * 4: local input
+			 * 5: remote 2 input (max6695/96 only)
+			 * 6: remote 2 low limit (max6695/96 only)
+			 * 7: remote 2 high limit (max6695/96 only)
+			 */
 	u8 temp_hyst;
 	u16 alarms; /* bitvector (upper 8 bits for max6695/96) */
 };
@@ -533,8 +535,10 @@ static struct lm90_data *lm90_update_device(struct device *dev)
 				data->alarms |= alarms << 8;
 		}
 
-		/* Re-enable ALERT# output if it was originally enabled and
-		 * relevant alarms are all clear */
+		/*
+		 * Re-enable ALERT# output if it was originally enabled and
+		 * relevant alarms are all clear
+		 */
 		if ((data->config_orig & 0x80) = 0
 		 && (data->alarms & data->alert_alarms) = 0) {
 			u8 config;
@@ -1162,8 +1166,10 @@ static int lm90_detect(struct i2c_client *client,
 		 && (config1 & 0x3F) = 0x00
 		 && convrate <= 0x0A) {
 			name = "adm1032";
-			/* The ADM1032 supports PEC, but only if combined
-			   transactions are not used. */
+			/*
+			 * The ADM1032 supports PEC, but only if combined
+			 * transactions are not used.
+			 */
 			if (i2c_check_functionality(adapter,
 						    I2C_FUNC_SMBUS_BYTE))
 				info->flags |= I2C_CLIENT_PEC;
@@ -1382,8 +1388,10 @@ static int lm90_probe(struct i2c_client *client,
 			client->flags &= ~I2C_CLIENT_PEC;
 	}
 
-	/* Different devices have different alarm bits triggering the
-	 * ALERT# output */
+	/*
+	 * Different devices have different alarm bits triggering the
+	 * ALERT# output
+	 */
 	data->alert_alarms = lm90_params[data->kind].alert_alarms;
 
 	/* Set chip capabilities */
@@ -1488,9 +1496,11 @@ static void lm90_alert(struct i2c_client *client, unsigned int flag)
 			dev_warn(&client->dev,
 				 "temp%d out of range, please check!\n", 3);
 
-		/* Disable ALERT# output, because these chips don't implement
-		  SMBus alert correctly; they should only hold the alert line
-		  low briefly. */
+		/*
+		 * Disable ALERT# output, because these chips don't implement
+		 * SMBus alert correctly; they should only hold the alert line
+		 * low briefly.
+		 */
 		if ((data->flags & LM90_HAVE_BROKEN_ALERT)
 		 && (alarms & data->alert_alarms)) {
 			dev_dbg(&client->dev, "Disabling ALERT#\n");
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
