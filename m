From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jan 2008 22:15:49 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asb100) Various cleanups
Message-Id: <20080103231549.3cb00f27@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Drop history, it's incomplete and doesn't belong there
* Drop unused version number
* Drop trailing spaces
* Coding style fixes
* Fold long lines
* Rename new_client to client
* Drop redundant initializations to 0

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/asb100.c |  124 +++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 64 deletions(-)

--- linux-2.6.24-rc6.orig/drivers/hwmon/asb100.c	2007-12-26 14:39:06.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/asb100.c	2007-12-31 11:57:08.000000000 +0100
@@ -47,12 +47,6 @@
 #include <linux/mutex.h>
 #include "lm75.h"
 
-/*
-	HISTORY:
-	2003-12-29	1.0.0	Ported from lm_sensors project for kernel 2.6
-*/
-#define ASB100_VERSION "1.0.0"
-
 /* I2C addresses to scan */
 static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 
@@ -344,14 +338,14 @@ static ssize_t set_fan_div(struct device
 	unsigned long min;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int reg;
-	
+
 	mutex_lock(&data->update_lock);
 
 	min = FAN_FROM_REG(data->fan_min[nr],
 			DIV_FROM_REG(data->fan_div[nr]));
 	data->fan_div[nr] = DIV_TO_REG(val);
 
-	switch(nr) {
+	switch (nr) {
 	case 0:	/* fan 1 */
 		reg = asb100_read_value(client, ASB100_REG_VID_FANDIV);
 		reg = (reg & 0xcf) | (data->fan_div[0] << 4);
@@ -429,7 +423,7 @@ static int sprintf_temp_from_reg(u16 reg
 	}
 	return ret;
 }
-		 	
+
 #define show_temp_reg(reg) \
 static ssize_t show_##reg(struct device *dev, char *buf, int nr) \
 { \
@@ -502,7 +496,8 @@ sysfs_temp(3);
 sysfs_temp(4);
 
 /* VID */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -511,13 +506,15 @@ static ssize_t show_vid(struct device *d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* VRM */
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
 	struct asb100_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
 
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	struct asb100_data *data = dev_get_drvdata(dev);
 	data->vrm = simple_strtoul(buf, NULL, 10);
@@ -527,7 +524,8 @@ static ssize_t set_vrm(struct device *de
 /* Alarms */
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -536,13 +534,15 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* 1 PWM */
-static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr,
+		char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", ASB100_PWM_FROM_REG(data->pwm & 0x0f));
 }
 
-static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
@@ -556,14 +556,15 @@ static ssize_t set_pwm1(struct device *d
 	return count;
 }
 
-static ssize_t show_pwm_enable1(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_pwm_enable1(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", (data->pwm & 0x80) ? 1 : 0);
 }
 
-static ssize_t set_pwm_enable1(struct device *dev, struct device_attribute *attr, const char *buf,
-				size_t count)
+static ssize_t set_pwm_enable1(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
@@ -653,10 +654,10 @@ static int asb100_attach_adapter(struct 
 }
 
 static int asb100_detect_subclients(struct i2c_adapter *adapter, int address,
-		int kind, struct i2c_client *new_client)
+		int kind, struct i2c_client *client)
 {
 	int i, id, err;
-	struct asb100_data *data = i2c_get_clientdata(new_client);
+	struct asb100_data *data = i2c_get_clientdata(client);
 
 	data->lm75[0] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(data->lm75[0])) {
@@ -676,26 +677,26 @@ static int asb100_detect_subclients(stru
 		for (i = 2; i <= 3; i++) {
 			if (force_subclients[i] < 0x48 ||
 			    force_subclients[i] > 0x4f) {
-				dev_err(&new_client->dev, "invalid subclient "
+				dev_err(&client->dev, "invalid subclient "
 					"address %d; must be 0x48-0x4f\n",
 					force_subclients[i]);
 				err = -ENODEV;
 				goto ERROR_SC_2;
 			}
 		}
-		asb100_write_value(new_client, ASB100_REG_I2C_SUBADDR,
+		asb100_write_value(client, ASB100_REG_I2C_SUBADDR,
 					(force_subclients[2] & 0x07) |
-					((force_subclients[3] & 0x07) <<4));
+					((force_subclients[3] & 0x07) << 4));
 		data->lm75[0]->addr = force_subclients[2];
 		data->lm75[1]->addr = force_subclients[3];
 	} else {
-		int val = asb100_read_value(new_client, ASB100_REG_I2C_SUBADDR);
+		int val = asb100_read_value(client, ASB100_REG_I2C_SUBADDR);
 		data->lm75[0]->addr = 0x48 + (val & 0x07);
 		data->lm75[1]->addr = 0x48 + ((val >> 4) & 0x07);
 	}
 
-	if(data->lm75[0]->addr = data->lm75[1]->addr) {
-		dev_err(&new_client->dev, "duplicate addresses 0x%x "
+	if (data->lm75[0]->addr = data->lm75[1]->addr) {
+		dev_err(&client->dev, "duplicate addresses 0x%x "
 				"for subclients\n", data->lm75[0]->addr);
 		err = -ENODEV;
 		goto ERROR_SC_2;
@@ -705,18 +706,17 @@ static int asb100_detect_subclients(stru
 		i2c_set_clientdata(data->lm75[i], NULL);
 		data->lm75[i]->adapter = adapter;
 		data->lm75[i]->driver = &asb100_driver;
-		data->lm75[i]->flags = 0;
 		strlcpy(data->lm75[i]->name, "asb100 subclient", I2C_NAME_SIZE);
 	}
 
 	if ((err = i2c_attach_client(data->lm75[0]))) {
-		dev_err(&new_client->dev, "subclient %d registration "
+		dev_err(&client->dev, "subclient %d registration "
 			"at address 0x%x failed.\n", i, data->lm75[0]->addr);
 		goto ERROR_SC_2;
 	}
 
 	if ((err = i2c_attach_client(data->lm75[1]))) {
-		dev_err(&new_client->dev, "subclient %d registration "
+		dev_err(&client->dev, "subclient %d registration "
 			"at address 0x%x failed.\n", i, data->lm75[1]->addr);
 		goto ERROR_SC_3;
 	}
@@ -737,7 +737,7 @@ ERROR_SC_0:
 static int asb100_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int err;
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct asb100_data *data;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -757,13 +757,12 @@ static int asb100_detect(struct i2c_adap
 		goto ERROR0;
 	}
 
-	new_client = &data->client;
+	client = &data->client;
 	mutex_init(&data->lock);
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &asb100_driver;
-	new_client->flags = 0;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &asb100_driver;
 
 	/* Now, we do the remaining detection. */
 
@@ -773,15 +772,15 @@ static int asb100_detect(struct i2c_adap
 	   bank. */
 	if (kind < 0) {
 
-		int val1 = asb100_read_value(new_client, ASB100_REG_BANK);
-		int val2 = asb100_read_value(new_client, ASB100_REG_CHIPMAN);
+		int val1 = asb100_read_value(client, ASB100_REG_BANK);
+		int val2 = asb100_read_value(client, ASB100_REG_CHIPMAN);
 
 		/* If we're in bank 0 */
-		if ( (!(val1 & 0x07)) &&
+		if ((!(val1 & 0x07)) &&
 				/* Check for ASB100 ID (low byte) */
-				( ((!(val1 & 0x80)) && (val2 != 0x94)) ||
+				(((!(val1 & 0x80)) && (val2 != 0x94)) ||
 				/* Check for ASB100 ID (high byte ) */
-				((val1 & 0x80) && (val2 != 0x06)) ) ) {
+				((val1 & 0x80) && (val2 != 0x06)))) {
 			pr_debug("asb100.o: detect failed, "
 					"bad chip id 0x%02x!\n", val2);
 			err = -ENODEV;
@@ -792,19 +791,19 @@ static int asb100_detect(struct i2c_adap
 
 	/* We have either had a force parameter, or we have already detected
 	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
-	asb100_write_value(new_client, ASB100_REG_BANK,
-		(asb100_read_value(new_client, ASB100_REG_BANK) & 0x78) | 0x80);
+	asb100_write_value(client, ASB100_REG_BANK,
+		(asb100_read_value(client, ASB100_REG_BANK) & 0x78) | 0x80);
 
 	/* Determine the chip type. */
 	if (kind <= 0) {
-		int val1 = asb100_read_value(new_client, ASB100_REG_WCHIPID);
-		int val2 = asb100_read_value(new_client, ASB100_REG_CHIPMAN);
+		int val1 = asb100_read_value(client, ASB100_REG_WCHIPID);
+		int val2 = asb100_read_value(client, ASB100_REG_CHIPMAN);
 
 		if ((val1 = 0x31) && (val2 = 0x06))
 			kind = asb100;
 		else {
 			if (kind = 0)
-				dev_warn(&new_client->dev, "ignoring "
+				dev_warn(&client->dev, "ignoring "
 					"'force' parameter for unknown chip "
 					"at adapter %d, address 0x%02x.\n",
 					i2c_adapter_id(adapter), address);
@@ -814,34 +813,32 @@ static int asb100_detect(struct i2c_adap
 	}
 
 	/* Fill in remaining client fields and put it into the global list */
-	strlcpy(new_client->name, "asb100", I2C_NAME_SIZE);
+	strlcpy(client->name, "asb100", I2C_NAME_SIZE);
 	data->type = kind;
-
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto ERROR1;
 
 	/* Attach secondary lm75 clients */
 	if ((err = asb100_detect_subclients(adapter, address, kind,
-			new_client)))
+			client)))
 		goto ERROR2;
 
 	/* Initialize the chip */
-	asb100_init_client(new_client);
+	asb100_init_client(client);
 
 	/* A few vars need to be filled upon startup */
-	data->fan_min[0] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(0));
-	data->fan_min[1] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(1));
-	data->fan_min[2] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(2));
+	data->fan_min[0] = asb100_read_value(client, ASB100_REG_FAN_MIN(0));
+	data->fan_min[1] = asb100_read_value(client, ASB100_REG_FAN_MIN(1));
+	data->fan_min[2] = asb100_read_value(client, ASB100_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &asb100_group)))
+	if ((err = sysfs_create_group(&client->dev.kobj, &asb100_group)))
 		goto ERROR3;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR4;
@@ -850,14 +847,14 @@ static int asb100_detect(struct i2c_adap
 	return 0;
 
 ERROR4:
-	sysfs_remove_group(&new_client->dev.kobj, &asb100_group);
+	sysfs_remove_group(&client->dev.kobj, &asb100_group);
 ERROR3:
 	i2c_detach_client(data->lm75[1]);
 	i2c_detach_client(data->lm75[0]);
 	kfree(data->lm75[1]);
 	kfree(data->lm75[0]);
 ERROR2:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 ERROR1:
 	kfree(data);
 ERROR0:
@@ -913,17 +910,17 @@ static int asb100_read_value(struct i2c_
 		/* convert from ISA to LM75 I2C addresses */
 		switch (reg & 0xff) {
 		case 0x50: /* TEMP */
-			res = swab16(i2c_smbus_read_word_data (cl, 0));
+			res = swab16(i2c_smbus_read_word_data(cl, 0));
 			break;
 		case 0x52: /* CONFIG */
 			res = i2c_smbus_read_byte_data(cl, 1);
 			break;
 		case 0x53: /* HYST */
-			res = swab16(i2c_smbus_read_word_data (cl, 2));
+			res = swab16(i2c_smbus_read_word_data(cl, 2));
 			break;
 		case 0x55: /* MAX */
 		default:
-			res = swab16(i2c_smbus_read_word_data (cl, 3));
+			res = swab16(i2c_smbus_read_word_data(cl, 3));
 			break;
 		}
 	}
@@ -986,7 +983,7 @@ static void asb100_init_client(struct i2
 	vid = vid_from_reg(vid, data->vrm);
 
 	/* Start monitoring */
-	asb100_write_value(client, ASB100_REG_CONFIG, 
+	asb100_write_value(client, ASB100_REG_CONFIG,
 		(asb100_read_value(client, ASB100_REG_CONFIG) & 0xf7) | 0x01);
 }
 
@@ -1075,4 +1072,3 @@ MODULE_LICENSE("GPL");
 
 module_init(asb100_init);
 module_exit(asb100_exit);
-


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
