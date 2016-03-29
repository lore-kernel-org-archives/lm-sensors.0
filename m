From: Alexander Koch <mail@alexanderkoch.net>
Date: Tue, 29 Mar 2016 19:03:38 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: adc128d818: Implement chip mode selection
Message-Id: <1459278219-5573-2-git-send-email-mail@alexanderkoch.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1459278219-5573-1-git-send-email-mail@alexanderkoch.net>
In-Reply-To: <1459278219-5573-1-git-send-email-mail@alexanderkoch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Michael Hornung <mhornung.linux@gmail.com>, Alexander Koch <mail@alexanderkoch.net>

The ADC128D818 offers four operation modes (see datasheet sec. 8.4.1)
which vary in the number of available input signals and their types
(differential vs. absolute).

The current version of this driver only implements mode 0, this patch
prepares implementation of the others.

 * Introduce device tree property 'mode' for selection of chip operation
   mode, default to mode 0

 * Extend device data structure to cover all eight input channels

Example of 'mode' usage:

        adc1: adc128d818@1d {
                compatible = "ti,adc128d818";
                reg = <0x1d>;
                mode = /bits/ 8 <0>;
        };

Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
Acked-by: Michael Hornung <mhornung.linux@gmail.com>
---
 drivers/hwmon/adc128d818.c | 67 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index ad2b47e..7505d4e 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -28,6 +28,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
+#include <linux/of.h>
 
 /* Addresses to scan
  * The chip also supports addresses 0x35..0x37. Don't scan those addresses
@@ -63,10 +64,11 @@ struct adc128_data {
 	struct regulator *regulator;
 	int vref;		/* Reference voltage in mV */
 	struct mutex update_lock;
+	u8 mode;		/* Operation mode */
 	bool valid;		/* true if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	u16 in[3][7];		/* Register value, normalized to 12 bit
+	u16 in[3][8];		/* Register value, normalized to 12 bit
 				 * 0: input voltage
 				 * 1: min limit
 				 * 2: max limit
@@ -82,12 +84,14 @@ static struct adc128_data *adc128_update_device(struct device *dev)
 	struct adc128_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	struct adc128_data *ret = data;
-	int i, rv;
+	int i, rv, no_in;
+
+	no_in = (data->mode = 1 || data->mode = 2) ? 8 : 7;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		for (i = 0; i < 7; i++) {
+		for (i = 0; i < no_in; i++) {
 			rv = i2c_smbus_read_word_swapped(client,
 							 ADC128_REG_IN(i));
 			if (rv < 0)
@@ -107,20 +111,25 @@ static struct adc128_data *adc128_update_device(struct device *dev)
 			data->in[2][i] = rv << 4;
 		}
 
-		rv = i2c_smbus_read_word_swapped(client, ADC128_REG_TEMP);
-		if (rv < 0)
-			goto abort;
-		data->temp[0] = rv >> 7;
+		if (data->mode != 1) {
+			rv = i2c_smbus_read_word_swapped(client,
+							 ADC128_REG_TEMP);
+			if (rv < 0)
+				goto abort;
+			data->temp[0] = rv >> 7;
 
-		rv = i2c_smbus_read_byte_data(client, ADC128_REG_TEMP_MAX);
-		if (rv < 0)
-			goto abort;
-		data->temp[1] = rv << 1;
+			rv = i2c_smbus_read_byte_data(client,
+						      ADC128_REG_TEMP_MAX);
+			if (rv < 0)
+				goto abort;
+			data->temp[1] = rv << 1;
 
-		rv = i2c_smbus_read_byte_data(client, ADC128_REG_TEMP_HYST);
-		if (rv < 0)
-			goto abort;
-		data->temp[2] = rv << 1;
+			rv = i2c_smbus_read_byte_data(client,
+						      ADC128_REG_TEMP_HYST);
+			if (rv < 0)
+				goto abort;
+			data->temp[2] = rv << 1;
+		}
 
 		rv = i2c_smbus_read_byte_data(client, ADC128_REG_ALARM);
 		if (rv < 0)
@@ -304,7 +313,7 @@ static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, adc128_show_alarm, NULL, 5);
 static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, adc128_show_alarm, NULL, 6);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adc128_show_alarm, NULL, 7);
 
-static struct attribute *adc128_attrs[] = {
+static struct attribute *adc128m0_attrs[] = {
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in1_min.dev_attr.attr,
 	&sensor_dev_attr_in2_min.dev_attr.attr,
@@ -339,7 +348,7 @@ static struct attribute *adc128_attrs[] = {
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(adc128);
+ATTRIBUTE_GROUPS(adc128m0);
 
 static int adc128_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
@@ -387,6 +396,15 @@ static int adc128_init_client(struct adc128_data *data)
 	if (err)
 		return err;
 
+	/* Set operation mode, if non-default */
+	if (data->mode != 0) {
+		err = i2c_smbus_write_byte_data(client,
+						ADC128_REG_CONFIG_ADV,
+						data->mode << 1);
+		if (err)
+			return err;
+	}
+
 	/* Start monitoring */
 	err = i2c_smbus_write_byte_data(client, ADC128_REG_CONFIG, 0x01);
 	if (err)
@@ -410,6 +428,7 @@ static int adc128_probe(struct i2c_client *client,
 	struct regulator *regulator;
 	struct device *hwmon_dev;
 	struct adc128_data *data;
+	const struct attribute_group **groups;
 	int err, vref;
 
 	data = devm_kzalloc(dev, sizeof(struct adc128_data), GFP_KERNEL);
@@ -433,6 +452,18 @@ static int adc128_probe(struct i2c_client *client,
 		data->vref = 2560;	/* 2.56V, in mV */
 	}
 
+	/* Operation mode is optional and defaults to mode 0 */
+	data->mode = 0;
+	groups = adc128m0_groups;
+	if (of_property_read_u8(dev->of_node, "mode", &data->mode) = 0) {
+		if (data->mode != 0) {
+			dev_err(dev, "unsupported operation mode %d",
+				data->mode);
+			err = -EINVAL;
+			goto error;
+		}
+	}
+
 	data->client = client;
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -443,7 +474,7 @@ static int adc128_probe(struct i2c_client *client,
 		goto error;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-							   data, adc128_groups);
+							   data, groups);
 	if (IS_ERR(hwmon_dev)) {
 		err = PTR_ERR(hwmon_dev);
 		goto error;
-- 
2.7.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
