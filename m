From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 04 Jun 2012 15:53:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: (emc2103) Fix use of an uninitilized variable in error case
Message-Id: <1338825228-29311-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix:

emc2103.c: In function set_pwm_enable:
emc2103.c:463:12: warning: conf_reg may be used uninitialized in this function

by checking the return value from read_u8_from_i2c(). This fixes a real problem,
as conf_reg is really uninitialized if read_u8_from_i2c returns an error.

Cc: Steve Glendinning <steve.glendinning@smsc.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc2103.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index 9691f66..ff68563 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -451,11 +451,13 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
 		data->fan_rpm_control = true;
 		break;
 	default:
-		mutex_unlock(&data->update_lock);
-		return -EINVAL;
+		result = -EINVAL;
+		goto err;
 	}
 
-	read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg);
+	result = read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg);
+	if (result)
+		goto err;
 
 	if (data->fan_rpm_control)
 		conf_reg |= 0x80;
@@ -464,8 +466,10 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
 
 	i2c_smbus_write_byte_data(client, REG_FAN_CONF1, conf_reg);
 
+	result = count;
+err:
 	mutex_unlock(&data->update_lock);
-	return count;
+	return result;
 }
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
