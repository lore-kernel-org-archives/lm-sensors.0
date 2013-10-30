From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Oct 2013 17:04:34 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Fix max6696 alarm handling
Message-Id: <1383152674-8018-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bit 2 of status register 2 on MAX6696 (external diode 2 open)
sets ALERT; the bit thus has to be listed in alert_alarms.
Also display a message in the alert handler if the condition
is encountered.

Even though not all overtemperature conditions cause ALERT
to be set, we should not ignore them in the alert handler.
Display messages for all out-of-range conditions.

Reported-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Not sure how this fits into the ongoing restructuring.
I may have to apply some of the other patches first; let me know.

 drivers/hwmon/lm90.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index cdff742..14e36c1 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -278,7 +278,7 @@ static const struct lm90_params lm90_params[] = {
 	[max6696] = {
 		.flags = LM90_HAVE_EMERGENCY
 		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3,
-		.alert_alarms = 0x187c,
+		.alert_alarms = 0x1c7c,
 		.max_convrate = 6,
 		.reg_local_ext = MAX6657_REG_R_LOCAL_TEMPL,
 	},
@@ -1500,19 +1500,22 @@ static void lm90_alert(struct i2c_client *client, unsigned int flag)
 	if ((alarms & 0x7f) = 0 && (alarms2 & 0xfe) = 0) {
 		dev_info(&client->dev, "Everything OK\n");
 	} else {
-		if (alarms & 0x61)
+		if ((alarms & 0x61) || (alarms2 & 0x80))
 			dev_warn(&client->dev,
 				 "temp%d out of range, please check!\n", 1);
-		if (alarms & 0x1a)
+		if ((alarms & 0x1a) || (alarms2 & 0x20))
 			dev_warn(&client->dev,
 				 "temp%d out of range, please check!\n", 2);
 		if (alarms & 0x04)
 			dev_warn(&client->dev,
 				 "temp%d diode open, please check!\n", 2);
 
-		if (alarms2 & 0x18)
+		if (alarms2 & 0x5a)
 			dev_warn(&client->dev,
 				 "temp%d out of range, please check!\n", 3);
+		if (alarms2 & 0x04)
+			dev_warn(&client->dev,
+				 "temp%d diode open, please check!\n", 3);
 
 		/*
 		 * Disable ALERT# output, because these chips don't implement
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
