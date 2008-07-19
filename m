From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 19 Jul 2008 10:05:25 +0000
Subject: [lm-sensors] [PATCH 2/3] thmc50: add support for single temperature
Message-Id: <20080719120525.5d6b2b64.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds support for single temperature sensors.
It is needed for upcoming support of the thmc51 sensor.

The previous version supported sensors with 2 or 3 
temperatures.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Acked-by: Jean Delvare <khali@linux-fr.org>
---

diff -urp hwmon/drivers/hwmon/thmc50.c linux-2.6.26/drivers/hwmon/thmc50.c
--- hwmon/drivers/hwmon/thmc50.c	2008-07-19 11:28:15.465976575 +0200
+++ linux-2.6.26/drivers/hwmon/thmc50.c	2008-07-19 11:27:44.413973608 +0200
@@ -68,7 +68,7 @@ struct thmc50_data {
 	struct mutex update_lock;
 	enum chips type;
 	unsigned long last_updated;	/* In jiffies */
-	char has_temp3;		/* !=0 if it is ADM1022 in temp3 mode */
+	char temp_num;		/* THMC51 = 1, ADM1022 = 2 or 3, otherwise 2 */
 	char valid;		/* !=0 if following fields are valid */
 
 	/* Register values */
@@ -375,7 +375,7 @@ static int thmc50_probe(struct i2c_clien
 		goto exit_free;
 
 	/* Register ADM1022 sysfs hooks */
-	if (data->has_temp3)
+	if (data->temp_num = 3)
 		if ((err = sysfs_create_group(&client->dev.kobj,
 					      &temp3_group)))
 			goto exit_remove_sysfs_thmc50;
@@ -390,7 +390,7 @@ static int thmc50_probe(struct i2c_clien
 	return 0;
 
 exit_remove_sysfs:
-	if (data->has_temp3)
+	if (data->temp_num = 3)
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 exit_remove_sysfs_thmc50:
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
@@ -406,7 +406,7 @@ static int thmc50_remove(struct i2c_clie
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
-	if (data->has_temp3)
+	if (data->temp_num = 3)
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 
 	kfree(data);
@@ -427,10 +427,11 @@ static void thmc50_init_client(struct i2
 		i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
 					  data->analog_out);
 	}
+	data->temp_num = 2;
 	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
 	config |= 0x1;	/* start the chip if it is in standby mode */
-	if (data->type = adm1022 && (config & (1 << 7)))
-		data->has_temp3 = 1;
+	if (config & (1 << 7)) /* config MSB */
+		data->temp_num = 3;
 	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
 }
 
@@ -445,13 +446,12 @@ static struct thmc50_data *thmc50_update
 	if (time_after(jiffies, data->last_updated + timeout)
 	    || !data->valid) {
 
-		int temps = data->has_temp3 ? 3 : 2;
 		int i;
 		int prog = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
 
 		prog &= THMC50_REG_CONF_PROGRAMMED;
 
-		for (i = 0; i < temps; i++) {
+		for (i = 0; i < data->temp_num; i++) {
 			data->temp_input[i] = i2c_smbus_read_byte_data(client,
 						THMC50_REG_TEMP[i]);
 			data->temp_max[i] = i2c_smbus_read_byte_data(client,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
