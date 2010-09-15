From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:00:34 +0000
Subject: [lm-sensors] [patch 22/36] hwmon: (w83795) Rework beep_enable
Message-Id: <20100915160034.61448125@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Handle beep_enable just like all other beep bits. It doesn't need
anything special, so let's avoid redundant code. This also saves a
duplicate register read at initialization time.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   40 ++--------------------------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:13:54.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:13:57.000000000 +0200
@@ -398,7 +398,6 @@ struct w83795_data {
 
 	u8 alarms[6];		/* Register value */
 	u8 beeps[6];		/* Register value */
-	u8 beep_enable;
 
 	char valid;
 };
@@ -616,39 +615,6 @@ store_beep(struct device *dev, struct de
 	return count;
 }
 
-static ssize_t
-show_beep_enable(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
-	return sprintf(buf, "%u\n", data->beep_enable);
-}
-
-static ssize_t
-store_beep_enable(struct device *dev, struct device_attribute *attr,
-		  const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
-	unsigned long val;
-	u8 tmp;
-
-	if (strict_strtoul(buf, 10, &val) < 0)
-		return -EINVAL;
-	if (val != 0 && val != 1)
-		return -EINVAL;
-
-	mutex_lock(&data->update_lock);
-	data->beep_enable = val;
-	tmp = w83795_read(client, W83795_REG_BEEP(5));
-	tmp &= 0x7f;
-	tmp |= val << 7;
-	w83795_write(client, W83795_REG_BEEP(5), tmp);
-	mutex_unlock(&data->update_lock);
-
-	return count;
-}
-
 /* Write any value to clear chassis alarm */
 static ssize_t
 store_chassis_clear(struct device *dev,
@@ -1689,8 +1655,8 @@ static const struct sensor_device_attrib
 static const struct sensor_device_attribute_2 sda_single_files[] = {
 	SENSOR_ATTR_2(chassis, S_IWUSR | S_IRUGO, show_alarm_beep,
 		      store_chassis_clear, ALARM_STATUS, 46),
-	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_beep_enable,
-		      store_beep_enable, NOT_USED, NOT_USED),
+	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_alarm_beep,
+		      store_beep, BEEP_ENABLE, 47),
 	SENSOR_ATTR_2(speed_cruise_tolerance, S_IWUSR | S_IRUGO, show_fanin,
 		store_fanin, FANIN_TOL, NOT_USED),
 	SENSOR_ATTR_2(pwm_default, S_IWUSR | S_IRUGO, show_sf_setup,
@@ -2136,8 +2102,6 @@ static int w83795_probe(struct i2c_clien
 		data->alarms[i] = w83795_read(client, W83795_REG_ALARM(i));
 		data->beeps[i] = w83795_read(client, W83795_REG_BEEP(i));
 	}
-	data->beep_enable -		(w83795_read(client, W83795_REG_BEEP(5)) >> 7) & 0x01;
 
 	err = w83795_handle_files(dev, device_create_file);
 	if (err)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
