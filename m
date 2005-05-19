From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] I2C: Update fscher pwm functionality
Message-Id: <20050105224847.4868fe93.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This is a small update to the fscher hardware monitoring chip driver.
More specifically it fixes two aspects of pwm:
1* Use the new sysfs names (e.g. pwm1 instead of fan1_pwm).
2* Better handling of out-of-range pwm values.

Please apply,
Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/drivers/i2c/chips/fscher.c.orig	2004-12-26 16:13:38.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/fscher.c	2005-01-05 20:40:34.000000000 +0100
@@ -192,7 +192,7 @@
 static DEVICE_ATTR(kind, S_IRUGO, show_##kind##0##sub, NULL);
 
 #define sysfs_fan(offset, reg_status, reg_min, reg_ripple, reg_act) \
-sysfs_rw_n(fan, _pwm   , offset, reg_min) \
+sysfs_rw_n(pwm,        , offset, reg_min) \
 sysfs_rw_n(fan, _status, offset, reg_status) \
 sysfs_rw_n(fan, _div   , offset, reg_ripple) \
 sysfs_ro_n(fan, _input , offset, reg_act)
@@ -241,7 +241,7 @@
 #define device_create_file_fan(client, offset) \
 do { \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_status); \
-	device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
+	device_create_file(&client->dev, &dev_attr_pwm##offset); \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
 } while (0)
@@ -476,16 +476,17 @@
 	return sprintf(buf, "%u\n", data->fan_status[FAN_INDEX_FROM_NUM(nr)] & 0x04);
 }
 
-static ssize_t set_fan_pwm(struct i2c_client *client, struct fscher_data *data,
+static ssize_t set_pwm(struct i2c_client *client, struct fscher_data *data,
 		       const char *buf, size_t count, int nr, int reg)
 {
-	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = simple_strtoul(buf, NULL, 10) & 0xff;
+	unsigned long v = simple_strtoul(buf, NULL, 10);
+	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = v > 0xff ? 0xff : v;
 
 	fscher_write_value(client, reg, data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
 	return count;
 }
 
-static ssize_t show_fan_pwm (struct fscher_data *data, char *buf, int nr)
+static ssize_t show_pwm(struct fscher_data *data, char *buf, int nr)
 {
 	return sprintf(buf, "%u\n", data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
 }


-- 
Jean Delvare
http://khali.linux-fr.org/
