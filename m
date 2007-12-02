From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2007 22:33:57 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (adm1031) Various cleanups
Message-Id: <20071202233357.7ddaa2e9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Rename new_client to client
* Drop redundant initializations to 0
* Drop trailing space
* Other whitespace cleanups
* Split/fold a few long lines
* Constify static data
* Optimizations in set_fan_div()

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1031.c |  126 +++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 64 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/adm1031.c	2007-12-02 22:22:18.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/adm1031.c	2007-12-02 22:33:47.000000000 +0100
@@ -5,7 +5,7 @@
   Supports adm1030 / adm1031
   Copyright (C) 2004 Alexandre d'Alton <alex@alexdalton.org>
   Reworked by Jean Delvare <khali@linux-fr.org>
-  
+
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
@@ -32,22 +32,22 @@
 
 /* Following macros takes channel parameter starting from 0 to 2 */
 #define ADM1031_REG_FAN_SPEED(nr)	(0x08 + (nr))
-#define ADM1031_REG_FAN_DIV(nr)		(0x20  + (nr))
+#define ADM1031_REG_FAN_DIV(nr)		(0x20 + (nr))
 #define ADM1031_REG_PWM			(0x22)
 #define ADM1031_REG_FAN_MIN(nr)		(0x10 + (nr))
 
-#define ADM1031_REG_TEMP_MAX(nr)	(0x14  + 4*(nr))
-#define ADM1031_REG_TEMP_MIN(nr)	(0x15  + 4*(nr))
-#define ADM1031_REG_TEMP_CRIT(nr)	(0x16  + 4*(nr))
+#define ADM1031_REG_TEMP_MAX(nr)	(0x14 + 4 * (nr))
+#define ADM1031_REG_TEMP_MIN(nr)	(0x15 + 4 * (nr))
+#define ADM1031_REG_TEMP_CRIT(nr)	(0x16 + 4 * (nr))
 
-#define ADM1031_REG_TEMP(nr)		(0xa + (nr))
+#define ADM1031_REG_TEMP(nr)		(0x0a + (nr))
 #define ADM1031_REG_AUTO_TEMP(nr)	(0x24 + (nr))
 
 #define ADM1031_REG_STATUS(nr)		(0x2 + (nr))
 
-#define ADM1031_REG_CONF1		0x0
-#define ADM1031_REG_CONF2		0x1
-#define ADM1031_REG_EXT_TEMP		0x6
+#define ADM1031_REG_CONF1		0x00
+#define ADM1031_REG_CONF2		0x01
+#define ADM1031_REG_EXT_TEMP		0x06
 
 #define ADM1031_CONF1_MONITOR_ENABLE	0x01	/* Monitoring enable */
 #define ADM1031_CONF1_PWM_INVERT	0x08	/* PWM Invert */
