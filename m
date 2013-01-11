From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 11 Jan 2013 14:46:07 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm73) Add 'update_interval' attribute
Message-Id: <1357915569-6669-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Chris Verges <kg4ysn@gmail.com>

The LM73 supports four A/D conversion resolutions.  The default used by
the existing lm73 driver is the chip's default, 11-bit (0.25 C/LSB).
This patch enables changing of this resolution from userspace via the
update_interval sysfs attribute.  Full details on usage are included in
Documentation/hwmon/lm73.

Signed-off-by: Chris Verges <kg4ysn@gmail.com>
[linux@roeck-us.net: cleanup]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm73 |   79 +++++++++++++++++++++++++++++++++++++
 drivers/hwmon/lm73.c     |   97 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 165 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/hwmon/lm73

diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
new file mode 100644
index 0000000..782b3e1
--- /dev/null
+++ b/Documentation/hwmon/lm73
@@ -0,0 +1,79 @@
+Kernel driver lm73
+=========
+
+Supported chips:
+  * Texas Instruments LM73
+    Prefix: 'lm73'
+    Addresses scanned: I2C 0x48, 0x49, 0x4a, 0x4c, 0x4d, and 0x4e
+    Datasheet: Publicly available at the Texas Instruments website
+               http://www.ti.com/product/lm73
+
+Author: Guillaume Ligneul <guillaume.ligneul@gmail.com>
+Documentation: Chris Verges <kg4ysn@gmail.com>
+
+
+Description
+-----------
+
+The LM73 is a digital temperature sensor.  All temperature values are
+given in degrees Celsius.
+
+Measurement Resolution Support
+------------------------------
+
+The LM73 supports four resolutions, defined in terms of degrees C per
+LSB: 0.25, 0.125, 0.0625, and 0.3125.  Changing the resolution mode
+affects the conversion time of the LM73's analog-to-digital converter.
+From userspace, the desired resolution can be specified as a function of
+conversion time via the 'update_interval' sysfs attribute for the
+device.  This attribute will normalize ranges of input values to the
+maximum times defined for the resolution in the datasheet.
+
+    Resolution    Conv. Time    Input Range
+    (C/LSB)       (msec)        (msec)
+    --------------------------------------
+    0.25          14             0..14
+    0.125         28            15..28
+    0.0625        56            29..56
+    0.03125       112           57..infinity
+    --------------------------------------
+
+The following examples show how the 'update_interval' attribute can be
+used to change the conversion time:
+
+    $ echo 0 > update_interval
+    $ cat update_interval
+    14
+    $ cat temp1_input
+    24250
+
+    $ echo 22 > update_interval
+    $ cat update_interval
+    28
+    $ cat temp1_input
+    24125
+
+    $ echo 56 > update_interval
+    $ cat update_interval
+    56
+    $ cat temp1_input
+    24062
+
+    $ echo 85 > update_interval
+    $ cat update_interval
+    112
+    $ cat temp1_input
+    24031
+
+As shown here, the lm73 driver automatically adjusts any user input for
+'update_interval' via a step function.  Reading back the
+'update_interval' value after a write operation will confirm the
+conversion time actively in use.
+
+Mathematically, the resolution can be derived from the conversion time
+via the following function:
+
+   g(x) = 0.250 * [log(x/14) / log(2)]
+
+where 'x' is the output from 'update_interval' and 'g(x)' is the
+resolution in degrees C per LSB.
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 5166a8e3..904c9ba 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -39,8 +39,24 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
 #define LM73_TEMP_MIN		(-40)
 #define LM73_TEMP_MAX		150
 
-/*-----------------------------------------------------------------------*/
+#define LM73_CTRL_RES_SHIFT	5
+#define LM73_CTRL_RES_MASK	(BIT(5) | BIT(6))
+#define LM73_CTRL_TO_MASK	BIT(7)
+
+static const unsigned short lm73_convrates[] = {
+	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
+	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
+	56,	/* 13-bits (0.06250 C/LSB): RES1 Bit = 1, RES0 Bit = 0 */
+	112,	/* 14-bits (0.03125 C/LSB): RES1 Bit = 1, RES0 Bit = 1 */
+};
+
+struct lm73_data {
+	struct device *hwmon_dev;
+	struct mutex lock;
+	u8 ctrl;			/* control register value */
+};
 
+/*-----------------------------------------------------------------------*/
 
 static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 			const char *buf, size_t count)
@@ -79,6 +95,51 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 	return scnprintf(buf, PAGE_SIZE, "%d\n", temp);
 }
 
+static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm73_data *data = i2c_get_clientdata(client);
+	unsigned long convrate;
+	s32 err;
+	int res = 0;
+
+	err = kstrtoul(buf, 10, &convrate);
+	if (err < 0)
+		return err;
+
+	/*
+	 * Convert the desired conversion rate into register bits.
+	 * res is already initialized, and everything past the second-to-last
+	 * value in the array is treated as belonging to the last value
+	 * in the array.
+	 */
+	while (res < (ARRAY_SIZE(lm73_convrates) - 1) &&
+			convrate > lm73_convrates[res])
+		res++;
+
+	mutex_lock(&data->lock);
+	data->ctrl &= LM73_CTRL_TO_MASK;
+	data->ctrl |= res << LM73_CTRL_RES_SHIFT;
+	err = i2c_smbus_write_byte_data(client, LM73_REG_CTRL, data->ctrl);
+	mutex_unlock(&data->lock);
+
+	if (err < 0)
+		return err;
+
+	return count;
+}
+
+static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
+			     char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm73_data *data = i2c_get_clientdata(client);
+	int res;
+
+	res = (data->ctrl & LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_SHIFT;
+	return scnprintf(buf, PAGE_SIZE, "%hu\n", lm73_convrates[res]);
+}
 
 /*-----------------------------------------------------------------------*/
 
@@ -90,13 +151,14 @@ static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
 			show_temp, set_temp, LM73_REG_MIN);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
 			show_temp, NULL, LM73_REG_INPUT);
-
+static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
+			show_convrate, set_convrate, 0);
 
 static struct attribute *lm73_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
-
+	&sensor_dev_attr_update_interval.dev_attr.attr,
 	NULL
 };
 
@@ -111,23 +173,36 @@ static const struct attribute_group lm73_group = {
 static int
 lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct device *hwmon_dev;
 	int status;
+	struct lm73_data *data;
+	int ctrl;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct lm73_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->lock);
+
+	ctrl = i2c_smbus_read_byte_data(client, LM73_REG_CTRL);
+	if (ctrl < 0)
+		return ctrl;
+	data->ctrl = ctrl;
 
 	/* Register sysfs hooks */
 	status = sysfs_create_group(&client->dev.kobj, &lm73_group);
 	if (status)
 		return status;
 
-	hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(hwmon_dev)) {
-		status = PTR_ERR(hwmon_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		status = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
-	i2c_set_clientdata(client, hwmon_dev);
 
 	dev_info(&client->dev, "%s: sensor '%s'\n",
-		 dev_name(hwmon_dev), client->name);
+		 dev_name(data->hwmon_dev), client->name);
 
 	return 0;
 
@@ -138,9 +213,9 @@ exit_remove:
 
 static int lm73_remove(struct i2c_client *client)
 {
-	struct device *hwmon_dev = i2c_get_clientdata(client);
+	struct lm73_data *data = i2c_get_clientdata(client);
 
-	hwmon_device_unregister(hwmon_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm73_group);
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
