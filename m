From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 19 May 2009 08:08:05 +0000
Subject: [lm-sensors] [PATCH v2 2/3] tmp401: Add support for TI's TMP411
Message-Id: <20090519080805.GC5200@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This adds support for TI's TMP411 sensor chip.

Preliminary support were done by Gabriel Konat, Sander Leget and
Wouter Willems. The chip is compatible with TI's TMP401 sensor
chip. It has additional support for historical minimun/maximum
measurements.

Changes in v2:

Adjust copyright notes.
Add sysfs attribute temp_reset_history to reset to temperature history.
Fix condition in tmp401_update_device_reg16().

Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
---
 drivers/hwmon/tmp401.c |  206 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 165 insertions(+), 41 deletions(-)

Index: linux-2.6/drivers/hwmon/tmp401.c
=================================--- linux-2.6.orig/drivers/hwmon/tmp401.c	2009-05-18 22:02:37.000000000 +0200
+++ linux-2.6/drivers/hwmon/tmp401.c	2009-05-18 22:05:30.000000000 +0200
@@ -1,6 +1,9 @@
 /* tmp401.c
  *
  * Copyright (C) 2007,2008 Hans de Goede <hdegoede@redhat.com>
+ * Preliminary tmp411 support by:
+ * Gabriel Konat, Sander Leget, Wouter Willems
+ * Copyright (C) 2009 Andre Prendel <andre.prendel@gmx.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -40,8 +43,7 @@
 static const unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(tmp401);
-
+I2C_CLIENT_INSMOD_2(tmp401, tmp411);
 
 /*
  * The TMP401 registers, note some registers have different addresses for
@@ -56,6 +58,7 @@
 #define TMP401_CONSECUTIVE_ALERT		0x22
 #define TMP401_MANUFACTURER_ID_REG		0xFE
 #define TMP401_DEVICE_ID_REG			0xFF
+#define TMP411_N_FACTOR_REG			0x18
 
 static const u8 TMP401_TEMP_MSB[2]			= { 0x00, 0x01 };
 static const u8 TMP401_TEMP_LSB[2]			= { 0x15, 0x10 };
@@ -68,6 +71,11 @@
 /* These are called the THERM limit / hysteresis / mask in the datasheet */
 static const u8 TMP401_TEMP_CRIT_LIMIT[2]		= { 0x20, 0x19 };
 
+static const u8 TMP411_TEMP_LOWEST_MSB[2]		= { 0x30, 0x34 };
+static const u8 TMP411_TEMP_LOWEST_LSB[2]		= { 0x31, 0x35 };
+static const u8 TMP411_TEMP_HIGHEST_MSB[2]		= { 0x32, 0x36 };
+static const u8 TMP411_TEMP_HIGHEST_LSB[2]		= { 0x33, 0x37 };
+
 /* Flags */
 #define TMP401_CONFIG_RANGE		0x04
 #define TMP401_CONFIG_SHUTDOWN		0x40
@@ -82,6 +90,7 @@
 /* Manufacturer / Device ID's */
 #define TMP401_MANUFACTURER_ID			0x55
 #define TMP401_DEVICE_ID			0x11
+#define TMP411_DEVICE_ID			0x12
 
 /*
  * Functions declarations
@@ -100,6 +109,7 @@
 
 static const struct i2c_device_id tmp401_id[] = {
 	{ "tmp401", tmp401 },
+	{ "tmp411", tmp411 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp401_id);
@@ -125,6 +135,7 @@
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
+	int kind;
 
 	/* register values */
 	u8 status;
@@ -134,6 +145,8 @@
 	u16 temp_high[2];
 	u8 temp_crit[2];
 	u8 temp_crit_hyst;