@@ -78,7 +78,7 @@ struct adm1031_data {
 	/* The chan_select_table contains the possible configurations for
 	 * auto fan control.
 	 */
-	auto_chan_table_t *chan_select_table;
+	const auto_chan_table_t *chan_select_table;
 	u16 alarm;
 	u8 conf1;
 	u8 conf2;
@@ -181,25 +181,25 @@ static int AUTO_TEMP_MAX_TO_REG(int val,
 #define GET_FAN_AUTO_BITFIELD(data, idx)	\
 	(*(data)->chan_select_table)[FAN_CHAN_FROM_REG((data)->conf1)][idx%2]
 
-/* The tables below contains the possible values for the auto fan 
+/* The tables below contains the possible values for the auto fan
  * control bitfields. the index in the table is the register value.
  * MSb is the auto fan control enable bit, so the four first entries
  * in the table disables auto fan control when both bitfields are zero.
  */
-static auto_chan_table_t auto_channel_select_table_adm1031 = {
-	{0, 0}, {0, 0}, {0, 0}, {0, 0},
-	{2 /*0b010 */ , 4 /*0b100 */ },
-	{2 /*0b010 */ , 2 /*0b010 */ },
-	{4 /*0b100 */ , 4 /*0b100 */ },
-	{7 /*0b111 */ , 7 /*0b111 */ },
+static const auto_chan_table_t auto_channel_select_table_adm1031 = {
+	{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },
+	{ 2 /* 0b010 */ , 4 /* 0b100 */ },
+	{ 2 /* 0b010 */ , 2 /* 0b010 */ },
+	{ 4 /* 0b100 */ , 4 /* 0b100 */ },
+	{ 7 /* 0b111 */ , 7 /* 0b111 */ },
 };
 
-static auto_chan_table_t auto_channel_select_table_adm1030 = {
-	{0, 0}, {0, 0}, {0, 0}, {0, 0},
-	{2 /*0b10 */		, 0},
-	{0xff /*invalid */	, 0},
-	{0xff /*invalid */	, 0},
-	{3 /*0b11 */		, 0},
+static const auto_chan_table_t auto_channel_select_table_adm1030 = {
+	{ 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 },
+	{ 2 /* 0b10 */		, 0 },
+	{ 0xff /* invalid */	, 0 },
+	{ 0xff /* invalid */	, 0 },
+	{ 3 /* 0b11 */		, 0 },
 };
 
 /* That function checks if a bitfield is valid and returns the other bitfield
@@ -228,8 +228,8 @@ get_fan_auto_nearest(struct adm1031_data
 			break;
 		} else if (val = (*data->chan_select_table)[i][chan] &&
 			   first_match = -1) {
-			/* Save the first match in case of an exact match has not been
-			 * found 
+			/* Save the first match in case of an exact match has
+			 * not been found
 			 */
 			first_match = i;
 		}
@@ -264,16 +264,17 @@ set_fan_auto_channel(struct device *dev,
 	old_fan_mode = data->conf1;
 
 	mutex_lock(&data->update_lock);
-	
+
 	if ((ret = get_fan_auto_nearest(data, nr, val, data->conf1, &reg))) {
 		mutex_unlock(&data->update_lock);
 		return ret;
 	}
-	if (((data->conf1 = FAN_CHAN_TO_REG(reg, data->conf1)) & ADM1031_CONF1_AUTO_MODE) ^ 
+	data->conf1 = FAN_CHAN_TO_REG(reg, data->conf1);
+	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) ^
 	    (old_fan_mode & ADM1031_CONF1_AUTO_MODE)) {
 		if (data->conf1 & ADM1031_CONF1_AUTO_MODE){
-			/* Switch to Auto Fan Mode 
-			 * Save PWM registers 
+			/* Switch to Auto Fan Mode
+			 * Save PWM registers
 			 * Set PWM registers to 33% Both */
 			data->old_pwm[0] = data->pwm[0];
 			data->old_pwm[1] = data->pwm[1];
@@ -283,7 +284,7 @@ set_fan_auto_channel(struct device *dev,
 			data->pwm[0] = data->old_pwm[0];
 			data->pwm[1] = data->old_pwm[1];
 			/* Restore PWM registers */
-			adm1031_write_value(client, ADM1031_REG_PWM, 
+			adm1031_write_value(client, ADM1031_REG_PWM,
 					    data->pwm[0] | (data->pwm[1] << 4));
 		}
 	}
@@ -314,7 +315,7 @@ fan_auto_channel_offset(2);
 static ssize_t show_auto_temp_off(struct device *dev, char *buf, int nr)
 {
 	struct adm1031_data *data = adm1031_update_device(dev);
-	return sprintf(buf, "%d\n", 
+	return sprintf(buf, "%d\n",
 		       AUTO_TEMP_OFF_FROM_REG(data->auto_temp[nr]));
 }
 static ssize_t show_auto_temp_min(struct device *dev, char *buf, int nr)
@@ -407,7 +408,7 @@ set_pwm(struct device *dev, const char *
 	int reg;
 
 	mutex_lock(&data->update_lock);
-	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) && 
+	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) &&
 	    (((val>>4) & 0xf) != 5)) {
 		/* In automatic mode, the only PWM accepted is 33% */
 		mutex_unlock(&data->update_lock);
@@ -471,7 +472,7 @@ static int trust_fan_readings(struct adm
 			    AUTO_TEMP_MIN_FROM_REG_DEG(data->auto_temp[0])
 			    || data->temp[1] > 			    AUTO_TEMP_MIN_FROM_REG_DEG(data->auto_temp[1])
-			    || (data->chip_type = adm1031 
+			    || (data->chip_type = adm1031
 				&& data->temp[2] > 				AUTO_TEMP_MIN_FROM_REG_DEG(data->auto_temp[2]));
 			break;
@@ -514,7 +515,7 @@ set_fan_min(struct device *dev, const ch
 
 	mutex_lock(&data->update_lock);
 	if (val) {
-		data->fan_min[nr] = 
+		data->fan_min[nr]  			FAN_TO_REG(val, FAN_DIV_FROM_REG(data->fan_div[nr]));
 	} else {
 		data->fan_min[nr] = 0xff;
@@ -535,12 +536,12 @@ set_fan_div(struct device *dev, const ch
 
 	tmp = val = 8 ? 0xc0 :
 	      val = 4 ? 0x80 :
-	      val = 2 ? 0x40 :	
-	      val = 1 ? 0x00 :  
+	      val = 2 ? 0x40 :
+	      val = 1 ? 0x00 :
 	      0xff;
 	if (tmp = 0xff)
 		return -EINVAL;
-	
+
 	mutex_lock(&data->update_lock);
 	/* Get fresh readings */
 	data->fan_div[nr] = adm1031_read_value(client,
@@ -550,14 +551,13 @@ set_fan_div(struct device *dev, const ch
 
 	/* Write the new clock divider and fan min */
 	old_div = FAN_DIV_FROM_REG(data->fan_div[nr]);
-	data->fan_div[nr] = (tmp & 0xC0) | (0x3f & data->fan_div[nr]);
-	new_min = data->fan_min[nr] * old_div / 
-		FAN_DIV_FROM_REG(data->fan_div[nr]);
+	data->fan_div[nr] = tmp | (0x3f & data->fan_div[nr]);
+	new_min = data->fan_min[nr] * old_div / val;
 	data->fan_min[nr] = new_min > 0xff ? 0xff : new_min;
 
-	adm1031_write_value(client, ADM1031_REG_FAN_DIV(nr), 
+	adm1031_write_value(client, ADM1031_REG_FAN_DIV(nr),
 			    data->fan_div[nr]);
-	adm1031_write_value(client, ADM1031_REG_FAN_MIN(nr), 
+	adm1031_write_value(client, ADM1031_REG_FAN_MIN(nr),
 			    data->fan_min[nr]);
 
 	/* Invalidate the cache: fan speed is no longer valid */
@@ -796,7 +796,7 @@ static const struct attribute_group adm1
 /* This function is called by i2c_probe */
 static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct adm1031_data *data;
 	int err = 0;
 	const char *name = "";
@@ -809,17 +809,16 @@ static int adm1031_detect(struct i2c_ada
 		goto exit;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &adm1031_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &adm1031_driver;
 
 	if (kind < 0) {
 		int id, co;
-		id = i2c_smbus_read_byte_data(new_client, 0x3d);
-		co = i2c_smbus_read_byte_data(new_client, 0x3e);
+		id = i2c_smbus_read_byte_data(client, 0x3d);
+		co = i2c_smbus_read_byte_data(client, 0x3e);
 
 		if (!((id = 0x31 || id = 0x30) && co = 0x41))
 			goto exit_free;
@@ -840,28 +839,27 @@ static int adm1031_detect(struct i2c_ada
 	}
 	data->chip_type = kind;
 
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->valid = 0;
+	strlcpy(client->name, name, I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 
 	/* Initialize the ADM1031 chip */
-	adm1031_init_client(new_client);
+	adm1031_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm1031_group)))
+	if ((err = sysfs_create_group(&client->dev.kobj, &adm1031_group)))
 		goto exit_detach;
 
 	if (kind = adm1031) {
-		if ((err = sysfs_create_group(&new_client->dev.kobj,
+		if ((err = sysfs_create_group(&client->dev.kobj,
 						&adm1031_group_opt)))
 			goto exit_remove;
 	}
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
@@ -870,10 +868,10 @@ static int adm1031_detect(struct i2c_ada
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &adm1031_group);
-	sysfs_remove_group(&new_client->dev.kobj, &adm1031_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &adm1031_group);
+	sysfs_remove_group(&client->dev.kobj, &adm1031_group_opt);
 exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
@@ -905,7 +903,7 @@ static void adm1031_init_client(struct i
 	if (data->chip_type = adm1031) {
 		mask |= (ADM1031_CONF2_PWM2_ENABLE |
 			ADM1031_CONF2_TACH2_ENABLE);
-	} 
+	}
 	/* Initialize the ADM1031 chip (enables fan speed reading ) */
 	read_val = adm1031_read_value(client, ADM1031_REG_CONF2);
 	if ((read_val | mask) != read_val) {
@@ -984,7 +982,7 @@ static struct adm1031_data *adm1031_upda
 		if (data->chip_type = adm1030) {
 			data->alarm &= 0xc0ff;
 		}
-		
+
 		for (chan=0; chan<(data->chip_type = adm1030 ? 1 : 2); chan++) {
 			data->fan_div[chan]  			    adm1031_read_value(client, ADM1031_REG_FAN_DIV(chan));
@@ -993,7 +991,7 @@ static struct adm1031_data *adm1031_upda
 			data->fan[chan]  			    adm1031_read_value(client, ADM1031_REG_FAN_SPEED(chan));
 			data->pwm[chan] -			    0xf & (adm1031_read_value(client, ADM1031_REG_PWM) >> 
+			    0xf & (adm1031_read_value(client, ADM1031_REG_PWM) >>
 				   (4*chan));
 		}
 		data->last_updated = jiffies;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
