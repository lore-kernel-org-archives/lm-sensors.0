From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Nov 2007 22:47:16 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (adm1026) More cleanups
Message-Id: <20071129234716.3836cc60@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Various cleanups:
* Drop an unused define.
* Drop unused struct member "type".
* Drop one useless instruction.
* Drop redundant initializations to 0.
* Rename new_client to client.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1026.c |   47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/adm1026.c	2007-11-29 23:16:40.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/adm1026.c	2007-11-29 23:18:27.000000000 +0100
@@ -232,9 +232,6 @@ static int adm1026_scaling[] = { /* .001
 #define DAC_TO_REG(val) (SENSORS_LIMIT(((((val)*255)+500)/2500), 0, 255))
 #define DAC_FROM_REG(val) (((val)*2500)/255)
 
-/* Typically used with systems using a v9.1 VRM spec ? */
-#define ADM1026_INIT_VRM  91
-
 /* Chip sampling rates
  *
  * Some sensors are not updated more frequently than once per second
@@ -264,7 +261,6 @@ struct pwm_data {
 struct adm1026_data {
 	struct i2c_client client;
 	struct device *hwmon_dev;
-	enum chips type;
 
 	struct mutex update_lock;
 	int valid;		/* !=0 if following fields are valid */
@@ -387,7 +383,6 @@ static void adm1026_init_client(struct i
 			"and temp limits enabled.\n");
 	}
 
-	value = data->config3;
 	if (data->config3 & CFG3_GPIO16_ENABLE) {
 		dev_dbg(&client->dev, "GPIO16 enabled.  THERM "
 			"pin disabled.\n");
@@ -1641,7 +1636,7 @@ static int adm1026_detect(struct i2c_ada
 			  int kind)
 {
 	int company, verstep;
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct adm1026_data *data;
 	int err = 0;
 	const char *type_name = "";
@@ -1660,26 +1655,25 @@ static int adm1026_detect(struct i2c_ada
 		goto exit;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &adm1026_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &adm1026_driver;
 
 	/* Now, we do the remaining detection. */
 
-	company = adm1026_read_value(new_client, ADM1026_REG_COMPANY);
-	verstep = adm1026_read_value(new_client, ADM1026_REG_VERSTEP);
+	company = adm1026_read_value(client, ADM1026_REG_COMPANY);
+	verstep = adm1026_read_value(client, ADM1026_REG_VERSTEP);
 
-	dev_dbg(&new_client->dev, "Detecting device at %d,0x%02x with"
+	dev_dbg(&client->dev, "Detecting device at %d,0x%02x with"
 		" COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
-		i2c_adapter_id(new_client->adapter), new_client->addr,
+		i2c_adapter_id(client->adapter), client->addr,
 		company, verstep);
 
 	/* If auto-detecting, Determine the chip type. */
 	if (kind <= 0) {
-		dev_dbg(&new_client->dev, "Autodetecting device at %d,0x%02x "
+		dev_dbg(&client->dev, "Autodetecting device at %d,0x%02x "
 			"...\n", i2c_adapter_id(adapter), address);
 		if (company = ADM1026_COMPANY_ANALOG_DEV
 		    && verstep = ADM1026_VERSTEP_ADM1026) {
@@ -1695,7 +1689,7 @@ static int adm1026_detect(struct i2c_ada
 				verstep);
 			kind = any_chip;
 		} else {
-			dev_dbg(&new_client->dev, ": Autodetection "
+			dev_dbg(&client->dev, ": Autodetection "
 				"failed\n");
 			/* Not an ADM1026 ... */
 			if (kind = 0) { /* User used force=x,y */
@@ -1704,7 +1698,6 @@ static int adm1026_detect(struct i2c_ada
 					"force_adm1026.\n",
 					i2c_adapter_id(adapter), address);
 			}
-			err = 0;
 			goto exitfree;
 		}
 	}
@@ -1723,28 +1716,26 @@ static int adm1026_detect(struct i2c_ada
 		err = -EFAULT;
 		goto exitfree;
 	}
-	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
+	strlcpy(client->name, type_name, I2C_NAME_SIZE);
 
 	/* Fill in the remaining client fields */
-	data->type = kind;
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exitfree;
 
 	/* Set the VRM version */
 	data->vrm = vid_which_vrm();
 
 	/* Initialize the ADM1026 chip */
-	adm1026_init_client(new_client);
+	adm1026_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm1026_group)))
+	if ((err = sysfs_create_group(&client->dev.kobj, &adm1026_group)))
 		goto exitdetach;
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exitremove;
@@ -1754,9 +1745,9 @@ static int adm1026_detect(struct i2c_ada
 
 	/* Error out and cleanup code */
 exitremove:
-	sysfs_remove_group(&new_client->dev.kobj, &adm1026_group);
+	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
 exitdetach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 exitfree:
 	kfree(data);
 exit:

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
