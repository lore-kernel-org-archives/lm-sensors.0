From: Ben Hutchings <bhutchings@solarflare.com>
Date: Wed, 04 Jun 2008 18:44:03 +0000
Subject: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080604184401.GG11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new-style lm87 driver is configurable through platform_data and does not
require initialisation by firmware.  It also provides a function to poll and
return the sensor values.

The legacy lm87 driver is renamed lm87_legacy and implemented using the new-
style driver's functions.  This modified legacy driver is untested as I do
not have access to a motherboard with an LM87.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm87.c |  460 +++++++++++++++++++++++++++++---------------------
 include/linux/lm87.h |  132 ++++++++++++++
 2 files changed, 400 insertions(+), 192 deletions(-)
 create mode 100644 include/linux/lm87.h

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index e1c183f..b808fde 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -65,6 +65,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
+#include <linux/lm87.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 
@@ -147,19 +148,14 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A, 0x38, 0x2C };
 				 (val) >= 2500 ? 255 : \
 				 ((val) * 10 + 49) / 98)
 
-/* nr in 0..1 */
-#define CHAN_NO_FAN(nr)		(1 << (nr))
-#define CHAN_TEMP3		(1 << 2)
-#define CHAN_VCC_5V		(1 << 3)
-#define CHAN_NO_VID		(1 << 7)
-
 /*
  * Functions declaration
  */
 
+static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *);
+static int lm87_remove(struct i2c_client *client);
 static int lm87_attach_adapter(struct i2c_adapter *adapter);
 static int lm87_detect(struct i2c_adapter *adapter, int address, int kind);
-static void lm87_init_client(struct i2c_client *client);
 static int lm87_detach_client(struct i2c_client *client);
 static struct lm87_data *lm87_update_device(struct device *dev);
 
@@ -167,10 +163,26 @@ static struct lm87_data *lm87_update_device(struct device *dev);
  * Driver data (common to all clients)
  */
 
+static const struct i2c_device_id lm87_id[] = {
+	{ "lm87", lm87 },
+	{ "adm1024", adm1024 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm87_id);
+
 static struct i2c_driver lm87_driver = {
 	.driver = {
 		.name	= "lm87",
 	},
+	.probe		= lm87_probe,
+	.remove		= lm87_remove,
+	.id_table	= lm87_id,
+};
+
+static struct i2c_driver lm87_legacy_driver = {
+	.driver = {
+		.name	= "lm87_legacy",
+	},
 	.attach_adapter	= lm87_attach_adapter,
 	.detach_client	= lm87_detach_client,
 };
@@ -180,32 +192,19 @@ static struct i2c_driver lm87_driver = {
  */
 
 struct lm87_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* In jiffies */
 
-	u8 channel;		/* register value */
+	struct lm87_settings set;
+	struct lm87_values val;
 
-	u8 in[8];		/* register value */
-	u8 in_max[8];		/* register value */
-	u8 in_min[8];		/* register value */
 	u16 in_scale[8];
 
-	s8 temp[3];		/* register value */
-	s8 temp_high[3];	/* register value */
-	s8 temp_low[3];		/* register value */
 	s8 temp_crit_int;	/* min of two register values */
 	s8 temp_crit_ext;	/* min of two register values */
 
-	u8 fan[2];		/* register value */
-	u8 fan_min[2];		/* register value */
-	u8 fan_div[2];		/* register value, shifted right */
-	u8 aout;		/* register value */
-
-	u16 alarms;		/* register values, combined */
-	u8 vid;			/* register values, combined */
 	u8 vrm;
 };
 
@@ -227,19 +226,19 @@ static inline int lm87_write_value(struct i2c_client *client, u8 reg, u8 value)
 static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->val.in[offset], \
 		       data->in_scale[offset])); \
 } \
 static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->set.in_min[offset], \
 		       data->in_scale[offset])); \
 } \
 static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->set.in_max[offset], \
 		       data->in_scale[offset])); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
