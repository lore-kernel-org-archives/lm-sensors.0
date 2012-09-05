From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Sep 2012 02:03:29 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (w83793) Remove legacy chassis intrusion detection sysfs attributes
Message-Id: <1346810610-26352-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83793.c |   23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index d6b0bdd..4fc47e0 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -442,27 +442,6 @@ store_beep_enable(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* Write any value to clear chassis alarm */
-static ssize_t
-store_chassis_clear_legacy(struct device *dev,
-			   struct device_attribute *attr, const char *buf,
-			   size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83793_data *data = i2c_get_clientdata(client);
-	u8 val;
-
-	dev_warn(dev, "Attribute chassis is deprecated, "
-		 "use intrusion0_alarm instead\n");
-
-	mutex_lock(&data->update_lock);
-	val = w83793_read_value(client, W83793_REG_CLR_CHASSIS);
-	val |= 0x80;
-	w83793_write_value(client, W83793_REG_CLR_CHASSIS, val);
-	mutex_unlock(&data->update_lock);
-	return count;
-}
-
 /* Write 0 to clear chassis alarm */
 static ssize_t
 store_chassis_clear(struct device *dev,
@@ -1189,8 +1168,6 @@ static struct sensor_device_attribute_2 w83793_vid[] = {
 static DEVICE_ATTR(vrm, S_IWUSR | S_IRUGO, show_vrm, store_vrm);
 
 static struct sensor_device_attribute_2 sda_single_files[] = {
-	SENSOR_ATTR_2(chassis, S_IWUSR | S_IRUGO, show_alarm_beep,
-		      store_chassis_clear_legacy, ALARM_STATUS, 30),
 	SENSOR_ATTR_2(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm_beep,
 		      store_chassis_clear, ALARM_STATUS, 30),
 	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_beep_enable,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
