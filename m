From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH I2C sysfs naming cleanup: lm85
Message-Id: <qrf5715d7juccpc9oe9njri59urecef8eb@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch changes lm85 sysfs names to match style of other names 
and to remove the repeated name within name.

--Grant.



Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 lm85.c |  128 ++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 64 insertions(+), 64 deletions(-)

--- linux-2.6.12-rc3/drivers/i2c/chips/lm85.c	2005-04-30 06:45:30.000000000 +1000
+++ linux-2.6.12-rc3a/drivers/i2c/chips/lm85.c	2005-04-30 09:07:40.000000000 +1000
@@ -786,58 +786,58 @@
 	return count;
 }
 #define pwm_auto(offset)						\
-static ssize_t show_pwm##offset##_auto_channels (struct device *dev,	\
+static ssize_t show_auto_pwm##offset##_channels (struct device *dev,	\
 	char *buf)							\
 {									\
 	return show_pwm_auto_channels(dev, buf, offset - 1);		\
 }									\
-static ssize_t set_pwm##offset##_auto_channels (struct device *dev,	\
+static ssize_t set_auto_pwm##offset##_channels (struct device *dev,	\
 	const char *buf, size_t count)					\
 {									\
 	return set_pwm_auto_channels(dev, buf, count, offset - 1);	\
 }									\
-static ssize_t show_pwm##offset##_auto_pwm_min (struct device *dev,	\
+static ssize_t show_auto_pwm##offset##_min (struct device *dev,	\
 	char *buf)							\
 {									\
 	return show_pwm_auto_pwm_min(dev, buf, offset - 1);		\
 }									\
-static ssize_t set_pwm##offset##_auto_pwm_min (struct device *dev,	\
+static ssize_t set_auto_pwm##offset##_min (struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
 	return set_pwm_auto_pwm_min(dev, buf, count, offset - 1);	\
 }									\
-static ssize_t show_pwm##offset##_auto_pwm_minctl (struct device *dev,	\
+static ssize_t show_auto_pwm##offset##_minctl (struct device *dev,	\
 	char *buf)							\
 {									\
 	return show_pwm_auto_pwm_minctl(dev, buf, offset - 1);		\
 }									\
-static ssize_t set_pwm##offset##_auto_pwm_minctl (struct device *dev,	\
+static ssize_t set_auto_pwm##offset##_minctl (struct device *dev,	\
 	const char *buf, size_t count)					\
 {									\
 	return set_pwm_auto_pwm_minctl(dev, buf, count, offset - 1);	\
 }									\
-static ssize_t show_pwm##offset##_auto_pwm_freq (struct device *dev,	\
+static ssize_t show_auto_pwm##offset##_freq (struct device *dev,	\
 	char *buf)							\
 {									\
 	return show_pwm_auto_pwm_freq(dev, buf, offset - 1);		\
 }									\
-static ssize_t set_pwm##offset##_auto_pwm_freq(struct device *dev,	\
+static ssize_t set_auto_pwm##offset##_freq(struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
 	return set_pwm_auto_pwm_freq(dev, buf, count, offset - 1);	\
 }									\
-static DEVICE_ATTR(pwm##offset##_auto_channels, S_IRUGO | S_IWUSR,	\
-		show_pwm##offset##_auto_channels,			\
-		set_pwm##offset##_auto_channels);			\
-static DEVICE_ATTR(pwm##offset##_auto_pwm_min, S_IRUGO | S_IWUSR,	\
-		show_pwm##offset##_auto_pwm_min,			\
-		set_pwm##offset##_auto_pwm_min);			\
-static DEVICE_ATTR(pwm##offset##_auto_pwm_minctl, S_IRUGO | S_IWUSR,	\
-		show_pwm##offset##_auto_pwm_minctl,			\
-		set_pwm##offset##_auto_pwm_minctl);			\
-static DEVICE_ATTR(pwm##offset##_auto_pwm_freq, S_IRUGO | S_IWUSR,	\
-		show_pwm##offset##_auto_pwm_freq,			\
-		set_pwm##offset##_auto_pwm_freq);              
+static DEVICE_ATTR(auto_pwm##offset##_channels, S_IRUGO | S_IWUSR,	\
+		show_auto_pwm##offset##_channels,			\
+		set_auto_pwm##offset##_channels);			\
+static DEVICE_ATTR(auto_pwm##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_auto_pwm##offset##_min,				\
+		set_auto_pwm##offset##_min);				\
+static DEVICE_ATTR(auto_pwm##offset##_minctl, S_IRUGO | S_IWUSR,	\
+		show_auto_pwm##offset##_minctl,				\
+		set_auto_pwm##offset##_minctl);				\
+static DEVICE_ATTR(auto_pwm##offset##_freq, S_IRUGO | S_IWUSR,		\
+		show_auto_pwm##offset##_freq,				\
+		set_auto_pwm##offset##_freq);              
 pwm_auto(1);
 pwm_auto(2);
 pwm_auto(3);
@@ -962,58 +962,58 @@
 	return count;
 }
 #define temp_auto(offset)						\
-static ssize_t show_temp##offset##_auto_temp_off (struct device *dev,	\
+static ssize_t show_auto_temp##offset##_off (struct device *dev,	\
 	char *buf)							\
 {									\
 	return show_temp_auto_temp_off(dev, buf, offset - 1);		\
 }									\
-static ssize_t set_temp##offset##_auto_temp_off (struct device *dev,	\
+static ssize_t set_auto_temp##offset##_off (struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
 	return set_temp_auto_temp_off(dev, buf, count, offset - 1);	\
 }									\
-static ssize_t show_temp##offset##_auto_temp_min (struct device *dev,	\
+static ssize_t show_auto_temp##offset##_min (struct device *dev,	\
 	char *buf)							\
 {									\
 	return show_temp_auto_temp_min(dev, buf, offset - 1);		\
 }									\
-static ssize_t set_temp##offset##_auto_temp_min (struct device *dev,	\
+static ssize_t set_auto_temp##offset##_min (struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
 	return set_temp_auto_temp_min(dev, buf, count, offset - 1);	\
 }									\
-static ssize_t show_temp##offset##_auto_temp_max (struct device *dev,	\
+static ssize_t show_auto_temp##offset##_max (struct device *dev,	\
 	char *buf)							\
 {									\
 	return show_temp_auto_temp_max(dev, buf, offset - 1);		\
 }									\
-static ssize_t set_temp##offset##_auto_temp_max (struct device *dev,	\
+static ssize_t set_auto_temp##offset##_max (struct device *dev,		\
 	const char *buf, size_t count)					\
 {									\
 	return set_temp_auto_temp_max(dev, buf, count, offset - 1);	\
 }									\
-static ssize_t show_temp##offset##_auto_temp_crit (struct device *dev,	\
+static ssize_t show_auto_temp##offset##_crit (struct device *dev,	\
 	char *buf)							\
 {									\
 	return show_temp_auto_temp_crit(dev, buf, offset - 1);		\
 }									\
