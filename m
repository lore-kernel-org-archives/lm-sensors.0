From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:02:41 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (w83627hf) Fix various checkpatch errors and warnings
Message-Id: <1363219364-5221-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixes:
WARNING: please, no space before tabs
ERROR: code indent should use tabs where possible
WARNING: please, no spaces at the start of a line
ERROR: space prohibited after that open parenthesis '('
ERROR: spaces required before/around/after (various)
WARNING: line over 80 characters
ERROR: trailing whitespace
WARNING: quoted string split across lines
WARNING: static const char * array should probably be static const char * const

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627hf.c |  103 ++++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 3b9ef2d..83f674a 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -218,11 +218,11 @@ static const u8 W83627THF_PWM_ENABLE_SHIFT[] = { 2, 4, 1 };
 #define W83627THF_REG_PWM2		0x03	/* 697HF/637HF/687THF too */
 #define W83627THF_REG_PWM3		0x11	/* 637HF/687THF too */
 
-#define W83627THF_REG_VRM_OVT_CFG 	0x18	/* 637HF/687THF too */
+#define W83627THF_REG_VRM_OVT_CFG	0x18	/* 637HF/687THF too */
 
 static const u8 regpwm_627hf[] = { W83627HF_REG_PWM1, W83627HF_REG_PWM2 };
 static const u8 regpwm[] = { W83627THF_REG_PWM1, W83627THF_REG_PWM2,
-                             W83627THF_REG_PWM3 };
+			     W83627THF_REG_PWM3 };
 #define W836X7HF_REG_PWM(type, nr) (((type) = w83627hf) ? \
 				    regpwm_627hf[nr] : regpwm[nr])
 
@@ -265,8 +265,8 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define TEMP_MIN (-128000)
-#define TEMP_MAX ( 127000)
+#define TEMP_MIN	(-128000)
+#define TEMP_MAX	127000
 
 /*
  * TEMP: 0.001C/bit (-128C to +127C)
@@ -281,10 +281,11 @@ static u8 TEMP_TO_REG(long temp)
 
 static int TEMP_FROM_REG(u8 reg)
 {
-        return (s8)reg * 1000;
+	return (s8)reg * 1000;
 }
 
-#define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
+#define FAN_FROM_REG(val, div) ((val) = 0 ? -1 \
+				: (val) = 255 ? 0 : 1350000 / ((val) * (div)))
 
 #define PWM_TO_REG(val) (clamp_val((val), 0, 255))
 
@@ -573,29 +574,33 @@ static ssize_t show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
 		/* use VRM8 (standard) calculation */
 		in0 = (long)IN_FROM_REG(reg);
 
-	return sprintf(buf,"%ld\n", in0);
+	return sprintf(buf, "%ld\n", in0);
 }
 
-static ssize_t show_regs_in_0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_regs_in_0(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in[0]);
 }
 
-static ssize_t show_regs_in_min0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_regs_in_min0(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in_min[0]);
 }
 
-static ssize_t show_regs_in_max0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_regs_in_max0(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in_max[0]);
 }
 
-static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t count)
+static ssize_t store_regs_in_min0(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -606,7 +611,7 @@ static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *a
 		return err;
 
 	mutex_lock(&data->update_lock);
-	
+
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf = data->type || w83637hf = data->type
 		 || w83687thf = data->type))
@@ -623,8 +628,9 @@ static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *a
 	return count;
 }
 
-static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t count)
+static ssize_t store_regs_in_max0(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -639,7 +645,7 @@ static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *a
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf = data->type || w83637hf = data->type
 		 || w83687thf = data->type))
-		
+
 		/* use VRM9 calculation */
 		data->in_max[0]  			clamp_val(((val * 100) - 70000 + 244) / 488, 0, 255);
@@ -787,7 +793,7 @@ store_temp_max_hyst(struct device *dev, struct device_attribute *devattr,
 #define sysfs_temp_decl(offset) \
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
 			  show_temp, NULL, offset - 1);			\
-static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO|S_IWUSR,	 	\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO|S_IWUSR,		\
 			  show_temp_max, store_temp_max, offset - 1);	\
 static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO|S_IWUSR,	\
 			  show_temp_max_hyst, store_temp_max_hyst, offset - 1);
@@ -802,6 +808,7 @@ show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
+
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t
@@ -810,8 +817,10 @@ show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
+
 static ssize_t
-store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -824,6 +833,7 @@ store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf
 
 	return count;
 }
+
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
 static ssize_t
@@ -832,6 +842,7 @@ show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->alarms);
 }
+
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 
 static ssize_t
@@ -841,6 +852,7 @@ show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
+
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
 static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
