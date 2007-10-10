From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Oct 2007 19:14:11 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (adm1025) Various cleanups
Message-Id: <20071010211411.44b47d10@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Whitespace cleanups
* Constify scaling constants
* Fold long lines
* Drop redundant initializations to 0
* Rename new_client to just client
* Use sysfs_create_group()
* Drop a useless comment

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1025.c |   80 +++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

--- linux-2.6.23.orig/drivers/hwmon/adm1025.c	2007-10-10 20:55:30.000000000 +0200
+++ linux-2.6.23/drivers/hwmon/adm1025.c	2007-10-10 20:55:42.000000000 +0200
@@ -75,7 +75,7 @@ I2C_CLIENT_INSMOD_2(adm1025, ne1619);
  */
 
 #define ADM1025_REG_MAN_ID		0x3E
-#define ADM1025_REG_CHIP_ID 		0x3F
+#define ADM1025_REG_CHIP_ID		0x3F
 #define ADM1025_REG_CONFIG		0x40
 #define ADM1025_REG_STATUS1		0x41
 #define ADM1025_REG_STATUS2		0x42
@@ -93,7 +93,7 @@ I2C_CLIENT_INSMOD_2(adm1025, ne1619);
  * The ADM1025 uses signed 8-bit values for temperatures.
  */
 
-static int in_scale[6] = { 2500, 2250, 3300, 5000, 12000, 3300 };
+static const int in_scale[6] = { 2500, 2250, 3300, 5000, 12000, 3300 };
 
 #define IN_FROM_REG(reg,scale)	(((reg) * (scale) + 96) / 192)
 #define IN_TO_REG(val,scale)	((val) <= 0 ? 0 : \
@@ -293,7 +293,8 @@ static SENSOR_DEVICE_ATTR(temp##offset##
 set_temp(1);
 set_temp(2);
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t
+show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -317,19 +318,22 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 4);
 static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 14);
 
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t
+show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t
+show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1025_data *data = i2c_get_clientdata(client);
@@ -389,7 +393,7 @@ static const struct attribute_group adm1
 	.attrs = adm1025_attributes,
 };
 
-static struct attribute *adm1025_attributes_opt[] = {
+static struct attribute *adm1025_attributes_in4[] = {
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
@@ -397,8 +401,8 @@ static struct attribute *adm1025_attribu
 	NULL
 };
 
-static const struct attribute_group adm1025_group_opt = {
-	.attrs = adm1025_attributes_opt,
+static const struct attribute_group adm1025_group_in4 = {
+	.attrs = adm1025_attributes_in4,
 };
 
 /*
@@ -407,7 +411,7 @@ static const struct attribute_group adm1
  */
 static int adm1025_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct adm1025_data *data;
 	int err = 0;
 	const char *name = "";
@@ -421,14 +425,11 @@ static int adm1025_detect(struct i2c_ada
 		goto exit;
 	}
 
-	/* The common I2C client data is placed right before the
-	   ADM1025-specific data. */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &adm1025_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &adm1025_driver;
 
 	/*
 	 * Now we do the remaining detection. A negative kind means that
@@ -440,12 +441,12 @@ static int adm1025_detect(struct i2c_ada
 	 * requested, so both the detection and the identification steps
 	 * are skipped.
 	 */
-	config = i2c_smbus_read_byte_data(new_client, ADM1025_REG_CONFIG);
+	config = i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG);
 	if (kind < 0) { /* detection */
 		if ((config & 0x80) != 0x00
-		 || (i2c_smbus_read_byte_data(new_client,
+		 || (i2c_smbus_read_byte_data(client,
 		     ADM1025_REG_STATUS1) & 0xC0) != 0x00
-		 || (i2c_smbus_read_byte_data(new_client,
+		 || (i2c_smbus_read_byte_data(client,
 		     ADM1025_REG_STATUS2) & 0xBC) != 0x00) {
 			dev_dbg(&adapter->dev,
 				"ADM1025 detection failed at 0x%02x.\n",
@@ -457,11 +458,9 @@ static int adm1025_detect(struct i2c_ada
 	if (kind <= 0) { /* identification */
 		u8 man_id, chip_id;
 
-		man_id = i2c_smbus_read_byte_data(new_client,
-			 ADM1025_REG_MAN_ID);
-		chip_id = i2c_smbus_read_byte_data(new_client,
-			  ADM1025_REG_CHIP_ID);
-		
+		man_id = i2c_smbus_read_byte_data(client, ADM1025_REG_MAN_ID);
+		chip_id = i2c_smbus_read_byte_data(client, ADM1025_REG_CHIP_ID);
+
 		if (man_id = 0x41) { /* Analog Devices */
 			if ((chip_id & 0xF0) = 0x20) { /* ADM1025/ADM1025A */
 				kind = adm1025;
@@ -489,35 +488,28 @@ static int adm1025_detect(struct i2c_ada
 	}
 
 	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->valid = 0;
+	strlcpy(client->name, name, I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 
 	/* Initialize the ADM1025 chip */
-	adm1025_init_client(new_client);
+	adm1025_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm1025_group)))
+	if ((err = sysfs_create_group(&client->dev.kobj, &adm1025_group)))
 		goto exit_detach;
 
 	/* Pin 11 is either in4 (+12V) or VID4 */
 	if (!(config & 0x20)) {
-		if ((err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in4_input.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in4_min.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in4_max.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in4_alarm.dev_attr)))
+		if ((err = sysfs_create_group(&client->dev.kobj,
+					      &adm1025_group_in4)))
 			goto exit_remove;
 	}
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
@@ -526,10 +518,10 @@ static int adm1025_detect(struct i2c_ada
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &adm1025_group);
-	sysfs_remove_group(&new_client->dev.kobj, &adm1025_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
+	sysfs_remove_group(&client->dev.kobj, &adm1025_group_in4);
 exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
@@ -585,7 +577,7 @@ static int adm1025_detach_client(struct 
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
-	sysfs_remove_group(&client->dev.kobj, &adm1025_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &adm1025_group_in4);
 
 	if ((err = i2c_detach_client(client)))
 		return err;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