-static ssize_t set_temp##offset##_auto_temp_crit (struct device *dev,	\
+static ssize_t set_auto_temp##offset##_crit (struct device *dev,	\
 	const char *buf, size_t count)					\
 {									\
 	return set_temp_auto_temp_crit(dev, buf, count, offset - 1);	\
 }									\
-static DEVICE_ATTR(temp##offset##_auto_temp_off, S_IRUGO | S_IWUSR,	\
-		show_temp##offset##_auto_temp_off,			\
-		set_temp##offset##_auto_temp_off);			\
-static DEVICE_ATTR(temp##offset##_auto_temp_min, S_IRUGO | S_IWUSR,	\
-		show_temp##offset##_auto_temp_min,			\
-		set_temp##offset##_auto_temp_min);			\
-static DEVICE_ATTR(temp##offset##_auto_temp_max, S_IRUGO | S_IWUSR,	\
-		show_temp##offset##_auto_temp_max,			\
-		set_temp##offset##_auto_temp_max);			\
-static DEVICE_ATTR(temp##offset##_auto_temp_crit, S_IRUGO | S_IWUSR,	\
-		show_temp##offset##_auto_temp_crit,			\
-		set_temp##offset##_auto_temp_crit);
+static DEVICE_ATTR(auto_temp##offset##_off, S_IRUGO | S_IWUSR,		\
+		show_auto_temp##offset##_off,				\
+		set_auto_temp##offset##_off);				\
+static DEVICE_ATTR(auto_temp##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_auto_temp##offset##_min,				\
+		set_auto_temp##offset##_min);				\
+static DEVICE_ATTR(auto_temp##offset##_max, S_IRUGO | S_IWUSR,		\
+		show_auto_temp##offset##_max,				\
+		set_auto_temp##offset##_max);				\
+static DEVICE_ATTR(auto_temp##offset##_crit, S_IRUGO | S_IWUSR,		\
+		show_auto_temp##offset##_crit,				\
+		set_auto_temp##offset##_crit);
 temp_auto(1);
 temp_auto(2);
 temp_auto(3);
@@ -1210,30 +1210,30 @@
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_channels);
-	device_create_file(&new_client->dev, &dev_attr_pwm2_auto_channels);
-	device_create_file(&new_client->dev, &dev_attr_pwm3_auto_channels);
-	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_pwm_min);
-	device_create_file(&new_client->dev, &dev_attr_pwm2_auto_pwm_min);
-	device_create_file(&new_client->dev, &dev_attr_pwm3_auto_pwm_min);
-	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_pwm_minctl);
-	device_create_file(&new_client->dev, &dev_attr_pwm2_auto_pwm_minctl);
-	device_create_file(&new_client->dev, &dev_attr_pwm3_auto_pwm_minctl);
-	device_create_file(&new_client->dev, &dev_attr_pwm1_auto_pwm_freq);
-	device_create_file(&new_client->dev, &dev_attr_pwm2_auto_pwm_freq);
-	device_create_file(&new_client->dev, &dev_attr_pwm3_auto_pwm_freq);
-	device_create_file(&new_client->dev, &dev_attr_temp1_auto_temp_off);
-	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_off);
-	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_off);
-	device_create_file(&new_client->dev, &dev_attr_temp1_auto_temp_min);
-	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_min);
-	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_min);
-	device_create_file(&new_client->dev, &dev_attr_temp1_auto_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp1_auto_temp_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_crit);
-	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_crit);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm1_channels);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm2_channels);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm3_channels);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm1_min);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm2_min);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm3_min);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm1_minctl);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm2_minctl);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm3_minctl);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm1_freq);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm2_freq);
+	device_create_file(&new_client->dev, &dev_attr_auto_pwm3_freq);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp1_off);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp2_off);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp3_off);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp1_min);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp2_min);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp3_min);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp2_max);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp3_max);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp1_crit);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp2_crit);
+	device_create_file(&new_client->dev, &dev_attr_auto_temp3_crit);
 
 	return 0;
 
