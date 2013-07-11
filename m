From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Thu, 11 Jul 2013 05:03:00 +0000
Subject: [lm-sensors] [PATCH 1/1] hwmon: (abx500) Staticize abx500_temp_attributes
Message-Id: <1373518260-13344-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

abx500_temp_attributes is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/hwmon/abx500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
index eee1134..769fe20 100644
--- a/drivers/hwmon/abx500.c
+++ b/drivers/hwmon/abx500.c
@@ -315,7 +315,7 @@ static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IWUSR | S_IRUGO,
 static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_min_alarm, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_max_alarm, NULL, 3);
 
-struct attribute *abx500_temp_attributes[] = {
+static struct attribute *abx500_temp_attributes[] = {
 	&sensor_dev_attr_name.dev_attr.attr,
 
 	&sensor_dev_attr_temp1_label.dev_attr.attr,
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
