From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Apr 2013 01:02:57 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (tmp401) Add support for TMP432
Message-Id: <1365210177-24656-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

TMP432 is sililar to TMP431 with a second external temperature sensor.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/tmp401 |    7 ++
 drivers/hwmon/tmp401.c     |  180 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 152 insertions(+), 35 deletions(-)

diff --git a/Documentation/hwmon/tmp401 b/Documentation/hwmon/tmp401
index 12e4781..d43ef8e 100644
--- a/Documentation/hwmon/tmp401
+++ b/Documentation/hwmon/tmp401
@@ -14,6 +14,10 @@ Supported chips:
     Prefix: 'tmp431'
     Addresses scanned: I2C 0x4c, 0x4d
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp431.html
+  * Texas Instruments TMP432
+    Prefix: 'tmp432'
+    Addresses scanned: I2C 0x4c, 0x4d
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp432.html
 
 Authors:
          Hans de Goede <hdegoede@redhat.com>
@@ -44,3 +48,6 @@ some additional features.
 
   Exported via sysfs attribute temp_reset_history. Writing 1 to this
   file triggers a reset.
+
+TMP432 is compatible with TMP401 and TMP431. It supports two external
+temperature sensors.
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index e16544a..e018c27 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -42,7 +42,7 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
-enum chips { tmp401, tmp411, tmp431 };
+enum chips { tmp401, tmp411, tmp431, tmp432 };
 
 /*
  * The TMP401 registers, note some registers have different addresses for
@@ -84,6 +84,28 @@ static const u8 TMP401_TEMP_LSB[6][2] = {
 	{ 0x33, 0x37 },	/* highest */
 };
 
+static const u8 TMP432_TEMP_MSB_READ[4][3] = {
+	{ 0x00, 0x01, 0x23 },	/* temp */
+	{ 0x06, 0x08, 0x16 },	/* low limit */
+	{ 0x05, 0x07, 0x15 },	/* high limit */
+	{ 0x20, 0x19, 0x1A },	/* therm (crit) limit */
+};
+
+static const u8 TMP432_TEMP_MSB_WRITE[3][3] = {
+	{ 0x00, 0x00, 0x00 },	/* temp  - unused */
+	{ 0x0C, 0x0E, 0x16 },	/* low limit */
+	{ 0x0B, 0x0D, 0x15 },	/* high limit */
+};
+
+static const u8 TMP432_TEMP_LSB[3][3] = {
+	{ 0x29, 0x10, 0x24 },	/* temp */
+	{ 0x3E, 0x14, 0x18 },	/* low limit */
+	{ 0x3D, 0x13, 0x17 },	/* high limit */
+};
+
+/* [0] = fault, [1] = low, [2] = high, [3] = therm/crit */
+const u8 TMP432_STATUS_REG[] = { 0x1b, 0x36, 0x35, 0x37 };
+
 /* Flags */
 #define TMP401_CONFIG_RANGE			BIT(2)
 #define TMP401_CONFIG_SHUTDOWN			BIT(6)
