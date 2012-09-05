From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Sep 2012 02:03:27 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (adm9240) Remove legacy chassis intrusion detection sysfs attribute
Message-Id: <1346810610-26352-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm9240.c |   26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 5a78d10..8b24d1a 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -500,31 +500,6 @@ static ssize_t set_aout(struct device *dev,
 }
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
 
-/* chassis_clear */
-static ssize_t chassis_clear_legacy(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	long val;
-	int err;
-
-	err = kstrtol(buf, 10, &val);
-	if (err)
-		return err;
-
-	dev_warn(dev, "Attribute chassis_clear is deprecated, "
-		 "use intrusion0_alarm instead\n");
-
-	if (val = 1) {
-		i2c_smbus_write_byte_data(client,
-				ADM9240_REG_CHASSIS_CLEAR, 0x80);
-		dev_dbg(&client->dev, "chassis intrusion latch cleared\n");
-	}
-	return count;
-}
-static DEVICE_ATTR(chassis_clear, S_IWUSR, NULL, chassis_clear_legacy);
-
 static ssize_t chassis_clear(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
@@ -586,7 +561,6 @@ static struct attribute *adm9240_attributes[] = {
 	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_aout_output.attr,
-	&dev_attr_chassis_clear.attr,
 	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
 	&dev_attr_cpu0_vid.attr,
 	NULL
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
