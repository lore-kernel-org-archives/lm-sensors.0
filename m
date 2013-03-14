From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:20 +0000
Subject: [lm-sensors] [PATCH 5/9] hwmon: (ina2xx) Fix 'Avoid unnecessary line continuations' checkpatch warni
Message-Id: <1363221864-15284-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ina2xx.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 8e7158c..4958b2f 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -186,20 +186,20 @@ static ssize_t ina2xx_show_value(struct device *dev,
 }
 
 /* shunt voltage */
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, \
-	ina2xx_show_value, NULL, INA2XX_SHUNT_VOLTAGE);
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_value, NULL,
+			  INA2XX_SHUNT_VOLTAGE);
 
 /* bus voltage */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, \
-	ina2xx_show_value, NULL, INA2XX_BUS_VOLTAGE);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina2xx_show_value, NULL,
+			  INA2XX_BUS_VOLTAGE);
 
 /* calculated current */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, \
-	ina2xx_show_value, NULL, INA2XX_CURRENT);
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina2xx_show_value, NULL,
+			  INA2XX_CURRENT);
 
 /* calculated power */
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, \
-	ina2xx_show_value, NULL, INA2XX_POWER);
+static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx_show_value, NULL,
+			  INA2XX_POWER);
 
 /* pointers to created device attributes */
 static struct attribute *ina2xx_attributes[] = {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