@@ -95,6 +117,11 @@ static const u8 TMP401_TEMP_LSB[6][2] = {
 #define TMP401_STATUS_LOCAL_LOW			BIT(5)
 #define TMP401_STATUS_LOCAL_HIGH		BIT(6)
 
+/* On TMP432, each status has its own register */
+#define TMP432_STATUS_LOCAL			BIT(0)
+#define TMP432_STATUS_REMOTE1			BIT(1)
+#define TMP432_STATUS_REMOTE2			BIT(2)
+
 /* Manufacturer / Device ID's */
 #define TMP401_MANUFACTURER_ID			0x55
 #define TMP401_DEVICE_ID			0x11
@@ -102,6 +129,7 @@ static const u8 TMP401_TEMP_LSB[6][2] = {
 #define TMP411B_DEVICE_ID			0x13
 #define TMP411C_DEVICE_ID			0x10
 #define TMP431_DEVICE_ID			0x31
+#define TMP432_DEVICE_ID			0x32
 
 /*
  * Driver data (common to all clients)
@@ -111,6 +139,7 @@ static const struct i2c_device_id tmp401_id[] = {
 	{ "tmp401", tmp401 },
 	{ "tmp411", tmp411 },
 	{ "tmp431", tmp431 },
+	{ "tmp432", tmp432 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp401_id);
@@ -129,9 +158,9 @@ struct tmp401_data {
 	int update_interval;	/* in milliseconds */
 
 	/* register values */
-	u8 status;
+	u8 status[4];
 	u8 config;
-	u16 temp[6][2];
+	u16 temp[6][3];
 	u8 temp_crit_hyst;
 };
 
@@ -165,22 +194,26 @@ static int tmp401_update_device_reg16(struct i2c_client *client,
 {
 	int i, j, val;
 	int num_regs = data->kind = tmp411 ? 6 : 4;
+	int num_sensors = data->kind = tmp432 ? 3 : 2;
 
-	for (i = 0; i < 2; i++) {			/* local / rem1 */
+	for (i = 0; i < num_sensors; i++) {		/* local / rem1 */
 		for (j = 0; j < num_regs; j++) {	/* temp / low / ... */
+			u8 reg;
 			/*
 			 * High byte must be read first immediately followed
 			 * by the low byte
 			 */
-			val = i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_MSB_READ[j][i]);
+			reg = data->kind = tmp432 ? TMP432_TEMP_MSB_READ[j][i]
+						   : TMP401_TEMP_MSB_READ[j][i];
+			val = i2c_smbus_read_byte_data(client, reg);
 			if (val < 0)
 				return val;
 			data->temp[j][i] = val << 8;
 			if (j = 3)		/* crit is msb only */
 				continue;
-			val = i2c_smbus_read_byte_data(client,
-						TMP401_TEMP_LSB[j][i]);
+			reg = data->kind = tmp432 ? TMP432_TEMP_LSB[j][i]
+						   : TMP401_TEMP_LSB[j][i];
+			val = i2c_smbus_read_byte_data(client, reg);
 			if (val < 0)
 				return val;
 			data->temp[j][i] |= val;
@@ -194,7 +227,7 @@ static struct tmp401_data *tmp401_update_device(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tmp401_data *data = i2c_get_clientdata(client);
 	struct tmp401_data *ret = data;
-	int val;
+	int i, val;
 	unsigned long next_update;
 
 	mutex_lock(&data->update_lock);
@@ -202,12 +235,34 @@ static struct tmp401_data *tmp401_update_device(struct device *dev)
 	next_update = data->last_updated +
 	  msecs_to_jiffies(data->update_interval) + 1;
 	if (time_after(jiffies, next_update) || !data->valid) {
-		val = i2c_smbus_read_byte_data(client, TMP401_STATUS);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
+		if (data->kind != tmp432) {
+			val = i2c_smbus_read_byte_data(client, TMP401_STATUS);
+			if (val < 0) {
+				ret = ERR_PTR(val);
+				goto abort;
+			}
+			data->status[0] +			  (val & TMP401_STATUS_REMOTE_OPEN) >> 1;
+			data->status[1] +			  ((val & TMP401_STATUS_REMOTE_LOW) >> 2) |
+			  ((val & TMP401_STATUS_LOCAL_LOW) >> 5);
+			data->status[2] +			  ((val & TMP401_STATUS_REMOTE_HIGH) >> 3) |
+			  ((val & TMP401_STATUS_LOCAL_HIGH) >> 6);
+			data->status[3] = val & (TMP401_STATUS_LOCAL_CRIT
+						| TMP401_STATUS_REMOTE_CRIT);
+		} else {
+			for (i = 0; i < ARRAY_SIZE(data->status); i++) {
+				val = i2c_smbus_read_byte_data(client,
+							TMP432_STATUS_REG[i]);
+				if (val < 0) {
+					ret = ERR_PTR(val);
+					goto abort;
+				}
+				data->status[i] = val;
+			}
 		}
-		data->status = val;
+
 		val = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
 		if (val < 0) {
 			ret = ERR_PTR(val);
@@ -269,13 +324,14 @@ static ssize_t show_temp_crit_hyst(struct device *dev,
 static ssize_t show_status(struct device *dev,
 	struct device_attribute *devattr, char *buf)
 {
-	int mask = to_sensor_dev_attr(devattr)->index;
+	int nr = to_sensor_dev_attr_2(devattr)->nr;
+	int mask = to_sensor_dev_attr_2(devattr)->index;
 	struct tmp401_data *data = tmp401_update_device(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return sprintf(buf, "%d\n", !!(data->status & mask));
+	return sprintf(buf, "%d\n", !!(data->status[nr] & mask));
 }
 
 static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
@@ -286,6 +342,7 @@ static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
 	struct tmp401_data *data = tmp401_update_device(dev);
 	long val;
 	u16 regval;
+	u8 reg;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -297,14 +354,16 @@ static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
 
 	mutex_lock(&data->update_lock);
 
-	i2c_smbus_write_byte_data(to_i2c_client(dev),
-		TMP401_TEMP_MSB_WRITE[nr][index], regval >> 8);
+	reg = data->kind = tmp432 ? TMP432_TEMP_MSB_WRITE[nr][index]
+				   : TMP401_TEMP_MSB_WRITE[nr][index];
+	i2c_smbus_write_byte_data(to_i2c_client(dev), reg, regval >> 8);
 	if (nr = 3) {
 		/* drop LSB for critical limit */
 		regval &= 0xff00;
 	} else {
-		i2c_smbus_write_byte_data(to_i2c_client(dev),
-					  TMP401_TEMP_LSB[nr][index],
+		reg = data->kind = tmp432 ? TMP432_TEMP_LSB[nr][index]
+					   : TMP401_TEMP_LSB[nr][index];
+		i2c_smbus_write_byte_data(to_i2c_client(dev), reg,
 					  regval & 0xFF);
 	}
 
@@ -423,12 +482,12 @@ static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IWUSR | S_IRUGO, show_temp,
 			    store_temp, 3, 0);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO,
 			  show_temp_crit_hyst, store_temp_crit_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_status, NULL,
-			  TMP401_STATUS_LOCAL_LOW);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_status, NULL,
-			  TMP401_STATUS_LOCAL_HIGH);
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_status, NULL,
-			  TMP401_STATUS_LOCAL_CRIT);
+static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO, show_status, NULL,
+			    1, TMP432_STATUS_LOCAL);
+static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO, show_status, NULL,
+			    2, TMP432_STATUS_LOCAL);
+static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO, show_status, NULL,
+			    3, TMP432_STATUS_LOCAL);
 static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
 static SENSOR_DEVICE_ATTR_2(temp2_min, S_IWUSR | S_IRUGO, show_temp,
 			    store_temp, 1, 1);
@@ -438,14 +497,14 @@ static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IWUSR | S_IRUGO, show_temp,
 			    store_temp, 3, 1);
 static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst,
 			  NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_status, NULL,
-			  TMP401_STATUS_REMOTE_OPEN);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_status, NULL,
-			  TMP401_STATUS_REMOTE_LOW);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_status, NULL,
-			  TMP401_STATUS_REMOTE_HIGH);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_status, NULL,
-			  TMP401_STATUS_REMOTE_CRIT);
+static SENSOR_DEVICE_ATTR_2(temp2_fault, S_IRUGO, show_status, NULL,
+			    0, TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO, show_status, NULL,
+			    1, TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO, show_status, NULL,
+			    2, TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO, show_status, NULL,
+			    3, TMP432_STATUS_REMOTE1);
 
 static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
 		   set_update_interval);
