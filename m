From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 17:55:23 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (ds1621) Clean up register access
Message-Id: <20090130185523.7c05c1ea@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix a few oddities in how the ds1621 driver accesses the registers:
* We don't need a wrapper to access the configuration register.
* Check for error before calling swab16. Error checking isn't
  complete yet, but that's a start.
* Device-specific read functions should never be called during
  detection, as by definition we don't know what device we are talking
  to at that point.
* Likewise, don't assume that register reads succeed during detection.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/ds1621.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

--- linux-2.6.29-rc2.orig/drivers/hwmon/ds1621.c	2009-01-27 14:35:08.000000000 +0100
+++ linux-2.6.29-rc2/drivers/hwmon/ds1621.c	2009-01-28 10:04:25.000000000 +0100
@@ -81,28 +81,27 @@ struct ds1621_data {
 	u8 conf;			/* Register encoding, combined */
 };
 
-/* All registers are word-sized, except for the configuration register.
+/* Temperature registers are word-sized.
    DS1621 uses a high-byte first convention, which is exactly opposite to
    the SMBus standard. */
-static int ds1621_read_value(struct i2c_client *client, u8 reg)
+static int ds1621_read_temp(struct i2c_client *client, u8 reg)
 {
-	if (reg = DS1621_REG_CONF)
-		return i2c_smbus_read_byte_data(client, reg);
-	else
-		return swab16(i2c_smbus_read_word_data(client, reg));
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+	return swab16(ret);
 }
 
-static int ds1621_write_value(struct i2c_client *client, u8 reg, u16 value)
+static int ds1621_write_temp(struct i2c_client *client, u8 reg, u16 value)
 {
-	if (reg = DS1621_REG_CONF)
-		return i2c_smbus_write_byte_data(client, reg, value);
-	else
-		return i2c_smbus_write_word_data(client, reg, swab16(value));
+	return i2c_smbus_write_word_data(client, reg, swab16(value));
 }
 
 static void ds1621_init_client(struct i2c_client *client)
 {
-	int reg = ds1621_read_value(client, DS1621_REG_CONF);
+	int reg = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
 	/* switch to continuous conversion mode */
 	reg &= ~ DS1621_REG_CONFIG_1SHOT;
 
@@ -112,7 +111,7 @@ static void ds1621_init_client(struct i2
 	else if (polarity = 1)
 		reg |= DS1621_REG_CONFIG_POLARITY;
 	
-	ds1621_write_value(client, DS1621_REG_CONF, reg);
+	i2c_smbus_write_byte_data(client, DS1621_REG_CONF, reg);
 	
 	/* start conversion */
 	i2c_smbus_write_byte(client, DS1621_COM_START);
@@ -132,11 +131,11 @@ static struct ds1621_data *ds1621_update
 
 		dev_dbg(&client->dev, "Starting ds1621 update\n");
 
-		data->conf = ds1621_read_value(client, DS1621_REG_CONF);
+		data->conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
 
 		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
-			data->temp[i] = ds1621_read_value(client,
-							  DS1621_REG_TEMP[i]);
+			data->temp[i] = ds1621_read_temp(client,
+							 DS1621_REG_TEMP[i]);
 
 		/* reset alarms if necessary */
 		new_conf = data->conf;
@@ -145,8 +144,8 @@ static struct ds1621_data *ds1621_update
 		if (data->temp[0] < data->temp[2])	/* input < max */
 			new_conf &= ~DS1621_ALARM_TEMP_HIGH;
 		if (data->conf != new_conf)
-			ds1621_write_value(client, DS1621_REG_CONF,
-					   new_conf);
+			i2c_smbus_write_byte_data(client, DS1621_REG_CONF,
+						  new_conf);
 
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -176,8 +175,8 @@ static ssize_t set_temp(struct device *d
 
 	mutex_lock(&data->update_lock);
 	data->temp[attr->index] = val;
-	ds1621_write_value(client, DS1621_REG_TEMP[attr->index],
-			   data->temp[attr->index]);
+	ds1621_write_temp(client, DS1621_REG_TEMP[attr->index],
+			  data->temp[attr->index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -239,13 +238,14 @@ static int ds1621_detect(struct i2c_clie
 		/* The NVB bit should be low if no EEPROM write has been 
 		   requested during the latest 10ms, which is highly 
 		   improbable in our case. */
-		conf = ds1621_read_value(client, DS1621_REG_CONF);
-		if (conf & DS1621_REG_CONFIG_NVB)
+		conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
+		if (conf < 0 || conf & DS1621_REG_CONFIG_NVB)
 			return -ENODEV;
 		/* The 7 lowest bits of a temperature should always be 0. */
 		for (i = 0; i < ARRAY_SIZE(DS1621_REG_TEMP); i++) {
-			temp = ds1621_read_value(client, DS1621_REG_TEMP[i]);
-			if (temp & 0x007f)
+			temp = i2c_smbus_read_word_data(client,
+							DS1621_REG_TEMP[i]);
+			if (temp < 0 || (temp & 0x7f00))
 				return -ENODEV;
 		}
 	}

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
