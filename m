From: David Brownell <david-b@pacbell.net>
Date: Tue, 25 Sep 2007 05:19:26 +0000
Subject: [lm-sensors] [patch 2.6.23-rc8 2/3] lm75: new style driver binding
Message-Id: <20070925051926.7349F23942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Teach LM75 driver how to use new-style driver binding.

 - Create a second driver struct, using new-style driver binding methods.

 - Make the legacy bind/unbind logic delegate all its work.

 - Rename the old driver struct as "lm75_legacy".

 - Sensor limits are chip-specific; record them, and use them in new
   routines to interconvert temperature and register values.

 - More careful initialization.  Chips are put into 9-bit mode so
   the current interconversion routines will never fail.

 - Save the original chip configuration, and restore it on exit.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/hwmon/Kconfig |    9 +-
 drivers/hwmon/lm75.c  |  189 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 148 insertions(+), 50 deletions(-)

--- a/drivers/hwmon/Kconfig	2007-09-24 21:59:26.000000000 -0700
+++ b/drivers/hwmon/Kconfig	2007-09-24 21:59:42.000000000 -0700
@@ -312,9 +312,12 @@ config SENSORS_LM75
 		- TelCom (now Microchip) TCN75
 		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
 
-	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
-	  a force module parameter. The driver will not handle the extra
-	  precision anyhow.
+	  This driver supports driver model based binding through board
+	  specific I2C device tables.
+
+	  It also supports the "legacy" style of driver binding.  To use
+	  that with some chips which don't replicate lm75 quirks exactly,
+	  you may need the "force" module parameter.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm75.
--- a/drivers/hwmon/lm75.c	2007-09-24 21:59:35.000000000 -0700
+++ b/drivers/hwmon/lm75.c	2007-09-24 21:59:54.000000000 -0700
@@ -54,9 +54,11 @@ static const u8 LM75_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct lm75_data {
-	struct i2c_client	client;
+	struct i2c_client	*client;
 	struct device		*hwmon_dev;
 	struct mutex		update_lock;
+	int			min, max;
+	char			orig_conf;
 	char			valid;		/* !=0 if registers are valid */
 	unsigned long		last_updated;	/* In jiffies */
 	u16			temp[3];	/* Register values,
@@ -65,7 +67,6 @@ struct lm75_data {
 						   2 = hyst */
 };
 
-static void lm75_init_client(struct i2c_client *client);
 static int lm75_read_value(struct i2c_client *client, u8 reg);
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
 static struct lm75_data *lm75_update_device(struct device *dev);
@@ -75,13 +76,28 @@ static struct lm75_data *lm75_update_dev
 
 /* sysfs attributes for hwmon */
 
+static inline s16 temp_to_reg(struct lm75_data *lm75, long temp)
+{
+	if (temp < lm75->min)
+		temp = lm75->min;
+	else if (temp > lm75->max)
+		temp = lm75->max;
+
+	return LM75_TEMP_TO_REG(temp);
+}
+
+static inline int reg_to_temp(s16 reg)
+{
+	return LM75_TEMP_FROM_REG(reg);
+}
+
 static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm75_data *data = lm75_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
