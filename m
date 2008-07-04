From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Jul 2008 10:05:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ad7418) Convert to a new-style i2c
Message-Id: <20080704120522.052e2d9a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ad7418 driver is only used on embedded platforms where i2c
devices can easily be declared in platform code. Thus a new-style
i2c driver makes perfect sense. This lets us get rid of quirky
detection code (these chips have no identification registers) and
shrinks the binary driver size by 38%.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
---
 drivers/hwmon/ad7418.c |  109 +++++++++++-------------------------------------
 1 file changed, 26 insertions(+), 83 deletions(-)

--- linux-2.6.26-rc8.orig/drivers/hwmon/ad7418.c	2008-07-04 11:30:12.000000000 +0200
+++ linux-2.6.26-rc8/drivers/hwmon/ad7418.c	2008-07-04 11:51:39.000000000 +0200
@@ -23,12 +23,9 @@
 
 #include "lm75.h"
 
-#define DRV_VERSION "0.3"
+#define DRV_VERSION "0.4"
 
-/* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x28, I2C_CLIENT_END };
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_3(ad7416, ad7417, ad7418);
+enum chips { ad7416, ad7417, ad7418 };
 
 /* AD7418 registers */
 #define AD7418_REG_TEMP_IN	0x00
@@ -46,7 +43,6 @@ static const u8 AD7418_REG_TEMP[] = { AD
 					AD7418_REG_TEMP_OS };
 
 struct ad7418_data {
-	struct i2c_client	client;
 	struct device		*hwmon_dev;
 	struct attribute_group	attrs;
 	enum chips		type;
@@ -58,16 +54,25 @@ struct ad7418_data {
 	u16			in[4];
 };
 
-static int ad7418_attach_adapter(struct i2c_adapter *adapter);
-static int ad7418_detect(struct i2c_adapter *adapter, int address, int kind);
-static int ad7418_detach_client(struct i2c_client *client);
+static int ad7418_probe(struct i2c_client *client,
+			const struct i2c_device_id *id);
+static int ad7418_remove(struct i2c_client *client);
+
+static struct i2c_device_id ad7418_id[] = {
+	{ "ad7416", ad7416 },
+	{ "ad7417", ad7417 },
+	{ "ad7418", ad7418 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad7418_id);
 
 static struct i2c_driver ad7418_driver = {
 	.driver = {
 		.name	= "ad7418",
 	},
-	.attach_adapter	= ad7418_attach_adapter,
-	.detach_client	= ad7418_detach_client,
+	.probe		= ad7418_probe,
+	.remove		= ad7418_remove,
+	.id_table	= ad7418_id,
 };
 
 /* All registers are word-sized, except for the configuration registers.
@@ -192,13 +197,6 @@ static SENSOR_DEVICE_ATTR(in2_input, S_I
 static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_adc, NULL, 2);
 static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_adc, NULL, 3);
 
-static int ad7418_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, ad7418_detect);
-}
-
 static struct attribute *ad7416_attributes[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
@@ -225,98 +223,46 @@ static struct attribute *ad7418_attribut
 	NULL
 };
 
-static int ad7418_detect(struct i2c_adapter *adapter, int address, int kind)
+static int ad7418_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
-	struct i2c_client *client;
+	struct i2c_adapter *adapter = client->adapter;
 	struct ad7418_data *data;
-	int err = 0;
+	int err;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
-					I2C_FUNC_SMBUS_WORD_DATA))
+					I2C_FUNC_SMBUS_WORD_DATA)) {
+		err = -EOPNOTSUPP;
 		goto exit;
+	}
 
 	if (!(data = kzalloc(sizeof(struct ad7418_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
 
-	client = &data->client;
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &ad7418_driver;
-
 	i2c_set_clientdata(client, data);
 
 	mutex_init(&data->lock);
-
-	/* AD7418 has a curious behaviour on registers 6 and 7. They
-	 * both always read 0xC071 and are not documented on the datasheet.
-	 * We use them to detect the chip.
-	 */
-	if (kind <= 0) {
-		int reg, reg6, reg7;
-
-		/* the AD7416 lies within this address range, but I have
-		 * no means to check.
-		 */
-		if (address >= 0x48 && address <= 0x4f) {
-			/* XXX add tests for AD7416 here */
-			/* data->type = ad7416; */
-		}
-		/* here we might have AD7417 or AD7418 */
-		else if (address >= 0x28 && address <= 0x2f) {
-			reg6 = i2c_smbus_read_word_data(client, 0x06);
-			reg7 = i2c_smbus_read_word_data(client, 0x07);
-
-			if (address = 0x28 && reg6 = 0xC071 && reg7 = 0xC071)
-				data->type = ad7418;
-
-			/* XXX add tests for AD7417 here */
-
-
-			/* both AD7417 and AD7418 have bits 0-5 of
-			 * the CONF2 register at 0
-			 */
-			reg = i2c_smbus_read_byte_data(client,
-							AD7418_REG_CONF2);
-			if (reg & 0x3F)
-				data->type = any_chip; /* detection failed */
-		}
-	} else {
-		dev_dbg(&adapter->dev, "detection forced\n");
-	}
-
-	if (kind > 0)
-		data->type = kind;
-	else if (kind < 0 && data->type = any_chip) {
-		err = -ENODEV;
-		goto exit_free;
-	}
+	data->type = id->driver_data;
 
 	switch (data->type) {
-	case any_chip:
 	case ad7416:
 		data->adc_max = 0;
 		data->attrs.attrs = ad7416_attributes;
-		strlcpy(client->name, "ad7416", I2C_NAME_SIZE);
 		break;
 
 	case ad7417:
 		data->adc_max = 4;
 		data->attrs.attrs = ad7417_attributes;
-		strlcpy(client->name, "ad7417", I2C_NAME_SIZE);
 		break;
 
 	case ad7418:
 		data->adc_max = 1;
 		data->attrs.attrs = ad7418_attributes;
-		strlcpy(client->name, "ad7418", I2C_NAME_SIZE);
 		break;
 	}
 
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
-
 	dev_info(&client->dev, "%s chip found\n", client->name);
 
 	/* Initialize the AD7418 chip */
@@ -324,7 +270,7 @@ static int ad7418_detect(struct i2c_adap
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))
-		goto exit_detach;
+		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -336,20 +282,17 @@ static int ad7418_detect(struct i2c_adap
 
 exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-exit_detach:
-	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
 	return err;
 }
 
-static int ad7418_detach_client(struct i2c_client *client)
+static int ad7418_remove(struct i2c_client *client)
 {
 	struct ad7418_data *data = i2c_get_clientdata(client);
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