@@ -506,6 +565,42 @@ static const struct attribute_group tmp411_group = {
 	.attrs = tmp411_attributes,
 };
 
+static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_min, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 1, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_max, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IWUSR | S_IRUGO, show_temp,
+			    store_temp, 3, 2);
+static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst,
+			  NULL, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_status, NULL,
+			    0, TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO, show_status, NULL,
+			    1, TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO, show_status, NULL,
+			    2, TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO, show_status, NULL,
+			    3, TMP432_STATUS_REMOTE2);
+
+static struct attribute *tmp432_attributes[] = {
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
+
+	NULL
+};
+
+static const struct attribute_group tmp432_group = {
+	.attrs = tmp432_attributes,
+};
+
 /*
  * Begin non sysfs callback code (aka Real code)
  */
@@ -576,6 +671,11 @@ static int tmp401_detect(struct i2c_client *client,
 			return -ENODEV;
 		kind = tmp431;
 		break;
+	case TMP432_DEVICE_ID:
+		if (client->addr = 0x4e)
+			return -ENODEV;
+		kind = tmp432;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -607,6 +707,9 @@ static int tmp401_remove(struct i2c_client *client)
 	if (data->kind = tmp411)
 		sysfs_remove_group(&dev->kobj, &tmp411_group);
 
+	if (data->kind = tmp432)
+		sysfs_remove_group(&dev->kobj, &tmp432_group);
+
 	return 0;
 }
 
@@ -616,7 +719,7 @@ static int tmp401_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int err;
 	struct tmp401_data *data;
-	const char *names[] = { "TMP401", "TMP411", "TMP431" };
+	const char *names[] = { "TMP401", "TMP411", "TMP431", "TMP432" };
 
 	data = devm_kzalloc(&client->dev, sizeof(struct tmp401_data),
 			    GFP_KERNEL);
@@ -642,6 +745,13 @@ static int tmp401_probe(struct i2c_client *client,
 			goto exit_remove;
 	}
 
+	/* Register additional tmp432 sysfs hooks */
+	if (data->kind = tmp432) {
+		err = sysfs_create_group(&dev->kobj, &tmp432_group);
+		if (err)
+			goto exit_remove;
+	}
+
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
