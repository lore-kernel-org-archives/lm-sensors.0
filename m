From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 14:37:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: (gl520sm) Convert to a new-style i2c
Message-Id: <20080716163723.61391a7a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Maarten Deprez <maartendeprez-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

The new-style gl520sm driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Maarten Deprez <maartendeprez@users.sourceforge.net>
---
 drivers/hwmon/gl520sm.c |   91 ++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/gl520sm.c	2008-07-12 09:20:30.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/gl520sm.c	2008-07-12 10:27:21.000000000 +0200
@@ -79,26 +79,37 @@ static const u8 GL520_REG_TEMP_MAX_HYST[
  * Function declarations
  */
 
-static int gl520_attach_adapter(struct i2c_adapter *adapter);
-static int gl520_detect(struct i2c_adapter *adapter, int address, int kind);
+static int gl520_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id);
+static int gl520_detect(struct i2c_client *client, int kind,
+			struct i2c_board_info *info);
 static void gl520_init_client(struct i2c_client *client);
-static int gl520_detach_client(struct i2c_client *client);
+static int gl520_remove(struct i2c_client *client);
 static int gl520_read_value(struct i2c_client *client, u8 reg);
 static int gl520_write_value(struct i2c_client *client, u8 reg, u16 value);
 static struct gl520_data *gl520_update_device(struct device *dev);
 
 /* Driver data */
+static const struct i2c_device_id gl520_id[] = {
+	{ "gl520sm", gl520sm },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, gl520_id);
+
 static struct i2c_driver gl520_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "gl520sm",
 	},
-	.attach_adapter	= gl520_attach_adapter,
-	.detach_client	= gl520_detach_client,
+	.probe		= gl520_probe,
+	.remove		= gl520_remove,
+	.id_table	= gl520_id,
+	.detect		= gl520_detect,
+	.address_data	= &addr_data,
 };
 
 /* Client data */
 struct gl520_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* zero until the following fields are valid */
@@ -669,37 +680,15 @@ static const struct attribute_group gl52
  * Real code
  */
 
-static int gl520_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, gl520_detect);
-}
-
-static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int gl520_detect(struct i2c_client *client, int kind,
+			struct i2c_board_info *info)
 {
-	struct i2c_client *client;
-	struct gl520_data *data;
-	int err = 0;
+	struct i2c_adapter *adapter = client->adapter;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
-		goto exit;
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access gl520_{read,write}_value. */
-
-	if (!(data = kzalloc(sizeof(struct gl520_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	client = &data->client;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &gl520_driver;
+		return -ENODEV;
 
 	/* Determine the chip type. */
 	if (kind < 0) {
@@ -707,24 +696,36 @@ static int gl520_detect(struct i2c_adapt
 		    ((gl520_read_value(client, GL520_REG_REVISION) & 0x7f) != 0x00) ||
 		    ((gl520_read_value(client, GL520_REG_CONF) & 0x80) != 0x00)) {
 			dev_dbg(&client->dev, "Unknown chip type, skipping\n");
-			goto exit_free;
+			return -ENODEV;
 		}
 	}
 
-	/* Fill in the remaining client fields */
-	strlcpy(client->name, "gl520sm", I2C_NAME_SIZE);
-	mutex_init(&data->update_lock);
+	strlcpy(info->type, "gl520sm", I2C_NAME_SIZE);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
+	return 0;
+}
+
+static int gl520_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct gl520_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct gl520_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
 
 	/* Initialize the GL520SM chip */
 	gl520_init_client(client);
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&client->dev.kobj, &gl520_group)))
-		goto exit_detach;
+		goto exit_free;
 
 	if (data->two_temps) {
 		if ((err = device_create_file(&client->dev,
@@ -764,8 +765,6 @@ static int gl520_detect(struct i2c_adapt
 exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &gl520_group);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_opt);
-exit_detach:
-	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
@@ -811,18 +810,14 @@ static void gl520_init_client(struct i2c
 	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
 }
 
-static int gl520_detach_client(struct i2c_client *client)
+static int gl520_remove(struct i2c_client *client)
 {
 	struct gl520_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_opt);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
-
 	kfree(data);
 	return 0;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
