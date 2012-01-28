From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 28 Jan 2012 01:57:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) Disable setting DC mode for pwm2, pwm3 on NCT6776F
Message-Id: <1327715876-3605-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6776F only supports pwm mode for pwm2 and pwm3. Return error if an attempt
is made to set those pwm channels to DC mode.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627ehf.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index c0ef1a3..4f58202 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1318,6 +1318,7 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
+	struct w83627ehf_sio_data *sio_data = dev->platform_data;
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	unsigned long val;
@@ -1330,6 +1331,11 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 
 	if (val > 1)
 		return -EINVAL;
+
+	/* On NCT67766F, DC mode is only supported for pwm1 */
+	if (sio_data->kind = nct6776 && nr && val != 1)
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 	reg = w83627ehf_read_value(data, W83627EHF_REG_PWM_ENABLE[nr]);
 	data->pwm_mode[nr] = val;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