@@ -260,9 +259,9 @@ static void set_in_min(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->in_min[nr] = IN_TO_REG(val, data->in_scale[nr]);
+	data->set.in_min[nr] = IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MIN(nr) :
-			 LM87_REG_AIN_MIN(nr-6), data->in_min[nr]);
+			 LM87_REG_AIN_MIN(nr-6), data->set.in_min[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -273,9 +272,9 @@ static void set_in_max(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->in_max[nr] = IN_TO_REG(val, data->in_scale[nr]);
+	data->set.in_max[nr] = IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MAX(nr) :
-			 LM87_REG_AIN_MAX(nr-6), data->in_max[nr]);
+			 LM87_REG_AIN_MAX(nr-6), data->set.in_max[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -309,17 +308,17 @@ set_in(7);
 static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->val.temp[offset-1])); \
 } \
 static ssize_t show_temp##offset##_low(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->set.temp_low[offset-1])); \
 } \
 static ssize_t show_temp##offset##_high(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->set.temp_high[offset-1])); \
 }\
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
 		show_temp##offset##_input, NULL);
@@ -334,8 +333,8 @@ static void set_temp_low(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_low[nr] = TEMP_TO_REG(val);
-	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->temp_low[nr]);
+	data->set.temp_low[nr] = TEMP_TO_REG(val);
+	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->set.temp_low[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -346,8 +345,8 @@ static void set_temp_high(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_high[nr] = TEMP_TO_REG(val);
-	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->temp_high[nr]);
+	data->set.temp_high[nr] = TEMP_TO_REG(val);
+	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->set.temp_high[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -392,19 +391,19 @@ static DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit_ext, NULL);
 static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_div[offset-1]))); \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->val.fan[offset-1], \
+		       FAN_DIV_FROM_REG(data->set.fan_div[offset-1]))); \
 } \
 static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_div[offset-1]))); \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->set.fan_min[offset-1], \
+		       FAN_DIV_FROM_REG(data->set.fan_div[offset-1]))); \
 } \
 static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_DIV_FROM_REG(data->fan_div[offset-1])); \
+	return sprintf(buf, "%d\n", FAN_DIV_FROM_REG(data->set.fan_div[offset-1])); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
 		show_fan##offset##_input, NULL);
