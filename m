From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Apr 2007 19:01:57 +0000
Subject: [lm-sensors] [PATCH 2/5] w83781d: Clean up conversion macros
Message-Id: <20070407210157.d5b83635.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Fix voltage rounding
* Drop useless macros
* Drop useless casts
* Turn macros evaluating their parameters more than once into inline
  functions
* Use signed variables for temperatures

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |   54 ++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

--- linux-2.6.21-rc5.orig/drivers/hwmon/w83781d.c	2007-03-28 12:55:21.000000000 +0200
+++ linux-2.6.21-rc5/drivers/hwmon/w83781d.c	2007-03-28 13:01:53.000000000 +0200
@@ -164,12 +164,9 @@ static const u8 BIT_SCFG2[] = { 0x10, 0x
 #define W83781D_REG_RT_IDX		0x50
 #define W83781D_REG_RT_VAL		0x51
 
-/* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
-#define IN_TO_REG(val)			(SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
-#define IN_FROM_REG(val)		(((val) * 16) / 10)
+/* Conversions */
+#define IN_TO_REG(val)			SENSORS_LIMIT(((val) + 8) / 16, 0, 255)
+#define IN_FROM_REG(val)		((val) * 16)
 
 static inline u8
 FAN_TO_REG(long rpm, int div)
@@ -180,24 +177,24 @@ FAN_TO_REG(long rpm, int div)
 	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val,div)		((val) = 0   ? -1 : \
-					((val) = 255 ? 0 : \
-							1350000 / ((val) * (div))))
-
-#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val) < 0 ? (val)+0x100*1000 \
-						: (val)) / 1000, 0, 0xff))
-#define TEMP_FROM_REG(val)		(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
+static inline long
+FAN_FROM_REG(u8 val, int div)
+{
+	if (val = 0)
+		return -1;
+	if (val = 255)
+		return 0;
+	return 1350000 / (val * div);
+}
+
+#define TEMP_TO_REG(val)		SENSORS_LIMIT((val) / 1000, -127, 128)
+#define TEMP_FROM_REG(val)		((val) * 1000)
 
-#define PWM_FROM_REG(val)		(val)
-#define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
 #define BEEP_MASK_FROM_REG(val,type)	((type) = as99127f ? \
 					 (val) ^ 0x7fff : (val))
 #define BEEP_MASK_TO_REG(val,type)	((type) = as99127f ? \
 					 (~(val)) & 0x7fff : (val) & 0xffffff)
 
-#define BEEP_ENABLE_TO_REG(val)		((val) ? 1 : 0)
-#define BEEP_ENABLE_FROM_REG(val)	((val) ? 1 : 0)
-
 #define DIV_FROM_REG(val)		(1 << (val))
 
 static inline u8
@@ -212,7 +209,7 @@ DIV_TO_REG(long val, enum chips type)
 			break;
 		val >>= 1;
 	}
-	return ((u8) i);
+	return i;
 }
 
 /* There are some complications in a module like this. First off, W83781D chips
@@ -246,9 +243,9 @@ struct w83781d_data {
 	u8 in_min[9];		/* Register value - 8 & 9 for 782D only */
 	u8 fan[3];		/* Register value */
 	u8 fan_min[3];		/* Register value */
-	u8 temp;
-	u8 temp_max;		/* Register value */
-	u8 temp_max_hyst;	/* Register value */
+	s8 temp;		/* Register value */
+	s8 temp_max;		/* Register value */
+	s8 temp_max_hyst;	/* Register value */
 	u16 temp_add[2];	/* Register value */
 	u16 temp_max_add[2];	/* Register value */
 	u16 temp_max_hyst_add[2];	/* Register value */
@@ -303,7 +300,7 @@ static struct platform_driver w83781d_is
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
 { \
 	struct w83781d_data *data = w83781d_update_device(dev); \
-	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
+	return sprintf(buf, "%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
 }
 show_in_reg(in);
 show_in_reg(in_min);
@@ -316,7 +313,7 @@ static ssize_t store_in_##reg (struct de
 	struct i2c_client *client = &data->client; \
 	u32 val; \
 	 \
-	val = simple_strtoul(buf, NULL, 10) / 10; \
+	val = simple_strtoul(buf, NULL, 10); \
 	 \
 	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
@@ -534,8 +531,7 @@ static ssize_t show_beep_mask (struct de
 static ssize_t show_beep_enable (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n",
-		       (long)BEEP_ENABLE_FROM_REG(data->beep_enable));
+	return sprintf(buf, "%ld\n", (long)data->beep_enable);
 }
 
 #define BEEP_ENABLE			0	/* Store beep_enable */
@@ -566,7 +562,7 @@ store_beep_reg(struct device *dev, const
 		val2 = (data->beep_mask >> 8) & 0x7f;
 	} else {		/* We are storing beep_enable */
 		val2 = w83781d_read_value(client, W83781D_REG_BEEP_INTS2) & 0x7f;
-		data->beep_enable = BEEP_ENABLE_TO_REG(val);
+		data->beep_enable = !!val;
 	}
 
 	w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
@@ -659,7 +655,7 @@ static ssize_t
 show_pwm_reg(struct device *dev, char *buf, int nr)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr - 1]));
+	return sprintf(buf, "%ld\n", (long)data->pwm[nr - 1]);
 }
 
 static ssize_t
@@ -679,7 +675,7 @@ store_pwm_reg(struct device *dev, const 
 	val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->pwm[nr - 1] = PWM_TO_REG(val);
+	data->pwm[nr - 1] = SENSORS_LIMIT(val, 0, 255);
 	w83781d_write_value(client, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
 	mutex_unlock(&data->update_lock);
 	return count;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
