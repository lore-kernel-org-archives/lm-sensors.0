From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jan 2008 22:04:55 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (w83627hf) Refactor beep enable
Message-Id: <20080103230455.3e0786c1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We can handle the beep enable bit as any other beep mask bit for
slightly smaller code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Carlos, Jim, could any of you please test and/or review this patch?

 drivers/hwmon/w83627hf.c |   78 +++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 52 deletions(-)

--- linux-2.6.24-rc6.orig/drivers/hwmon/w83627hf.c	2008-01-03 22:31:00.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/w83627hf.c	2008-01-03 22:42:28.000000000 +0100
@@ -323,10 +323,8 @@ static inline u8 pwm_freq_to_reg(unsigne
 		return (0x80 | (180000UL / (val << 8)));
 }
 
-#define BEEP_MASK_FROM_REG(val)		 (val)
-#define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
-#define BEEP_ENABLE_TO_REG(val)		((val)?1:0)
-#define BEEP_ENABLE_FROM_REG(val)	((val)?1:0)
+#define BEEP_MASK_FROM_REG(val)		((val) & 0xff7fff)
+#define BEEP_MASK_TO_REG(val)		((val) & 0xff7fff)
 
 #define DIV_FROM_REG(val) (1 << (val))
 
@@ -367,7 +365,6 @@ struct w83627hf_data {
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
 	u32 beep_mask;		/* Register encoding, combined */
-	u8 beep_enable;		/* Boolean */
 	u8 pwm[3];		/* Register value */
 	u8 pwm_freq[3];		/* Register value */
 	u16 sens[3];		/* 1 = pentium diode; 2 = 3904 diode;
@@ -740,65 +737,41 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);
 
-#define show_beep_reg(REG, reg) \
-static ssize_t show_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct w83627hf_data *data = w83627hf_update_device(dev); \
-	return sprintf(buf,"%ld\n", \
-		      (long)BEEP_##REG##_FROM_REG(data->beep_##reg)); \
-}
-show_beep_reg(ENABLE, enable)
-show_beep_reg(MASK, mask)
-
-#define BEEP_ENABLE			0	/* Store beep_enable */
-#define BEEP_MASK			1	/* Store beep_mask */
+static ssize_t
+show_beep_mask(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return sprintf(buf, "%ld\n",
+		      (long)BEEP_MASK_FROM_REG(data->beep_mask));
+}
 
 static ssize_t
-store_beep_reg(struct device *dev, const char *buf, size_t count,
-	       int update_mask)
+store_beep_mask(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	u32 val, val2;
+	unsigned long val;
 
 	val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 
-	if (update_mask = BEEP_MASK) {	/* We are storing beep_mask */
-		data->beep_mask = BEEP_MASK_TO_REG(val);
-		w83627hf_write_value(data, W83781D_REG_BEEP_INTS1,
-				    data->beep_mask & 0xff);
-		w83627hf_write_value(data, W83781D_REG_BEEP_INTS3,
-				    ((data->beep_mask) >> 16) & 0xff);
-		val2 = (data->beep_mask >> 8) & 0x7f;
-	} else {		/* We are storing beep_enable */
-		val2 -		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS2) & 0x7f;
-		data->beep_enable = BEEP_ENABLE_TO_REG(val);
-	}
-
+	/* preserve beep enable */
+	data->beep_mask = (data->beep_mask & 0x8000)
+			| BEEP_MASK_TO_REG(val);
+	w83627hf_write_value(data, W83781D_REG_BEEP_INTS1,
+			    data->beep_mask & 0xff);
+	w83627hf_write_value(data, W83781D_REG_BEEP_INTS3,
+			    ((data->beep_mask) >> 16) & 0xff);
 	w83627hf_write_value(data, W83781D_REG_BEEP_INTS2,
-			    val2 | data->beep_enable << 7);
+			    (data->beep_mask >> 8) & 0xff);
 
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-#define sysfs_beep(REG, reg) \
-static ssize_t show_regs_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_beep_##reg(dev, attr, buf); \
-} \
-static ssize_t \
-store_regs_beep_##reg (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	return store_beep_reg(dev, buf, count, BEEP_##REG); \
-} \
-static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, \
-		  show_regs_beep_##reg, store_regs_beep_##reg);
-
-sysfs_beep(ENABLE, enable);
-sysfs_beep(MASK, mask);
+static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
+		   show_beep_mask, store_beep_mask);
 
 static ssize_t
 show_beep(struct device *dev, struct device_attribute *attr, char *buf)
@@ -884,6 +857,8 @@ static SENSOR_DEVICE_ATTR(temp2_beep, S_
 			show_beep, store_beep, 5);
 static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO | S_IWUSR,
 			show_beep, store_beep, 13);
+static SENSOR_DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 15);
 
 static ssize_t
 show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
@@ -1223,7 +1198,7 @@ static struct attribute *w83627hf_attrib
 	TEMP_UNIT_ATTRS(2),
 
 	&dev_attr_alarms.attr,
-	&dev_attr_beep_enable.attr,
+	&sensor_dev_attr_beep_enable.dev_attr.attr,
 	&dev_attr_beep_mask.attr,
 
 	&sensor_dev_attr_pwm1.dev_attr.attr,
@@ -1748,8 +1723,7 @@ static struct w83627hf_data *w83627hf_up
 		    (w83627hf_read_value(data, W83781D_REG_ALARM2) << 8) |
 		    (w83627hf_read_value(data, W83781D_REG_ALARM3) << 16);
 		i = w83627hf_read_value(data, W83781D_REG_BEEP_INTS2);
-		data->beep_enable = i >> 7;
-		data->beep_mask = ((i & 0x7f) << 8) |
+		data->beep_mask = (i << 8) |
 		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS1) |
 		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS3) << 16;
 		data->last_updated = jiffies;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
