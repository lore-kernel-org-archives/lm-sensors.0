From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:52 +0000
Subject: [lm-sensors] [PATCH 04/24] hwmon: (adm9240) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Replace new_client variable with client to make code easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm9240.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index c3c2865..28e966a 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -177,7 +177,6 @@ struct adm9240_data {
 	u16 alarms;		/* ro	alarms */
 	u8 aout;		/* rw	aout_output */
 	u8 vid;			/* ro	vid */
-	u8 vrm;			/* --	vrm set on startup, no accessor */
 };
 
 /*** sysfs accessors ***/
@@ -467,7 +466,7 @@ static ssize_t show_vid(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
@@ -588,7 +587,6 @@ static struct attribute *adm9240_attributes[] = {
 	&dev_attr_aout_output.attr,
 	&dev_attr_chassis_clear.attr,
 	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
-	&dev_attr_cpu0_vid.attr,
 	NULL
 };
 
@@ -600,19 +598,19 @@ static const struct attribute_group adm9240_group = {
 /*** sensor chip detect and driver install ***/
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adm9240_detect(struct i2c_client *new_client,
+static int adm9240_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
-	struct i2c_adapter *adapter = new_client->adapter;
+	struct i2c_adapter *adapter = client->adapter;
 	const char *name = "";
-	int address = new_client->addr;
+	int address = client->addr;
 	u8 man_id, die_rev;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
 	/* verify chip: reg address should match i2c address */
-	if (i2c_smbus_read_byte_data(new_client, ADM9240_REG_I2C_ADDR)
+	if (i2c_smbus_read_byte_data(client, ADM9240_REG_I2C_ADDR)
 			!= address) {
 		dev_err(&adapter->dev, "detect fail: address match, 0x%02x\n",
 			address);
@@ -620,7 +618,7 @@ static int adm9240_detect(struct i2c_client *new_client,
 	}
 
 	/* check known chip manufacturer */
-	man_id = i2c_smbus_read_byte_data(new_client, ADM9240_REG_MAN_ID);
+	man_id = i2c_smbus_read_byte_data(client, ADM9240_REG_MAN_ID);
 	if (man_id = 0x23) {
 		name = "adm9240";
 	} else if (man_id = 0xda) {
@@ -634,7 +632,7 @@ static int adm9240_detect(struct i2c_client *new_client,
 	}
 
 	/* successful detect, print chip info */
-	die_rev = i2c_smbus_read_byte_data(new_client, ADM9240_REG_DIE_REV);
+	die_rev = i2c_smbus_read_byte_data(client, ADM9240_REG_DIE_REV);
 	dev_info(&adapter->dev, "found %s revision %u\n",
 		 man_id = 0x23 ? "ADM9240" :
 		 man_id = 0xda ? "DS1780" : "LM81", die_rev);
@@ -644,7 +642,7 @@ static int adm9240_detect(struct i2c_client *new_client,
 	return 0;
 }
 
-static int adm9240_probe(struct i2c_client *new_client,
+static int adm9240_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct adm9240_data *data;
@@ -656,17 +654,23 @@ static int adm9240_probe(struct i2c_client *new_client,
 		goto exit;
 	}
 
-	i2c_set_clientdata(new_client, data);
+	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
-	adm9240_init_client(new_client);
+	adm9240_init_client(client);
 
 	/* populate sysfs filesystem */
-	err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group);
+	err = sysfs_create_group(&client->dev.kobj, &adm9240_group);
 	if (err)
 		goto exit_free;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (vid_which_vrm() > 0) {
+		err = device_create_file(&client->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exit_remove;
+	}
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
@@ -675,7 +679,8 @@ static int adm9240_probe(struct i2c_client *new_client,
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &adm9240_group);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
+	sysfs_remove_group(&client->dev.kobj, &adm9240_group);
 exit_free:
 	kfree(data);
 exit:
@@ -687,6 +692,7 @@ static int adm9240_remove(struct i2c_client *client)
 	struct adm9240_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	device_remove_file(&client->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&client->dev.kobj, &adm9240_group);
 
 	kfree(data);
@@ -695,15 +701,9 @@ static int adm9240_remove(struct i2c_client *client)
 
 static void adm9240_init_client(struct i2c_client *client)
 {
-	struct adm9240_data *data = i2c_get_clientdata(client);
 	u8 conf = i2c_smbus_read_byte_data(client, ADM9240_REG_CONFIG);
 	u8 mode = i2c_smbus_read_byte_data(client, ADM9240_REG_TEMP_CONF) & 3;
 
-	data->vrm = vid_which_vrm(); /* need this to report vid as mV */
-
-	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
-			data->vrm % 10);
-
 	if (conf & 1) { /* measurement cycle running: report state */
 
 		dev_info(&client->dev, "status: config 0x%02x mode %u\n",
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
