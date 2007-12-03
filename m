From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Dec 2007 22:28:42 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm85) Make the pwmN_enable files
Message-Id: <20071203232842.0d6b57f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the pwmN_enable files writable. This makes it possible to use
standard fan speed control tools (pwmconfig, fancontrol) with the lm85
driver.

I left the non-standard pwmN_auto_channels files in place, as they
give additional control for the automatic mode, and some users might
be used to them by now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/lm85.c	2007-12-03 18:02:57.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/lm85.c	2007-12-03 20:43:48.000000000 +0100
@@ -532,11 +532,47 @@ static ssize_t show_pwm_enable(struct de
 	return sprintf(buf, "%d\n", enable);
 }
 
+static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
+		*attr, const char *buf, size_t count)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm85_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	u8 config;
+
+	switch (val) {
+	case 0:
+		config = 3;
+		break;
+	case 1:
+		config = 7;
+		break;
+	case 2:
+		/* Here we have to choose arbitrarily one of the 5 possible
+		   configurations; I go for the safest */
+		config = 6;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->update_lock);
+	data->autofan[nr].config = lm85_read_value(client,
+		LM85_REG_AFAN_CONFIG(nr));
+	data->autofan[nr].config = (data->autofan[nr].config & ~0xe0)
+		| (config << 5);
+	lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
+		data->autofan[nr].config);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
 #define show_pwm_reg(offset)						\
 static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
 		show_pwm, set_pwm, offset - 1);				\
-static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO,		\
-		show_pwm_enable, NULL, offset - 1)
+static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
+		show_pwm_enable, set_pwm_enable, offset - 1)
 
 show_pwm_reg(1);
 show_pwm_reg(2);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
