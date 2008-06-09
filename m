From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 09 Jun 2008 11:08:18 +0000
Subject: [lm-sensors] [PATCH 3/3] lm87: Expose sensor values to kernel users
Message-Id: <20080609110817.GA11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move all sensor values into struct lm87_values, added to <linux/lm87.h>.
Export the function lm87_update_values() which polls and returns the
sensor values.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/lm87.c |   44 ++++++++++++++++++++++----------------------
 include/linux/lm87.h |   25 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 794deec..0703359 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -199,18 +199,13 @@ struct lm87_data {
 	unsigned long last_updated; /* In jiffies */
 
 	struct lm87_settings set;
+	struct lm87_values val;
 
-	u8 in[8];		/* register value */
 	u16 in_scale[8];
 
-	s8 temp[3];		/* register value */
 	s8 temp_crit_int;	/* min of two register values */
 	s8 temp_crit_ext;	/* min of two register values */
 
-	u8 fan[2];		/* register value */
-
-	u16 alarms;		/* register values, combined */
-	u8 vid;			/* register values, combined */
 	u8 vrm;
 };
 
@@ -232,7 +227,7 @@ static inline int lm87_write_value(struct i2c_client *client, u8 reg, u8 value)
 static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->val.in[offset], \
 		       data->in_scale[offset])); \
 } \
 static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
@@ -314,7 +309,7 @@ set_in(7);
 static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->val.temp[offset-1])); \
 } \
 static ssize_t show_temp##offset##_low(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
@@ -397,7 +392,7 @@ static DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit_ext, NULL);
 static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[offset-1], \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->val.fan[offset-1], \
 		       FAN_DIV_FROM_REG(data->set.fan_div[offset-1]))); \
 } \
 static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
@@ -497,14 +492,14 @@ set_fan(2);
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
 
@@ -545,7 +540,7 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	int bitnr = to_sensor_dev_attr(attr)->index;
-	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+	return sprintf(buf, "%u\n", (data->val.alarms >> bitnr) & 1);
 }
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
@@ -987,7 +982,7 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 		i = (data->set.channel & LM87_CHAN_TEMP3) ? 1 : 0;
 		j = (data->set.channel & LM87_CHAN_TEMP3) ? 5 : 6;
 		for (; i < j; i++) {
-			data->in[i] = lm87_read_value(client,
+			data->val.in[i] = lm87_read_value(client,
 				      LM87_REG_IN(i));
 			data->set.in_min[i] = lm87_read_value(client,
 					  LM87_REG_IN_MIN(i));
@@ -997,7 +992,7 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 
 		for (i = 0; i < 2; i++) {
 			if (data->set.channel & LM87_CHAN_NO_FAN(i)) {
-				data->in[6+i] = lm87_read_value(client,
+				data->val.in[6+i] = lm87_read_value(client,
 						LM87_REG_AIN(i));
 				data->set.in_max[6+i] = lm87_read_value(client,
 						    LM87_REG_AIN_MAX(i));
@@ -1005,7 +1000,7 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 						    LM87_REG_AIN_MIN(i));
 
 			} else {
-				data->fan[i] = lm87_read_value(client,
+				data->val.fan[i] = lm87_read_value(client,
 					       LM87_REG_FAN(i));
 				data->set.fan_min[i] = lm87_read_value(client,
 						   LM87_REG_FAN_MIN(i));
@@ -1014,7 +1009,7 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 
 		j = (data->set.channel & LM87_CHAN_TEMP3) ? 3 : 2;
 		for (i = 0 ; i < j; i++) {
-			data->temp[i] = lm87_read_value(client,
+			data->val.temp[i] = lm87_read_value(client,
 					LM87_REG_TEMP[i]);
 			data->set.temp_high[i] = lm87_read_value(client,
 					     LM87_REG_TEMP_HIGH[i]);
@@ -1033,13 +1028,11 @@ static struct lm87_data *lm87_update_device(struct device *dev)
 		i = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
 		data->set.fan_div[0] = (i >> 4) & 0x03;
 		data->set.fan_div[1] = (i >> 6) & 0x03;
-		data->vid = (i & 0x0F)
-			  | (lm87_read_value(client, LM87_REG_VID4) & 0x01)
-			     << 4;
+		data->val.vid = (i & 0x0F)
+			| (lm87_read_value(client, LM87_REG_VID4) & 0x01) << 4;
 
-		data->alarms = lm87_read_value(client, LM87_REG_ALARMS1)
-			     | (lm87_read_value(client, LM87_REG_ALARMS2)
-				<< 8);
+		data->val.alarms = lm87_read_value(client, LM87_REG_ALARMS1)
+			| (lm87_read_value(client, LM87_REG_ALARMS2) << 8);
 		data->set.aout = lm87_read_value(client, LM87_REG_AOUT);
 
 		data->last_updated = jiffies;
@@ -1051,6 +1044,13 @@ static struct lm87_data *lm87_update_device(struct device *dev)
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
 	int err;
diff --git a/include/linux/lm87.h b/include/linux/lm87.h
index cf0472d..da4c0fe 100644
--- a/include/linux/lm87.h
+++ b/include/linux/lm87.h
@@ -13,6 +13,7 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
+#include <linux/i2c.h>
 
 /* Channel mode register */
 #define LM87_CHAN_NO_FAN(nr)	(1 << (nr))	/* nr in 0..1 */
@@ -86,6 +87,24 @@ struct lm87_settings {
 };
 
 /**
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
  * struct lm87_platform_data - platform data for LM87 hardware monitor
  * @reset: Flag for whether to reset and set channel mode register
  * @set_limits: Flag for whether to set limit registers
@@ -102,6 +121,12 @@ struct lm87_platform_data {
 	struct lm87_settings set;
 };
 
+/**
+ * lm87_update_values() - update and return current values
+ * @client: I2C client to which the LM87 driver is bound
+ */
+struct lm87_values *lm87_update_values(struct i2c_client *client);
+
 #endif
 
 #endif

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
