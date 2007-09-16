From: David Brownell <david-b@pacbell.net>
Date: Sun, 16 Sep 2007 23:45:19 +0000
Subject: [lm-sensors] [patch 2.6.23-rc6] lm75: new-style i2c binding, cleanup
Message-Id: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Updates and cleanups for lm75:

 - Update the LM75 driver to handle new-style I2C driver binding
   (following the driver model).

 - Use 12 bit resolution (1/16 degree C) on chips that support it,
   instead of 9 bit (1/2 degree C);  needs new conversion routines.

 - Grow the list of compatible chips; update Kconfig accordingly.

 - On driver disconnect, restore the original device config (which
   usually means shutdown).

 - Some code cleanups:  a handful of whitespace fixes, and clearly
   marking the various driver components (sysfs/hwmon attributes,
   driver core support, legacy stuff, register access, module glue).

The way to kick in higher sample resolution on a given board is to
use the new style binding to pass in the chip type.

One temporary omission:  IRQ support, or for the TI chips SMBALERT#
notifications.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/hwmon/Kconfig |   22 ++--
 drivers/hwmon/lm75.c  |  274 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 216 insertions(+), 80 deletions(-)

--- a/drivers/hwmon/Kconfig	2007-09-16 16:38:18.000000000 -0700
+++ b/drivers/hwmon/Kconfig	2007-09-16 16:38:18.000000000 -0700
@@ -301,13 +301,23 @@ config SENSORS_LM75
 	tristate "National Semiconductor LM75 and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for National Semiconductor LM75
-	  sensor chips and clones: Dallas Semiconductor DS75 and DS1775 (in
-	  9-bit precision mode), and TelCom (now Microchip) TCN75.
+	  If you say yes here you get support for one common type of
+	  temperature sensor chip, with models including:
 
-	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
-	  a force module parameter. The driver will not handle the extra
-	  precision anyhow.
+		- Dallas Semiconductor DS75 and DS1775
+		- Microchip MCP980x
+		- National Semiconductor LM75
+		- ST Microelectronics STDS75
+		- TelCom (now Microchip) TCN75
+		- Texas Instruments TMP75, TMP175, and TMP275
+
+	  This driver supports driver model based binding through board
+	  specific I2C device tables.  When those tables report a chip
+	  type that's recognized as supporting it, this driver uses 12-bit
+	  sample resolution (to 1/16 degree C).
+
+	  It also supports the "legacy" style of driver binding.  To use
+	  that with some chips, you may need the "force" module parameter.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm75.
--- a/drivers/hwmon/lm75.c	2007-09-16 16:33:53.000000000 -0700
+++ b/drivers/hwmon/lm75.c	2007-09-16 16:38:18.000000000 -0700
@@ -27,17 +27,21 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include "lm75.h"
 
 
-/* Addresses to scan */
+/*
+ * This driver handles (at least) the DS75, DS1775, LM75, MCP980x,
+ * STDS75, TCN75, TMP75, TMP175, TMP275, and other digital temperature
+ * sensors.
+ */
+
+/* Addresses scanned by legacy style driver binding */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-/* Insmod parameters */
+/* Insmod parameters (only for legacy style binding) */
 I2C_CLIENT_INSMOD_1(lm75);
 
-/* Many LM75 constants specified below */
 
 /* The LM75 registers */
 #define LM75_REG_CONF		0x01
@@ -49,43 +53,79 @@ static const u8 LM75_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct lm75_data {
-	struct i2c_client	client;
-	struct class_device *class_dev;
+	struct i2c_client	*client;
+	struct class_device	*hwmon;
 	struct mutex		update_lock;
-	char			valid;		/* !=0 if following fields are valid */
+	int			min, max;
+	char			orig_conf;
+	char			valid;		/* !=0 if registers are valid */
 	unsigned long		last_updated;	/* In jiffies */
 	u16			temp[3];	/* Register values,
 						   0 = input
 						   1 = max
 						   2 = hyst */
+	u16			round;		/* f(resolution) */
 };
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter);
-static int lm75_detect(struct i2c_adapter *adapter, int address, int kind);
-static void lm75_init_client(struct i2c_client *client);
 static int lm75_detach_client(struct i2c_client *client);
 static int lm75_read_value(struct i2c_client *client, u8 reg);
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
 static struct lm75_data *lm75_update_device(struct device *dev);
 
 
