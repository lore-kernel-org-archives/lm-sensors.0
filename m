From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 14:34:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7473) Convert to a new-style i2c
Message-Id: <20080716163448.46442517@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: "Darrick J. Wong" <djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

The new-style adt7473 driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
---
 drivers/hwmon/adt7473.c |  102 ++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 54 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/adt7473.c	2008-07-12 09:20:30.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/adt7473.c	2008-07-12 10:27:28.000000000 +0200
@@ -143,7 +143,6 @@ I2C_CLIENT_INSMOD_1(adt7473);
 #define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
 
 struct adt7473_data {
-	struct i2c_client	client;
 	struct device		*hwmon_dev;
 	struct attribute_group	attrs;
 	struct mutex		lock;
@@ -178,16 +177,28 @@ struct adt7473_data {
 	u8			max_duty_at_overheat;
 };
 
-static int adt7473_attach_adapter(struct i2c_adapter *adapter);
-static int adt7473_detect(struct i2c_adapter *adapter, int address, int kind);
-static int adt7473_detach_client(struct i2c_client *client);
+static int adt7473_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id);
+static int adt7473_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info);
+static int adt7473_remove(struct i2c_client *client);
+
+static const struct i2c_device_id adt7473_id[] = {
+	{ "adt7473", adt7473 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adt7473_id);
 
 static struct i2c_driver adt7473_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "adt7473",
 	},
-	.attach_adapter	= adt7473_attach_adapter,
-	.detach_client	= adt7473_detach_client,
+	.probe		= adt7473_probe,
+	.remove		= adt7473_remove,
+	.id_table	= adt7473_id,
+	.detect		= adt7473_detect,
+	.address_data	= &addr_data,
 };
 
 /*
@@ -1042,66 +1053,52 @@ static struct attribute *adt7473_attr[] 
 	NULL
 };
 
-static int adt7473_attach_adapter(struct i2c_adapter *adapter)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int adt7473_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, adt7473_detect);
-}
-
-static int adt7473_detect(struct i2c_adapter *adapter, int address, int kind)
-{
-	struct i2c_client *client;
-	struct adt7473_data *data;
-	int err = 0;
+	struct i2c_adapter *adapter = client->adapter;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	data = kzalloc(sizeof(struct adt7473_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	client = &data->client;
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &adt7473_driver;
-
-	i2c_set_clientdata(client, data);
-
-	mutex_init(&data->lock);
+		return -ENODEV;
 
 	if (kind <= 0) {
 		int vendor, device, revision;
 
 		vendor = i2c_smbus_read_byte_data(client, ADT7473_REG_VENDOR);
-		if (vendor != ADT7473_VENDOR) {
-			err = -ENODEV;
-			goto exit_free;
-		}
+		if (vendor != ADT7473_VENDOR)
+			return -ENODEV;
 
 		device = i2c_smbus_read_byte_data(client, ADT7473_REG_DEVICE);
-		if (device != ADT7473_DEVICE) {
-			err = -ENODEV;
-			goto exit_free;
-		}
+		if (device != ADT7473_DEVICE)
+			return -ENODEV;
 
 		revision = i2c_smbus_read_byte_data(client,
 						    ADT7473_REG_REVISION);
-		if (revision != ADT7473_REV_68 && revision != ADT7473_REV_69) {
-			err = -ENODEV;
-			goto exit_free;
-		}
+		if (revision != ADT7473_REV_68 && revision != ADT7473_REV_69)
+			return -ENODEV;
 	} else
 		dev_dbg(&adapter->dev, "detection forced\n");
 
-	strlcpy(client->name, "adt7473", I2C_NAME_SIZE);
+	strlcpy(info->type, "adt7473", I2C_NAME_SIZE);
 
-	err = i2c_attach_client(client);
-	if (err)
-		goto exit_free;
+	return 0;
+}
+
+static int adt7473_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct adt7473_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct adt7473_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->lock);
 
 	dev_info(&client->dev, "%s chip found\n", client->name);
 
@@ -1112,7 +1109,7 @@ static int adt7473_detect(struct i2c_ada
 	data->attrs.attrs = adt7473_attr;
 	err = sysfs_create_group(&client->dev.kobj, &data->attrs);
 	if (err)
-		goto exit_detach;
+		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1124,21 +1121,18 @@ static int adt7473_detect(struct i2c_ada
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-exit_detach:
-	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
 	return err;
 }
 
-static int adt7473_detach_client(struct i2c_client *client)
+static int adt7473_remove(struct i2c_client *client)
 {
 	struct adt7473_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-	i2c_detach_client(client);
 	kfree(data);
 	return 0;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
