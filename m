From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 14:36:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (fschmd) Convert to a new-style i2c
Message-Id: <20080716163629.58e7c98f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>

The new-style fschmd driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>
---
 drivers/hwmon/fschmd.c |  112 ++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 55 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/fschmd.c	2008-07-12 09:20:30.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/fschmd.c	2008-07-12 10:27:23.000000000 +0200
@@ -171,20 +171,37 @@ static const int FSCHMD_NO_TEMP_SENSORS[
  * Functions declarations
  */
 
-static int fschmd_attach_adapter(struct i2c_adapter *adapter);
-static int fschmd_detach_client(struct i2c_client *client);
+static int fschmd_probe(struct i2c_client *client,
+			const struct i2c_device_id *id);
+static int fschmd_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info);
+static int fschmd_remove(struct i2c_client *client);
 static struct fschmd_data *fschmd_update_device(struct device *dev);
 
 /*
  * Driver data (common to all clients)
  */
 
+static const struct i2c_device_id fschmd_id[] = {
+	{ "fscpos", fscpos },
+	{ "fscher", fscher },
+	{ "fscscy", fscscy },
+	{ "fschrc", fschrc },
+	{ "fschmd", fschmd },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, fschmd_id);
+
 static struct i2c_driver fschmd_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= FSCHMD_NAME,
 	},
-	.attach_adapter	= fschmd_attach_adapter,
-	.detach_client	= fschmd_detach_client,
+	.probe		= fschmd_probe,
+	.remove		= fschmd_remove,
+	.id_table	= fschmd_id,
+	.detect		= fschmd_detect,
+	.address_data	= &addr_data,
 };
 
 /*
@@ -192,7 +209,6 @@ static struct i2c_driver fschmd_driver   */
 
 struct fschmd_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	int kind;
@@ -269,7 +285,7 @@ static ssize_t store_temp_max(struct dev
 	v = SENSORS_LIMIT(v, -128, 127) + 128;
 
 	mutex_lock(&data->update_lock);
-	i2c_smbus_write_byte_data(&data->client,
+	i2c_smbus_write_byte_data(to_i2c_client(dev),
 		FSCHMD_REG_TEMP_LIMIT[data->kind][index], v);
 	data->temp_max[index] = v;
 	mutex_unlock(&data->update_lock);
@@ -346,14 +362,14 @@ static ssize_t store_fan_div(struct devi
 
 	mutex_lock(&data->update_lock);
 
-	reg = i2c_smbus_read_byte_data(&data->client,
+	reg = i2c_smbus_read_byte_data(to_i2c_client(dev),
 		FSCHMD_REG_FAN_RIPPLE[data->kind][index]);
 
 	/* bits 2..7 reserved => mask with 0x03 */
 	reg &= ~0x03;
 	reg |= v;
 
-	i2c_smbus_write_byte_data(&data->client,
+	i2c_smbus_write_byte_data(to_i2c_client(dev),
 		FSCHMD_REG_FAN_RIPPLE[data->kind][index], reg);
 
 	data->fan_ripple[index] = reg;
@@ -416,7 +432,7 @@ static ssize_t store_pwm_auto_point1_pwm
 
 	mutex_lock(&data->update_lock);
 
-	i2c_smbus_write_byte_data(&data->client,
+	i2c_smbus_write_byte_data(to_i2c_client(dev),
 		FSCHMD_REG_FAN_MIN[data->kind][index], v);
 	data->fan_min[index] = v;
 
@@ -448,14 +464,14 @@ static ssize_t store_alert_led(struct de
 
 	mutex_lock(&data->update_lock);
 
-	reg = i2c_smbus_read_byte_data(&data->client, FSCHMD_REG_CONTROL);
+	reg = i2c_smbus_read_byte_data(to_i2c_client(dev), FSCHMD_REG_CONTROL);
 
 	if (v)
 		reg |= FSCHMD_CONTROL_ALERT_LED_MASK;
 	else
 		reg &= ~FSCHMD_CONTROL_ALERT_LED_MASK;
 
-	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_CONTROL, reg);
+	i2c_smbus_write_byte_data(to_i2c_client(dev), FSCHMD_REG_CONTROL, reg);
 
 	data->global_control = reg;
 
@@ -600,32 +616,15 @@ static void fschmd_dmi_decode(const stru
 	}
 }
 
-static int fschmd_detect(struct i2c_adapter *adapter, int address, int kind)
+static int fschmd_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info)
 {
-	struct i2c_client *client;
-	struct fschmd_data *data;
-	u8 revision;
-	const char * const names[5] = { "Poseidon", "Hermes", "Scylla",
-					"Heracles", "Heimdall" };
+	struct i2c_adapter *adapter = client->adapter;
 	const char * const client_names[5] = { "fscpos", "fscher", "fscscy",
 						"fschrc", "fschmd" };
-	int i, err = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return 0;
-
-	/* OK. For now, we presume we have a valid client. We now create the
-	 * client structure, even though we cannot fill it completely yet.
-	 * But it allows us to access i2c_smbus_read_byte_data. */
-	if (!(data = kzalloc(sizeof(struct fschmd_data), GFP_KERNEL)))
-		return -ENOMEM;
-
-	client = &data->client;
-	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &fschmd_driver;
-	mutex_init(&data->update_lock);
+		return -ENODEV;
 
 	/* Detect & Identify the chip */
 	if (kind <= 0) {
@@ -650,9 +649,31 @@ static int fschmd_detect(struct i2c_adap
 		else if (!strcmp(id, "HMD"))
 			kind = fschmd;
 		else
-			goto exit_free;
+			return -ENODEV;
 	}
 
+	strlcpy(info->type, client_names[kind - 1], I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int fschmd_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct fschmd_data *data;
+	u8 revision;
+	const char * const names[5] = { "Poseidon", "Hermes", "Scylla",
+					"Heracles", "Heimdall" };
+	int i, err;
+	enum chips kind = id->driver_data;
+
+	data = kzalloc(sizeof(struct fschmd_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
 	if (kind = fscpos) {
 		/* The Poseidon has hardwired temp limits, fill these
 		   in for the alarm resetting code */
@@ -674,11 +695,6 @@ static int fschmd_detect(struct i2c_adap
 
 	/* i2c kind goes from 1-5, we want from 0-4 to address arrays */
 	data->kind = kind - 1;
-	strlcpy(client->name, client_names[data->kind], I2C_NAME_SIZE);
-
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
 
 	for (i = 0; i < ARRAY_SIZE(fschmd_attr); i++) {
 		err = device_create_file(&client->dev,
@@ -726,25 +742,14 @@ static int fschmd_detect(struct i2c_adap
 	return 0;
 
 exit_detach:
-	fschmd_detach_client(client); /* will also free data for us */
-	return err;
-
-exit_free:
-	kfree(data);
+	fschmd_remove(client); /* will also free data for us */
 	return err;
 }
 
-static int fschmd_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, fschmd_detect);
-}
-
-static int fschmd_detach_client(struct i2c_client *client)
+static int fschmd_remove(struct i2c_client *client)
 {
 	struct fschmd_data *data = i2c_get_clientdata(client);
-	int i, err;
+	int i;
 
 	/* Check if registered in case we're called from fschmd_detect
 	   to cleanup after an error */
@@ -760,9 +765,6 @@ static int fschmd_detach_client(struct i
 		device_remove_file(&client->dev,
 					&fschmd_fan_attr[i].dev_attr);
 
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
