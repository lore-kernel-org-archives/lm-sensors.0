From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 12:51:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1031) Convert to a new-style i2c
Message-Id: <20080716145157.0187af72@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Alexandre d'Alton <alex-jojFES6RfZNxtahE/wReCQ@public.gmane.org>

The new-style adm1031 driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Alexandre d'Alton <alex@alexdalton.org>
---
 drivers/hwmon/adm1031.c |   96 +++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/adm1031.c	2008-07-12 09:20:31.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/adm1031.c	2008-07-12 10:27:32.000000000 +0200
@@ -70,7 +70,6 @@ typedef u8 auto_chan_table_t[8][2];
 
 /* Each client has this additional data */
 struct adm1031_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	int chip_type;
@@ -99,19 +98,32 @@ struct adm1031_data {
 	s8 temp_crit[3];
 };
 
-static int adm1031_attach_adapter(struct i2c_adapter *adapter);
-static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind);
+static int adm1031_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id);
+static int adm1031_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info);
 static void adm1031_init_client(struct i2c_client *client);
-static int adm1031_detach_client(struct i2c_client *client);
+static int adm1031_remove(struct i2c_client *client);
 static struct adm1031_data *adm1031_update_device(struct device *dev);
 
+static const struct i2c_device_id adm1031_id[] = {
+	{ "adm1030", adm1030 },
+	{ "adm1031", adm1031 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1031_id);
+
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1031_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name = "adm1031",
 	},
-	.attach_adapter = adm1031_attach_adapter,
-	.detach_client = adm1031_detach_client,
+	.probe		= adm1031_probe,
+	.remove		= adm1031_remove,
+	.id_table	= adm1031_id,
+	.detect		= adm1031_detect,
+	.address_data	= &addr_data,
 };
 
 static inline u8 adm1031_read_value(struct i2c_client *client, u8 reg)
@@ -693,13 +705,6 @@ static SENSOR_DEVICE_ATTR(temp3_crit_ala
 static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 13);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 14);
 
-static int adm1031_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, adm1031_detect);
-}
-
 static struct attribute *adm1031_attributes[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
@@ -770,27 +775,15 @@ static const struct attribute_group adm1
 	.attrs = adm1031_attributes_opt,
 };
 
-/* This function is called by i2c_probe */
-static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int adm1031_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info)
 {
-	struct i2c_client *client;
-	struct adm1031_data *data;
-	int err = 0;
+	struct i2c_adapter *adapter = client->adapter;
 	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	if (!(data = kzalloc(sizeof(struct adm1031_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	client = &data->client;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &adm1031_driver;
+		return -ENODEV;
 
 	if (kind < 0) {
 		int id, co;
@@ -798,7 +791,7 @@ static int adm1031_detect(struct i2c_ada
 		co = i2c_smbus_read_byte_data(client, 0x3e);
 
 		if (!((id = 0x31 || id = 0x30) && co = 0x41))
-			goto exit_free;
+			return -ENODEV;
 		kind = (id = 0x30) ? adm1030 : adm1031;
 	}
 
@@ -809,28 +802,43 @@ static int adm1031_detect(struct i2c_ada
 	 * auto fan control helper table. */
 	if (kind = adm1030) {
 		name = "adm1030";
-		data->chan_select_table = &auto_channel_select_table_adm1030;
 	} else if (kind = adm1031) {
 		name = "adm1031";
-		data->chan_select_table = &auto_channel_select_table_adm1031;
 	}
-	data->chip_type = kind;
+	strlcpy(info->type, name, I2C_NAME_SIZE);
 
-	strlcpy(client->name, name, I2C_NAME_SIZE);
+	return 0;
+}
+
+static int adm1031_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct adm1031_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct adm1031_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	data->chip_type = id->driver_data;
 	mutex_init(&data->update_lock);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
+	if (data->chip_type = adm1030)
+		data->chan_select_table = &auto_channel_select_table_adm1030;
+	else
+		data->chan_select_table = &auto_channel_select_table_adm1031;
 
 	/* Initialize the ADM1031 chip */
 	adm1031_init_client(client);
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&client->dev.kobj, &adm1031_group)))
-		goto exit_detach;
+		goto exit_free;
 
-	if (kind = adm1031) {
+	if (data->chip_type = adm1031) {
 		if ((err = sysfs_create_group(&client->dev.kobj,
 						&adm1031_group_opt)))
 			goto exit_remove;
@@ -847,25 +855,19 @@ static int adm1031_detect(struct i2c_ada
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &adm1031_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1031_group_opt);
-exit_detach:
-	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
 	return err;
 }
 
-static int adm1031_detach_client(struct i2c_client *client)
+static int adm1031_remove(struct i2c_client *client)
 {
 	struct adm1031_data *data = i2c_get_clientdata(client);
-	int ret;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1031_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1031_group_opt);
-	if ((ret = i2c_detach_client(client)) != 0) {
-		return ret;
-	}
 	kfree(data);
 	return 0;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
