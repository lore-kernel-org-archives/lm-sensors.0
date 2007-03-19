From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Mar 2007 12:34:04 +0000
Subject: [lm-sensors] [PATCH 2/3] lm78: Be less i2c_client-centric
Message-Id: <20070319133404.8354ea72.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use the driver data structure as the main device reference, instead of
the i2c client. It makes the driver a bit smaller, and makes more sense
as this is an hybrid driver, supporting both I2C and ISA devices.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/lm78.c |   86 +++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

--- linux-2.6.21-rc4.orig/drivers/hwmon/lm78.c	2007-03-19 09:37:45.000000000 +0100
+++ linux-2.6.21-rc4/drivers/hwmon/lm78.c	2007-03-19 10:05:08.000000000 +0100
@@ -159,10 +159,10 @@ static int lm78_detach_client(struct i2c
 static int __devinit lm78_isa_probe(struct platform_device *pdev);
 static int __devexit lm78_isa_remove(struct platform_device *pdev);
 
-static int lm78_read_value(struct i2c_client *client, u8 reg);
-static int lm78_write_value(struct i2c_client *client, u8 reg, u8 value);
+static int lm78_read_value(struct lm78_data *data, u8 reg);
+static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value);
 static struct lm78_data *lm78_update_device(struct device *dev);