@@ -1024,10 +1036,12 @@ store_fan_div(struct device *dev, struct device_attribute *devattr,
 
 	data->fan_div[nr] = DIV_TO_REG(val);
 
-	reg = (w83627hf_read_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
-	       & (nr=0 ? 0xcf : 0x3f))
-	    | ((data->fan_div[nr] & 0x03) << (nr=0 ? 4 : 6));
-	w83627hf_write_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
+	reg = (w83627hf_read_value(data, nr = 2 ? W83781D_REG_PIN
+						 : W83781D_REG_VID_FANDIV)
+	       & (nr = 0 ? 0xcf : 0x3f))
+	    | ((data->fan_div[nr] & 0x03) << (nr = 0 ? 4 : 6));
+	w83627hf_write_value(data, nr = 2 ? W83781D_REG_PIN
+					   : W83781D_REG_VID_FANDIV, reg);
 
 	reg = (w83627hf_read_value(data, W83781D_REG_VBAT)
 	       & ~(1 << (5 + nr)))
@@ -1155,7 +1169,7 @@ store_pwm_freq(struct device *dev, struct device_attribute *devattr,
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = dev_get_drvdata(dev);
-	static const u8 mask[]={0xF8, 0x8F};
+	static const u8 mask[] = {0xF8, 0x8F};
 	unsigned long val;
 	int err;
 
@@ -1233,8 +1247,9 @@ store_temp_type(struct device *dev, struct device_attribute *devattr,
 		data->sens[nr] = val;
 		break;
 	case W83781D_DEFAULT_BETA:
-		dev_warn(dev, "Sensor type %d is deprecated, please use 4 "
-			 "instead\n", W83781D_DEFAULT_BETA);
+		dev_warn(dev,
+			 "Sensor type %d is deprecated, please use 4 instead\n",
+			 W83781D_DEFAULT_BETA);
 		/* fall through */
 	case 4:		/* thermistor */
 		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
@@ -1420,7 +1435,7 @@ static int w83627hf_probe(struct platform_device *pdev)
 	struct resource *res;
 	int err, i;
 
-	static const char *names[] = {
+	static const char * const names[] = {
 		"w83627hf",
 		"w83627thf",
 		"w83697hf",
@@ -1654,8 +1669,8 @@ static int w83627thf_read_gpio5(struct platform_device *pdev)
 	 */
 	sel = superio_inb(sio_data, W83627THF_GPIO5_IOSR) & 0x3f;
 	if ((sel & 0x1f) != 0x1f) {
-		dev_dbg(&pdev->dev, "GPIO5 not configured for VID "
-			"function\n");
+		dev_dbg(&pdev->dev,
+			"GPIO5 not configured for VID function\n");
 		goto exit;
 	}
 
@@ -1683,8 +1698,8 @@ static int w83687thf_read_vid(struct platform_device *pdev)
 
 	/* Make sure the pins are configured for input */
 	if (!(superio_inb(sio_data, W83687THF_VID_CFG) & (1 << 4))) {
-		dev_dbg(&pdev->dev, "VID configured as output, "
-			"no VID function\n");
+		dev_dbg(&pdev->dev,
+			"VID configured as output, no VID function\n");
 		goto exit;
 	}
 
@@ -1747,7 +1762,7 @@ static void w83627hf_init_device(struct platform_device *pdev)
 
 	/* Read VRM & OVT Config only once */
 	if (type = w83627thf || type = w83637hf || type = w83687thf) {
-		data->vrm_ovt = 
+		data->vrm_ovt  			w83627hf_read_value(data, W83627THF_REG_VRM_OVT_CFG);
 	}
 
@@ -1767,12 +1782,12 @@ static void w83627hf_init_device(struct platform_device *pdev)
 			break;
 	}
 
-	if(init) {
+	if (init) {
 		/* Enable temp2 */
 		tmp = w83627hf_read_value(data, W83627HF_REG_TEMP2_CONFIG);
 		if (tmp & 0x01) {
-			dev_warn(&pdev->dev, "Enabling temp2, readings "
-				 "might not make sense\n");
+			dev_warn(&pdev->dev,
+				 "Enabling temp2, readings might not make sense\n");
 			w83627hf_write_value(data, W83627HF_REG_TEMP2_CONFIG,
 				tmp & 0xfe);
 		}
@@ -1782,8 +1797,8 @@ static void w83627hf_init_device(struct platform_device *pdev)
 			tmp = w83627hf_read_value(data,
 				W83627HF_REG_TEMP3_CONFIG);
 			if (tmp & 0x01) {
-				dev_warn(&pdev->dev, "Enabling temp3, "
-					 "readings might not make sense\n");
+				dev_warn(&pdev->dev,
+					 "Enabling temp3, readings might not make sense\n");
 				w83627hf_write_value(data,
 					W83627HF_REG_TEMP3_CONFIG, tmp & 0xfe);
 			}
@@ -1855,8 +1870,8 @@ static struct w83627hf_data *w83627hf_update_device(struct device *dev)
 		for (i = 0; i <= 2; i++) {
 			u8 tmp = w83627hf_read_value(data,
 				W836X7HF_REG_PWM(data->type, i));
- 			/* bits 0-3 are reserved  in 627THF */
- 			if (data->type = w83627thf)
+			/* bits 0-3 are reserved  in 627THF */
+			if (data->type = w83627thf)
 				tmp &= 0xf0;
 			data->pwm[i] = tmp;
 			if (i = 1 &&
@@ -1887,12 +1902,12 @@ static struct w83627hf_data *w83627hf_update_device(struct device *dev)
 			}
 		}
 		for (i = 0; i < num_temps; i++) {
-			data->temp[i] = w83627hf_read_value(
-						data, w83627hf_reg_temp[i]);
-			data->temp_max[i] = w83627hf_read_value(
-						data, w83627hf_reg_temp_over[i]);
-			data->temp_max_hyst[i] = w83627hf_read_value(
-						data, w83627hf_reg_temp_hyst[i]);
+			data->temp[i] +			  w83627hf_read_value(data, w83627hf_reg_temp[i]);
+			data->temp_max[i] +			  w83627hf_read_value(data, w83627hf_reg_temp_over[i]);
+			data->temp_max_hyst[i] +			  w83627hf_read_value(data, w83627hf_reg_temp_hyst[i]);
 		}
 
 		w83627hf_update_fan_div(data);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