@@ -418,9 +417,9 @@ static void set_fan_min(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->fan_min[nr] = FAN_TO_REG(val,
-			    FAN_DIV_FROM_REG(data->fan_div[nr]));
-	lm87_write_value(client, LM87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	data->set.fan_min[nr] = FAN_TO_REG(val,
+			    FAN_DIV_FROM_REG(data->set.fan_div[nr]));
+	lm87_write_value(client, LM87_REG_FAN_MIN(nr), data->set.fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -438,14 +437,14 @@ static ssize_t set_fan_div(struct device *dev, const char *buf,
 	u8 reg;
 
 	mutex_lock(&data->update_lock);
-	min = FAN_FROM_REG(data->fan_min[nr],
-			   FAN_DIV_FROM_REG(data->fan_div[nr]));
+	min = FAN_FROM_REG(data->set.fan_min[nr],
+			   FAN_DIV_FROM_REG(data->set.fan_div[nr]));
 
 	switch (val) {
-	case 1: data->fan_div[nr] = 0; break;
-	case 2: data->fan_div[nr] = 1; break;
-	case 4: data->fan_div[nr] = 2; break;
-	case 8: data->fan_div[nr] = 3; break;
+	case 1: data->set.fan_div[nr] = 0; break;
+	case 2: data->set.fan_div[nr] = 1; break;
+	case 4: data->set.fan_div[nr] = 2; break;
+	case 8: data->set.fan_div[nr] = 3; break;
 	default:
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -454,17 +453,17 @@ static ssize_t set_fan_div(struct device *dev, const char *buf,
 	reg = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
 	switch (nr) {
 	case 0:
-	    reg = (reg & 0xCF) | (data->fan_div[0] << 4);
+	    reg = (reg & 0xCF) | (data->set.fan_div[0] << 4);
 	    break;
 	case 1:
-	    reg = (reg & 0x3F) | (data->fan_div[1] << 6);
+	    reg = (reg & 0x3F) | (data->set.fan_div[1] << 6);
 	    break;
 	}
 	lm87_write_value(client, LM87_REG_VID_FAN_DIV, reg);
 
-	data->fan_min[nr] = FAN_TO_REG(min, val);
+	data->set.fan_min[nr] = FAN_TO_REG(min, val);
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr),
-			 data->fan_min[nr]);
+			 data->set.fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -492,14 +491,14 @@ set_fan(2);
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
-	return sprintf(buf, "%d\n", data->alarms);
+	return sprintf(buf, "%d\n", data->val.alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->val.vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
@@ -519,7 +518,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
-	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
+	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->set.aout));
 }
 static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -528,8 +527,8 @@ static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->aout = AOUT_TO_REG(val);
-	lm87_write_value(client, LM87_REG_AOUT, data->aout);
+	data->set.aout = AOUT_TO_REG(val);
+	lm87_write_value(client, LM87_REG_AOUT, data->set.aout);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -540,7 +539,7 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	int bitnr = to_sensor_dev_attr(attr)->index;
-	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+	return sprintf(buf, "%u\n", (data->val.alarms >> bitnr) & 1);
 }
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
@@ -663,25 +662,17 @@ static const struct attribute_group lm87_group_opt = {
 static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
-	struct lm87_data *data;
-	int err = 0;
-	static const char *names[] = { "lm87", "adm1024" };
+	int err;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	if (!(data = kzalloc(sizeof(struct lm87_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
+		return 0;
 
-	/* The common I2C client data is placed right before the
-	   LM87-specific data. */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
+	new_client = kzalloc(sizeof(*new_client), GFP_KERNEL);
+	if (!new_client)
+		return -ENOMEM;
 	new_client->addr = address;
 	new_client->adapter = adapter;
-	new_client->driver = &lm87_driver;
+	new_client->driver = &lm87_legacy_driver;
 	new_client->flags = 0;
 
 	/* Default to an LM87 if forced */
@@ -705,25 +696,121 @@ static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 			dev_dbg(&adapter->dev,
 				"LM87 detection failed at 0x%02x.\n",
 				address);
+			err = 0;
 			goto exit_free;
 		}
 	}
 
-	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, names[kind - 1], I2C_NAME_SIZE);
+	strlcpy(new_client->name, lm87_id[kind - 1].name, I2C_NAME_SIZE);
+
+	err = lm87_probe(new_client, lm87_id + kind - 1);
+	if (err)
+		goto exit_free;
+
+	/* Tell the I2C layer a new client has arrived */
+	err = i2c_attach_client(new_client);
+	if (err)
+		goto exit_remove;
+
+	return 0;
+
+exit_remove:
+	lm87_remove(new_client);
+exit_free:
+	kfree(new_client);
+	return err;
+}
+
+static const struct lm87_settings lm87_default_set = {
+	.in_max = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF },
+	.in_min = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+	.temp_high = { 0x7F, 0x7F, 0x7F },
+	.temp_low = { 0x00, 0x00, 0x00 },
+};
+
+static int
+lm87_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	const struct lm87_platform_data *plat_data = client->dev.platform_data;
+	struct lm87_data *data;
+	u8 config;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	data = kzalloc(sizeof(struct lm87_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	data->valid = 0;
 	mutex_init(&data->update_lock);
+	if (plat_data)
+		data->set = plat_data->set;
+	else
+		data->set = lm87_default_set;
+	i2c_set_clientdata(client, data);
+
+	if (plat_data && plat_data->reset) {
+		config = 0x80;
+		lm87_write_value(client, LM87_REG_CONFIG, config);
+		lm87_write_value(client,
+				 LM87_REG_CHANNEL_MODE, data->set.channel);
+	} else {
+		data->set.channel = lm87_read_value(client,
+						    LM87_REG_CHANNEL_MODE);
+		config = lm87_read_value(client, LM87_REG_CONFIG);
+	}
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto exit_free;
+	if ((plat_data && plat_data->set_limits) || !(config & 0x01)) {
+		int i, j;
 
-	/* Initialize the LM87 chip */
-	lm87_init_client(new_client);
+		i = (data->set.channel & LM87_CHAN_TEMP3) ? 1 : 0;
+		j = (data->set.channel & LM87_CHAN_TEMP3) ? 5 : 6;
+		for (; i < j; i++) {
+			lm87_write_value(client, LM87_REG_IN_MIN(i),
+					 data->set.in_min[i]);
+			lm87_write_value(client, LM87_REG_IN_MAX(i),
+					 data->set.in_max[i]);
+		}
+
+		for (i = 0; i < 2; i++) {
+			if (data->set.channel & LM87_CHAN_NO_FAN(i)) {
+				lm87_write_value(client, LM87_REG_AIN_MIN(i),
+						 data->set.in_min[6 + i]);
+				lm87_write_value(client, LM87_REG_AIN_MAX(i),
+						 data->set.in_max[6 + i]);
+			} else {
+				lm87_write_value(client, LM87_REG_FAN_MIN(i),
+						 data->set.fan_min[i]);
+			}
+		}
+		lm87_write_value(client, LM87_REG_VID_FAN_DIV,
+				 (data->set.fan_div[0] << 4) |
+				 (data->set.fan_div[1] << 6));
+
+		j = (data->set.channel & LM87_CHAN_TEMP3) ? 3 : 2; 
+		for (i = 0; i < j; i++) {
+			lm87_write_value(client, LM87_REG_TEMP_HIGH[i],
+					 data->set.temp_high[i]);
+			lm87_write_value(client, LM87_REG_TEMP_LOW[i],
+					 data->set.temp_low[i]);
+		}
+	}
+
+	if (plat_data && plat_data->set_aout)
+		lm87_write_value(client, LM87_REG_AOUT, data->set.aout);
+
+	if ((config & 0x81) != 0x01) {
+		/* Start monitoring */
+		lm87_write_value(client, LM87_REG_CONFIG,
+				 (config & ~0x81) | 0x01);
+	}
 
 	data->in_scale[0] = 2500;
 	data->in_scale[1] = 2700;
-	data->in_scale[2] = (data->channel & CHAN_VCC_5V) ? 5000 : 3300;
+	data->in_scale[2] = (data->set.channel & LM87_CHAN_VCC_5V) ? 5000 : 3300;
 	data->in_scale[3] = 5000;
 	data->in_scale[4] = 12000;
 	data->in_scale[5] = 2700;
@@ -731,97 +818,97 @@ static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 	data->in_scale[7] = 1875;
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm87_group)))
-		goto exit_detach;
+	if ((err = sysfs_create_group(&client->dev.kobj, &lm87_group)))
+		goto exit_reset;
 