+	u16 temp_lowest[2];
+	u16 temp_highest[2];
 };
 
 /*
@@ -238,6 +251,28 @@
 	return sprintf(buf, "%d\n", temp);
 }
 
+static ssize_t show_temp_lowest(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct tmp401_data *data = tmp401_update_device(dev);
+
+	return sprintf(buf, "%d\n",
+		tmp401_register_to_temp(data->temp_lowest[index],
+					data->config));
+}
+
+static ssize_t show_temp_highest(struct device *dev,
+	struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct tmp401_data *data = tmp401_update_device(dev);
+
+	return sprintf(buf, "%d\n",
+		tmp401_register_to_temp(data->temp_highest[index],
+					data->config));
+}
+
 static ssize_t show_status(struct device *dev,
 	struct device_attribute *devattr, char *buf)
 {
@@ -250,8 +285,8 @@
 		return sprintf(buf, "0\n");
 }
 
-static ssize_t store_temp_min(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+static ssize_t store_temp_min(struct device *dev,
+	struct device_attribute	*devattr, const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
@@ -277,8 +312,8 @@
 	return count;
 }
 
-static ssize_t store_temp_max(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+static ssize_t store_temp_max(struct device *dev,
+	struct device_attribute	*devattr, const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
@@ -361,32 +396,71 @@
 	return count;
 }
 
+/*
+ * Resets the historical measurements of minimum and maximum temperatures.
+ * This is done by writing any value to any of the minimum/maximum registers
+ * (0x30-0x37).
+ */
+static ssize_t reset_temp_history(struct device *dev,
+	struct device_attribute	*devattr, const char *buf, size_t count)
+{
+	long val;
+
+	if (strict_strtol(buf, 10, &val))
+		return -EINVAL;
+
+	if (val != 1) {
+		dev_err(dev, "temp_reset_history value %ld not"
+			" supported. Use 1 to reset the history!\n", val);
+		return -EINVAL;
+	}
+	i2c_smbus_write_byte_data(to_i2c_client(dev),
+		TMP411_TEMP_LOWEST_MSB[0], val);
+
+	return count;
+}
+
 static struct sensor_device_attribute tmp401_attr[] = {
 	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
 	SENSOR_ATTR(temp1_min, 0644, show_temp_min, store_temp_min, 0),
 	SENSOR_ATTR(temp1_max, 0644, show_temp_max, store_temp_max, 0),
 	SENSOR_ATTR(temp1_crit, 0644, show_temp_crit, store_temp_crit, 0),
 	SENSOR_ATTR(temp1_crit_hyst, 0644, show_temp_crit_hyst,
-			store_temp_crit_hyst, 0),
+		    store_temp_crit_hyst, 0),
 	SENSOR_ATTR(temp1_min_alarm, 0444, show_status, NULL,
-			TMP401_STATUS_LOCAL_LOW),
+		    TMP401_STATUS_LOCAL_LOW),
 	SENSOR_ATTR(temp1_max_alarm, 0444, show_status, NULL,
-			TMP401_STATUS_LOCAL_HIGH),
+		    TMP401_STATUS_LOCAL_HIGH),
 	SENSOR_ATTR(temp1_crit_alarm, 0444, show_status, NULL,
-			TMP401_STATUS_LOCAL_CRIT),
+		    TMP401_STATUS_LOCAL_CRIT),
 	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
 	SENSOR_ATTR(temp2_min, 0644, show_temp_min, store_temp_min, 1),
 	SENSOR_ATTR(temp2_max, 0644, show_temp_max, store_temp_max, 1),
 	SENSOR_ATTR(temp2_crit, 0644, show_temp_crit, store_temp_crit, 1),
 	SENSOR_ATTR(temp2_crit_hyst, 0444, show_temp_crit_hyst, NULL, 1),
 	SENSOR_ATTR(temp2_fault, 0444, show_status, NULL,
-			TMP401_STATUS_REMOTE_OPEN),
+		    TMP401_STATUS_REMOTE_OPEN),
 	SENSOR_ATTR(temp2_min_alarm, 0444, show_status, NULL,
-			TMP401_STATUS_REMOTE_LOW),
+		    TMP401_STATUS_REMOTE_LOW),
 	SENSOR_ATTR(temp2_max_alarm, 0444, show_status, NULL,
-			TMP401_STATUS_REMOTE_HIGH),
+		    TMP401_STATUS_REMOTE_HIGH),
 	SENSOR_ATTR(temp2_crit_alarm, 0444, show_status, NULL,
-			TMP401_STATUS_REMOTE_CRIT),
+		    TMP401_STATUS_REMOTE_CRIT),
+};
+
+/*
+ * Additional features of the TMP411 chip.
+ * The TMP411 stores the minimum and maximum
+ * temperature measured since power-on, chip-reset, or
+ * minimum and maximum register reset for both the local
+ * and remote channels.
+ */
+static struct sensor_device_attribute tmp411_attr[] = {
+	SENSOR_ATTR(temp1_highest, 0444, show_temp_highest, NULL, 0),
+	SENSOR_ATTR(temp1_lowest, 0444, show_temp_lowest, NULL, 0),
+	SENSOR_ATTR(temp2_highest, 0444, show_temp_highest, NULL, 1),
+	SENSOR_ATTR(temp2_lowest, 0444, show_temp_lowest, NULL, 1),
+	SENSOR_ATTR(temp_reset_history, 0200, NULL, reset_temp_history, 0),
 };
 
 /*
@@ -432,8 +506,17 @@
 			return -ENODEV;
 
 		reg = i2c_smbus_read_byte_data(client, TMP401_DEVICE_ID_REG);
-		if (reg != TMP401_DEVICE_ID)
+
+		switch (reg) {
+		case TMP401_DEVICE_ID:
+			kind = tmp401;
+			break;
+		case TMP411_DEVICE_ID:
+			kind = tmp411;
+			break;
+		default:
 			return -ENODEV;
+		}
 
 		reg = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
 		if (reg & 0x1b)
@@ -441,19 +524,21 @@
 
 		reg = i2c_smbus_read_byte_data(client,
 					       TMP401_CONVERSION_RATE_READ);
+		/* Datasheet says: 0x1-0x6 */
 		if (reg > 15)
 			return -ENODEV;
 	}
