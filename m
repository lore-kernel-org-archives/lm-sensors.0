From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 09 Jun 2008 11:07:46 +0000
Subject: [lm-sensors] [PATCH 2/3] lm87: Add support for configuration
Message-Id: <20080609110744.GZ11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move all chip settings into a struct lm87_settings, defined in the new
header <linux/lm87.h>.

Check for and apply platform_data specified in the I2C client.  If
platform_data is set it must point to an instance of
struct lm87_platform_data, also defined in this new header, which
contains settings and flags for which to apply.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm87.c |  207 +++++++++++++++++++++++++++++---------------------
 include/linux/lm87.h |  107 ++++++++++++++++++++++++++
 2 files changed, 228 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/lm87.h

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 81a1643..794deec 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -65,6 +65,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
+#include <linux/lm87.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 
@@ -147,12 +148,6 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A, 0x38, 0x2C };
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
@@ -203,23 +198,16 @@ struct lm87_data {
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* In jiffies */
 
-	u8 channel;		/* register value */
+	struct lm87_settings set;
 
 	u8 in[8];		/* register value */
-	u8 in_max[8];		/* register value */
-	u8 in_min[8];		/* register value */
 	u16 in_scale[8];
 
 	s8 temp[3];		/* register value */
-	s8 temp_high[3];	/* register value */
-	s8 temp_low[3];		/* register value */
 	s8 temp_crit_int;	/* min of two register values */
 	s8 temp_crit_ext;	/* min of two register values */
 
 	u8 fan[2];		/* register value */
-	u8 fan_min[2];		/* register value */
-	u8 fan_div[2];		/* register value, shifted right */
-	u8 aout;		/* register value */
 
 	u16 alarms;		/* register values, combined */
 	u8 vid;			/* register values, combined */
@@ -250,13 +238,13 @@ static ssize_t show_in##offset##_input(struct device *dev, struct device_attribu
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
@@ -277,9 +265,9 @@ static void set_in_min(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->in_min[nr] = IN_TO_REG(val, data->in_scale[nr]);
+	data->set.in_min[nr] = IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MIN(nr) :
-			 LM87_REG_AIN_MIN(nr-6), data->in_min[nr]);
+			 LM87_REG_AIN_MIN(nr-6), data->set.in_min[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -290,9 +278,9 @@ static void set_in_max(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->in_max[nr] = IN_TO_REG(val, data->in_scale[nr]);
+	data->set.in_max[nr] = IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MAX(nr) :
-			 LM87_REG_AIN_MAX(nr-6), data->in_max[nr]);
+			 LM87_REG_AIN_MAX(nr-6), data->set.in_max[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -331,12 +319,12 @@ static ssize_t show_temp##offset##_input(struct device *dev, struct device_attri
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
@@ -351,8 +339,8 @@ static void set_temp_low(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_low[nr] = TEMP_TO_REG(val);
-	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->temp_low[nr]);
+	data->set.temp_low[nr] = TEMP_TO_REG(val);
+	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->set.temp_low[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -363,8 +351,8 @@ static void set_temp_high(struct device *dev, const char *buf, int nr)
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_high[nr] = TEMP_TO_REG(val);
-	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->temp_high[nr]);
+	data->set.temp_high[nr] = TEMP_TO_REG(val);
+	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->set.temp_high[nr]);
 	mutex_unlock(&data->update_lock);
 }
 
@@ -410,18 +398,18 @@ static ssize_t show_fan##offset##_input(struct device *dev, struct device_attrib
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_div[offset-1]))); \
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
@@ -435,9 +423,9 @@ static void set_fan_min(struct device *dev, const char *buf, int nr)
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
 
@@ -455,14 +443,14 @@ static ssize_t set_fan_div(struct device *dev, const char *buf,
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
@@ -471,17 +459,17 @@ static ssize_t set_fan_div(struct device *dev, const char *buf,
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
@@ -536,7 +524,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
-	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
+	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->set.aout));
 }
 static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -545,8 +533,8 @@ static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->aout = AOUT_TO_REG(val);
-	lm87_write_value(client, LM87_REG_AOUT, data->aout);
+	data->set.aout = AOUT_TO_REG(val);
+	lm87_write_value(client, LM87_REG_AOUT, data->set.aout);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -739,9 +727,18 @@ exit_free:
 	return err;
 }
 
