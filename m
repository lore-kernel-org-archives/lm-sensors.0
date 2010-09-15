From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:57:43 +0000
Subject: [lm-sensors] [patch 18/36] hwmon: (w83795) Fix PWM duty cycle
Message-Id: <20100915155743.2c2ad3d4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The PWM duty cycle frequenty attributes are improperly named
(fanN_div instead of pwmN_div) and contain raw values instead of
actual frequencies. Rename them and fix their contents.

Also improve the logic when the user asks for a new frequency, to
always pick the closest supported frequency. The algorithm could
certainly be optimized, but the operation is infrequent enough that
I don't think it's worth the effort.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   90 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 28 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:12:58.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:13:46.000000000 +0200
@@ -200,7 +200,6 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  #define W83795_REG_FCMS2		0x208
 #define W83795_REG_TFMR(index)		(0x202 + (index))
 #define W83795_REG_FOMC			0x20F
-#define W83795_REG_FOPFP(index)		(0x218 + (index))
 
 #define W83795_REG_TSS(index)		(0x209 + (index))
 
@@ -208,18 +207,13 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  #define PWM_START			1
 #define PWM_NONSTOP			2
 #define PWM_STOP_TIME			3
-#define PWM_DIV				4
+#define PWM_FREQ			4
 #define W83795_REG_PWM(index, nr) \
 	(((nr) = 0 ? 0x210 : \
 	  (nr) = 1 ? 0x220 : \
 	  (nr) = 2 ? 0x228 : \
 	  (nr) = 3 ? 0x230 : 0x218) + (index))
 
-#define W83795_REG_FOPFP_DIV(index) \
-	(((index) < 8) ? ((index) + 1) : \
-	 ((index) = 8) ? 12 : \
-	 (16 << ((index) - 9)))
-
 #define W83795_REG_FTSH(index)		(0x240 + (index) * 2)
 #define W83795_REG_FTSL(index)		(0x241 + (index) * 2)
 #define W83795_REG_TFTS			0x250
@@ -304,6 +298,50 @@ static inline s8 temp_to_reg(long val, s
 	return SENSORS_LIMIT((val < 0 ? -val : val) / 1000, min, max);
 }
 
+static const u16 pwm_freq_cksel0[16] = {
+	1024, 512, 341, 256, 205, 171, 146, 128,
+	85, 64, 32, 16, 8, 4, 2, 1
+};
+
+static unsigned int pwm_freq_from_reg(u8 reg, u16 clkin)
+{
+	unsigned long base_clock;
+
+	if (reg & 0x80) {
+		base_clock = clkin * 1000 / ((clkin = 48000) ? 384 : 256);
+		return base_clock / ((reg & 0x7f) + 1);
+	} else
+		return pwm_freq_cksel0[reg & 0x0f];
+}
+
+static u8 pwm_freq_to_reg(unsigned long val, u16 clkin)
+{
+	unsigned long base_clock;
+	u8 reg0, reg1;
+	unsigned long best0, best1;
+
+	/* Best fit for cksel = 0 */
+	for (reg0 = 0; reg0 < ARRAY_SIZE(pwm_freq_cksel0) - 1; reg0++) {
+		if (val > (pwm_freq_cksel0[reg0] +
+			   pwm_freq_cksel0[reg0 + 1]) / 2)
+			break;
+	}
+	if (val < 375)	/* cksel = 1 can't beat this */
+		return reg0;
+	best0 = pwm_freq_cksel0[reg0];
+
+	/* Best fit for cksel = 1 */
+	base_clock = clkin * 1000 / ((clkin = 48000) ? 384 : 256);
+	reg1 = SENSORS_LIMIT(DIV_ROUND_CLOSEST(base_clock, val), 1, 128);
+	best1 = base_clock / reg1;
+	reg1 = 0x80 | (reg1 - 1);
+
+	/* Choose the closest one */
+	if (abs(val - best0) > abs(val - best1))
+		return reg1;
+	else
+		return reg0;
+}
 
 enum chip_types {w83795g, w83795adg};
 
