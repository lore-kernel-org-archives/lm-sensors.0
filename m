From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 24 Jun 2013 17:23:29 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Drop unsupported fan alarm attributes for NCT6775
Message-Id: <1372094609-8620-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6775 does not support alarms for fans 4 and 5. Drop the attributes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 2405ab4..99cec18 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -199,7 +199,7 @@ static const s8 NCT6775_ALARM_BITS[] = {
 	0, 1, 2, 3, 8, 21, 20, 16,	/* in0.. in7 */
 	17, -1, -1, -1, -1, -1, -1,	/* in8..in14 */
 	-1,				/* unused */
-	6, 7, 11, 10, 23,		/* fan1..fan5 */
+	6, 7, 11, -1, -1,		/* fan1..fan5 */
 	-1, -1, -1,			/* unused */
 	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
 	12, -1 };			/* intrusion0, intrusion1 */
@@ -3877,10 +3877,12 @@ static int nct6775_probe(struct platform_device *pdev)
 						 &sda_fan_input[i].dev_attr);
 			if (err)
 				goto exit_remove;
-			err = device_create_file(dev,
-						 &sda_fan_alarm[i].dev_attr);
-			if (err)
-				goto exit_remove;
+			if (data->ALARM_BITS[FAN_ALARM_BASE + i] >= 0) {
+				err = device_create_file(dev,
+						&sda_fan_alarm[i].dev_attr);
+				if (err)
+					goto exit_remove;
+			}
 			if (data->kind != nct6776 &&
 			    data->kind != nct6779) {
 				err = device_create_file(dev,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
