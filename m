From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Mar 2010 13:24:45 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (tmp421) Restore missing inputs
Message-Id: <20100304142445.3e2762b6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

An off-by-one error caused some inputs to not be created by the driver
when they should. TMP421 gets only one input instead of two, TMP422
gets two instead of three, etc. Fix the bug by listing explicitly the
number of inputs each device has.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Andre Prendel <andre.prendel@gmx.de>
Cc: stable@kernel.org
---
 drivers/hwmon/tmp421.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.34-rc0.orig/drivers/hwmon/tmp421.c	2010-03-04 13:37:01.000000000 +0100
+++ linux-2.6.34-rc0/drivers/hwmon/tmp421.c	2010-03-04 13:38:51.000000000 +0100
@@ -61,9 +61,9 @@ static const u8 TMP421_TEMP_LSB[4]		= {
 #define TMP423_DEVICE_ID			0x23
 
 static const struct i2c_device_id tmp421_id[] = {
-	{ "tmp421", tmp421 },
-	{ "tmp422", tmp422 },
-	{ "tmp423", tmp423 },
+	{ "tmp421", 2 },
+	{ "tmp422", 3 },
+	{ "tmp423", 4 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp421_id);
@@ -73,7 +73,7 @@ struct tmp421_data {
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated;
-	int kind;
+	int channels;
 	u8 config;
 	s16 temp[4];
 };
@@ -107,7 +107,7 @@ static struct tmp421_data *tmp421_update
 		data->config = i2c_smbus_read_byte_data(client,
 			TMP421_CONFIG_REG_1);
 
-		for (i = 0; i <= data->kind; i++) {
+		for (i = 0; i < data->channels; i++) {
 			data->temp[i] = i2c_smbus_read_byte_data(client,
 				TMP421_TEMP_MSB[i]) << 8;
 			data->temp[i] |= i2c_smbus_read_byte_data(client,
@@ -166,7 +166,7 @@ static mode_t tmp421_is_visible(struct k
 	devattr = container_of(a, struct device_attribute, attr);
 	index = to_sensor_dev_attr(devattr)->index;
 
-	if (data->kind > index)
+	if (index < data->channels)
 		return a->mode;
 
 	return 0;
@@ -271,7 +271,7 @@ static int tmp421_probe(struct i2c_clien
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
-	data->kind = id->driver_data;
+	data->channels = id->driver_data;
 
 	err = tmp421_init_client(client);
 	if (err)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