@@ -343,7 +381,8 @@ struct w83795_data {
 				 * no config register, only affected by chip
 				 * type */
 	u8 pwm[8][5];		/* Register value, output, start, non stop, stop
-				 * time, div */
+				 * time, freq */
+	u16 clkin;		/* CLKIN frequency in kHz */
 	u8 pwm_fcms[2];		/* Register value */
 	u8 pwm_tfmr[6];		/* Register value */
 	u8 pwm_fomc;		/* Register value */
@@ -688,14 +727,14 @@ show_pwm(struct device *dev, struct devi
 	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
-	u16 val;
+	unsigned int val;
 
 	switch (nr) {
 	case PWM_STOP_TIME:
 		val = time_from_reg(data->pwm[index][nr]);
 		break;
-	case PWM_DIV:
-		val = W83795_REG_FOPFP_DIV(data->pwm[index][nr] & 0x0f);
+	case PWM_FREQ:
+		val = pwm_freq_from_reg(data->pwm[index][nr], data->clkin);
 		break;
 	default:
 		val = data->pwm[index][nr];
@@ -716,7 +755,6 @@ store_pwm(struct device *dev, struct dev
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	unsigned long val;
-	int i;
 
 	if (strict_strtoul(buf, 10, &val) < 0)
 		return -EINVAL;
@@ -726,28 +764,17 @@ store_pwm(struct device *dev, struct dev
 	case PWM_STOP_TIME:
 		val = time_to_reg(val);
 		break;
-	case PWM_DIV:
-		for (i = 0; i < 16; i++) {
-			if (W83795_REG_FOPFP_DIV(i) = val) {
-				val = i;
-				break;
-			}
-		}
-		if (i >= 16)
-			goto err_end;
-		val |= w83795_read(client, W83795_REG_PWM(index, nr)) & 0x80;
+	case PWM_FREQ:
+		val = pwm_freq_to_reg(val, data->clkin);
 		break;
 	default:
 		val = SENSORS_LIMIT(val, 0, 0xff);
 		break;
 	}
 	w83795_write(client, W83795_REG_PWM(index, nr), val);
-	data->pwm[index][nr] = val & 0xff;
+	data->pwm[index][nr] = val;
 	mutex_unlock(&data->update_lock);
 	return count;
-err_end:
-	mutex_unlock(&data->update_lock);
-	return -EINVAL;
 }
 
 static ssize_t
@@ -1502,8 +1529,8 @@ store_sf_setup(struct device *dev, struc
 		show_pwm, store_pwm, PWM_START, index - 1),		\
 	SENSOR_ATTR_2(pwm##index##_stop_time, S_IWUSR | S_IRUGO,	\
 		show_pwm, store_pwm, PWM_STOP_TIME, index - 1),	 \
-	SENSOR_ATTR_2(fan##index##_div, S_IWUSR | S_IRUGO,	\
-		show_pwm, store_pwm, PWM_DIV, index - 1),	 \
+	SENSOR_ATTR_2(pwm##index##_freq, S_IWUSR | S_IRUGO,	\
+		show_pwm, store_pwm, PWM_FREQ, index - 1),	 \
 	SENSOR_ATTR_2(pwm##index##_enable, S_IWUSR | S_IRUGO,		\
 		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1), \
 	SENSOR_ATTR_2(fan##index##_target, S_IWUSR | S_IRUGO, \
@@ -1685,6 +1712,10 @@ static const struct sensor_device_attrib
 
 static void w83795_init_client(struct i2c_client *client)
 {
+	struct w83795_data *data = i2c_get_clientdata(client);
+	static const u16 clkin[4] = {	/* in kHz */
+		14318, 24000, 33333, 48000
+	};
 	u8 config;
 
 	if (reset)
@@ -1697,6 +1728,9 @@ static void w83795_init_client(struct i2
 		w83795_write(client, W83795_REG_CONFIG,
 			     config | W83795_REG_CONFIG_START);
 	}
+
+	data->clkin = clkin[(config >> 3) & 0x3];
+	dev_dbg(&client->dev, "clkin = %u kHz\n", data->clkin);
 }
 
 static int w83795_get_device_id(struct i2c_client *client)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
