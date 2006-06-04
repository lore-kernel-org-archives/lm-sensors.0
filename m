From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 18:18:05 +0000
Subject: [lm-sensors] [PATCH 07/11] w83792d: Fix setting the PWM value
Message-Id: <20060604201805.49585bea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Yuan Mu <ymu at winbond.com.tw>
Content-Disposition: inline; filename=hwmon-w83792d-pwm-set-fix.patch

W83792D use pwm register low 4 bits to store PWM/DC value, bit 7
is used to store fan PWM/DC mode. The store_pwm function did not
convert the pwm input correctly, so it may change the fan mode
when new value is set.

This fix the problem. Change the "index" value of pwm*_mode
and pwm* SENSOR_ATTR to simplify code.

Signed-off-by: Yuan Mu <ymu at winbond.com.tw>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/w83792d.c |   56 ++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

--- linux-2.6.17-rc5.orig/drivers/hwmon/w83792d.c	2006-04-19 08:46:25.000000000 +0200
+++ linux-2.6.17-rc5/drivers/hwmon/w83792d.c	2006-05-30 08:51:24.000000000 +0200
@@ -250,8 +250,6 @@
 			: (val)) / 1000, 0, 0xff))
 #define TEMP_ADD_TO_REG_LOW(val)	((val%1000) ? 0x80 : 0x00)
 
-#define PWM_FROM_REG(val)		(val)
-#define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
 #define DIV_FROM_REG(val)		(1 << (val))
 
 static inline u8
@@ -291,7 +289,6 @@
 	u8 pwm[7];		/* We only consider the first 3 set of pwm,
 				   although 792 chip has 7 set of pwm. */
 	u8 pwmenable[3];
-	u8 pwm_mode[7];		/* indicates PWM or DC mode: 1->PWM; 0->DC */
 	u32 alarms;		/* realtime status register encoding,combined */
 	u8 chassis;		/* Chassis status */
 	u8 chassis_clear;	/* CLR_CHS, clear chassis intrusion detection */
@@ -627,7 +624,7 @@
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr-1]));
+	return sprintf(buf, "%d\n", (data->pwm[nr] & 0x0f) << 4);
 }
 
 static ssize_t
@@ -659,14 +656,16 @@
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index - 1;
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
+	u8 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255) >> 4;
 
-	val = simple_strtoul(buf, NULL, 10);
-	data->pwm[nr] = PWM_TO_REG(val);
+	mutex_lock(&data->update_lock);
+	val |= w83792d_read_value(client, W83792D_REG_PWM[nr]) & 0xf0;
+	data->pwm[nr] = val;
 	w83792d_write_value(client, W83792D_REG_PWM[nr], data->pwm[nr]);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
@@ -707,9 +706,9 @@
 }
 
 static struct sensor_device_attribute sda_pwm[] = {
-	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1),
-	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2),
-	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3),
+	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0),
+	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1),
+	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2),
 };
 static struct sensor_device_attribute sda_pwm_enable[] = {
 	SENSOR_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
@@ -728,7 +727,7 @@
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%d\n", data->pwm_mode[nr-1]);
+	return sprintf(buf, "%d\n", data->pwm[nr] >> 7);
 }
 
 static ssize_t
@@ -736,29 +735,35 @@
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index - 1;
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
 	u32 val;
-	u8 pwm_mode_mask = 0;
 
 	val = simple_strtoul(buf, NULL, 10);
-	data->pwm_mode[nr] = SENSORS_LIMIT(val, 0, 1);
-	pwm_mode_mask = w83792d_read_value(client,
-		W83792D_REG_PWM[nr]) & 0x7f;
-	w83792d_write_value(client, W83792D_REG_PWM[nr],
-		((data->pwm_mode[nr]) << 7) | pwm_mode_mask);
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->pwm[nr] = w83792d_read_value(client, W83792D_REG_PWM[nr]);
+	if (val) {			/* PWM mode */
+		data->pwm[nr] |= 0x80;
+	} else {			/* DC mode */
+		data->pwm[nr] &= 0x7f;
+	}
+	w83792d_write_value(client, W83792D_REG_PWM[nr], data->pwm[nr]);
+	mutex_unlock(&data->update_lock);
 
 	return count;
 }
 
 static struct sensor_device_attribute sda_pwm_mode[] = {
 	SENSOR_ATTR(pwm1_mode, S_IWUSR | S_IRUGO,
-		    show_pwm_mode, store_pwm_mode, 1),
+		    show_pwm_mode, store_pwm_mode, 0),
 	SENSOR_ATTR(pwm2_mode, S_IWUSR | S_IRUGO,
-		    show_pwm_mode, store_pwm_mode, 2),
+		    show_pwm_mode, store_pwm_mode, 1),
 	SENSOR_ATTR(pwm3_mode, S_IWUSR | S_IRUGO,
-		    show_pwm_mode, store_pwm_mode, 3),
+		    show_pwm_mode, store_pwm_mode, 2),
 };
 
 
@@ -1373,7 +1378,7 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
 	int i, j;
-	u8 reg_array_tmp[4], pwm_array_tmp[7], reg_tmp;
+	u8 reg_array_tmp[4], reg_tmp;
 
 	mutex_lock(&data->update_lock);
 
@@ -1402,10 +1407,8 @@
 			data->fan_min[i] = w83792d_read_value(client,
 						W83792D_REG_FAN_MIN[i]);
 			/* Update the PWM/DC Value and PWM/DC flag */
-			pwm_array_tmp[i] = w83792d_read_value(client,
+			data->pwm[i] = w83792d_read_value(client,
 						W83792D_REG_PWM[i]);
-			data->pwm[i] = pwm_array_tmp[i] & 0x0f;
-			data->pwm_mode[i] = pwm_array_tmp[i] >> 7;
 		}
 
 		reg_tmp = w83792d_read_value(client, W83792D_REG_FAN_CFG);
@@ -1513,7 +1516,6 @@
 		dev_dbg(dev, "fan[%d] is: 0x%x\n", i, data->fan[i]);
 		dev_dbg(dev, "fan[%d] min is: 0x%x\n", i, data->fan_min[i]);
 		dev_dbg(dev, "pwm[%d]     is: 0x%x\n", i, data->pwm[i]);
-		dev_dbg(dev, "pwm_mode[%d] is: 0x%x\n", i, data->pwm_mode[i]);
 	}
 	dev_dbg(dev, "3 set of Temperatures: ===>\n");
 	for (i=0; i<3; i++) {

-- 
Jean Delvare