-	strlcpy(info->type, "tmp401", I2C_NAME_SIZE);
+	strlcpy(info->type, tmp401_id[kind - 1].name, I2C_NAME_SIZE);
 
 	return 0;
 }
 
 static int tmp401_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
-{			
+{
 	int i, err = 0;
 	struct tmp401_data *data;
+	const char *names[] = { "TMP401", "TMP411" };
 
 	data = kzalloc(sizeof(struct tmp401_data), GFP_KERNEL);
 	if (!data)
@@ -461,6 +546,7 @@
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
+	data->kind = id->driver_data;
 
 	/* Initialize the TMP401 chip */
 	tmp401_init_client(client);
@@ -468,19 +554,29 @@
 	/* Register sysfs hooks */
 	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++) {
 		err = device_create_file(&client->dev,
-					&tmp401_attr[i].dev_attr);
+					 &tmp401_attr[i].dev_attr);
 		if (err)
 			goto exit_remove;
 	}
 
+	/* Register aditional tmp411 sysfs hooks */
+	if (data->kind = tmp411) {
+		for (i = 0; i < ARRAY_SIZE(tmp411_attr); i++) {
+			err = device_create_file(&client->dev,
+						 &tmp411_attr[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
+	}
+
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		data->hwmon_dev = NULL;
 		goto exit_remove;
 	}
-
-	dev_info(&client->dev, "Detected TI TMP401 chip\n");
+	dev_info(&client->dev, "Detected TI %s chip\n",
+		 names[data->kind]);
 
 	return 0;
 
@@ -500,43 +596,71 @@
 	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++)
 		device_remove_file(&client->dev, &tmp401_attr[i].dev_attr);
 
+	if (data->kind = tmp411) {
+		for (i = 0; i < ARRAY_SIZE(tmp411_attr); i++)
+			device_remove_file(&client->dev,
+					   &tmp411_attr[i].dev_attr);
+	}
+
 	kfree(data);
 	return 0;
 }
 
+static struct tmp401_data *tmp401_update_device_reg16(
+	struct i2c_client *client, struct tmp401_data *data)
+{
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		/*
+		 * High byte must be read first immediately followed
+		 * by the low byte
+		 */
+		data->temp[i] = i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_MSB[i]) << 8;
+		data->temp[i] |= i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_LSB[i]);
+		data->temp_low[i] = i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_LOW_LIMIT_MSB_READ[i]) << 8;
+		data->temp_low[i] |= i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_LOW_LIMIT_LSB[i]);
+		data->temp_high[i] = i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_HIGH_LIMIT_MSB_READ[i]) << 8;
+		data->temp_high[i] |= i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_HIGH_LIMIT_LSB[i]);
+		data->temp_crit[i] = i2c_smbus_read_byte_data(client,
+			TMP401_TEMP_CRIT_LIMIT[i]);
+
+		if (data->kind = tmp411) {
+			data->temp_lowest[i] = i2c_smbus_read_byte_data(client,
+				TMP411_TEMP_LOWEST_MSB[i]) << 8;
+			data->temp_lowest[i] |= i2c_smbus_read_byte_data(
+				client, TMP411_TEMP_LOWEST_LSB[i]);
+
+			data->temp_highest[i] = i2c_smbus_read_byte_data(
+				client, TMP411_TEMP_HIGHEST_MSB[i]) << 8;
+			data->temp_highest[i] |= i2c_smbus_read_byte_data(
+				client, TMP411_TEMP_HIGHEST_LSB[i]);
+		}
+	}
+	return data;
+}
+
 static struct tmp401_data *tmp401_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tmp401_data *data = i2c_get_clientdata(client);
-	int i;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		data->status = i2c_smbus_read_byte_data(client, TMP401_STATUS);
 		data->config = i2c_smbus_read_byte_data(client,
-						TMP401_CONFIG_READ);
-		for (i = 0; i < 2; i++) {
-			/* High byte must be read first immediately followed
-			   by the low byte */
-			data->temp[i] = i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_MSB[i]) << 8;
-			data->temp[i] |= i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_LSB[i]);
-			data->temp_low[i] = i2c_smbus_read_byte_data(client,
-				TMP401_TEMP_LOW_LIMIT_MSB_READ[i]) << 8;
-			data->temp_low[i] |= i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_LOW_LIMIT_LSB[i]);
-			data->temp_high[i] = i2c_smbus_read_byte_data(client,
-				TMP401_TEMP_HIGH_LIMIT_MSB_READ[i]) << 8;
-			data->temp_high[i] |= i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_HIGH_LIMIT_LSB[i]);
-			data->temp_crit[i] = i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_CRIT_LIMIT[i]);
-		}
+			TMP401_CONFIG_READ);
+		tmp401_update_device_reg16(client, data);
 
 		data->temp_crit_hyst = i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_CRIT_HYST);
+			TMP401_TEMP_CRIT_HYST);
 
 		data->last_updated = jiffies;
 		data->valid = 1;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
