From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 17:54:03 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (ds1621) Reorder code statements
Message-Id: <20090130185403.68e02343@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder the ds1621 driver code so that we can get rid of forward
function declarations.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/ds1621.c |  123 ++++++++++++++++++++++--------------------------
 1 file changed, 57 insertions(+), 66 deletions(-)

--- linux-2.6.29-rc2.orig/drivers/hwmon/ds1621.c	2009-01-24 17:35:19.000000000 +0100
+++ linux-2.6.29-rc2/drivers/hwmon/ds1621.c	2009-01-24 17:36:59.000000000 +0100
@@ -81,34 +81,6 @@ struct ds1621_data {
 	u8 conf;			/* Register encoding, combined */
 };
 
-static int ds1621_probe(struct i2c_client *client,
-			const struct i2c_device_id *id);
-static int ds1621_detect(struct i2c_client *client, int kind,
-			 struct i2c_board_info *info);
-static void ds1621_init_client(struct i2c_client *client);
-static int ds1621_remove(struct i2c_client *client);
-static struct ds1621_data *ds1621_update_client(struct device *dev);
-
-static const struct i2c_device_id ds1621_id[] = {
-	{ "ds1621", ds1621 },
-	{ "ds1625", ds1621 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ds1621_id);
-
-/* This is the driver that will be inserted */
-static struct i2c_driver ds1621_driver = {
-	.class		= I2C_CLASS_HWMON,
-	.driver = {
-		.name	= "ds1621",
-	},
-	.probe		= ds1621_probe,
-	.remove		= ds1621_remove,
-	.id_table	= ds1621_id,
-	.detect		= ds1621_detect,
-	.address_data	= &addr_data,
-};
-
 /* All registers are word-sized, except for the configuration register.
    DS1621 uses a high-byte first convention, which is exactly opposite to
    the SMBus standard. */
@@ -146,6 +118,45 @@ static void ds1621_init_client(struct i2
 	i2c_smbus_write_byte(client, DS1621_COM_START);
 }
 
+static struct ds1621_data *ds1621_update_client(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds1621_data *data = i2c_get_clientdata(client);
+	u8 new_conf;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		int i;
+
+		dev_dbg(&client->dev, "Starting ds1621 update\n");
+
+		data->conf = ds1621_read_value(client, DS1621_REG_CONF);
+
+		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
+			data->temp[i] = ds1621_read_value(client,
+							  DS1621_REG_TEMP[i]);
+
+		/* reset alarms if necessary */
+		new_conf = data->conf;
+		if (data->temp[0] > data->temp[1])	/* input > min */
+			new_conf &= ~DS1621_ALARM_TEMP_LOW;
+		if (data->temp[0] < data->temp[2])	/* input < max */
+			new_conf &= ~DS1621_ALARM_TEMP_HIGH;
+		if (data->conf != new_conf)
+			ds1621_write_value(client, DS1621_REG_CONF,
+					   new_conf);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
 static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 			 char *buf)
 {
@@ -294,45 +305,25 @@ static int ds1621_remove(struct i2c_clie
 	return 0;
 }
 
+static const struct i2c_device_id ds1621_id[] = {
+	{ "ds1621", ds1621 },
+	{ "ds1625", ds1621 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ds1621_id);
 
-static struct ds1621_data *ds1621_update_client(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ds1621_data *data = i2c_get_clientdata(client);
-	u8 new_conf;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
-		int i;
-
-		dev_dbg(&client->dev, "Starting ds1621 update\n");
-
-		data->conf = ds1621_read_value(client, DS1621_REG_CONF);
-
-		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
-			data->temp[i] = ds1621_read_value(client,
-							  DS1621_REG_TEMP[i]);
-
-		/* reset alarms if necessary */
-		new_conf = data->conf;
-		if (data->temp[0] > data->temp[1])	/* input > min */
-			new_conf &= ~DS1621_ALARM_TEMP_LOW;
-		if (data->temp[0] < data->temp[2])	/* input < max */
-			new_conf &= ~DS1621_ALARM_TEMP_HIGH;
-		if (data->conf != new_conf)
-			ds1621_write_value(client, DS1621_REG_CONF,
-					   new_conf);
-
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
-
-	return data;
-}
+/* This is the driver that will be inserted */
+static struct i2c_driver ds1621_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "ds1621",
+	},
+	.probe		= ds1621_probe,
+	.remove		= ds1621_remove,
+	.id_table	= ds1621_id,
+	.detect		= ds1621_detect,
+	.address_data	= &addr_data,
+};
 
 static int __init ds1621_init(void)
 {

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
