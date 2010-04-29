From: Andre Prendel <andre.prendel@gmx.de>
Date: Thu, 29 Apr 2010 19:17:01 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (tmp401) Use constants for sysfs
Message-Id: <1272568622-3385-1-git-send-email-andre.prendel@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replace octal representation of file permissions by the corresponding
constants.

Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
---
 drivers/hwmon/tmp401.c |   50 ++++++++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index d14a1af..d58b40a 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -420,30 +420,36 @@ static ssize_t reset_temp_history(struct device *dev,
 }
 
 static struct sensor_device_attribute tmp401_attr[] = {
-	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
-	SENSOR_ATTR(temp1_min, 0644, show_temp_min, store_temp_min, 0),
-	SENSOR_ATTR(temp1_max, 0644, show_temp_max, store_temp_max, 0),
-	SENSOR_ATTR(temp1_crit, 0644, show_temp_crit, store_temp_crit, 0),
-	SENSOR_ATTR(temp1_crit_hyst, 0644, show_temp_crit_hyst,
+	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp_value, NULL, 0),
+	SENSOR_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    store_temp_min, 0),
+	SENSOR_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    store_temp_max, 0),
+	SENSOR_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_crit,
+		    store_temp_crit, 0),
+	SENSOR_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_crit_hyst,
 		    store_temp_crit_hyst, 0),
-	SENSOR_ATTR(temp1_min_alarm, 0444, show_status, NULL,
+	SENSOR_ATTR(temp1_min_alarm, S_IRUGO, show_status, NULL,
 		    TMP401_STATUS_LOCAL_LOW),
-	SENSOR_ATTR(temp1_max_alarm, 0444, show_status, NULL,
+	SENSOR_ATTR(temp1_max_alarm, S_IRUGO, show_status, NULL,
 		    TMP401_STATUS_LOCAL_HIGH),
-	SENSOR_ATTR(temp1_crit_alarm, 0444, show_status, NULL,
+	SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_status, NULL,
 		    TMP401_STATUS_LOCAL_CRIT),
-	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
-	SENSOR_ATTR(temp2_min, 0644, show_temp_min, store_temp_min, 1),
-	SENSOR_ATTR(temp2_max, 0644, show_temp_max, store_temp_max, 1),
-	SENSOR_ATTR(temp2_crit, 0644, show_temp_crit, store_temp_crit, 1),
-	SENSOR_ATTR(temp2_crit_hyst, 0444, show_temp_crit_hyst, NULL, 1),
-	SENSOR_ATTR(temp2_fault, 0444, show_status, NULL,
+	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp_value, NULL, 1),
+	SENSOR_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
+		    store_temp_min, 1),
+	SENSOR_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
+		    store_temp_max, 1),
+	SENSOR_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit,
+		    store_temp_crit, 1),
+	SENSOR_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 1),
+	SENSOR_ATTR(temp2_fault, S_IRUGO, show_status, NULL,
 		    TMP401_STATUS_REMOTE_OPEN),
-	SENSOR_ATTR(temp2_min_alarm, 0444, show_status, NULL,
+	SENSOR_ATTR(temp2_min_alarm, S_IRUGO, show_status, NULL,
 		    TMP401_STATUS_REMOTE_LOW),
-	SENSOR_ATTR(temp2_max_alarm, 0444, show_status, NULL,
+	SENSOR_ATTR(temp2_max_alarm, S_IRUGO, show_status, NULL,
 		    TMP401_STATUS_REMOTE_HIGH),
-	SENSOR_ATTR(temp2_crit_alarm, 0444, show_status, NULL,
+	SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_status, NULL,
 		    TMP401_STATUS_REMOTE_CRIT),
 };
 
@@ -455,11 +461,11 @@ static struct sensor_device_attribute tmp401_attr[] = {
  * and remote channels.
  */
 static struct sensor_device_attribute tmp411_attr[] = {
-	SENSOR_ATTR(temp1_highest, 0444, show_temp_highest, NULL, 0),
-	SENSOR_ATTR(temp1_lowest, 0444, show_temp_lowest, NULL, 0),
-	SENSOR_ATTR(temp2_highest, 0444, show_temp_highest, NULL, 1),
-	SENSOR_ATTR(temp2_lowest, 0444, show_temp_lowest, NULL, 1),
-	SENSOR_ATTR(temp_reset_history, 0200, NULL, reset_temp_history, 0),
+	SENSOR_ATTR(temp1_highest, S_IRUGO, show_temp_highest, NULL, 0),
+	SENSOR_ATTR(temp1_lowest, S_IRUGO, show_temp_lowest, NULL, 0),
+	SENSOR_ATTR(temp2_highest, S_IRUGO, show_temp_highest, NULL, 1),
+	SENSOR_ATTR(temp2_lowest, S_IRUGO, show_temp_lowest, NULL, 1),
+	SENSOR_ATTR(temp_reset_history, S_IWUSR, NULL, reset_temp_history, 0),
 };
 
 /*
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