-	if (data->channel & CHAN_NO_FAN(0)) {
-		if ((err = device_create_file(&new_client->dev,
+	if (data->set.channel & LM87_CHAN_NO_FAN(0)) {
+		if ((err = device_create_file(&client->dev,
 					&dev_attr_in6_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in6_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in6_max))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&sensor_dev_attr_in6_alarm.dev_attr)))
 			goto exit_remove;
 	} else {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&client->dev,
 					&dev_attr_fan1_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_fan1_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_fan1_div))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&sensor_dev_attr_fan1_alarm.dev_attr)))
 			goto exit_remove;
 	}
 
-	if (data->channel & CHAN_NO_FAN(1)) {
-		if ((err = device_create_file(&new_client->dev,
+	if (data->set.channel & LM87_CHAN_NO_FAN(1)) {
+		if ((err = device_create_file(&client->dev,
 					&dev_attr_in7_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in7_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in7_max))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&sensor_dev_attr_in7_alarm.dev_attr)))
 			goto exit_remove;
 	} else {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&client->dev,
 					&dev_attr_fan2_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_fan2_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_fan2_div))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&sensor_dev_attr_fan2_alarm.dev_attr)))
 			goto exit_remove;
 	}
 
-	if (data->channel & CHAN_TEMP3) {
-		if ((err = device_create_file(&new_client->dev,
+	if (data->set.channel & LM87_CHAN_TEMP3) {
+		if ((err = device_create_file(&client->dev,
 					&dev_attr_temp3_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_temp3_max))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_temp3_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_temp3_crit))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&sensor_dev_attr_temp3_alarm.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&sensor_dev_attr_temp3_fault.dev_attr)))
 			goto exit_remove;
 	} else {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&client->dev,
 					&dev_attr_in0_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in0_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in0_max))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&sensor_dev_attr_in0_alarm.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in5_input))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in5_min))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_in5_max))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&sensor_dev_attr_in5_alarm.dev_attr)))
 			goto exit_remove;
 	}
 
