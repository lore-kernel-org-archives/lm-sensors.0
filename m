From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Mar 2011 08:27:09 +0000
Subject: [lm-sensors] hwmon: (ads1015) Drop dynamic attribute group
Message-Id: <20110303092709.4ce3fe3a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It is cheaper to handle attributes individually.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Dirk Eibach <eibach@gdsys.de>
---
In my tests, my version saves 14 bytes on the binary driver, plus 96
bytes of alloc'd memory per device (struct ads1015_data size is down
from 136 bytes to 40 bytes on x86-64.)

Dirk, I will leave it up to you whether we apply this patch or not. Oh,
and by the way, I would appreciate if you could add yourself to
MAINTAINERS as the maintainer of the ads1015 driver.

 drivers/hwmon/ads1015.c |   50 ++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

--- linux-2.6.38-rc6.orig/drivers/hwmon/ads1015.c	2011-03-03 09:10:21.000000000 +0100
+++ linux-2.6.38-rc6/drivers/hwmon/ads1015.c	2011-03-03 09:16:05.000000000 +0100
@@ -51,8 +51,6 @@ static const unsigned int fullscale_tabl
 struct ads1015_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock; /* mutex protect updates */
-	struct attribute *attr_table[ADS1015_CONFIG_CHANNELS + 1];
-	struct attribute_group attr_group;
 };
 
 static s32 ads1015_read_reg(struct i2c_client *client, unsigned int reg)
@@ -141,28 +139,15 @@ static ssize_t show_in(struct device *de
 	return (res < 0) ? res : sprintf(buf, "%d\n", in);
 }
 
-#define in_reg(offset)\
-static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in,\
-	NULL, offset)
-
-in_reg(0);
-in_reg(1);
-in_reg(2);
-in_reg(3);
-in_reg(4);
-in_reg(5);
-in_reg(6);
-in_reg(7);
-
-static struct attribute *all_attributes[] = {
-	&sensor_dev_attr_in0_input.dev_attr.attr,
-	&sensor_dev_attr_in1_input.dev_attr.attr,
-	&sensor_dev_attr_in2_input.dev_attr.attr,
-	&sensor_dev_attr_in3_input.dev_attr.attr,
-	&sensor_dev_attr_in4_input.dev_attr.attr,
-	&sensor_dev_attr_in5_input.dev_attr.attr,
-	&sensor_dev_attr_in6_input.dev_attr.attr,
-	&sensor_dev_attr_in7_input.dev_attr.attr,
+static const struct sensor_device_attribute ads1015_in[] = {
+	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
+	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),
+	SENSOR_ATTR(in2_input, S_IRUGO, show_in, NULL, 2),
+	SENSOR_ATTR(in3_input, S_IRUGO, show_in, NULL, 3),
+	SENSOR_ATTR(in4_input, S_IRUGO, show_in, NULL, 4),
+	SENSOR_ATTR(in5_input, S_IRUGO, show_in, NULL, 5),
+	SENSOR_ATTR(in6_input, S_IRUGO, show_in, NULL, 6),
+	SENSOR_ATTR(in7_input, S_IRUGO, show_in, NULL, 7),
 };
 
 /*
@@ -172,8 +157,11 @@ static struct attribute *all_attributes[
 static int ads1015_remove(struct i2c_client *client)
 {
 	struct ads1015_data *data = i2c_get_clientdata(client);
+	int k;
+
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &data->attr_group);
+	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k)
+		device_remove_file(&client->dev, &ads1015_in[k].dev_attr);
 	kfree(data);
 	return 0;
 }
@@ -210,7 +198,6 @@ static int ads1015_probe(struct i2c_clie
 	int err;
 	unsigned int exported_channels;
 	unsigned int k;
-	unsigned int n = 0;
 
 	data = kzalloc(sizeof(struct ads1015_data), GFP_KERNEL);
 	if (!data) {
@@ -222,16 +209,14 @@ static int ads1015_probe(struct i2c_clie
 	mutex_init(&data->update_lock);
 
 	/* build sysfs attribute group */
-	data->attr_group.attrs = data->attr_table;
 	exported_channels = ads1015_get_exported_channels(client);
 	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k) {
 		if (!(exported_channels & (1<<k)))
 			continue;
-		data->attr_table[n++] = all_attributes[k];
+		err = device_create_file(&client->dev, &ads1015_in[k].dev_attr);
+		if (err)
+			goto exit_free;
 	}
-	err = sysfs_create_group(&client->dev.kobj, &data->attr_group);
-	if (err)
-		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -242,7 +227,8 @@ static int ads1015_probe(struct i2c_clie
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &data->attr_group);
+	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k)
+		device_remove_file(&client->dev, &ads1015_in[k].dev_attr);
 exit_free:
 	kfree(data);
 exit:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
