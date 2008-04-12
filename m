From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 17:57:11 +0000
Subject: [lm-sensors] [PATCH 05/10] hwmon: (lm85) Misc cleanups
Message-Id: <20080412195711.6a73d07b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Misc cleanups to the lm85 hardware monitoring driver:
* Mark constant arrays as const.
* Remove useless masks.
* Have lm85_write_value return void - nobody is checking the returned
  value anyway and in some cases it was plain wrong.
* Remove useless initializations.
* Rename new_client to client in lm85_detect.
* Replace cascaded if/else with a switch/case in lm85_detect.
* Group similar loops in lm85_update_device.
* Remove legacy comments.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |  151 ++++++++++++++++++++++----------------------------
 1 file changed, 67 insertions(+), 84 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-03 14:18:50.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-03 15:27:45.000000000 +0200
@@ -110,7 +110,7 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
  */
 
 /* IN are scaled acording to built-in resistors */
-static int lm85_scaling[] = {  /* .001 Volts */
+static const int lm85_scaling[] = {  /* .001 Volts */
 	2500, 2250, 3300, 5000, 12000,
 	3300, 1500, 1800 /*EMC6D100*/
 };
@@ -164,7 +164,7 @@ static inline u16 FAN_TO_REG(unsigned lo
  */
 
 /* These are the zone temperature range encodings in .001 degree C */
-static int lm85_range_map[] = {
+static const int lm85_range_map[] = {
 	2000,  2500,  3300,  4000,  5000,  6600,
 	8000, 10000, 13300, 16000, 20000, 26600,
 	32000, 40000, 53300, 80000
@@ -191,13 +191,8 @@ static int RANGE_TO_REG(int range)
 }
 #define RANGE_FROM_REG(val)	lm85_range_map[(val) & 0x0f]
 
-/* These are the Acoustic Enhancement, or Temperature smoothing encodings
- * NOTE: The enable/disable bit is INCLUDED in these encodings as the
- *       MSB (bit 3, value 8).  If the enable bit is 0, the encoded value
- *       is ignored, or set to 0.
- */
 /* These are the PWM frequency encodings */
-static int lm85_freq_map[] = { /* .1 Hz */
+static const int lm85_freq_map[] = { /* .1 Hz */
 	100, 150, 230, 300, 380, 470, 620, 940
 };
 
@@ -210,7 +205,7 @@ static int FREQ_TO_REG(int freq)
 	for (i = 0; i < 7; ++i)
 		if (freq <= lm85_freq_map[i])
 			break;
-	return i & 0x07;
+	return i;
 }
 #define FREQ_FROM_REG(val)	lm85_freq_map[(val) & 0x07]
 
@@ -226,8 +221,8 @@ static int FREQ_TO_REG(int freq)
  *     -2 -- PWM responds to manual control
  */
 
-static int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };
-#define ZONE_FROM_REG(val)	lm85_zone_map[((val) >> 5) & 0x07]
+static const int lm85_zone_map[] = { 1, 2, 3, -1, 0, 23, 123, -2 };
+#define ZONE_FROM_REG(val)	lm85_zone_map[(val) >> 5]
 
 static int ZONE_TO_REG(int zone)
 {
@@ -238,7 +233,7 @@ static int ZONE_TO_REG(int zone)
 			break;
 	if (i > 7)   /* Not found. */
 		i = 3;  /* Always 100% */
-	return (i & 0x07) << 5;
+	return i << 5;
 }
 
 #define HYST_TO_REG(val)	SENSORS_LIMIT(((val) + 500) / 1000, 0, 15)
@@ -322,7 +317,7 @@ static int lm85_detect(struct i2c_adapte
 static int lm85_detach_client(struct i2c_client *client);
 
 static int lm85_read_value(struct i2c_client *client, u8 reg);
-static int lm85_write_value(struct i2c_client *client, u8 reg, int value);
+static void lm85_write_value(struct i2c_client *client, u8 reg, int value);
 static struct lm85_data *lm85_update_device(struct device *dev);
 static void lm85_init_client(struct i2c_client *client);
 
@@ -1096,13 +1091,12 @@ static int lm85_detect(struct i2c_adapte
 		int kind)
 {
 	int company, verstep;
-	struct i2c_client *new_client = NULL;
+	struct i2c_client *client;
 	struct lm85_data *data;
 	int err = 0;
-	const char *type_name = "";
+	const char *type_name;
 
-	if (!i2c_check_functionality(adapter,
-					I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		/* We need to be able to do byte I/O */
 		goto ERROR0;
 	}
@@ -1116,21 +1110,20 @@ static int lm85_detect(struct i2c_adapte
 		goto ERROR0;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm85_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &lm85_driver;
 
 	/* Now, we do the remaining detection. */
 
-	company = lm85_read_value(new_client, LM85_REG_COMPANY);
-	verstep = lm85_read_value(new_client, LM85_REG_VERSTEP);
+	company = lm85_read_value(client, LM85_REG_COMPANY);
+	verstep = lm85_read_value(client, LM85_REG_VERSTEP);
 
 	dev_dbg(&adapter->dev, "Detecting device at %d,0x%02x with"
 		" COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
-		i2c_adapter_id(new_client->adapter), new_client->addr,
+		i2c_adapter_id(client->adapter), client->addr,
 		company, verstep);
 
 	/* If auto-detecting, Determine the chip type. */
@@ -1197,56 +1190,65 @@ static int lm85_detect(struct i2c_adapte
 	}
 
 	/* Fill in the chip specific driver values */
-	if (kind = any_chip)
-		type_name = "lm85";
-	else if (kind = lm85b)
+	switch (kind) {
+	case lm85b:
 		type_name = "lm85b";
-	else if (kind = lm85c)
+		break;
+	case lm85c:
 		type_name = "lm85c";
-	else if (kind = adm1027)
+		break;
+	case adm1027:
 		type_name = "adm1027";
-	else if (kind = adt7463)
+		break;
+	case adt7463:
 		type_name = "adt7463";
-	else if (kind = emc6d100)
+		break;
+	case emc6d100:
 		type_name = "emc6d100";
-	else if (kind = emc6d102)
+		break;
+	case emc6d102:
 		type_name = "emc6d102";
-	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
+		break;
+	default:
+		type_name = "lm85";
+	}
+	strlcpy(client->name, type_name, I2C_NAME_SIZE);
 
 	/* Fill in the remaining client fields */
 	data->type = kind;
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	err = i2c_attach_client(client);
+	if (err)
 		goto ERROR1;
 
 	/* Set the VRM version */
 	data->vrm = vid_which_vrm();
 
 	/* Initialize the LM85 chip */
-	lm85_init_client(new_client);
+	lm85_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm85_group)))
+	err = sysfs_create_group(&client->dev.kobj, &lm85_group);
+	if (err)
 		goto ERROR2;
 
 	/* The ADT7463 has an optional VRM 10 mode where pin 21 is used
 	   as a sixth digital VID input rather than an analog input. */
-	data->vid = lm85_read_value(new_client, LM85_REG_VID);
+	data->vid = lm85_read_value(client, LM85_REG_VID);
 	if (!(kind = adt7463 && (data->vid & 0x80)))
-		if ((err = sysfs_create_group(&new_client->dev.kobj,
+		if ((err = sysfs_create_group(&client->dev.kobj,
 					&lm85_group_in4)))
 			goto ERROR3;
 
 	/* The EMC6D100 has 3 additional voltage inputs */
 	if (kind = emc6d100)
-		if ((err = sysfs_create_group(&new_client->dev.kobj,
+		if ((err = sysfs_create_group(&client->dev.kobj,
 					&lm85_group_in567)))
 			goto ERROR3;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR3;
@@ -1256,12 +1258,12 @@ static int lm85_detect(struct i2c_adapte
 
 	/* Error out and cleanup code */
  ERROR3:
-	sysfs_remove_group(&new_client->dev.kobj, &lm85_group);
-	sysfs_remove_group(&new_client->dev.kobj, &lm85_group_in4);
+	sysfs_remove_group(&client->dev.kobj, &lm85_group);
+	sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
 	if (kind = emc6d100)
-		sysfs_remove_group(&new_client->dev.kobj, &lm85_group_in567);
+		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
  ERROR2:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
  ERROR1:
 	kfree(data);
  ERROR0:
@@ -1308,10 +1310,8 @@ static int lm85_read_value(struct i2c_cl
 	return res;
 }
 
-static int lm85_write_value(struct i2c_client *client, u8 reg, int value)
+static void lm85_write_value(struct i2c_client *client, u8 reg, int value)
 {
-	int res;
-
 	switch (reg) {
 	case LM85_REG_FAN(0):  /* Write WORD data */
 	case LM85_REG_FAN(1):
@@ -1322,16 +1322,13 @@ static int lm85_write_value(struct i2c_c
 	case LM85_REG_FAN_MIN(2):
 	case LM85_REG_FAN_MIN(3):
 	/* NOTE: ALARM is read only, so not included here */
-		res = i2c_smbus_write_byte_data(client, reg, value & 0xff);
-		res |= i2c_smbus_write_byte_data(client, reg + 1,
-						 (value >> 8) & 0xff);
+		i2c_smbus_write_byte_data(client, reg, value & 0xff);
+		i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
 		break;
 	default:	/* Write BYTE data */
-		res = i2c_smbus_write_byte_data(client, reg, value);
+		i2c_smbus_write_byte_data(client, reg, value);
 		break;
 	}
-
-	return res;
 }
 
 static void lm85_init_client(struct i2c_client *client)
@@ -1413,6 +1410,8 @@ static struct lm85_data *lm85_update_dev
 		for (i = 0; i <= 3; ++i) {
 			data->in[i]  			    lm85_read_value(client, LM85_REG_IN(i));
+			data->fan[i] +			    lm85_read_value(client, LM85_REG_FAN(i));
 		}
 
 		if (!(data->type = adt7463 && (data->vid & 0x80))) {
@@ -1420,17 +1419,9 @@ static struct lm85_data *lm85_update_dev
 				      LM85_REG_IN(4));
 		}
 
-		for (i = 0; i <= 3; ++i) {
-			data->fan[i] -			    lm85_read_value(client, LM85_REG_FAN(i));
-		}
-
 		for (i = 0; i <= 2; ++i) {
 			data->temp[i]  			    lm85_read_value(client, LM85_REG_TEMP(i));
-		}
-
-		for (i = 0; i <= 2; ++i) {
 			data->pwm[i]  			    lm85_read_value(client, LM85_REG_PWM(i));
 		}
@@ -1461,13 +1452,13 @@ static struct lm85_data *lm85_update_dev
 						   EMC6D102_REG_EXTEND_ADC4);
 			data->in_ext[0] = ext3 & 0x0f;
 			data->in_ext[1] = ext4 & 0x0f;
-			data->in_ext[2] = (ext4 >> 4) & 0x0f;
-			data->in_ext[3] = (ext3 >> 4) & 0x0f;
-			data->in_ext[4] = (ext2 >> 4) & 0x0f;
+			data->in_ext[2] = ext4 >> 4;
+			data->in_ext[3] = ext3 >> 4;
+			data->in_ext[4] = ext2 >> 4;
 
 			data->temp_ext[0] = ext1 & 0x0f;
 			data->temp_ext[1] = ext2 & 0x0f;
-			data->temp_ext[2] = (ext1 >> 4) & 0x0f;
+			data->temp_ext[2] = ext1 >> 4;
 		}
 
 		data->last_reading = jiffies;
@@ -1483,6 +1474,8 @@ static struct lm85_data *lm85_update_dev
 			    lm85_read_value(client, LM85_REG_IN_MIN(i));
 			data->in_max[i]  			    lm85_read_value(client, LM85_REG_IN_MAX(i));
+			data->fan_min[i] +			    lm85_read_value(client, LM85_REG_FAN_MIN(i));
 		}
 
 		if (!(data->type = adt7463 && (data->vid & 0x80))) {
@@ -1501,25 +1494,19 @@ static struct lm85_data *lm85_update_dev
 			}
 		}
 
-		for (i = 0; i <= 3; ++i) {
-			data->fan_min[i] -			    lm85_read_value(client, LM85_REG_FAN_MIN(i));
-		}
-
 		for (i = 0; i <= 2; ++i) {
+			int val;
+
 			data->temp_min[i]  			    lm85_read_value(client, LM85_REG_TEMP_MIN(i));
 			data->temp_max[i]  			    lm85_read_value(client, LM85_REG_TEMP_MAX(i));
-		}
 
-		for (i = 0; i <= 2; ++i) {
-			int val;
 			data->autofan[i].config  			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
 			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
 			data->autofan[i].freq = val & 0x07;
-			data->zone[i].range = (val >> 4) & 0x0f;
+			data->zone[i].range = val >> 4;
 			data->autofan[i].min_pwm  			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
 			data->zone[i].limit @@ -1534,11 +1521,11 @@ static struct lm85_data *lm85_update_dev
 		data->autofan[2].min_off = (i & 0x80) != 0;
 
 		i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
-		data->zone[0].hyst = (i>>4) & 0x0f;
+		data->zone[0].hyst = i >> 4;
 		data->zone[1].hyst = i & 0x0f;
 
 		i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
-		data->zone[2].hyst = (i>>4) & 0x0f;
+		data->zone[2].hyst = i >> 4;
 
 		data->last_config = jiffies;
 	}  /* last_config */
@@ -1561,14 +1548,10 @@ static void  __exit sm_lm85_exit(void)
 	i2c_del_driver(&lm85_driver);
 }
 
-/* Thanks to Richard Barrington for adding the LM85 to sensors-detect.
- * Thanks to Margit Schubert-While <margitsw@t-online.de> for help with
- *     post 2.7.0 CVS changes.
- */
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, "
 	"Margit Schubert-While <margitsw@t-online.de>, "
-	"Justin Thiessen <jthiessen@penguincomputing.com");
+	"Justin Thiessen <jthiessen@penguincomputing.com>");
 MODULE_DESCRIPTION("LM85-B, LM85-C driver");
 
 module_init(sm_lm85_init);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
