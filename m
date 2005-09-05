From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:36 +0000
Subject: [lm-sensors] [PATCH] hwmon: (3/3) pc87360 driver update
Message-Id: <11259567712613@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: (3/3) pc87360 driver update

pc87360: consolidate fan helper

This patch consolidates the _set_fan_min() helper routine into the 2
line sysfs-callback wrapper that uses it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 11be27ea9bfd0ea7bca797ba6937285d18d426c2
tree 84d4952d0784b42990a3fbe1836d47992a22448d
parent 694fa056a60828ef54a5db958468cc600c3b3622
author Jim Cromie <jim.cromie@gmail.com> Fri, 02 Sep 2005 23:05:07 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:26:55 -0700

 drivers/hwmon/pc87360.c |   54 +++++++++++++++++++++--------------------------
 1 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
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

