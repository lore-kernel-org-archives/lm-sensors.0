From: Laurent Pinchart <laurentp@cse-semaphore.com>
Date: Wed, 16 Apr 2008 12:34:53 +0000
Subject: [lm-sensors] lm75: Convert to new-style I2C driver
Message-Id: <200804161434.54335.laurentp@cse-semaphore.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch converts the lm75 driver into a new-style I2C driver.

Signed-off-by: Laurent Pinchart <laurent@pclaurent.belgium.cse-semaphore.com>
---
 drivers/hwmon/lm75.c |  292 +++++++++++++++++++++-----------------------------
 1 files changed, 124 insertions(+), 168 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index d7a22a5..7c17611 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -29,14 +29,6 @@
 #include <linux/mutex.h>
 #include "lm75.h"
 
-
-/* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
-					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm75);
-
 /* Many LM75 constants specified below */
 
 /* The LM75 registers */
@@ -49,34 +41,61 @@ static const u8 LM75_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct lm75_data {
-	struct i2c_client	client;
-	struct device *hwmon_dev;
-	struct mutex		update_lock;
-	char			valid;		/* !=0 if following fields are valid */
-	unsigned long		last_updated;	/* In jiffies */
-	u16			temp[3];	/* Register values,
-						   0 = input
-						   1 = max
-						   2 = hyst */
+	struct device	*hwmon_dev;
+	struct mutex	update_lock;
+	char		valid;		/* !=0 if following fields are valid */
+	unsigned long	last_updated;	/* In jiffies */
+	u16		temp[3];	/* Register values,
+					   0 = input
+					   1 = max
+					   2 = hyst */
 };
 
-static int lm75_attach_adapter(struct i2c_adapter *adapter);
-static int lm75_detect(struct i2c_adapter *adapter, int address, int kind);
-static void lm75_init_client(struct i2c_client *client);
-static int lm75_detach_client(struct i2c_client *client);
-static int lm75_read_value(struct i2c_client *client, u8 reg);
-static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
-static struct lm75_data *lm75_update_device(struct device *dev);
+/* All registers are word-sized, except for the configuration register.
+   LM75 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int lm75_read_value(struct i2c_client *client, u8 reg)
+{
+	if (reg = LM75_REG_CONF)
+		return i2c_smbus_read_byte_data(client, reg);
+	else
+		return swab16(i2c_smbus_read_word_data(client, reg));
+}
 
+/* All registers are word-sized, except for the configuration register.
+   LM75 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if (reg = LM75_REG_CONF)
+		return i2c_smbus_write_byte_data(client, reg, value);
+	else
+		return i2c_smbus_write_word_data(client, reg, swab16(value));
+}
 
-/* This is the driver that will be inserted */
-static struct i2c_driver lm75_driver = {
-	.driver = {
-		.name	= "lm75",
-	},
-	.attach_adapter	= lm75_attach_adapter,
-	.detach_client	= lm75_detach_client,
-};
+static struct lm75_data *lm75_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm75_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		int i;
+		dev_dbg(&client->dev, "Starting lm75 update\n");
+
+		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
+			data->temp[i] = lm75_read_value(client,
+							LM75_REG_TEMP[i]);
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
 
 static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 			 char *buf)
@@ -109,13 +128,6 @@ static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
 			show_temp, set_temp, 2);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 
-static int lm75_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm75_detect);
-}
-
 static struct attribute *lm75_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
@@ -128,180 +140,124 @@ static const struct attribute_group lm75_group = {
 	.attrs = lm75_attributes,
 };
 