+static const struct lm87_settings lm87_default_set = {
+	.in_max = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF },
+	.in_min = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+	.temp_high = { 0x7F, 0x7F, 0x7F },
+	.temp_low = { 0x00, 0x00, 0x00 },
+};
+
 static int
 lm87_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
 {
+	const struct lm87_platform_data *plat_data +		new_client->dev.platform_data;
 	struct lm87_data *data;
 	int err;
 
@@ -761,7 +758,7 @@ lm87_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
 
 	data->in_scale[0] = 2500;
 	data->in_scale[1] = 2700;
-	data->in_scale[2] = (data->channel & CHAN_VCC_5V) ? 5000 : 3300;
+	data->in_scale[2] = (data->set.channel & LM87_CHAN_VCC_5V) ? 5000 : 3300;
 	data->in_scale[3] = 5000;
 	data->in_scale[4] = 12000;
 	data->in_scale[5] = 2700;
@@ -770,9 +767,9 @@ lm87_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm87_group)))
-		goto exit_free;
+		goto exit_reset;
 
-	if (data->channel & CHAN_NO_FAN(0)) {
+	if (data->set.channel & LM87_CHAN_NO_FAN(0)) {
 		if ((err = device_create_file(&new_client->dev,
 					&dev_attr_in6_input))
 		 || (err = device_create_file(&new_client->dev,
@@ -794,7 +791,7 @@ lm87_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
 			goto exit_remove;
 	}
 
-	if (data->channel & CHAN_NO_FAN(1)) {
+	if (data->set.channel & LM87_CHAN_NO_FAN(1)) {
 		if ((err = device_create_file(&new_client->dev,
 					&dev_attr_in7_input))
 		 || (err = device_create_file(&new_client->dev,
@@ -816,7 +813,7 @@ lm87_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
 			goto exit_remove;
 	}
 
-	if (data->channel & CHAN_TEMP3) {
+	if (data->set.channel & LM87_CHAN_TEMP3) {
 		if ((err = device_create_file(&new_client->dev,
 					&dev_attr_temp3_input))
 		 || (err = device_create_file(&new_client->dev,
@@ -850,7 +847,7 @@ lm87_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
 			goto exit_remove;
 	}
 
-	if (!(data->channel & CHAN_NO_VID)) {
+	if (!(data->set.channel & LM87_CHAN_NO_VID)) {
 		data->vrm = vid_which_vrm();
 		if ((err = device_create_file(&new_client->dev,
 					&dev_attr_cpu0_vid))
@@ -870,7 +867,10 @@ lm87_probe(struct i2c_client *new_client, const struct i2c_device_id *id)
 exit_remove:
 	sysfs_remove_group(&new_client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&new_client->dev.kobj, &lm87_group_opt);
-exit_free:
+exit_reset:
+	if (plat_data && plat_data->reset)
+		lm87_write_value(new_client, LM87_REG_CONFIG, 0x80);
+
 	kfree(data);
 	i2c_set_clientdata(new_client, NULL);
 	return err;
@@ -878,49 +878,84 @@ exit_free:
 
 static void lm87_init_client(struct i2c_client *client)
 {
+	const struct lm87_platform_data *plat_data = client->dev.platform_data;
 	struct lm87_data *data = i2c_get_clientdata(client);
 	u8 config;
 
-	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
+	if (plat_data)
+		data->set = plat_data->set;
+	else
+		data->set = lm87_default_set;
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
 
-	config = lm87_read_value(client, LM87_REG_CONFIG);
-	if (!(config & 0x01)) {
-		int i;
+	if ((plat_data && plat_data->set_limits) || !(config & 0x01)) {
+		int i, j;
 
-		/* Limits are left uninitialized after power-up */
-		for (i = 1; i < 6; i++) {
-			lm87_write_value(client, LM87_REG_IN_MIN(i), 0x00);
-			lm87_write_value(client, LM87_REG_IN_MAX(i), 0xFF);
+		i = (data->set.channel & LM87_CHAN_TEMP3) ? 1 : 0;
+		j = (data->set.channel & LM87_CHAN_TEMP3) ? 5 : 6;
+		for (; i < j; i++) {
+			lm87_write_value(client, LM87_REG_IN_MIN(i),
+					 data->set.in_min[i]);
+			lm87_write_value(client, LM87_REG_IN_MAX(i),
+					 data->set.in_max[i]);
 		}
+
 		for (i = 0; i < 2; i++) {
-			lm87_write_value(client, LM87_REG_TEMP_HIGH[i], 0x7F);
-			lm87_write_value(client, LM87_REG_TEMP_LOW[i], 0x00);
-			lm87_write_value(client, LM87_REG_AIN_MIN(i), 0x00);
-			lm87_write_value(client, LM87_REG_AIN_MAX(i), 0xFF);
+			if (data->set.channel & LM87_CHAN_NO_FAN(i)) {
+				lm87_write_value(client, LM87_REG_AIN_MIN(i),
+						 data->set.in_min[6 + i]);
+				lm87_write_value(client, LM87_REG_AIN_MAX(i),
+						 data->set.in_max[6 + i]);
+			} else {
+				lm87_write_value(client, LM87_REG_FAN_MIN(i),
+						 data->set.fan_min[i]);
+			}
 		}
-		if (data->channel & CHAN_TEMP3) {
-			lm87_write_value(client, LM87_REG_TEMP_HIGH[2], 0x7F);
-			lm87_write_value(client, LM87_REG_TEMP_LOW[2], 0x00);
-		} else {
-			lm87_write_value(client, LM87_REG_IN_MIN(0), 0x00);
-			lm87_write_value(client, LM87_REG_IN_MAX(0), 0xFF);
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
 		}
 	}
+
+	if (plat_data && plat_data->set_aout)
+		lm87_write_value(client, LM87_REG_AOUT, data->set.aout);
+
 	if ((config & 0x81) != 0x01) {
 		/* Start monitoring */
 		lm87_write_value(client, LM87_REG_CONFIG,
-				 (config & 0xF7) | 0x01);
+				 (config & ~0x81) | 0x01);
 	}
 }
 
 static int lm87_remove(struct i2c_client *client)
 {
+	const struct lm87_platform_data *plat_data = client->dev.platform_data;
 	struct lm87_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
 
+	if (plat_data && plat_data->reset)
+		lm87_write_value(client, LM87_REG_CONFIG, 0x80);
+
 	kfree(data);
 	i2c_set_clientdata(client, NULL);
 	return 0;
@@ -949,41 +984,41 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 
 		dev_dbg(&client->dev, "Updating data.\n");
 
-		i = (data->channel & CHAN_TEMP3) ? 1 : 0;
-		j = (data->channel & CHAN_TEMP3) ? 5 : 6;
+		i = (data->set.channel & LM87_CHAN_TEMP3) ? 1 : 0;
+		j = (data->set.channel & LM87_CHAN_TEMP3) ? 5 : 6;
 		for (; i < j; i++) {
 			data->in[i] = lm87_read_value(client,
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
+			if (data->set.channel & LM87_CHAN_NO_FAN(i)) {
 				data->in[6+i] = lm87_read_value(client,
 						LM87_REG_AIN(i));
-				data->in_max[6+i] = lm87_read_value(client,
+				data->set.in_max[6+i] = lm87_read_value(client,
 						    LM87_REG_AIN_MAX(i));
-				data->in_min[6+i] = lm87_read_value(client,
+				data->set.in_min[6+i] = lm87_read_value(client,
 						    LM87_REG_AIN_MIN(i));
 
 			} else {
 				data->fan[i] = lm87_read_value(client,
 					       LM87_REG_FAN(i));
-				data->fan_min[i] = lm87_read_value(client,
+				data->set.fan_min[i] = lm87_read_value(client,
 						   LM87_REG_FAN_MIN(i));
 			}
 		}
 
-		j = (data->channel & CHAN_TEMP3) ? 3 : 2;
+		j = (data->set.channel & LM87_CHAN_TEMP3) ? 3 : 2;
 		for (i = 0 ; i < j; i++) {
 			data->temp[i] = lm87_read_value(client,
 					LM87_REG_TEMP[i]);
-			data->temp_high[i] = lm87_read_value(client,
+			data->set.temp_high[i] = lm87_read_value(client,
 					     LM87_REG_TEMP_HIGH[i]);
-			data->temp_low[i] = lm87_read_value(client,
+			data->set.temp_low[i] = lm87_read_value(client,
 					    LM87_REG_TEMP_LOW[i]);
 		}
 
@@ -996,8 +1031,8 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 		data->temp_crit_ext = min(i, j);
 
 		i = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
-		data->fan_div[0] = (i >> 4) & 0x03;
-		data->fan_div[1] = (i >> 6) & 0x03;
+		data->set.fan_div[0] = (i >> 4) & 0x03;
+		data->set.fan_div[1] = (i >> 6) & 0x03;
 		data->vid = (i & 0x0F)
 			  | (lm87_read_value(client, LM87_REG_VID4) & 0x01)
 			     << 4;
@@ -1005,7 +1040,7 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 		data->alarms = lm87_read_value(client, LM87_REG_ALARMS1)
 			     | (lm87_read_value(client, LM87_REG_ALARMS2)
 				<< 8);
-		data->aout = lm87_read_value(client, LM87_REG_AOUT);
+		data->set.aout = lm87_read_value(client, LM87_REG_AOUT);
 
 		data->last_updated = jiffies;
 		data->valid = 1;
diff --git a/include/linux/lm87.h b/include/linux/lm87.h
new file mode 100644
index 0000000..cf0472d
--- /dev/null
+++ b/include/linux/lm87.h
@@ -0,0 +1,107 @@
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
