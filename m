From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Jul 2005 21:48:16 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: kill cast abuses
Message-Id: <20050729214552.041842e4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Some hardware monitoring drivers use needless casts to long.
Especially, three Winbond drivers use many of them. Let's clean this
up for the sake of code readability, if nothing else.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/adm1026.c  |    2 +-
 drivers/hwmon/it87.c     |    4 ++--
 drivers/hwmon/lm85.c     |    4 ++--
 drivers/hwmon/w83627hf.c |   29 ++++++++++++++---------------
 drivers/hwmon/w83781d.c  |   29 ++++++++++++++---------------
 drivers/hwmon/w83792d.c  |   14 +++++++-------
 6 files changed, 40 insertions(+), 42 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/adm1026.c	2005-07-29 21:11:38.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/adm1026.c	2005-07-29 21:12:00.000000000 +0200
@@ -1252,7 +1252,7 @@
 static ssize_t show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) (data->alarms));
+	return sprintf(buf, "%ld\n", data->alarms);
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
--- linux-2.6.13-rc3.orig/drivers/hwmon/it87.c	2005-07-29 21:11:38.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/it87.c	2005-07-29 21:12:00.000000000 +0200
@@ -662,7 +662,7 @@
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
+	return sprintf(buf, "%d\n", data->vrm);
 }
 static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
@@ -684,7 +684,7 @@
 show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
--- linux-2.6.13-rc3.orig/drivers/hwmon/lm85.c	2005-07-29 21:11:38.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm85.c	2005-07-29 21:12:00.000000000 +0200
@@ -444,7 +444,7 @@
 static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
@@ -452,7 +452,7 @@
 static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
+	return sprintf(buf, "%u\n", data->vrm);
 }
 
 static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83627hf.c	2005-07-29 21:11:37.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83627hf.c	2005-07-29 21:23:52.000000000 +0200
@@ -338,7 +338,7 @@
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
 	struct w83627hf_data *data = w83627hf_update_device(dev); \
-	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->reg[nr])); \
 }
 show_in_reg(in)
 show_in_reg(in_min)
@@ -410,10 +410,10 @@
 		(w83627thf = data->type || w83637hf = data->type))
 
 		/* use VRM9 calculation */
-		in0 = (long)((reg * 488 + 70000 + 50) / 100);
+		in0 = (reg * 488 + 70000 + 50) / 100;
 	else
 		/* use VRM8 (standard) calculation */
-		in0 = (long)IN_FROM_REG(reg);
+		in0 = IN_FROM_REG(reg);
 
 	return sprintf(buf,"%ld\n", in0);
 }
@@ -567,10 +567,10 @@
 { \
 	struct w83627hf_data *data = w83627hf_update_device(dev); \
 	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
-		return sprintf(buf,"%ld\n", \
-			(long)LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
+		return sprintf(buf, "%d\n", \
+			LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
 	} else {	/* TEMP1 */ \
-		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
+		return sprintf(buf, "%d\n", TEMP_FROM_REG(data->reg)); \
 	} \
 }
 show_temp_reg(temp);
@@ -647,7 +647,7 @@
 show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
@@ -657,7 +657,7 @@
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
+	return sprintf(buf, "%u\n", data->vrm);
 }
 static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
@@ -679,7 +679,7 @@
 show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->alarms);
+	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 #define device_create_file_alarms(client) \
@@ -756,8 +756,7 @@
 show_fan_div_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return sprintf(buf, "%ld\n",
-		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr - 1]));
 }
 
 /* Note: we save and restore the fan minimum here, because its value is
@@ -826,7 +825,7 @@
 show_pwm_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->pwm[nr - 1]);
+	return sprintf(buf, "%u\n", data->pwm[nr - 1]);
 }
 
 static ssize_t
@@ -885,7 +884,7 @@
 show_sensor_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
+	return sprintf(buf, "%u\n", data->sens[nr - 1]);
 }
 
 static ssize_t
@@ -926,8 +925,8 @@
 		break;
 	default:
 		dev_err(&client->dev,
-		       "Invalid sensor type %ld; must be 1, 2, or %d\n",
-		       (long) val, W83781D_DEFAULT_BETA);
+			"Invalid sensor type %u; must be 1, 2, or %d\n",
+			val, W83781D_DEFAULT_BETA);
 		break;
 	}
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83781d.c	2005-07-29 21:11:38.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83781d.c	2005-07-29 21:24:54.000000000 +0200
@@ -291,7 +291,7 @@
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
 	struct w83781d_data *data = w83781d_update_device(dev); \
-	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->reg[nr] * 10)); \
 }
 show_in_reg(in);
 show_in_reg(in_min);
@@ -425,7 +425,7 @@
 		return sprintf(buf,"%d\n", \
 			LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
 	} else {	/* TEMP1 */ \