-	if (!(data->channel & CHAN_NO_VID)) {
+	if (!(data->set.channel & LM87_CHAN_NO_VID)) {
 		data->vrm = vid_which_vrm();
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&client->dev,
 					&dev_attr_cpu0_vid))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(&client->dev,
 					&dev_attr_vrm)))
 			goto exit_remove;
 	}
 
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
@@ -830,67 +917,43 @@ static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &lm87_group);
-	sysfs_remove_group(&new_client->dev.kobj, &lm87_group_opt);
-exit_detach:
-	i2c_detach_client(new_client);
-exit_free:
+	sysfs_remove_group(&client->dev.kobj, &lm87_group);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
+exit_reset:
+	if (plat_data && plat_data->reset)
+		lm87_write_value(client, LM87_REG_CONFIG, 0x80);
+
 	kfree(data);
-exit:
+	i2c_set_clientdata(client, NULL);
 	return err;
 }
 
-static void lm87_init_client(struct i2c_client *client)
+static int lm87_remove(struct i2c_client *client)
 {
+	const struct lm87_platform_data *plat_data = client->dev.platform_data;
 	struct lm87_data *data = i2c_get_clientdata(client);
-	u8 config;
 
-	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
 
-	config = lm87_read_value(client, LM87_REG_CONFIG);
-	if (!(config & 0x01)) {
-		int i;
+	if (plat_data && plat_data->reset)
+		lm87_write_value(client, LM87_REG_CONFIG, 0x80);
 
-		/* Limits are left uninitialized after power-up */
-		for (i = 1; i < 6; i++) {
-			lm87_write_value(client, LM87_REG_IN_MIN(i), 0x00);
-			lm87_write_value(client, LM87_REG_IN_MAX(i), 0xFF);
-		}
-		for (i = 0; i < 2; i++) {
-			lm87_write_value(client, LM87_REG_TEMP_HIGH[i], 0x7F);
-			lm87_write_value(client, LM87_REG_TEMP_LOW[i], 0x00);
-			lm87_write_value(client, LM87_REG_AIN_MIN(i), 0x00);
-			lm87_write_value(client, LM87_REG_AIN_MAX(i), 0xFF);
-		}
-		if (data->channel & CHAN_TEMP3) {
-			lm87_write_value(client, LM87_REG_TEMP_HIGH[2], 0x7F);
-			lm87_write_value(client, LM87_REG_TEMP_LOW[2], 0x00);
-		} else {
-			lm87_write_value(client, LM87_REG_IN_MIN(0), 0x00);
-			lm87_write_value(client, LM87_REG_IN_MAX(0), 0xFF);
-		}
-	}
-	if ((config & 0x81) != 0x01) {
-		/* Start monitoring */
-		lm87_write_value(client, LM87_REG_CONFIG,
-				 (config & 0xF7) | 0x01);
-	}
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+	return 0;
 }
 
 static int lm87_detach_client(struct i2c_client *client)
 {
-	struct lm87_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm87_group);
-	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
-
-	if ((err = i2c_detach_client(client)))
-		return err;
-
-	kfree(data);
-	return 0;
+	lm87_remove(client);
+	err = i2c_detach_client(client);
+	if (!err)
+		kfree(client);
+	return err;
 }
 
 static struct lm87_data *lm87_update_device(struct device *dev)
@@ -905,41 +968,41 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 
 		dev_dbg(&client->dev, "Updating data.\n");
 