-/* This function is called by i2c_probe */
-static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
+static void lm75_init_client(struct i2c_client *client)
 {
-	int i;
-	struct i2c_client *new_client;
-	struct lm75_data *data;
-	int err = 0;
-	const char *name = "";
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_WORD_DATA))
-		goto exit;
+	int reg;
 
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access lm75_{read,write}_value. */
-	if (!(data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	/* Enable if in shutdown mode */
+	reg = lm75_read_value(client, LM75_REG_CONF);
+	if (reg >= 0 && (reg & 0x01))
+		lm75_write_value(client, LM75_REG_CONF, reg & 0xfe);
+}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm75_driver;
-	new_client->flags = 0;
+static int lm75_detect(struct i2c_client *client)
+{
+	int cur, conf, hyst, os, na, i;
 
-	/* Now, we do the remaining detection. There is no identification-
+	/* Try to identify the chip. There is no identification-
 	   dedicated register so we have to rely on several tricks:
 	   unused bits, registers cycling over 8-address boundaries,
-	   addresses 0x04-0x07 returning the last read value (LM75) or
-	   0xffff (Philips LM75A).
+           addresses 0x04-0x07 returning the last read value (LM75) or
+           0xffff (Philips LM75A).
 	   The cycling+unused addresses combination is not tested,
 	   since it would significantly slow the detection down and would
 	   hardly add any value. */
-	if (kind < 0) {
-		int cur, conf, hyst, os, na;
-
-		/* Unused addresses */
-		cur = i2c_smbus_read_word_data(new_client, 0);
-		conf = i2c_smbus_read_byte_data(new_client, 1);
-		hyst = i2c_smbus_read_word_data(new_client, 2);
-		for (i = 4; i < 8; ++i) {
-			na = i2c_smbus_read_word_data(new_client, i);
-			if (na != hyst && na != 0xffff)
-				goto exit_free;
-		}
-		os = i2c_smbus_read_word_data(new_client, 3);
-		for (i = 4; i < 8; ++i) {
-			na = i2c_smbus_read_word_data(new_client, i);
-			if (na != os && na != 0xffff)
-				goto exit_free;
-		}
-
-		/* Unused bits */
-		if (conf & 0xe0)
-		 	goto exit_free;
-
-		/* Addresses cycling */
-		for (i = 8; i < 0xff; i += 8)
-			if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
-			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
-			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
-				goto exit_free;
+
+	/* Unused addresses */
+	cur = i2c_smbus_read_word_data(client, 0);
+	conf = i2c_smbus_read_byte_data(client, 1);
+	hyst = i2c_smbus_read_word_data(client, 2);
+	for (i = 4; i < 8; ++i) {
+		na = i2c_smbus_read_word_data(client, i);
+		if (na != hyst && na != 0xffff)
+			return -ENODEV;
+	}
+	os = i2c_smbus_read_word_data(client, 3);
+	for (i = 4; i < 8; ++i) {
+		na = i2c_smbus_read_word_data(client, i);
+		if (na != os && na != 0xffff)
+			return -ENODEV;
 	}
 
-	/* Determine the chip type - only one kind supported! */
-	if (kind <= 0)
-		kind = lm75;
+	/* Unused bits */
+	if (conf & 0xe0)
+		return -ENODEV;
 
-	if (kind = lm75) {
-		name = "lm75";
+	/* Addresses cycling */
+	for (i = 8; i < 0xff; i += 8)
+		if (i2c_smbus_read_byte_data(client, i + 1) != conf
+		 || i2c_smbus_read_word_data(client, i + 2) != hyst
+		 || i2c_smbus_read_word_data(client, i + 3) != os)
+			return -ENODEV;
+
+	return 0;
+}
+
+static int lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct lm75_data *data;
+	int err = 0;
+
+	if (!(data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
 	}
 
-	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->valid = 0;
 	mutex_init(&data->update_lock);
+	data->valid = 0;
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	/* Make sure this is really a LM75 */
+	if ((err = lm75_detect(client)) < 0)
 		goto exit_free;
 
 	/* Initialize the LM75 chip */
-	lm75_init_client(new_client);
+	lm75_init_client(client);
 	
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm75_group)))
-		goto exit_detach;
+	if ((err = sysfs_create_group(&client->dev.kobj, &lm75_group)))
+		goto exit_free;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
+	i2c_set_clientdata(client, data);
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &lm75_group);
-exit_detach:
-	i2c_detach_client(new_client);
+	sysfs_remove_group(&client->dev.kobj, &lm75_group);
 exit_free:
 	kfree(data);
 exit:
 	return err;
 }
 
-static int lm75_detach_client(struct i2c_client *client)
+static int lm75_remove(struct i2c_client *client)
 {
 	struct lm75_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm75_group);
-	i2c_detach_client(client);
 	kfree(data);
 	return 0;
 }
 
-/* All registers are word-sized, except for the configuration register.
-   LM75 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
-static int lm75_read_value(struct i2c_client *client, u8 reg)
-{
-	if (reg = LM75_REG_CONF)
-		return i2c_smbus_read_byte_data(client, reg);
-	else
-		return swab16(i2c_smbus_read_word_data(client, reg));
-}
-
-/* All registers are word-sized, except for the configuration register.
-   LM75 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
-static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
-{
-	if (reg = LM75_REG_CONF)
-		return i2c_smbus_write_byte_data(client, reg, value);
-	else
-		return i2c_smbus_write_word_data(client, reg, swab16(value));
-}
-
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
-static struct lm75_data *lm75_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm75_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
-		int i;
-		dev_dbg(&client->dev, "Starting lm75 update\n");
-
-		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
-			data->temp[i] = lm75_read_value(client,
-							LM75_REG_TEMP[i]);
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
+static struct i2c_device_id lm75_id[] = {
+	{ "lm75", 0 },
+	{ "lm75a", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, lm75_id);
 
-	return data;
-}
+static struct i2c_driver lm75_driver = {
+	.driver = {
+		.name	= "lm75",
+	},
+	.probe = lm75_probe,
+	.remove = lm75_remove,
+	.id_table = lm75_id,
+};
 
 static int __init sensors_lm75_init(void)
 {
-- 
1.5.0


-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
