From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:21 +0000
Subject: [lm-sensors] [PATCH 6/9] hwmon: (ltc4151) Fix 'Avoid unnecessary line continuations' checkpatch warn
Message-Id: <1363221864-15284-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4151.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ltc4151.c b/drivers/hwmon/ltc4151.c
index 4319a94..af81be1 100644
--- a/drivers/hwmon/ltc4151.c
+++ b/drivers/hwmon/ltc4151.c
@@ -146,14 +146,14 @@ static ssize_t ltc4151_show_value(struct device *dev,
 /*
  * Input voltages.
  */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, \
-	ltc4151_show_value, NULL, LTC4151_VIN_H);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, \
-	ltc4151_show_value, NULL, LTC4151_ADIN_H);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4151_show_value, NULL,
+			  LTC4151_VIN_H);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4151_show_value, NULL,
+			  LTC4151_ADIN_H);
 
 /* Currents (via sense resistor) */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, \
-	ltc4151_show_value, NULL, LTC4151_SENSE_H);
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4151_show_value, NULL,
+			  LTC4151_SENSE_H);
 
 /*
  * Finally, construct an array of pointers to members of the above objects,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