-		i = (data->channel & CHAN_TEMP3) ? 1 : 0;
-		j = (data->channel & CHAN_TEMP3) ? 5 : 6;
+		i = (data->set.channel & LM87_CHAN_TEMP3) ? 1 : 0;
+		j = (data->set.channel & LM87_CHAN_TEMP3) ? 5 : 6;
 		for (; i < j; i++) {
-			data->in[i] = lm87_read_value(client,
+			data->val.in[i] = lm87_read_value(client,
 				      LM87_REG_IN(i));
-			data->in_min[i] = lm87_read_value(client,
+			data->set.in_min[i] = lm87_read_value(client,
 					  LM87_REG_IN_MIN(i));
-			data->in_max[i] = lm87_read_value(client,
+			data->set.in_max[i] = lm87_read_value(client,
 					  LM87_REG_IN_MAX(i));
 		}
 
 		for (i = 0; i < 2; i++) {
-			if (data->channel & CHAN_NO_FAN(i)) {
-				data->in[6+i] = lm87_read_value(client,
+			if (data->set.channel & LM87_CHAN_NO_FAN(i)) {
+				data->val.in[6+i] = lm87_read_value(client,
 						LM87_REG_AIN(i));
-				data->in_max[6+i] = lm87_read_value(client,
+				data->set.in_max[6+i] = lm87_read_value(client,
 						    LM87_REG_AIN_MAX(i));
-				data->in_min[6+i] = lm87_read_value(client,
+				data->set.in_min[6+i] = lm87_read_value(client,
 						    LM87_REG_AIN_MIN(i));
 
 			} else {
-				data->fan[i] = lm87_read_value(client,
+				data->val.fan[i] = lm87_read_value(client,
 					       LM87_REG_FAN(i));
-				data->fan_min[i] = lm87_read_value(client,
+				data->set.fan_min[i] = lm87_read_value(client,
 						   LM87_REG_FAN_MIN(i));
 			}
 		}
 
-		j = (data->channel & CHAN_TEMP3) ? 3 : 2;
+		j = (data->set.channel & LM87_CHAN_TEMP3) ? 3 : 2;
 		for (i = 0 ; i < j; i++) {
-			data->temp[i] = lm87_read_value(client,
+			data->val.temp[i] = lm87_read_value(client,
 					LM87_REG_TEMP[i]);
-			data->temp_high[i] = lm87_read_value(client,
+			data->set.temp_high[i] = lm87_read_value(client,
 					     LM87_REG_TEMP_HIGH[i]);
-			data->temp_low[i] = lm87_read_value(client,
+			data->set.temp_low[i] = lm87_read_value(client,
 					    LM87_REG_TEMP_LOW[i]);
 		}
 
@@ -952,16 +1015,14 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 		data->temp_crit_ext = min(i, j);
 
 		i = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
-		data->fan_div[0] = (i >> 4) & 0x03;
-		data->fan_div[1] = (i >> 6) & 0x03;
-		data->vid = (i & 0x0F)
-			  | (lm87_read_value(client, LM87_REG_VID4) & 0x01)
-			     << 4;
+		data->set.fan_div[0] = (i >> 4) & 0x03;
+		data->set.fan_div[1] = (i >> 6) & 0x03;
+		data->val.vid = (i & 0x0F)
+			| (lm87_read_value(client, LM87_REG_VID4) & 0x01) << 4;
 
-		data->alarms = lm87_read_value(client, LM87_REG_ALARMS1)
-			     | (lm87_read_value(client, LM87_REG_ALARMS2)
-				<< 8);
-		data->aout = lm87_read_value(client, LM87_REG_AOUT);
+		data->val.alarms = lm87_read_value(client, LM87_REG_ALARMS1)
+			| (lm87_read_value(client, LM87_REG_ALARMS2) << 8);
+		data->set.aout = lm87_read_value(client, LM87_REG_AOUT);
 
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -972,13 +1033,28 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 	return data;
 }
 
+struct lm87_values *lm87_update_values(struct i2c_client *client)
+{
+	struct lm87_data *data = lm87_update_device(&client->dev);
+	return &data->val;
+}
+EXPORT_SYMBOL(lm87_update_values);
+
 static int __init sensors_lm87_init(void)
 {
-	return i2c_add_driver(&lm87_driver);
+	int err;
+	err = i2c_add_driver(&lm87_driver);
+	if (err)
+		return err;
+	err = i2c_add_driver(&lm87_legacy_driver);
+	if (err)
+		i2c_del_driver(&lm87_driver);
+	return err;
 }
 
 static void __exit sensors_lm87_exit(void)
 {
+	i2c_del_driver(&lm87_legacy_driver);
 	i2c_del_driver(&lm87_driver);
 }
 
diff --git a/include/linux/lm87.h b/include/linux/lm87.h
new file mode 100644
index 0000000..da4c0fe
--- /dev/null
+++ b/include/linux/lm87.h
@@ -0,0 +1,132 @@
+/****************************************************************************
+ * Interface to lm87 driver
+ * Copyright 2008 Solarflare Communications Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef _LM87_H_
+#define _LM87_H_
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/i2c.h>
+
+/* Channel mode register */
+#define LM87_CHAN_NO_FAN(nr)	(1 << (nr))	/* nr in 0..1 */
+#define LM87_CHAN_TEMP3		(1 << 2)
+#define LM87_CHAN_VCC_5V	(1 << 3)
+#define LM87_CHAN_NO_VID	(1 << 7)
+
+/* Interrupt registers (combined) */
+#define LM87_INT_IN_2P5V	(1 << 0)
+#define LM87_INT_TEMP_EXT2	(1 << 0)
+#define LM87_INT_IN_VCCP1	(1 << 1)
+#define LM87_INT_IN_VCC		(1 << 2)
+#define LM87_INT_IN_5V		(1 << 3)
+#define LM87_INT_TEMP_INT	(1 << 4)
+#define LM87_INT_TEMP_EXT1	(1 << 5)
+#define LM87_INT_FAN_1		(1 << 6)
+#define LM87_INT_IN_AIN1	(1 << 6)
+#define LM87_INT_FAN_2		(1 << 7)
+#define LM87_INT_IN_AIN2	(1 << 7)
+#define LM87_INT_IN_12V		(1 << 8)
+#define LM87_INT_IN_VCCP2	(1 << 9)
+#define LM87_INT_CI		(1 << 12)
+#define LM87_INT_THERM		(1 << 13)
+#define LM87_INT_D1		(1 << 14)
+#define LM87_INT_D2		(1 << 15)
+
+/* Input indices */
+#define LM87_IN_2P5V	0
+#define LM87_IN_VCCP1	1
+#define LM87_IN_VCC	2
+#define LM87_IN_5V	3
+#define LM87_IN_12V	4
+#define LM87_IN_VCCP2	5
+#define LM87_IN_AIN1	6
+#define LM87_IN_AIN2	7
+
+/* Temperature indices */
+#define LM87_TEMP_INT	0
+#define LM87_TEMP_EXT1	1
+#define LM87_TEMP_EXT2	2
+
+/* Fan indices */
+#define LM87_FAN_1	0
+#define LM87_FAN_2	1
+
+/**
+ * struct lm87_settings - settings for LM87 hardware monitor
+ * @channel: Channel mode
+ * @in_max: Voltage high limits, indexed by %LM87_IN_*
+ * @in_min: Voltage low limits, indexed by %LM87_IN_*
+ * @temp_high: Temperature high limits, indexed by %LM87_TEMP_*
+ * @temp_low: Temperature low limits, indexed by %LM87_TEMP_*
+ * @fan_min: Fan speed minimums, indexed by %LM87_FAN_*
+ * @fan_div: Fan speed dividers, indexed by %LM87_FAN_*.
+ *	These are bitfield values in the range 0..3.
+ * @aout: DAC output
+ *
+ * The channel mode value determines which of these settings
+ * are actually used.  All values are raw register values,
+ * with the exception of @fan_div.
+ */
+struct lm87_settings {
+	u8 channel;
+	u8 in_max[8];
+	u8 in_min[8];
+	s8 temp_high[3];
+	s8 temp_low[3];
+	u8 fan_min[2];
+	u8 fan_div[2];
+	u8 aout;
+};
+
+/**
+ * struct lm87_values - values from LM87 hardware monitor
+ * @in: Voltages, indexed by %LM87_IN_*
+ * @temp: Temperatures, indexed by %LM87_TEMP_*
+ * @fan: Fan speeds, indexed by %LM87_FAN_*
+ * @alarms: Interrupt flags, combined with register 2 shifted 8 bits left
+ * @vid: Voltage id, combined from the two bitfields
+ *
+ * All sensor values are raw register values.
+ */
+struct lm87_values {
+	u8 in[8];
+	s8 temp[3];
+	u8 fan[2];
+	u16 alarms;
+	u8 vid;
+};
+
+/**
+ * struct lm87_platform_data - platform data for LM87 hardware monitor
+ * @reset: Flag for whether to reset and set channel mode register
+ * @set_limits: Flag for whether to set limit registers
+ * @set_aout: Flag for whether to set DAC out register
+ * @set: Settings to be applied depending on the above flags
+ *
+ * This platform data is optional.  If not provided, the driver will
+ * assume that the LM87 is configured by firmware.
+ */
+struct lm87_platform_data {
+	unsigned reset : 1;
+	unsigned set_limits : 1;
+	unsigned set_aout : 1;
+	struct lm87_settings set;
+};
+
+/**
+ * lm87_update_values() - update and return current values
+ * @client: I2C client to which the LM87 driver is bound
+ */
+struct lm87_values *lm87_update_values(struct i2c_client *client);
+
+#endif
+
+#endif

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
