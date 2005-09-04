From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 04 Sep 2005 03:24:49 +0000
Subject: [lm-sensors] RFC PATCH patch-13-mm1-hwmon-adm9240-whitespace-1
Message-Id: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Time for adm9240 cleanup, starting with whitespace fixups with no 
code changes, compiled and tested.  Patches are planned to make 
chassis_clear write data = <dont_care>, and rework sysfs interface 
to reduce driver size.

This patch removes mixed tab/space indenting, breaks long lines, 
removed a trailing space and is code neutral.  Further patches are 
planned which will apply after this cleanup.  Run tested :)

Thanks,
Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |  151 ++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 74 insertions(+), 77 deletions(-)

--- linux-2.6.13-mm1a/drivers/hwmon/adm9240.c	2005-09-02 07:50:33.000000000 +1000
+++ linux-2.6.13-mm1b/drivers/hwmon/adm9240.c	2005-09-03 17:32:50.000000000 +1000
@@ -186,8 +186,7 @@ static int adm9240_write_value(struct i2
 /* temperature */
 #define show_temp(value, scale)					\
 static ssize_t show_##value(struct device *dev,			\
-			    struct device_attribute *attr,	\
-			    char *buf)				\
+		struct device_attribute *attr, char *buf)	\
 {								\
 	struct adm9240_data *data = adm9240_update_device(dev);	\
 	return sprintf(buf, "%d\n", data->value * scale);	\
@@ -198,8 +197,8 @@ show_temp(temp, 500); /* 0.5'C per bit *
 
 #define set_temp(value, reg)					\
 static ssize_t set_##value(struct device *dev, 			\
-			   struct device_attribute *attr,	\
-			   const char *buf, size_t count)	\
+		struct device_attribute *attr,			\
+		const char *buf, size_t count)			\
 {								\
 	struct i2c_client *client = to_i2c_client(dev);		\
 	struct adm9240_data *data = adm9240_update_device(dev);	\
@@ -268,43 +267,39 @@ static ssize_t set_in_max(struct device 
 	return count;
 }
 
-#define show_in_offset(offset)						\
-static ssize_t show_in##offset(struct device *dev,			\
-			       struct device_attribute *attr,		\
-			       char *buf)				\
-{									\
-	return show_in(dev, buf, offset);				\
-}									\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);	\
-static ssize_t show_in##offset##_min(struct device *dev,		\
-				     struct device_attribute *attr,	\
-				     char *buf)				\
-{									\
-	return show_in_min(dev, buf, offset);				\
-}									\
-static ssize_t show_in##offset##_max(struct device *dev,		\
-				     struct device_attribute *attr,	\
-				     char *buf)				\
-{									\
-	return show_in_max(dev, buf, offset);				\
-}									\
-static ssize_t								\
-set_in##offset##_min(struct device *dev,				\
-		     struct device_attribute *attr, const char *buf,	\
-		     size_t count)					\
-{									\
-	return set_in_min(dev, buf, count, offset);			\
-}									\
-static ssize_t								\
-set_in##offset##_max(struct device *dev,				\
-		     struct device_attribute *attr, const char *buf,	\
-		     size_t count)					\
-{									\
-	return set_in_max(dev, buf, count, offset);			\
-}									\
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,			\
-		show_in##offset##_min, set_in##offset##_min);		\
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,			\
+#define show_in_offset(offset)					\
+static ssize_t show_in##offset(struct device *dev,		\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	return show_in(dev, buf, offset);			\
+}								\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO,			\
+		show_in##offset, NULL);				\
+static ssize_t show_in##offset##_min(struct device *dev,	\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	return show_in_min(dev, buf, offset);			\
+}								\
+static ssize_t show_in##offset##_max(struct device *dev,	\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	return show_in_max(dev, buf, offset);			\
+}								\
+static ssize_t set_in##offset##_min(struct device *dev,		\
+		struct device_attribute *attr,			\
+		const char *buf, size_t count)			\
+{								\
+	return set_in_min(dev, buf, count, offset);		\
+}								\
+static ssize_t set_in##offset##_max(struct device *dev,		\
+		struct device_attribute *attr,			\
+		const char *buf, size_t count)			\
+{								\
+	return set_in_max(dev, buf, count, offset);		\
+}								\
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_in##offset##_min, set_in##offset##_min);	\
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,		\
 		show_in##offset##_max, set_in##offset##_max);
 
 show_in_offset(0);
@@ -350,7 +345,7 @@ static void adm9240_write_fan_div(struct
 			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
 }
 
-/* 
+/*
  * set fan speed low limit:
  *
  * - value is zero: disable fan speed low limit alarm
@@ -413,43 +408,41 @@ static ssize_t set_fan_min(struct device
 	return count;
 }
 
-#define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev,			\
-				  struct device_attribute *attr,	\
-				  char *buf)				\
-{									\
-return show_fan(dev, buf, offset - 1);					\
-}									\
-static ssize_t show_fan_##offset##_div (struct device *dev,		\
-					struct device_attribute *attr,	\
-					char *buf)			\
-{									\
-return show_fan_div(dev, buf, offset - 1);				\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev,		\
-					struct device_attribute *attr,	\
-					char *buf)			\
-{									\
-return show_fan_min(dev, buf, offset - 1);				\
-}									\
-static ssize_t set_fan_##offset##_min (struct device *dev, 		\
-				       struct device_attribute *attr,	\
-				       const char *buf, size_t count)	\
-{									\
-return set_fan_min(dev, buf, count, offset - 1);			\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, 			\
-		show_fan_##offset, NULL);				\
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO, 				\
-		show_fan_##offset##_div, NULL);				\
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
+#define show_fan_offset(offset)					\
+static ssize_t show_fan_##offset (struct device *dev,		\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	return show_fan(dev, buf, offset - 1);			\
+}								\
+static ssize_t show_fan_##offset##_div (struct device *dev,	\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	return show_fan_div(dev, buf, offset - 1);		\
+}								\
+static ssize_t show_fan_##offset##_min (struct device *dev,	\
+		struct device_attribute *attr, char *buf)	\
+{								\
+	return show_fan_min(dev, buf, offset - 1);		\
+}								\
+static ssize_t set_fan_##offset##_min (struct device *dev, 	\
+		struct device_attribute *attr,			\
+		const char *buf, size_t count)			\
+{								\
+	return set_fan_min(dev, buf, count, offset - 1);	\
+}								\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, 		\
+		show_fan_##offset, NULL);			\
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO, 			\
+		show_fan_##offset##_div, NULL);			\
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 	\
 		show_fan_##offset##_min, set_fan_##offset##_min);
 
 show_fan_offset(1);
 show_fan_offset(2);
 
 /* alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -457,7 +450,8 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* vid */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -465,13 +459,15 @@ static ssize_t show_vid(struct device *d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* analog output */
-static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_aout(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
 
-static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_aout(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
@@ -486,7 +482,8 @@ static ssize_t set_aout(struct device *d
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
 
 /* chassis_clear */
-static ssize_t chassis_clear(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t chassis_clear(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned long val = simple_strtol(buf, NULL, 10);
