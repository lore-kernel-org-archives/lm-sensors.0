From: ymu@Winbond.com.tw (Yuan Mu)
Date: Tue, 30 May 2006 02:12:44 +0000
Subject: [lm-sensors] [PATCH] Fix the set pwm value will change fan mode
Message-Id: <447BAA1C.3070901@winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <444610F0.1070809@winbond.com.tw>
In-Reply-To: <444610F0.1070809@winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Here comes the patch, please can you check, i add the lock and allow fan
pwm input range 0-255 here, the write also unconditional, please can you check :)



W83792D use pwm register low 4 bits to store PWM/DC value, bit 7 is used to store fan PWM/DC mode,
The store_pwm function did not convert the pwm input correctly, so it may change the fan mode when new value is set.

This fix the problem. Change the "index" value of pwm*_mode and pwm* SENSOR_ATTR to simplify code.


Signed-off-by: Yuan Mu <ymu at winbond.com.tw>
---
 w83792d.c |   59 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

--- linux-2.6.17-rc5.orig/drivers/hwmon/w83792d.c	2006-05-29 14:43:09.000000000 +0800
+++ linux-2.6.17-rc5/drivers/hwmon/w83792d.c	2006-05-30 10:00:42.000000000 +0800
@@ -250,8 +250,6 @@ FAN_TO_REG(long rpm, int div)
 			: (val)) / 1000, 0, 0xff))
 #define TEMP_ADD_TO_REG_LOW(val)	((val%1000) ? 0x80 : 0x00)

-#define PWM_FROM_REG(val)		(val)
-#define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
 #define DIV_FROM_REG(val)		(1 << (val))

 static inline u8
@@ -291,7 +289,6 @@ struct w83792d_data {
 	u8 pwm[7];		/* We only consider the first 3 set of pwm,
 				   although 792 chip has 7 set of pwm. */
 	u8 pwmenable[3];
-	u8 pwm_mode[7];		/* indicates PWM or DC mode: 1->PWM; 0->DC */
 	u32 alarms;		/* realtime status register encoding,combined */
 	u8 chassis;		/* Chassis status */
 	u8 chassis_clear;	/* CLR_CHS, clear chassis intrusion detection */
@@ -627,7 +624,7 @@ show_pwm(struct device *dev, struct devi
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr-1]));
+	return sprintf(buf, "%d\n", (data->pwm[nr] & 0x0f) << 4);
 }

 static ssize_t
@@ -659,14 +656,16 @@ store_pwm(struct device *dev, struct dev
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
@@ -707,9 +706,9 @@ store_pwmenable(struct device *dev, stru
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
@@ -728,7 +727,7 @@ show_pwm_mode(struct device *dev, struct
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct w83792d_data *data = w83792d_update_device(dev);
-	return sprintf(buf, "%d\n", data->pwm_mode[nr-1]);
+	return sprintf(buf, "%d\n", data->pwm[nr] >> 7);
 }

 static ssize_t
@@ -736,29 +735,34 @@ store_pwm_mode(struct device *dev, struc
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	int nr = sensor_attr->index - 1;
+	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
-	u32 val;
-	u8 pwm_mode_mask = 0;
+	u32 val = simple_strtoul(buf, NULL, 10);

-	val = simple_strtoul(buf, NULL, 10);
-	data->pwm_mode[nr] = SENSORS_LIMIT(val, 0, 1);
-	pwm_mode_mask = w83792d_read_value(client,
-		W83792D_REG_PWM[nr]) & 0x7f;
-	w83792d_write_value(client, W83792D_REG_PWM[nr],
-		((data->pwm_mode[nr]) << 7) | pwm_mode_mask);
+	mutex_lock(&data->update_lock);
+	data->pwm[nr] = w83792d_read_value(client, W83792D_REG_PWM[nr]);
+	if (0 = val) {			/* DC mode */
+		data->pwm[nr] &= 0x7f;
+	} else if (1 = val) {		/* PWM mode */
+		data->pwm[nr] = (data->pwm[nr] & 0x7f) | 0x80;
+	} else {
+		return -EINVAL;
+	}
+
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


@@ -1373,7 +1377,7 @@ static struct w83792d_data *w83792d_upda
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
 	int i, j;
-	u8 reg_array_tmp[4], pwm_array_tmp[7], reg_tmp;
+	u8 reg_array_tmp[4], reg_tmp;

 	mutex_lock(&data->update_lock);

@@ -1402,10 +1406,8 @@ static struct w83792d_data *w83792d_upda
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
@@ -1513,7 +1515,6 @@ static void w83792d_print_debug(struct w
 		dev_dbg(dev, "fan[%d] is: 0x%x\n", i, data->fan[i]);
 		dev_dbg(dev, "fan[%d] min is: 0x%x\n", i, data->fan_min[i]);
 		dev_dbg(dev, "pwm[%d]     is: 0x%x\n", i, data->pwm[i]);
-		dev_dbg(dev, "pwm_mode[%d] is: 0x%x\n", i, data->pwm_mode[i]);
 	}
 	dev_dbg(dev, "3 set of Temperatures: ===>\n");
 	for (i=0; i<3; i++) {


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
If your computer is unable to decode Chinese font, please ignore the following message.It essentially repeats the statement in English given above.
???????????????????, ?????????????????. ?????????????????????????????????, ????????????????????????????. ??????, ??????. ????, ?????????????????????????????. ??????????????,??????????????.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ymu.vcf
Type: text/x-vcard
Size: 61 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060530/8324c56a/ymu.vcf
