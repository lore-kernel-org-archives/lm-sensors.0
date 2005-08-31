From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 31 Aug 2005 20:29:54 +0000
Subject: [lm-sensors] [patch-A 5/5] pc87360 SDA callbacks - consolidate fan
Message-Id: <200508311828.j7VIS8Dv006827@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



05.	i2c-pc87360-sda-05-consolidate-fan-helper.patch

This patch consolidates the _set_fan_min() helper routine into the 2
line sysfs-callback wrapper that uses it.



Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

diff -ruNp -X exclude-diffs B-4/drivers/hwmon/pc87360.c B-5/drivers/hwmon/pc87360.c
--- B-4/drivers/hwmon/pc87360.c	2005-08-31 10:31:27.000000000 -0600
+++ B-5/drivers/hwmon/pc87360.c	2005-08-31 10:31:59.000000000 -0600
@@ -246,35 +246,6 @@ static struct i2c_driver pc87360_driver 
  * Sysfs stuff
  */
 
-static ssize_t _set_fan_min(struct device *dev, const char *buf,
-	size_t count, int nr)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	long fan_min = simple_strtol(buf, NULL, 10);
-
-	down(&data->update_lock);
-	fan_min = FAN_TO_REG(fan_min, FAN_DIV_FROM_REG(data->fan_status[nr]));
-
-	/* If it wouldn't fit, change clock divisor */
-	while (fan_min > 255
-	    && (data->fan_status[nr] & 0x60) != 0x60) {
-		fan_min >>= 1;
-		data->fan[nr] >>= 1;
-		data->fan_status[nr] += 0x20;
-	}
-	data->fan_min[nr] = fan_min > 255 ? 255 : fan_min;
-	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_MIN(nr),
-			    data->fan_min[nr]);
-
-	/* Write new divider, preserve alarm bits */
-	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_STATUS(nr),
-			    data->fan_status[nr] & 0xF9);
-	up(&data->update_lock);
-
-	return count;
-}
-
 static ssize_t show_fan_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -307,7 +278,30 @@ static ssize_t set_fan_min(struct device
 	size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	return _set_fan_min(dev, buf, count, attr->index);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long fan_min = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	fan_min = FAN_TO_REG(fan_min, FAN_DIV_FROM_REG(data->fan_status[attr->index]));
+
+	/* If it wouldn't fit, change clock divisor */
+	while (fan_min > 255
+	    && (data->fan_status[attr->index] & 0x60) != 0x60) {
+		fan_min >>= 1;
+		data->fan[attr->index] >>= 1;
+		data->fan_status[attr->index] += 0x20;
+	}
+	data->fan_min[attr->index] = fan_min > 255 ? 255 : fan_min;
+	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_MIN(attr->index),
+			    data->fan_min[attr->index]);
+
+	/* Write new divider, preserve alarm bits */
+	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_STATUS(attr->index),
+			    data->fan_status[attr->index] & 0xF9);
+	up(&data->update_lock);
+
+	return count;
 }
 
 #define show_and_set_fan(offset) \
@@ -559,6 +553,7 @@ static ssize_t show_in_alarms(struct dev
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
 
+
 static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -651,6 +646,7 @@ show_and_set_temp(2)
 show_and_set_temp(3)
 
 
+
 static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
