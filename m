From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: adm9240 driver cleanup, take 1
Message-Id: <ccs881d9udtiesr60rl07knb7j12dk9f96@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch adds a no-op write accessor to fan_div to silence an 
ambiguous 'unable to write' warning from 'sensors -s' when a set 
fan_div is specified, the write data is ignored as this driver 
implements auto fan_div.  This seems to be best option in light 
of planned move to auto fan_div in other drivers.

Secondly it adds an info print of detected VRM stolen from Sebastian 
Witt's atxp1 sriver.  ADM9240 already has vrm accessor removed.

Thirdly, a whitespace cleanup in macro area and minor comment 
corrections.  The messy bit :)

Development on 2.6.11.9, patch cleanly applies to 2.6.12-rc4-mm1.
Driver is integrated with libsensors and tested on adm9240 chip.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |  148 ++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 78 insertions(+), 70 deletions(-)

--- linux-2.6.12-rc4-mm1/drivers/i2c/chips/adm9240.c	2005-05-12 21:33:22.000000000 +1000
+++ linux-2.6.12-rc4-mm1b/drivers/i2c/chips/adm9240.c	2005-05-13 15:25:28.000000000 +1000
@@ -165,7 +165,7 @@
 	s8 temp_high;		/* rw	temp1_max */
 	s8 temp_hyst;		/* rw	temp1_max_hyst */
 	u16 alarms;		/* ro	alarms */
-	u8 aout;		/* rw	analog_out */
+	u8 aout;		/* rw	aout_output */
 	u8 vid;			/* ro	vid */
 	u8 vrm;			/* --	vrm set on startup, no accessor */
 };
@@ -184,29 +184,29 @@
 /*** sysfs accessors ***/
 
 /* temperature */
-#define show_temp(value, scale)					\
-static ssize_t show_##value(struct device *dev, char *buf)	\
-{								\
-	struct adm9240_data *data = adm9240_update_device(dev);	\
-	return sprintf(buf, "%d\n", data->value * scale);	\
+#define show_temp(value, scale) \
+static ssize_t show_##value(struct device *dev, char *buf) \
+{ \
+	struct adm9240_data *data = adm9240_update_device(dev); \
+	return sprintf(buf, "%d\n", data->value * scale); \
 }
 show_temp(temp_high, 1000);
 show_temp(temp_hyst, 1000);
-show_temp(temp, 500);
+show_temp(temp, 500); /* 0.5'C per bit */
 
-#define set_temp(value, reg)					\
-static ssize_t set_##value(struct device *dev, const char *buf,	\
-		size_t count)					\
-{								\
-	struct i2c_client *client = to_i2c_client(dev);		\
-	struct adm9240_data *data = adm9240_update_device(dev);	\
-	long temp = simple_strtoul(buf, NULL, 10);		\
-								\
-	down(&data->update_lock);				\
-	data->value = TEMP_TO_REG(temp);			\
-	adm9240_write_value(client, reg, data->value);		\
-	up(&data->update_lock);					\
-	return count;						\
+#define set_temp(value, reg) \
+static ssize_t set_##value(struct device *dev, const char *buf, \
+		size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct adm9240_data *data = adm9240_update_device(dev); \
+	long temp = simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
+	data->value = TEMP_TO_REG(temp); \
+	adm9240_write_value(client, reg, data->value); \
+	up(&data->update_lock); \
+	return count; \
 }
 
 set_temp(temp_high, ADM9240_REG_TEMP_HIGH);
@@ -265,33 +265,33 @@
 	return count;
 }
 
-#define show_in_offset(offset)						\
-static ssize_t show_in##offset(struct device *dev, char *buf)		\
-{									\
-	return show_in(dev, buf, offset);				\
-}									\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);	\
-static ssize_t show_in##offset##_min(struct device *dev, char *buf)	\
-{									\
-	return show_in_min(dev, buf, offset);				\
-}									\
-static ssize_t show_in##offset##_max(struct device *dev, char *buf)	\
-{									\
-	return show_in_max(dev, buf, offset);				\
-}									\
-static ssize_t								\
-set_in##offset##_min(struct device *dev, const char *buf, size_t count)	\
-{									\
-	return set_in_min(dev, buf, count, offset);			\
-}									\
-static ssize_t								\
-set_in##offset##_max(struct device *dev, const char *buf, size_t count)	\
-{									\
-	return set_in_max(dev, buf, count, offset);			\
-}									\
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,			\
-		show_in##offset##_min, set_in##offset##_min);		\
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,			\
+#define show_in_offset(offset) \
+static ssize_t show_in##offset(struct device *dev, char *buf) \
+{ \
+	return show_in(dev, buf, offset); \
+} \
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL); \
+static ssize_t show_in##offset##_min(struct device *dev, char *buf) \
+{ \
+	return show_in_min(dev, buf, offset); \
+} \
+static ssize_t show_in##offset##_max(struct device *dev, char *buf) \
+{ \
+	return show_in_max(dev, buf, offset); \
+} \
+static ssize_t set_in##offset##_min(struct device *dev, const char *buf, \
+		size_t count) \
+{ \
+	return set_in_min(dev, buf, count, offset); \
+} \
+static ssize_t set_in##offset##_max(struct device *dev, const char *buf, \
+		size_t count) \
+{ \
+	return set_in_max(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
+		show_in##offset##_min, set_in##offset##_min); \
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
 		show_in##offset##_max, set_in##offset##_max);
 
 show_in_offset(0);
@@ -400,29 +400,34 @@
 	return count;
 }
 
-#define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
-{									\
-return show_fan(dev, buf, offset - 1);					\
-}									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
-{									\
-return show_fan_div(dev, buf, offset - 1);				\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
-{									\
-return show_fan_min(dev, buf, offset - 1);				\
-}									\
-static ssize_t set_fan_##offset##_min (struct device *dev, 		\
-const char *buf, size_t count)						\
-{									\
-return set_fan_min(dev, buf, count, offset - 1);			\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, 			\
-		show_fan_##offset, NULL);				\
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO, 				\
-		show_fan_##offset##_div, NULL);				\
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
+#define show_fan_offset(offset) \
+static ssize_t show_fan_##offset (struct device *dev, char *buf) \
+{ \
+	return show_fan(dev, buf, offset - 1); \
+} \
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf) \
+{ \
+	return show_fan_div(dev, buf, offset - 1); \
+} \
+static ssize_t set_fan_##offset##_div (struct device *dev, \
+		const char *buf, size_t count) \
+{ \
+	return count; \
+} \
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf) \
+{ \
+	return show_fan_min(dev, buf, offset - 1); \
+} \
+static ssize_t set_fan_##offset##_min (struct device *dev, \
+		const char *buf, size_t count) \
+{ \
+	return set_fan_min(dev, buf, count, offset - 1); \
+} \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
+		show_fan_##offset, NULL); \
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
+		show_fan_##offset##_div, set_fan_##offset##_div); \
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
 		show_fan_##offset##_min, set_fan_##offset##_min);
 
 show_fan_offset(1);
@@ -630,6 +635,9 @@
 
 	data->vrm = i2c_which_vrm(); /* need this to report vid as mV */
 
+	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
+			data->vrm % 10);
+
 	if (conf & 1) { /* measurement cycle running: report state */
 
 		dev_info(&client->dev, "status: config 0x%02x mode %u\n",
