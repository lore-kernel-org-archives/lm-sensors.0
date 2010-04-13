From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 13 Apr 2010 22:54:28 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (adm1031) allow setting update rate
Message-Id: <1271199268-3180-3-git-send-email-iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1270671720-1575-3-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1270671720-1575-3-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The adm1031 chip is capable of using a runtime configurable sampling rate,
using the fan filter register. Add support for reading and setting the
update rate via sysfs.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/hwmon/adm1031.c |   82 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 1644b92..3366881 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -36,6 +36,7 @@
 #define ADM1031_REG_FAN_DIV(nr)		(0x20 + (nr))
 #define ADM1031_REG_PWM			(0x22)
 #define ADM1031_REG_FAN_MIN(nr)		(0x10 + (nr))
+#define ADM1031_REG_FAN_FILTER		(0x23)
 
 #define ADM1031_REG_TEMP_OFFSET(nr)	(0x0d + (nr))
 #define ADM1031_REG_TEMP_MAX(nr)	(0x14 + 4 * (nr))
@@ -61,6 +62,8 @@
 #define ADM1031_CONF2_TACH2_ENABLE	0x08
 #define ADM1031_CONF2_TEMP_ENABLE(chan)	(0x10 << (chan))
 
+#define ADM1031_UPDATE_RATE_MASK	0x1c
+
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
@@ -75,6 +78,7 @@ struct adm1031_data {
 	int chip_type;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
+	unsigned int update_rate;	/* In milliseconds */
 	/* The chan_select_table contains the possible configurations for
 	 * auto fan control.
 	 */
@@ -738,6 +742,58 @@ static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL, 12);
 static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 13);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 14);
 
+/* Update Rate */
+static ssize_t show_update_rate(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1031_data *data = i2c_get_clientdata(client);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", data->update_rate);
+}
+
+static ssize_t set_update_rate(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1031_data *data = i2c_get_clientdata(client);
+	unsigned int rates[] = { 125, 250, 500, 1000, 2000, 4000, 8000, 16000 };
+	unsigned int regvals[] = { 0x1c, 0x18, 0x14, 0x10, 0xc, 0x8, 0x4, 0x0 };
+	unsigned int reg;
+	int val, i;
+
+	/* both arrays must have the same number of values */
+	BUILD_BUG_ON(ARRAY_SIZE(rates) != ARRAY_SIZE(regvals));
+
+	/* find the update rate from the table */
+	val = simple_strtol(buf, NULL, 10);
+	for (i = 0; i < ARRAY_SIZE(rates); i++) {
+		if (val = rates[i])
+			break;
+	}
+
+	/* if the update rate was not found, the value is invalid */
+	if (i = ARRAY_SIZE(rates))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	/* set the new update rate while preserving other settings */
+	reg = adm1031_read_value(client, ADM1031_REG_FAN_FILTER);
+	reg &= ~ADM1031_UPDATE_RATE_MASK;
+	reg |= regvals[i];
+
+	adm1031_write_value(client, ADM1031_REG_FAN_FILTER, reg);
+	data->update_rate = rates[i];
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(update_rate, S_IRUGO | S_IWUSR, show_update_rate,
+		   set_update_rate);
+
 static struct attribute *adm1031_attributes[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
@@ -774,6 +830,7 @@ static struct attribute *adm1031_attributes[] = {
 
 	&sensor_dev_attr_auto_fan1_min_pwm.dev_attr.attr,
 
+	&dev_attr_update_rate.attr,
 	&dev_attr_alarms.attr,
 
 	NULL
@@ -901,6 +958,9 @@ static void adm1031_init_client(struct i2c_client *client)
 	unsigned int read_val;
 	unsigned int mask;
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	unsigned int rates[] = { 125, 250, 500, 1000, 2000, 4000, 8000, 16000 };
+	unsigned int regvals[] = { 0x1c, 0x18, 0x14, 0x10, 0xc, 0x8, 0x4, 0x0 };
+	int i;
 
 	mask = (ADM1031_CONF2_PWM1_ENABLE | ADM1031_CONF2_TACH1_ENABLE);
 	if (data->chip_type = adm1031) {
@@ -919,18 +979,36 @@ static void adm1031_init_client(struct i2c_client *client)
 				ADM1031_CONF1_MONITOR_ENABLE);
 	}
 
+	/* Read the chip's update rate */
+	mask = ADM1031_UPDATE_RATE_MASK;
+	read_val = adm1031_read_value(client, ADM1031_REG_FAN_FILTER);
+
+	/* Find the update rate from the table */
+	for (i = 0; i < ARRAY_SIZE(regvals); i++) {
+		if ((read_val & mask) = regvals[i])
+			break;
+	}
+
+	/* the update rate was not found, use the default */
+	if (i = ARRAY_SIZE(regvals)) {
+		data->update_rate = 1000;
+		return;
+	}
+
+	data->update_rate = rates[i];
 }
 
 static struct adm1031_data *adm1031_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1031_data *data = i2c_get_clientdata(client);
+	unsigned long next_update;
 	int chan;
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
+	next_update = data->last_updated + msecs_to_jiffies(data->update_rate);
+	if (time_after(jiffies, next_update) || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting adm1031 update\n");
 		for (chan = 0;
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