-/* This is the driver that will be inserted */
-static struct i2c_driver lm75_driver = {
+/* We handle both I2C driver binding models */
+static struct i2c_driver lm75_legacy_driver = {
 	.driver = {
-		.name	= "lm75",
+		.name	= "lm75_legacy",
 	},
 	.id		= I2C_DRIVERID_LM75,
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
 };
 
+static int lm75_probe(struct i2c_client *client);
+static int lm75_remove(struct i2c_client *client);
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
+/* sysfs attributes for hwmon, handling any sample resolution */
+
+static inline s16 temp_to_reg(struct lm75_data *lm75, long temp)
+{
+	if (temp < lm75->min)
+		temp = lm75->min;
+	else if (temp > lm75->max)
+		temp = lm75->max;
+
+	/* this "rounding" is squirrely but backwards-compatible */
+	temp += (temp < 0) ? -lm75->round : lm75->round;
+	return (temp * 256) / 1000;
+}
+
+static inline int reg_to_temp(s16 reg)
+{
+	/* Use integer division instead of logical right shift to
+	 * preserve sign (compiler uses arithmetic right shift).
+	 */
+	return (reg * 1000) / 256;
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
@@ -98,7 +138,7 @@ static ssize_t set_temp(struct device *d
 	unsigned long temp = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp[nr] = LM75_TEMP_TO_REG(temp);
+	data->temp[nr] = temp_to_reg(data, temp);
 	lm75_write_value(client, LM75_REG_TEMP[nr], data->temp[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -110,13 +150,6 @@ static SENSOR_DEVICE_ATTR(temp1_max_hyst
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
@@ -129,32 +162,134 @@ static const struct attribute_group lm75
 	.attrs = lm75_attributes,
 };
 
+/*-----------------------------------------------------------------------*/
+
+/* "New style" I2C driver binding -- following the driver model */
+
+static int lm75_probe(struct i2c_client *client)
+{
+	struct lm75_data	*data;
+	int			status;
+	u8			set_mask, clr_mask;
+	int			new;
+	int			resolution;
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
+	resolution = 9;
+
+	/* for ds1175, use name "ds75".
+	 * for tmp175 or tmp275, use name "tmp75".
+	 */
+	if (strcmp(client->name, "ds75") = 0
+			|| strcmp(client->name, "mcp980x") = 0
+			|| strcmp(client->name, "tmp75") = 0) {
+		resolution = 12;
+		set_mask |= (1 << 6) | (1 << 5);
+	}
+	data->round = 500 / (1 << (resolution - 8));
+
+	data->min = -55 * 1000;
+	data->max = 125 * 1000;
+
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
+	data->hwmon = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon)) {
+		status = PTR_ERR(data->hwmon);
+		goto exit_remove;
+	}
+
+	dev_info(&client->dev,
+		"%s: sensor '%s', resolution 0.%03d degrees C\n",
+		data->hwmon->class_id, client->name, data->round * 2);
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
+	hwmon_device_unregister(data->hwmon);
+	sysfs_remove_group(&client->dev.kobj, &lm75_group);
+	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+	return 0;
+}
+
+/*-----------------------------------------------------------------------*/
+
+/* "Legacy" I2C driver binding */
+
 /* This function is called by i2c_probe */
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
 	struct i2c_client *new_client;
-	struct lm75_data *data;
 	int err = 0;
-	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
 		goto exit;
 
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
+	/* OK. For now, we presume we have a valid address. We create the
+	   client structure, even though there may be no sensor present.
 	   But it allows us to access lm75_{read,write}_value. */
-	if (!(data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
+	if (!(new_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
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
@@ -175,17 +310,17 @@ static int lm75_detect(struct i2c_adapte
 		 || i2c_smbus_read_word_data(new_client, 5) != hyst
 		 || i2c_smbus_read_word_data(new_client, 6) != hyst
 		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
-		 	goto exit_free;
+			goto exit_free;
 		os = i2c_smbus_read_word_data(new_client, 3);
 		if (i2c_smbus_read_word_data(new_client, 4) != os
 		 || i2c_smbus_read_word_data(new_client, 5) != os
 		 || i2c_smbus_read_word_data(new_client, 6) != os
 		 || i2c_smbus_read_word_data(new_client, 7) != os)
-		 	goto exit_free;
+			goto exit_free;
 
 		/* Unused bits */
 		if (conf & 0xe0)
-		 	goto exit_free;
+			goto exit_free;
 
 		/* Addresses cycling */
 		for (i = 8; i < 0xff; i += 8)
@@ -193,60 +328,46 @@ static int lm75_detect(struct i2c_adapte
 			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
 			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
 				goto exit_free;
-	}
-
-	/* Determine the chip type - only one kind supported! */
-	if (kind <= 0)
-		kind = lm75;
 
-	if (kind = lm75) {
-		name = "lm75";
+		strlcpy(new_client->name, "lm75", I2C_NAME_SIZE);
 	}
 
-	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
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
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
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
 
+static int lm75_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, lm75_detect);
+}
+
 static int lm75_detach_client(struct i2c_client *client)
 {
-	struct lm75_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->class_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm75_group);
+	lm75_remove(client);
 	i2c_detach_client(client);
-	kfree(data);
+	kfree(client);
 	return 0;
 }
 
+/*-----------------------------------------------------------------------*/
+
+/* register access */
+
 /* All registers are word-sized, except for the configuration register.
    LM75 uses a high-byte first convention, which is exactly opposite to
    the usual practice. */
@@ -269,16 +390,6 @@ static int lm75_write_value(struct i2c_c
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
@@ -303,13 +414,28 @@ static struct lm75_data *lm75_update_dev
 	return data;
 }
 
+/*-----------------------------------------------------------------------*/
+
+/* module glue */
+
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