-		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
+		return sprintf(buf, "%d\n", TEMP_FROM_REG(data->reg)); \
 	} \
 }
 show_temp_reg(temp);
@@ -498,7 +498,7 @@
 show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 
 static
@@ -509,7 +509,7 @@
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
+	return sprintf(buf, "%u\n", data->vrm);
 }
 
 static ssize_t
@@ -543,14 +543,14 @@
 static ssize_t show_beep_mask (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n",
-		       (long)BEEP_MASK_FROM_REG(data->beep_mask, data->type));
+	return sprintf(buf, "%u\n",
+		       BEEP_MASK_FROM_REG(data->beep_mask, data->type));
 }
 static ssize_t show_beep_enable (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n",
-		       (long)BEEP_ENABLE_FROM_REG(data->beep_enable));
+	return sprintf(buf, "%u\n",
+		       BEEP_ENABLE_FROM_REG(data->beep_enable));
 }
 
 #define BEEP_ENABLE			0	/* Store beep_enable */
@@ -615,8 +615,7 @@
 show_fan_div_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n",
-		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
+	return sprintf(buf, "%u\n", DIV_FROM_REG(data->fan_div[nr - 1]));
 }
 
 /* Note: we save and restore the fan minimum here, because its value is
@@ -685,14 +684,14 @@
 show_pwm_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr - 1]));
+	return sprintf(buf, "%u\n", PWM_FROM_REG(data->pwm[nr - 1]));
 }
 
 static ssize_t
 show_pwmenable_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->pwmenable[nr - 1]);
+	return sprintf(buf, "%u\n", data->pwmenable[nr - 1]);
 }
 
 static ssize_t
@@ -791,7 +790,7 @@
 show_sensor_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
+	return sprintf(buf, "%u\n", data->sens[nr - 1]);
 }
 
 static ssize_t
@@ -831,8 +830,8 @@
 		data->sens[nr - 1] = val;
 		break;
 	default:
-		dev_err(dev, "Invalid sensor type %ld; must be 1, 2, or %d\n",
-		       (long) val, W83781D_DEFAULT_BETA);
+		dev_err(dev, "Invalid sensor type %u; must be 1, 2, or %d\n",
+			val, W83781D_DEFAULT_BETA);
 		break;
 	}
 
--- linux-2.6.13-rc3.orig/drivers/hwmon/w83792d.c	2005-07-29 21:11:38.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/w83792d.c	2005-07-29 21:12:05.000000000 +0200
@@ -376,7 +376,7 @@
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
 	int nr = sensor_attr->index; \
 	struct w83792d_data *data = w83792d_update_device(dev); \
-	return sprintf(buf,"%ld\n", (long)(IN_FROM_REG(nr, (data->reg[nr])*4))); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(nr, (data->reg[nr])*4)); \
 }
 
 show_in_reg(in_min);
@@ -583,8 +583,8 @@
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf,"%ld\n",
-		(long)TEMP_ADD_FROM_REG(data->temp_add[nr][index], 
+	return sprintf(buf, "%d\n",
+		TEMP_ADD_FROM_REG(data->temp_add[nr][index],
 			data->temp_add[nr][index+1]));
 }
 
@@ -652,7 +652,7 @@
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr-1]));
+	return sprintf(buf, "%u\n", PWM_FROM_REG(data->pwm[nr-1]));
 }
 
 static ssize_t
@@ -859,7 +859,7 @@
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long)data->thermal_cruise[nr-1]);
+	return sprintf(buf, "%u\n", data->thermal_cruise[nr-1]);
 }
 
 static ssize_t
@@ -907,7 +907,7 @@
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long)data->tolerance[nr-1]);
+	return sprintf(buf, "%u\n", data->tolerance[nr-1]);
 }
 
 static ssize_t
@@ -959,7 +959,7 @@
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long)data->sf2_points[index-1][nr-1]);
+	return sprintf(buf, "%u\n", data->sf2_points[index-1][nr-1]);
 }
 
 static ssize_t


-- 
Jean Delvare
