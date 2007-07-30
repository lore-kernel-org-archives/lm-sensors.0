From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 30 Jul 2007 18:42:05 +0000
Subject: [lm-sensors] [PATCH 2/2] adt7470: Read limits less frequently
Message-Id: <20070730184204.GB2795@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Only read the sensor alarm limits from the chip every minute or so to make
the update_device function somewhat faster.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/adt7470.c |   85 ++++++++++++++++++++++++++++++-----------------
 1 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index dc0b35c..582fa7a 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -105,7 +105,11 @@ I2C_CLIENT_INSMOD_1(adt7470);
 /* "all temps" according to hwmon sysfs interface spec */
 #define ADT7470_PWM_ALL_TEMPS	0x3FF
 
-#define REFRESH_INTERVAL	(5 * HZ)
+/* How often do we reread sensors values? (In jiffies) */
+#define SENSOR_REFRESH_INTERVAL	(5 * HZ)
+
+/* How often do we reread sensor limit values? (In jiffies) */
+#define LIMIT_REFRESH_INTERVAL	(60 * HZ)
 
 /* sleep 1s while gathering temperature data */
 #define TEMP_COLLECTION_TIME	1000
@@ -122,8 +126,10 @@ struct adt7470_data {
 	struct i2c_client	client;
 	struct class_device	*class_dev;
 	struct mutex		lock;
-	char			valid;
-	unsigned long		last_updated;	/* In jiffies */
+	char			sensors_valid;
+	char			limits_valid;
+	unsigned long		sensors_last_updated;	/* In jiffies */
+	unsigned long		limits_last_updated;	/* In jiffies */
 
 	s8			temp[ADT7470_TEMP_COUNT];
 	s8			temp_min[ADT7470_TEMP_COUNT];
@@ -188,13 +194,15 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7470_data *data = i2c_get_clientdata(client);
+	unsigned long local_jiffies = jiffies;
 	u8 cfg;
 	int i;
 
 	mutex_lock(&data->lock);
-	if (time_before(jiffies, data->last_updated + REFRESH_INTERVAL)
-		&& data->valid)
-		goto out;
+	if (time_before(local_jiffies, data->sensors_last_updated +
+		SENSOR_REFRESH_INTERVAL)
+		&& data->sensors_valid)
+		goto no_sensor_update;
 
 	/* start reading temperature sensors */
 	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
@@ -213,42 +221,27 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
 	cfg &= ~0x80;
 	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
 
-	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
+	for (i = 0; i < ADT7470_TEMP_COUNT; i++)
 		data->temp[i] = i2c_smbus_read_byte_data(client,
 						ADT7470_TEMP_REG(i));
-		data->temp_min[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_MIN_REG(i));
-		data->temp_max[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_TEMP_MAX_REG(i));
-	}
 
-	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
+	for (i = 0; i < ADT7470_FAN_COUNT; i++)
 		data->fan[i] = adt7470_read_word_data(client,
 						ADT7470_REG_FAN(i));
-		data->fan_min[i] = adt7470_read_word_data(client,
-						ADT7470_REG_FAN_MIN(i));
-		data->fan_max[i] = adt7470_read_word_data(client,
-						ADT7470_REG_FAN_MAX(i));
-	}
 
 	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
-		int reg = ADT7470_REG_PWM_CFG(i);
+		int reg;
 		int reg_mask;
 
+		data->pwm[i] = i2c_smbus_read_byte_data(client,
+						ADT7470_REG_PWM(i));
+
 		if (i % 2)
 			reg_mask = ADT7470_PWM2_AUTO_MASK;
 		else
 			reg_mask = ADT7470_PWM1_AUTO_MASK;
 
-		data->pwm[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM(i));
-		data->pwm_max[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_MAX(i));
-		data->pwm_min[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_MIN(i));
-		data->pwm_tmin[i] = i2c_smbus_read_byte_data(client,
-						ADT7470_REG_PWM_TMIN(i));
-
+		reg = ADT7470_REG_PWM_CFG(i);
 		if (i2c_smbus_read_byte_data(client, reg) & reg_mask)
 			data->pwm_automatic[i] = 1;
 		else
@@ -272,8 +265,40 @@ static struct adt7470_data *adt7470_update_device(struct device *dev)
 	data->alarms_mask = adt7470_read_word_data(client,
 						   ADT7470_REG_ALARM1_MASK);
 
-	data->last_updated = jiffies;
-	data->valid = 1;
+	data->sensors_last_updated = local_jiffies;
+	data->sensors_valid = 1;
+
+no_sensor_update:
+	if (time_before(local_jiffies, data->limits_last_updated +
+		LIMIT_REFRESH_INTERVAL)
+		&& data->limits_valid)
+		goto out;
+
+	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
+		data->temp_min[i] = i2c_smbus_read_byte_data(client,
+						ADT7470_TEMP_MIN_REG(i));
+		data->temp_max[i] = i2c_smbus_read_byte_data(client,
+						ADT7470_TEMP_MAX_REG(i));
+	}
+
+	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
+		data->fan_min[i] = adt7470_read_word_data(client,
+						ADT7470_REG_FAN_MIN(i));
+		data->fan_max[i] = adt7470_read_word_data(client,
+						ADT7470_REG_FAN_MAX(i));
+	}
+
+	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
+		data->pwm_max[i] = i2c_smbus_read_byte_data(client,
+						ADT7470_REG_PWM_MAX(i));
+		data->pwm_min[i] = i2c_smbus_read_byte_data(client,
+						ADT7470_REG_PWM_MIN(i));
+		data->pwm_tmin[i] = i2c_smbus_read_byte_data(client,
+						ADT7470_REG_PWM_TMIN(i));
+	}
+
+	data->limits_last_updated = local_jiffies;
+	data->limits_valid = 1;
 
 out:
 	mutex_unlock(&data->lock);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
