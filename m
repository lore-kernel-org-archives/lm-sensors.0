From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 21 Feb 2012 18:58:54 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (max6639) Fix FAN_FROM_REG calculation
Message-Id: <1329850735-9876-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Chris D Schimp <silverchris@gmail.com>

RPM calculation from tachometer value does not depend on PPR.
Also, do not report negative RPM values.

Signed-off-by: Chris D Schimp <silverchris@gmail.com>
[guenter.roeck@ericsson.com: do not report negative RPM values]
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/max6639.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index e10a092..13e58a1 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -72,8 +72,8 @@ static unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
-#define FAN_FROM_REG(val, div, rpm_range)	((val) = 0 ? -1 : \
-	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / ((div + 1) * (val)))
+#define FAN_FROM_REG(val, rpm_range)	((val) = 0 || (val) = 255 ? \
+				0 : (rpm_ranges[rpm_range] * 30) / (val))
 #define TEMP_LIMIT_TO_REG(val)	SENSORS_LIMIT((val) / 1000, 0, 255)
 
 /*
@@ -333,7 +333,7 @@ static ssize_t show_fan_input(struct device *dev,
 		return PTR_ERR(data);
 
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->ppr, data->rpm_range));
+		       data->rpm_range));
 }
 
 static ssize_t show_alarm(struct device *dev,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
