From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 May 2007 17:59:09 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon/ds1621: Minor cleanups
Message-Id: <20070516195909.5ea5cab1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Discard comments which do not apply or are redundant.
* Remove a few useless instructions.
* Rename new_client to just client.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/ds1621.c |   51 +++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

--- linux-2.6.22-rc1.orig/drivers/hwmon/ds1621.c	2007-05-16 17:39:56.000000000 +0200
+++ linux-2.6.22-rc1/drivers/hwmon/ds1621.c	2007-05-16 18:04:55.000000000 +0200
@@ -63,10 +63,7 @@ MODULE_PARM_DESC(polarity, "Output's pol
 #define DS1621_ALARM_TEMP_HIGH		0x40
 #define DS1621_ALARM_TEMP_LOW		0x20
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
+/* Conversions */
 #define ALARMS_FROM_REG(val) ((val) & \
                               (DS1621_ALARM_TEMP_HIGH | DS1621_ALARM_TEMP_LOW))
 
@@ -101,7 +98,7 @@ static struct i2c_driver ds1621_driver  
 /* All registers are word-sized, except for the configuration register.
    DS1621 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
+   the SMBus standard. */
 static int ds1621_read_value(struct i2c_client *client, u8 reg)
 {
 	if (reg = DS1621_REG_CONF)
@@ -110,9 +107,6 @@ static int ds1621_read_value(struct i2c_
 		return swab16(i2c_smbus_read_word_data(client, reg));
 }
 
-/* All registers are word-sized, except for the configuration register.
-   DS1621 uses a high-byte first convention, which is exactly opposite to
-   the usual practice. */
 static int ds1621_write_value(struct i2c_client *client, u8 reg, u16 value)
 {
 	if (reg = DS1621_REG_CONF)
@@ -204,7 +198,7 @@ static int ds1621_detect(struct i2c_adap
 			 int kind)
 {
 	int conf, temp;
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct ds1621_data *data;
 	int err = 0;
 
@@ -221,55 +215,48 @@ static int ds1621_detect(struct i2c_adap
 		goto exit;
 	}
 	
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &ds1621_driver;
-	new_client->flags = 0;
-
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &ds1621_driver;
 
 	/* Now, we do the remaining detection. It is lousy. */
 	if (kind < 0) {
 		/* The NVB bit should be low if no EEPROM write has been 
 		   requested during the latest 10ms, which is highly 
 		   improbable in our case. */
-		conf = ds1621_read_value(new_client, DS1621_REG_CONF);
+		conf = ds1621_read_value(client, DS1621_REG_CONF);
 		if (conf & DS1621_REG_CONFIG_NVB)
 			goto exit_free;
 		/* The 7 lowest bits of a temperature should always be 0. */
-		temp = ds1621_read_value(new_client, DS1621_REG_TEMP);
+		temp = ds1621_read_value(client, DS1621_REG_TEMP);
 		if (temp & 0x007f)
 			goto exit_free;
-		temp = ds1621_read_value(new_client, DS1621_REG_TEMP_MIN);
+		temp = ds1621_read_value(client, DS1621_REG_TEMP_MIN);
 		if (temp & 0x007f)
 			goto exit_free;
-		temp = ds1621_read_value(new_client, DS1621_REG_TEMP_MAX);
+		temp = ds1621_read_value(client, DS1621_REG_TEMP_MAX);
 		if (temp & 0x007f)
 			goto exit_free;
 	}
 
-	/* Determine the chip type - only one kind supported! */
-	if (kind <= 0)
-		kind = ds1621;
-
 	/* Fill in remaining client fields and put it into the global list */
-	strlcpy(new_client->name, "ds1621", I2C_NAME_SIZE);
-	data->valid = 0;
+	strlcpy(client->name, "ds1621", I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 
 	/* Initialize the DS1621 chip */
-	ds1621_init_client(new_client);
+	ds1621_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &ds1621_group)))
+	if ((err = sysfs_create_group(&client->dev.kobj, &ds1621_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
+	data->class_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto exit_remove_files;
@@ -278,9 +265,9 @@ static int ds1621_detect(struct i2c_adap
 	return 0;
 
       exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &ds1621_group);
+	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
       exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
       exit_free:
 	kfree(data);
       exit:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
