From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 09 Jun 2008 11:07:00 +0000
Subject: [lm-sensors] [PATCH 1/3] lm87: Converted into a new-style driver
Message-Id: <20080609110659.GY11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Renamed the legacy driver to lm87_legacy, implemented using the new-style
driver (untested).

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm87.c |  116 ++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 84 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index e1c183f..81a1643 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -157,6 +157,8 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A, 0x38, 0x2C };
  * Functions declaration
  */
 
+static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *);
+static int lm87_remove(struct i2c_client *client);
 static int lm87_attach_adapter(struct i2c_adapter *adapter);
 static int lm87_detect(struct i2c_adapter *adapter, int address, int kind);
 static void lm87_init_client(struct i2c_client *client);
@@ -167,10 +169,26 @@ static struct lm87_data *lm87_update_device(struct device *dev);
  * Driver data (common to all clients)
  */
 
+static const struct i2c_device_id lm87_id[] = {
+	{ "lm87", lm87 },
+	{ "adm1024", adm1024 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm87_id);
+
 static struct i2c_driver lm87_driver = {
 	.driver = {
 		.name	= "lm87",
 	},
+	.probe		= lm87_probe,
+	.remove		= lm87_remove,
+	.id_table	= lm87_id,
+};
+
+static struct i2c_driver lm87_legacy_driver = {
+	.driver = {
+		.name	= "lm87_legacy",
+	},
 	.attach_adapter	= lm87_attach_adapter,
 	.detach_client	= lm87_detach_client,
 };
@@ -180,7 +198,6 @@ static struct i2c_driver lm87_driver = {
  */
 
 struct lm87_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
@@ -663,25 +680,17 @@ static const struct attribute_group lm87_group_opt = {
 static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
-	struct lm87_data *data;
-	int err = 0;
-	static const char *names[] = { "lm87", "adm1024" };
+	int err;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	if (!(data = kzalloc(sizeof(struct lm87_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
+		return 0;
 
-	/* The common I2C client data is placed right before the
-	   LM87-specific data. */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
+	new_client = kzalloc(sizeof(*new_client), GFP_KERNEL);
+	if (!new_client)
+		return -ENOMEM;
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &lm87_driver;
+	new_client->driver = &lm87_legacy_driver;
 	new_client->flags = 0;
 
 	/* Default to an LM87 if forced */
@@ -705,20 +714,49 @@ static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 			dev_dbg(&adapter->dev,
 				"LM87 detection failed at 0x%02x.\n",
 				address);
+			err = 0;
 			goto exit_free;
 		}
 	}
 
-	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, names[kind - 1], I2C_NAME_SIZE);
-	data->valid = 0;
-	mutex_init(&data->update_lock);
+	strlcpy(new_client->name, lm87_id[kind - 1].name, I2C_NAME_SIZE);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	err = lm87_probe(new_client, lm87_id + kind - 1);
+	if (err)
 		goto exit_free;
 
-	/* Initialize the LM87 chip */
+	/* Tell the I2C layer a new client has arrived */
+	err = i2c_attach_client(new_client);
+	if (err)
+		goto exit_remove;
+
+	return 0;
+
+exit_remove:
+	lm87_remove(new_client);
+exit_free:
+	kfree(new_client);
+	return err;
+}
+
+static int
+lm87_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
+{
+	struct lm87_data *data;
+	int err;
+
+	if (!i2c_check_functionality(new_client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->valid = 0;
+	mutex_init(&data->update_lock);
+	i2c_set_clientdata(new_client, data);
+
 	lm87_init_client(new_client);
 
 	data->in_scale[0] = 2500;
@@ -732,7 +770,7 @@ static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm87_group)))
-		goto exit_detach;
+		goto exit_free;
 
 	if (data->channel & CHAN_NO_FAN(0)) {
 		if ((err = device_create_file(&new_client->dev,
@@ -832,11 +870,9 @@ static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 exit_remove:
 	sysfs_remove_group(&new_client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&new_client->dev.kobj, &lm87_group_opt);
-exit_detach:
-	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
-exit:
+	i2c_set_clientdata(new_client, NULL);
 	return err;
 }
 
@@ -877,22 +913,30 @@ static void lm87_init_client(struct i2c_client *client)
 	}
 }
 
-static int lm87_detach_client(struct i2c_client *client)
+static int lm87_remove(struct i2c_client *client)
 {
 	struct lm87_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
-
 	kfree(data);
+	i2c_set_clientdata(client, NULL);
 	return 0;
 }
 
+static int lm87_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	lm87_remove(client);
+	err = i2c_detach_client(client);
+	if (!err)
+		kfree(client);
+	return err;
+}
+
 static struct lm87_data *lm87_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -974,11 +1018,19 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 
 static int __init sensors_lm87_init(void)
 {
-	return i2c_add_driver(&lm87_driver);
+	int err;
+	err = i2c_add_driver(&lm87_driver);
+	if (err)
+		return err;
+	err = i2c_add_driver(&lm87_legacy_driver);
+	if (err)
+		i2c_del_driver(&lm87_driver);
+	return err;
 }
 
 static void __exit sensors_lm87_exit(void)
 {
+	i2c_del_driver(&lm87_legacy_driver);
 	i2c_del_driver(&lm87_driver);
 }
 

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
