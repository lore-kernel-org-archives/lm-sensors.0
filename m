From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sat, 14 Jun 2008 11:41:29 +0000
Subject: [lm-sensors] [PATCH] thmc50: extend numbers of handled temperatures
Message-Id: <20080614134129.ea9f896a.krzysztof.h1@poczta.fm>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch extends number of handled temperatures
from 1 to 3. It is needed for upcoming support of
the thmc51 sensor.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch requires the previous thmc50 patch (support for critical temperatures).

diff -urp linux-old/drivers/hwmon/thmc50.c linux-new/drivers/hwmon/thmc50.c
--- linux-old/drivers/hwmon/thmc50.c	2008-06-11 22:28:55.205753933 +0200
+++ linux-new/drivers/hwmon/thmc50.c	2008-06-11 22:29:44.973748412 +0200
@@ -69,7 +69,7 @@ struct thmc50_data {
 	struct mutex update_lock;
 	enum chips type;
 	unsigned long last_updated;	/* In jiffies */
-	char has_temp3;		/* !=0 if it is ADM1022 in temp3 mode */
+	char temp_num;		/* THMC51 = 1, ADM1022 = 2 or 3, otherwise 2 */
 	char valid;		/* !=0 if following fields are valid */
 
 	/* Register values */
@@ -328,18 +328,20 @@ static int thmc50_detect(struct i2c_adap
 		goto exit_free;
 	}
 	data->type = kind;
+	data->temp_num = 2;
 
 	if (kind = adm1022) {
 		int id = i2c_adapter_id(client->adapter);
 		int i;
 
 		type_name = "adm1022";
-		data->has_temp3 = (config >> 7) & 1;	/* config MSB */
+		if ((config >> 7) & 1) /* config MSB */
+			data->temp_num = 3;
 		for (i = 0; i + 1 < adm1022_temp3_num; i += 2)
 			if (adm1022_temp3[i] = id &&
 			    adm1022_temp3[i + 1] = address) {
 				/* enable 2nd remote temp */
-				data->has_temp3 = 1;
+				data->temp_num = 3;
 				break;
 			}
 	} else {
@@ -363,7 +365,7 @@ static int thmc50_detect(struct i2c_adap
 		goto exit_detach;
 
 	/* Register ADM1022 sysfs hooks */
-	if (data->has_temp3)
+	if (data->temp_num = 3)
 		if ((err = sysfs_create_group(&client->dev.kobj,
 					      &temp3_group)))
 			goto exit_remove_sysfs_thmc50;
@@ -378,7 +380,7 @@ static int thmc50_detect(struct i2c_adap
 	return 0;
 
 exit_remove_sysfs:
-	if (data->has_temp3)
+	if (data->temp_num = 3)
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 exit_remove_sysfs_thmc50:
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
@@ -404,7 +406,7 @@ static int thmc50_detach_client(struct i
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
-	if (data->has_temp3)
+	if (data->temp_num = 3)
 		sysfs_remove_group(&client->dev.kobj, &temp3_group);
 
 	if ((err = i2c_detach_client(client)))
@@ -430,7 +432,7 @@ static void thmc50_init_client(struct i2
 	}
 	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
 	config |= 0x1;	/* start the chip if it is in standby mode */
-	if (data->has_temp3)
+	if (data->temp_num = 3)
 		config |= 0x80;		/* enable 2nd remote temp */
 	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
 }
@@ -446,13 +448,12 @@ static struct thmc50_data *thmc50_update
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


----------------------------------------------------------------------
Tania telefonia internetowa!
Sprawdz >>>  http://link.interia.pl/f1e2e


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
