From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 18:22:22 +0000
Subject: [lm-sensors] [PATCH 1/6] hwmon: (w83781d) Refactor beep enable
Message-Id: <20081007202222.4b7c83ad@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We can handle the beep enable bit as any other beep mask bit for
slightly smaller code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
---
This is the same change as was done on the w83627hf driver several
months ago.

 drivers/hwmon/w83781d.c |   46 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

--- linux-2.6.25-rc4.orig/drivers/hwmon/w83781d.c	2008-03-09 11:19:57.000000000 +0100
+++ linux-2.6.25-rc4/drivers/hwmon/w83781d.c	2008-03-09 11:19:58.000000000 +0100
@@ -178,9 +178,9 @@ FAN_FROM_REG(u8 val, int div)
 #define TEMP_FROM_REG(val)		((val) * 1000)
 
 #define BEEP_MASK_FROM_REG(val,type)	((type) = as99127f ? \
-					 (val) ^ 0x7fff : (val))
+					 (~(val)) & 0x7fff : (val) & 0xff7fff)
 #define BEEP_MASK_TO_REG(val,type)	((type) = as99127f ? \
-					 (~(val)) & 0x7fff : (val) & 0xffffff)
+					 (~(val)) & 0x7fff : (val) & 0xff7fff)
 
 #define DIV_FROM_REG(val)		(1 << (val))
 
@@ -240,7 +240,6 @@ struct w83781d_data {
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
 	u32 beep_mask;		/* Register encoding, combined */
-	u8 beep_enable;		/* Boolean */
 	u8 pwm[4];		/* Register value */
 	u8 pwm2_enable;		/* Boolean */
 	u16 sens[3];		/* 782D/783S only.
@@ -513,11 +512,6 @@ static ssize_t show_beep_mask (struct de
 	return sprintf(buf, "%ld\n",
 		       (long)BEEP_MASK_FROM_REG(data->beep_mask, data->type));
 }
-static ssize_t show_beep_enable (struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long)data->beep_enable);
-}
 
 static ssize_t
 store_beep_mask(struct device *dev, struct device_attribute *attr,
@@ -529,12 +523,12 @@ store_beep_mask(struct device *dev, stru
 	val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->beep_mask = BEEP_MASK_TO_REG(val, data->type);
+	data->beep_mask &= 0x8000; /* preserve beep enable */
+	data->beep_mask |= BEEP_MASK_TO_REG(val, data->type);
 	w83781d_write_value(data, W83781D_REG_BEEP_INTS1,
 			    data->beep_mask & 0xff);
 	w83781d_write_value(data, W83781D_REG_BEEP_INTS2,
-			    ((data->beep_mask >> 8) & 0x7f)
-			    | data->beep_enable << 7);
+			    (data->beep_mask >> 8) & 0xff);
 	if (data->type != w83781d && data->type != as99127f) {
 		w83781d_write_value(data, W83781D_REG_BEEP_INTS3,
 				    ((data->beep_mask) >> 16) & 0xff);
@@ -544,31 +538,8 @@ store_beep_mask(struct device *dev, stru
 	return count;
 }
 
-static ssize_t
-store_beep_enable(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct w83781d_data *data = dev_get_drvdata(dev);
-	u32 val;
-
-	val = simple_strtoul(buf, NULL, 10);
-	if (val != 0 && val != 1)
-		return -EINVAL;
-
-	mutex_lock(&data->update_lock);
-	data->beep_enable = val;
-	val = w83781d_read_value(data, W83781D_REG_BEEP_INTS2) & 0x7f;
-	val |= data->beep_enable << 7;
-	w83781d_write_value(data, W83781D_REG_BEEP_INTS2, val);
-	mutex_unlock(&data->update_lock);
-
-	return count;
-}
-
 static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
 		show_beep_mask, store_beep_mask);
-static DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
-		show_beep_enable, store_beep_enable);
 
 static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -663,6 +634,8 @@ static SENSOR_DEVICE_ATTR(temp2_beep, S_
 			show_beep, store_beep, 5);
 static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO,
 			show_temp3_beep, store_beep, 13);
+static SENSOR_DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 15);
 
 static ssize_t
 show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
@@ -1029,7 +1002,7 @@ static struct attribute* w83781d_attribu
 	&dev_attr_vrm.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_beep_mask.attr,
-	&dev_attr_beep_enable.attr,
+	&sensor_dev_attr_beep_enable.dev_attr.attr,
 	NULL
 };
 static const struct attribute_group w83781d_group = {
@@ -1775,8 +1748,7 @@ static struct w83781d_data *w83781d_upda
 						W83781D_REG_ALARM2) << 8);
 		}
 		i = w83781d_read_value(data, W83781D_REG_BEEP_INTS2);
-		data->beep_enable = i >> 7;
-		data->beep_mask = ((i & 0x7f) << 8) +
+		data->beep_mask = (i << 8) +
 		    w83781d_read_value(data, W83781D_REG_BEEP_INTS1);
 		if ((data->type != w83781d) && (data->type != as99127f)) {
 			data->beep_mask |
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
