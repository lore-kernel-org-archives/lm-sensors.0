From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 Nov 2007 22:44:23 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (gl520sm) Various cleanups
Message-Id: <20071104234423.1e67928e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Drop trailing spaces
* Drop unused driver ID
* Drop stray backslashes in macros
* Rename new_client to client
* Drop redundant initializations to 0

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl520sm.c |   63 ++++++++++++++++++++++-------------------------
 include/linux/i2c-id.h  |    1 
 2 files changed, 30 insertions(+), 34 deletions(-)

--- linux-2.6.24-rc1.orig/drivers/hwmon/gl520sm.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc1/drivers/hwmon/gl520sm.c	2007-11-04 12:53:24.000000000 +0100
@@ -43,9 +43,9 @@ static unsigned short normal_i2c[] = { 0
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(gl520sm);
 
-/* Many GL520 constants specified below 
+/* Many GL520 constants specified below
 One of the inputs can be configured as either temp or voltage.
-That's why _TEMP2 and _IN4 access the same register 
+That's why _TEMP2 and _IN4 access the same register
 */
 
 /* The GL520 registers */
@@ -114,7 +114,6 @@ static struct i2c_driver gl520_driver = 
 	.driver = {
 		.name	= "gl520sm",
 	},
-	.id		= I2C_DRIVERID_GL520,
 	.attach_adapter	= gl520_attach_adapter,
 	.detach_client	= gl520_detach_client,
 };
@@ -194,7 +193,7 @@ sysfs_ro_n(cpu, n, _vid, GL520_REG_VID_I
 #define sysfs_in(n) \
 sysfs_ro_n(in, n, _input, GL520_REG_IN##n##INPUT) \
 sysfs_rw_n(in, n, _min, GL520_REG_IN##n##_MIN) \
-sysfs_rw_n(in, n, _max, GL520_REG_IN##n##_MAX) \
+sysfs_rw_n(in, n, _max, GL520_REG_IN##n##_MAX)
 
 #define sysfs_fan(n) \
 sysfs_ro_n(fan, n, _input, GL520_REG_FAN_INPUT) \
@@ -202,7 +201,7 @@ sysfs_rw_n(fan, n, _min, GL520_REG_FAN_M
 sysfs_rw_n(fan, n, _div, GL520_REG_FAN_DIV)
 
 #define sysfs_fan_off(n) \
-sysfs_rw_n(fan, n, _off, GL520_REG_FAN_OFF) \
+sysfs_rw_n(fan, n, _off, GL520_REG_FAN_OFF)
 
 #define sysfs_temp(n) \
 sysfs_ro_n(temp, n, _input, GL520_REG_TEMP##n##_INPUT) \
@@ -477,7 +476,7 @@ static ssize_t set_beep_enable(struct i2
 static ssize_t set_beep_mask(struct i2c_client *client, struct gl520_data *data, const char *buf, size_t count, int n, int reg)
 {
 	u8 r = simple_strtoul(buf, NULL, 10);
-	
+
 	mutex_lock(&data->update_lock);
 	r &= data->alarm_mask;
 	data->beep_mask = r;
@@ -553,7 +552,7 @@ static int gl520_attach_adapter(struct i
 
 static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct gl520_data *data;
 	int err = 0;
 
@@ -570,59 +569,57 @@ static int gl520_detect(struct i2c_adapt
 		goto exit;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &gl520_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &gl520_driver;
 
 	/* Determine the chip type. */
 	if (kind < 0) {
-		if ((gl520_read_value(new_client, GL520_REG_CHIP_ID) != 0x20) ||
-		    ((gl520_read_value(new_client, GL520_REG_REVISION) & 0x7f) != 0x00) ||
-		    ((gl520_read_value(new_client, GL520_REG_CONF) & 0x80) != 0x00)) {
-			dev_dbg(&new_client->dev, "Unknown chip type, skipping\n");
+		if ((gl520_read_value(client, GL520_REG_CHIP_ID) != 0x20) ||
+		    ((gl520_read_value(client, GL520_REG_REVISION) & 0x7f) != 0x00) ||
+		    ((gl520_read_value(client, GL520_REG_CONF) & 0x80) != 0x00)) {
+			dev_dbg(&client->dev, "Unknown chip type, skipping\n");
 			goto exit_free;
 		}
 	}
 
 	/* Fill in the remaining client fields */
-	strlcpy(new_client->name, "gl520sm", I2C_NAME_SIZE);
-	data->valid = 0;
+	strlcpy(client->name, "gl520sm", I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 
 	/* Initialize the GL520SM chip */
-	gl520_init_client(new_client);
+	gl520_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &gl520_group)))
+	if ((err = sysfs_create_group(&client->dev.kobj, &gl520_group)))
 		goto exit_detach;
 
 	if (data->two_temps) {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&client->dev,
 					      &dev_attr_temp2_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					      &dev_attr_temp2_max))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					      &dev_attr_temp2_max_hyst)))
 			goto exit_remove_files;
 	} else {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&client->dev,
 					      &dev_attr_in4_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					      &dev_attr_in4_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					      &dev_attr_in4_max)))
 			goto exit_remove_files;
 	}
 
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
@@ -631,10 +628,10 @@ static int gl520_detect(struct i2c_adapt
 	return 0;
 
 exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &gl520_group);
-	sysfs_remove_group(&new_client->dev.kobj, &gl520_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &gl520_group);
+	sysfs_remove_group(&client->dev.kobj, &gl520_group_opt);
 exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit:
@@ -697,7 +694,7 @@ static int gl520_detach_client(struct i2
 }
 
 
-/* Registers 0x07 to 0x0c are word-sized, others are byte-sized 
+/* Registers 0x07 to 0x0c are word-sized, others are byte-sized
    GL520 uses a high-byte first convention */
 static int gl520_read_value(struct i2c_client *client, u8 reg)
 {
--- linux-2.6.24-rc1.orig/include/linux/i2c-id.h	2007-11-03 17:30:05.000000000 +0100
+++ linux-2.6.24-rc1/include/linux/i2c-id.h	2007-11-04 11:19:08.000000000 +0100
@@ -139,7 +139,6 @@
 #define I2C_DRIVERID_BT869 1013
 #define I2C_DRIVERID_MAXILIFE 1014
 #define I2C_DRIVERID_MATORB 1015
-#define I2C_DRIVERID_GL520 1016
 #define I2C_DRIVERID_THMC50 1017
 #define I2C_DRIVERID_ADM1025 1020
 #define I2C_DRIVERID_LM87 1021


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
