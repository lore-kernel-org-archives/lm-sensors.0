From: Robert Coulson <rob.coulson@gmail.com>
Date: Mon, 10 Jun 2013 20:50:17 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (ds1621) Add ds1721 update interval sysfs attribute
Message-Id: <1370897417-28903-1-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ds1721 device can be configured for 9..12 bit resolutions;
add a sysfs attribute for userspace to configure this attribute.
The definition, description, details, and usage are shown in the
documentation and were crafted from an LM73 driver patch done by
Chris Verges & Guenter Roeck).

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---

v2 - removes unused devattr variable reported by Jean Delvare.

 Documentation/hwmon/ds1621 |   65 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/ds1621.c     |   56 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
index ee7bc01..ae29036 100644
--- a/Documentation/hwmon/ds1621
+++ b/Documentation/hwmon/ds1621
@@ -75,3 +75,68 @@ The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
 degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
 default setting of 75 and 80 degrees respectifully, and a maximum conversion
 time of 750ms.
+
+In addition, the DS1721 supports four resolution settings from 9 to 12 bits
+(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625, respectifully),
+that are set at device power on to the highest resolution: 12-bits (0.0625 degree C).
+
+Changing the DS1721 resolution mode affects the conversion time and can be
+done from userspace, via the device 'update_interval' sysfs attribute. This
+attribute will normalize range of input values to the device maximum resolution
+values defined in the datasheet as such:
+
+Resolution    Conversion Time    Input Range
+ (C/LSB)       (msec)             (msec)
+--------------------------------------------
+0.5             93.75              0....94
+0.25            187.5              95...187
+0.125           375                188..375
+0.0625          750                376..infinity
+--------------------------------------
+
+The following examples show how the 'update_interval' attribute can be
+used to change the conversion time:
+
+$ cat update_interval
+750
+$ cat temp1_input
+22062
+$
+$ echo 300 > update_interval
+$ cat update_interval
+375
+$ cat temp1_input
+22125
+$
+$ echo 150 > update_interval
+$ cat update_interval
+188
+$ cat temp1_input
+22250
+$
+$ echo 1 > update_interval
+$ cat update_interval
+94
+$ cat temp1_input
+22000
+$
+$ echo 1000 > update_interval
+$ cat update_interval
+750
+$ cat temp1_input
+22062
+$
+
+As shown, the ds1621 driver automatically adjusts the 'update_interval'
+user input, via a step function. Reading back the 'update_interval' value
+after a write operation provides the conversion time used by the device.
+
+Mathematically, the resolution can be derived from the conversion time
+via the following function:
+
+   g(x) = 0.5 * [minimum_conversion_time/x]
+
+where:
+ -> 'x' = the output from 'update_interval'
+ -> 'g(x)' = the resolution in degrees C per LSB.
+ -> 93.75ms = minimum conversion time
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 04a3b12..763de4c 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -274,7 +274,47 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
 	return sprintf(buf, "%d\n", !!(data->conf & attr->index));
 }
 
+static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
+			  char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds1621_data *data = i2c_get_clientdata(client);
+	return scnprintf(buf, PAGE_SIZE, "%hu\n", data->update_interval);
+}
+
+static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds1621_data *data = i2c_get_clientdata(client);
+	unsigned long convrate;
+	s32 err;
+	int resol = 0;
+
+	err = kstrtoul(buf, 10, &convrate);
+	if (err)
+		return err;
+
+	/* Convert rate into resolution bits */
+	while (resol < (ARRAY_SIZE(ds1721_convrates) - 1) &&
+	       convrate > ds1721_convrates[resol])
+		resol++;
+
+	mutex_lock(&data->update_lock);
+	data->conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
+	data->conf &= ~DS1621_REG_CONFIG_RESOL;
+	data->conf |= (resol << DS1621_REG_CONFIG_RESOL_SHIFT);
+	i2c_smbus_write_byte_data(client, DS1621_REG_CONF, data->conf);
+	data->update_interval = ds1721_convrates[resol];
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_convrate,
+		   set_convrate);
+
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp, 1);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp, 2);
@@ -290,11 +330,27 @@ static struct attribute *ds1621_attributes[] = {
 	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	&dev_attr_alarms.attr,
+	&dev_attr_update_interval.attr,
 	NULL
 };
 
+static umode_t ds1621_attribute_visible(struct kobject *kobj,
+					struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds1621_data *data = i2c_get_clientdata(client);
+
+	if (attr = &dev_attr_update_interval.attr)
+		if (data->kind != ds1721)
+			/* shhh, we're hiding update_interval */
+			return 0;
+	return attr->mode;
+}
+
 static const struct attribute_group ds1621_group = {
 	.attrs = ds1621_attributes,
+	.is_visible = ds1621_attribute_visible
 };
 
 
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
