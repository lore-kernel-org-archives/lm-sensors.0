From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Jan 2009 15:57:31 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (ds1621) Make use of the extra
Message-Id: <20090116165731.5517cbc5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The DS1621 has an extra register which provides a resolution of 1/16
degree C instead of 1/2 degree C. Make use of it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/ds1621.c |   48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

--- linux-2.6.29-rc1.orig/drivers/hwmon/ds1621.c	2009-01-16 15:53:57.000000000 +0100
+++ linux-2.6.29-rc1/drivers/hwmon/ds1621.c	2009-01-16 16:33:28.000000000 +0100
@@ -59,6 +59,8 @@ static const u8 DS1621_REG_TEMP[3] = {
 	0xA2,		/* min, word, RW */
 	0xA1,		/* max, word, RW */
 };
+#define DS1621_REG_COUNTER		0xA8
+#define DS1621_REG_SLOPE		0xA9
 #define DS1621_REG_CONF			0xAC /* byte, RW */
 #define DS1621_COM_START		0xEE /* no data */
 #define DS1621_COM_STOP			0x22 /* no data */
@@ -79,15 +81,15 @@ struct ds1621_data {
 	unsigned long last_updated;	/* In jiffies */
 	unsigned long last_written;	/* In jiffies */
 
-	u16 temp[3];			/* Register values, word */
+	s16 temp[3];			/* Register values, word */
 	u8 conf;			/* Register encoding, combined */
+	u8 slope;			/* Register value */
 };
 
 static int ds1621_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
 static int ds1621_detect(struct i2c_client *client, int kind,
 			 struct i2c_board_info *info);
-static void ds1621_init_client(struct i2c_client *client);
 static int ds1621_remove(struct i2c_client *client);
 static struct ds1621_data *ds1621_update_client(struct device *dev);
 
@@ -111,12 +113,13 @@ static struct i2c_driver ds1621_driver  	.address_data	= &addr_data,
 };
 
-/* All registers are word-sized, except for the configuration register.
+/* The temperature value and limit registers are word-sized.
    DS1621 uses a high-byte first convention, which is exactly opposite to
    the SMBus standard. */
 static int ds1621_read_value(struct i2c_client *client, u8 reg)
 {
-	if (reg = DS1621_REG_CONF)
+	if (reg = DS1621_REG_CONF ||
+	    reg = DS1621_REG_COUNTER || reg = DS1621_REG_SLOPE)
 		return i2c_smbus_read_byte_data(client, reg);
 	else
 		return swab16(i2c_smbus_read_word_data(client, reg));
@@ -144,7 +147,7 @@ static int ds1621_write_value(struct i2c
 	return ret;
 }
 
-static void ds1621_init_client(struct i2c_client *client)
+static int ds1621_init_client(struct i2c_client *client)
 {
 	struct ds1621_data *data = i2c_get_clientdata(client);
 	int old_reg, reg;
@@ -165,6 +168,15 @@ static void ds1621_init_client(struct i2
 	
 	/* start conversion */
 	i2c_smbus_write_byte(client, DS1621_COM_START);
+
+	/* assume that the value of this register never changes */
+	data->slope = ds1621_read_value(client, DS1621_REG_SLOPE);
+	if (data->slope = 0) {
+		dev_err(&client->dev, "Invalid slope value\n");
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 static ssize_t show_temp(struct device *dev, struct device_attribute *da,
@@ -172,8 +184,7 @@ static ssize_t show_temp(struct device *
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ds1621_data *data = ds1621_update_client(dev);
-	return sprintf(buf, "%d\n",
-		       LM75_TEMP_FROM_REG(data->temp[attr->index]));
+	return sprintf(buf, "%d\n", data->temp[attr->index] * 1000 / 256);
 }
 
 static ssize_t set_temp(struct device *dev, struct device_attribute *da,
@@ -281,7 +292,9 @@ static int ds1621_probe(struct i2c_clien
 	mutex_init(&data->update_lock);
 
 	/* Initialize the DS1621 chip */
-	ds1621_init_client(client);
+	err = ds1621_init_client(client);
+	if (err)
+		goto exit_free;
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&client->dev.kobj, &ds1621_group)))
@@ -320,7 +333,8 @@ static struct ds1621_data *ds1621_update
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ds1621_data *data = i2c_get_clientdata(client);
-	u8 new_conf;
+	u8 new_conf, counter;
+	s16 temp;
 
 	mutex_lock(&data->update_lock);
 
@@ -336,6 +350,22 @@ static struct ds1621_data *ds1621_update
 			data->temp[i] = ds1621_read_value(client,
 							  DS1621_REG_TEMP[i]);
 
+		/* read the extra resolution bits */
+		counter = ds1621_read_value(client, DS1621_REG_COUNTER);
+		/* There is a small chance that the device updated the
+		   registers by the time we read the counter register.
+		   So we have to read the temperature register again. */
+		temp = ds1621_read_value(client, DS1621_REG_TEMP[0]);
+		if (temp = data->temp[0]) {
+			/* merge the extra resolution bits */
+			data->temp[0] = (data->temp[0] & 0xff00) + 0xc0
+					- (counter << 8) / data->slope;
+		} else {
+			/* The reading just changed, meaning that we are at
+			   the exact boundary between the two values. */
+			data->temp[0] = (data->temp[0] + temp) / 2;
+		}
+
 		/* reset alarms if necessary */
 		new_conf = data->conf;
 		if (data->temp[0] > data->temp[1])	/* input > min */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