+
+	return sprintf(buf, "%d\n", reg_to_temp(data->temp[attr->index]));
 }
 
 static ssize_t set_temp(struct device *dev, struct device_attribute *da,
@@ -94,7 +110,7 @@ static ssize_t set_temp(struct device *d
 	long temp = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp[nr] = LM75_TEMP_TO_REG(temp);
+	data->temp[nr] = temp_to_reg(data, temp);
 	lm75_write_value(client, LM75_REG_TEMP[nr], data->temp[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -120,16 +136,112 @@ static const struct attribute_group lm75
 
 /*-----------------------------------------------------------------------*/
 
+/* "New style" I2C driver binding -- following the driver model */
+
+static int lm75_probe(struct i2c_client *client)
+{
+	struct lm75_data	*data;
+	int			status;
+	u8			set_mask, clr_mask;
+	int			new;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		return -EIO;
+
+	if (!(data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL)))
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+
+	data->client = client;
+	mutex_init(&data->update_lock);
+
+	/* Set to LM75 resolution (9 bits, 0.5 degrees C) and range.
+	 * Then tweak to be more precise when appropriate.
+	 */
+	set_mask = 0;
+	clr_mask = (1 << 0)			/* continuous conversions */
+		| (1 << 6) | (1 << 5);		/* 9-bit mode */
+
+	data->min = -55 * 1000;
+	data->max = 125 * 1000;
+
+	/* for tmp175 or tmp275, use name "tmp75" */
+	if (strcmp(client->name, "tmp75") = 0)
+		data->min = -40 * 1000;
+
+	/* NOTE:  also need to ensure that the chip is in interrupt mode
+	 * in various cases, and maybe handle SMBALERT#.
+	 */
+
+	/* configure as specified */
+	status = lm75_read_value(client, LM75_REG_CONF);
+	if (status < 0) {
+		dev_dbg(&client->dev, "can't read config? %d\n", status);
+		goto exit_free;
+	}
+	data->orig_conf = status;
+	new = status & ~clr_mask;
+	new |= set_mask;
+	if (status != new)
+		lm75_write_value(client, LM75_REG_CONF, new);
+	dev_dbg(&client->dev, "config %02x\n", new);
+
+	/* Register sysfs hooks */
+	if ((status = sysfs_create_group(&client->dev.kobj, &lm75_group)))
+		goto exit_free;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		status = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	dev_info(&client->dev, "%s: sensor '%s'\n",
+		data->hwmon_dev->bus_id, client->name);
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &lm75_group);
+exit_free:
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+	return status;
+}
+
+static int lm75_remove(struct i2c_client *client)
+{
+	struct lm75_data	*data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &lm75_group);
+	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+	return 0;
+}
+
+static struct i2c_driver lm75_driver = {
+	.driver = {
+		.name	= "lm75",
+	},
+	.probe		= lm75_probe,
+	.remove		= lm75_remove,
+};
+
+/*-----------------------------------------------------------------------*/
+
 /* "Legacy" I2C driver binding */
 
-static struct i2c_driver lm75_driver;
+static struct i2c_driver lm75_legacy_driver;
 
 /* This function is called by i2c_probe */
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
 	struct i2c_client *new_client;
-	struct lm75_data *data;
 	int err = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
@@ -139,16 +251,14 @@ static int lm75_detect(struct i2c_adapte
 	/* OK. For now, we presume we have a valid address. We create the
 	   client structure, even though there may be no sensor present.
 	   But it allows us to access lm75_{read,write}_value. */
-	if (!(data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
+	if (!(new_client = kzalloc(sizeof *new_client, GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &lm75_driver;
+	new_client->driver = &lm75_legacy_driver;
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. There is no identification-
@@ -189,38 +299,24 @@ static int lm75_detect(struct i2c_adapte
 				goto exit_free;
 	}
 
-	/* NOTE: we treat "force=..." and "force_lm75=..." the same. */
+	/* NOTE: we treat "force=..." and "force_lm75=..." the same.
+	 * Only new-style driver binding distinguishes chip types.
+	 */
 	strlcpy(new_client->name, "lm75", I2C_NAME_SIZE);
 
-	/* Fill in the remaining client fields and put it into the global list */
-	data->valid = 0;
-	mutex_init(&data->update_lock);
-
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto exit_free;
 
-	/* Initialize the LM75 chip */
-	lm75_init_client(new_client);
-
-	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm75_group)))
+	if ((err = lm75_probe(new_client)) < 0)
 		goto exit_detach;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
 	return 0;
 
-exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &lm75_group);
 exit_detach:
 	i2c_detach_client(new_client);
 exit_free:
-	kfree(data);
+	kfree(new_client);
 exit:
 	return err;
 }
@@ -234,17 +330,15 @@ static int lm75_attach_adapter(struct i2
 
 static int lm75_detach_client(struct i2c_client *client)
 {
-	struct lm75_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm75_group);
+	lm75_remove(client);
 	i2c_detach_client(client);
-	kfree(data);
+	kfree(client);
 	return 0;
 }
 
-static struct i2c_driver lm75_driver = {
+static struct i2c_driver lm75_legacy_driver = {
 	.driver = {
-		.name	= "lm75",
+		.name	= "lm75_legacy",
 	},
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
@@ -276,16 +370,6 @@ static int lm75_write_value(struct i2c_c
 		return i2c_smbus_write_word_data(client, reg, swab16(value));
 }
 
-static void lm75_init_client(struct i2c_client *client)
-{
-	int reg;
-
-	/* Enable if in shutdown mode */
-	reg = lm75_read_value(client, LM75_REG_CONF);
-	if (reg >= 0 && (reg & 0x01))
-		lm75_write_value(client, LM75_REG_CONF, reg & 0xfe);
-}
-
 static struct lm75_data *lm75_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -316,11 +400,22 @@ static struct lm75_data *lm75_update_dev
 
 static int __init sensors_lm75_init(void)
 {
-	return i2c_add_driver(&lm75_driver);
+	int status;
+
+	status = i2c_add_driver(&lm75_driver);
+	if (status < 0)
+		return status;
+
+	status = i2c_add_driver(&lm75_legacy_driver);
+	if (status < 0)
+		i2c_del_driver(&lm75_driver);
+
+	return status;
 }
 
 static void __exit sensors_lm75_exit(void)
 {
+	i2c_del_driver(&lm75_legacy_driver);
 	i2c_del_driver(&lm75_driver);
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