-static void lm78_init_client(struct i2c_client *client);
+static void lm78_init_device(struct lm78_data *data);
 
 
 static struct i2c_driver lm78_driver = {
@@ -207,12 +207,11 @@ static ssize_t set_in_min(struct device 
 		size_t count, int nr)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
-	lm78_write_value(client, LM78_REG_IN_MIN(nr), data->in_min[nr]);
+	lm78_write_value(data, LM78_REG_IN_MIN(nr), data->in_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -221,12 +220,11 @@ static ssize_t set_in_max(struct device 
 		size_t count, int nr)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
-	lm78_write_value(client, LM78_REG_IN_MAX(nr), data->in_max[nr]);
+	lm78_write_value(data, LM78_REG_IN_MAX(nr), data->in_max[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -288,12 +286,11 @@ static ssize_t show_temp_over(struct dev
 static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_over = TEMP_TO_REG(val);
-	lm78_write_value(client, LM78_REG_TEMP_OVER, data->temp_over);
+	lm78_write_value(data, LM78_REG_TEMP_OVER, data->temp_over);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -307,12 +304,11 @@ static ssize_t show_temp_hyst(struct dev
 static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst = TEMP_TO_REG(val);
-	lm78_write_value(client, LM78_REG_TEMP_HYST, data->temp_hyst);
+	lm78_write_value(data, LM78_REG_TEMP_HYST, data->temp_hyst);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -342,12 +338,11 @@ static ssize_t set_fan_min(struct device
 		size_t count, int nr)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	lm78_write_value(client, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
+	lm78_write_value(data, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -366,7 +361,6 @@ static ssize_t set_fan_div(struct device
 	size_t count, int nr)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	unsigned long min;
 	u8 reg;
@@ -387,7 +381,7 @@ static ssize_t set_fan_div(struct device
 		return -EINVAL;
 	}
 
-	reg = lm78_read_value(client, LM78_REG_VID_FANDIV);
+	reg = lm78_read_value(data, LM78_REG_VID_FANDIV);
 	switch (nr) {
 	case 0:
 		reg = (reg & 0xcf) | (data->fan_div[nr] << 4);
@@ -396,11 +390,11 @@ static ssize_t set_fan_div(struct device
 		reg = (reg & 0x3f) | (data->fan_div[nr] << 6);
 		break;
 	}
-	lm78_write_value(client, LM78_REG_VID_FANDIV, reg);
+	lm78_write_value(data, LM78_REG_VID_FANDIV, reg);
 
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	lm78_write_value(client, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
+	lm78_write_value(data, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -563,11 +557,11 @@ static int lm78_detect(struct i2c_adapte
 
 	/* Now, we do the remaining detection. */
 	if (kind < 0) {
-		if (lm78_read_value(new_client, LM78_REG_CONFIG) & 0x80) {
+		if (lm78_read_value(data, LM78_REG_CONFIG) & 0x80) {
 			err = -ENODEV;
 			goto ERROR2;
 		}
-		if (lm78_read_value(new_client, LM78_REG_I2C_ADDR) !+		if (lm78_read_value(data, LM78_REG_I2C_ADDR) ! 		    address) {
 			err = -ENODEV;
 			goto ERROR2;
@@ -576,7 +570,7 @@ static int lm78_detect(struct i2c_adapte
 
 	/* Determine the chip type. */
 	if (kind <= 0) {
-		i = lm78_read_value(new_client, LM78_REG_CHIPID);
+		i = lm78_read_value(data, LM78_REG_CHIPID);
 		if (i = 0x00 || i = 0x20	/* LM78 */
 		 || i = 0x40)			/* LM78-J */
 			kind = lm78;
@@ -608,7 +602,7 @@ static int lm78_detect(struct i2c_adapte
 		goto ERROR2;
 
 	/* Initialize the LM78 chip */
-	lm78_init_client(new_client);
+	lm78_init_device(data);
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm78_group)))
@@ -671,7 +665,7 @@ static int __devinit lm78_isa_probe(stru
 	i2c_set_clientdata(&data->client, data);
 	platform_set_drvdata(pdev, data);
 
-	if (lm78_read_value(&data->client, LM78_REG_CHIPID) & 0x80) {
+	if (lm78_read_value(data, LM78_REG_CHIPID) & 0x80) {
 		data->type = lm79;
 		name = "lm79";
 	} else {
@@ -681,7 +675,7 @@ static int __devinit lm78_isa_probe(stru
 	strlcpy(data->client.name, name, I2C_NAME_SIZE);
 
 	/* Initialize the LM78 chip */
-	lm78_init_client(&data->client);
+	lm78_init_device(data);
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &lm78_group))
@@ -724,11 +718,12 @@ static int __devexit lm78_isa_remove(str
    separately.
    We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
    would slow down the LM78 access and should not be necessary.  */
-static int lm78_read_value(struct i2c_client *client, u8 reg)
+static int lm78_read_value(struct lm78_data *data, u8 reg)
 {
-	int res;
+	struct i2c_client *client = &data->client;
+
 	if (!client->driver) { /* ISA device */
-		struct lm78_data *data = i2c_get_clientdata(client);
+		int res;
 		mutex_lock(&data->lock);
 		outb_p(reg, client->addr + LM78_ADDR_REG_OFFSET);
 		res = inb_p(client->addr + LM78_DATA_REG_OFFSET);
@@ -745,10 +740,11 @@ static int lm78_read_value(struct i2c_cl
    would slow down the LM78 access and should not be necessary. 
    There are some ugly typecasts here, but the good new is - they should
    nowhere else be necessary! */
-static int lm78_write_value(struct i2c_client *client, u8 reg, u8 value)
+static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value)
 {
+	struct i2c_client *client = &data->client;
+
 	if (!client->driver) { /* ISA device */
-		struct lm78_data *data = i2c_get_clientdata(client);
 		mutex_lock(&data->lock);
 		outb_p(reg, client->addr + LM78_ADDR_REG_OFFSET);
 		outb_p(value, client->addr + LM78_DATA_REG_OFFSET);
@@ -758,21 +754,20 @@ static int lm78_write_value(struct i2c_c
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-static void lm78_init_client(struct i2c_client *client)
+static void lm78_init_device(struct lm78_data *data)
 {
-	struct lm78_data *data = i2c_get_clientdata(client);
 	u8 config;
 	int i;
 
 	/* Start monitoring */
-	config = lm78_read_value(client, LM78_REG_CONFIG);
+	config = lm78_read_value(data, LM78_REG_CONFIG);
 	if ((config & 0x09) != 0x01)
-		lm78_write_value(client, LM78_REG_CONFIG,
+		lm78_write_value(data, LM78_REG_CONFIG,
 				 (config & 0xf7) | 0x01);
 
 	/* A few vars need to be filled upon startup */
 	for (i = 0; i < 3; i++) {
-		data->fan_min[i] = lm78_read_value(client,
+		data->fan_min[i] = lm78_read_value(data,
 					LM78_REG_FAN_MIN(i));
 	}
 
@@ -782,7 +777,6 @@ static void lm78_init_client(struct i2c_
 static struct lm78_data *lm78_update_device(struct device *dev)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -794,35 +788,35 @@ static struct lm78_data *lm78_update_dev
 
 		for (i = 0; i <= 6; i++) {
 			data->in[i] -			    lm78_read_value(client, LM78_REG_IN(i));
+			    lm78_read_value(data, LM78_REG_IN(i));
 			data->in_min[i] -			    lm78_read_value(client, LM78_REG_IN_MIN(i));
+			    lm78_read_value(data, LM78_REG_IN_MIN(i));
 			data->in_max[i] -			    lm78_read_value(client, LM78_REG_IN_MAX(i));
+			    lm78_read_value(data, LM78_REG_IN_MAX(i));
 		}
 		for (i = 0; i < 3; i++) {
 			data->fan[i] -			    lm78_read_value(client, LM78_REG_FAN(i));
+			    lm78_read_value(data, LM78_REG_FAN(i));
 			data->fan_min[i] -			    lm78_read_value(client, LM78_REG_FAN_MIN(i));
+			    lm78_read_value(data, LM78_REG_FAN_MIN(i));
 		}
-		data->temp = lm78_read_value(client, LM78_REG_TEMP);
+		data->temp = lm78_read_value(data, LM78_REG_TEMP);
 		data->temp_over -		    lm78_read_value(client, LM78_REG_TEMP_OVER);
+		    lm78_read_value(data, LM78_REG_TEMP_OVER);
 		data->temp_hyst -		    lm78_read_value(client, LM78_REG_TEMP_HYST);
-		i = lm78_read_value(client, LM78_REG_VID_FANDIV);
+		    lm78_read_value(data, LM78_REG_TEMP_HYST);
+		i = lm78_read_value(data, LM78_REG_VID_FANDIV);
 		data->vid = i & 0x0f;
 		if (data->type = lm79)
 			data->vid |-			    (lm78_read_value(client, LM78_REG_CHIPID) &
+			    (lm78_read_value(data, LM78_REG_CHIPID) &
 			     0x01) << 4;
 		else
 			data->vid |= 0x10;
 		data->fan_div[0] = (i >> 4) & 0x03;
 		data->fan_div[1] = i >> 6;
-		data->alarms = lm78_read_value(client, LM78_REG_ALARM1) +
-		    (lm78_read_value(client, LM78_REG_ALARM2) << 8);
+		data->alarms = lm78_read_value(data, LM78_REG_ALARM1) +
+		    (lm78_read_value(data, LM78_REG_ALARM2) << 8);
 		data->last_updated = jiffies;
 		data->valid = 1;
 


-- 
Jean Delvare

