From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Oct 2011 07:13:31 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (w83627ehf) Better fix for negative
Message-Id: <20111020091331.798b0e04@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It is more efficient to left-align 8-bit temperature values, so that
8-bit and 9-bit temperature values can be handled exactly the same way
in the rest of the code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
Here's the bloat-o-meter report:
add/remove: 2/0 grow/shrink: 0/5 up/down: 138/-380 (-242)
function                                     old     new   delta
w83627ehf_write_temp                           -      78     +78
w83627ehf_read_temp                            -      60     +60
show_temp_max_hyst                           119      77     -42
show_temp_max                                119      77     -42
show_temp                                    119      77     -42
store_temp_max_hyst                          355     228    -127
store_temp_max                               355     228    -127

Guenter, what do you think?

 drivers/hwmon/w83627ehf.c |   51 +++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

--- linux-3.1-rc9.orig/drivers/hwmon/w83627ehf.c	2011-10-17 22:35:46.000000000 +0200
+++ linux-3.1-rc9/drivers/hwmon/w83627ehf.c	2011-10-18 08:50:01.000000000 +0200
@@ -385,23 +385,6 @@ div_from_reg(u8 reg)
 	return 1 << reg;
 }
 
-static inline int
-temp_from_reg(u16 reg, s16 regval)
-{
-	if (is_word_sized(reg))
-		return LM75_TEMP_FROM_REG(regval);
-	return ((s8)regval) * 1000;
-}
-
-static inline u16
-temp_to_reg(u16 reg, long temp)
-{
-	if (is_word_sized(reg))
-		return LM75_TEMP_TO_REG(temp);
-	return (s8)DIV_ROUND_CLOSEST(SENSORS_LIMIT(temp, -127000, 128000),
-				     1000);
-}
-
 /* Some of analog inputs have internal scaling (2x), 8mV is ADC LSB */
 
 static u8 scale_in[10] = { 8, 8, 16, 16, 8, 8, 8, 16, 16, 8 };
@@ -557,6 +540,26 @@ static int w83627ehf_write_value(struct
 	return 0;
 }
 
+/* We left-align 8-bit temperature values to make the code simpler */
+static u16 w83627ehf_read_temp(struct w83627ehf_data *data, u16 reg)
+{
+	u16 res;
+
+	res = w83627ehf_read_value(data, reg);
+	if (!is_word_sized(reg))
+		res <<= 8;
+
+	return res;
+}
+
+static int w83627ehf_write_temp(struct w83627ehf_data *data, u16 reg,
+				       u16 value)
+{
+	if (!is_word_sized(reg))
+		value >>= 8;
+	return w83627ehf_write_value(data, reg, value);
+}
+
 /* This function assumes that the caller holds data->update_lock */
 static void nct6775_write_fan_div(struct w83627ehf_data *data, int nr)
 {
@@ -858,15 +861,15 @@ static struct w83627ehf_data *w83627ehf_
 		for (i = 0; i < NUM_REG_TEMP; i++) {
 			if (!(data->have_temp & (1 << i)))
 				continue;
-			data->temp[i] = w83627ehf_read_value(data,
+			data->temp[i] = w83627ehf_read_temp(data,
 						data->reg_temp[i]);
 			if (data->reg_temp_over[i])
 				data->temp_max[i]
-				  = w83627ehf_read_value(data,
+				  = w83627ehf_read_temp(data,
 						data->reg_temp_over[i]);
 			if (data->reg_temp_hyst[i])
 				data->temp_max_hyst[i]
-				  = w83627ehf_read_value(data,
+				  = w83627ehf_read_temp(data,
 						data->reg_temp_hyst[i]);
 		}
 
@@ -1159,8 +1162,7 @@ show_##reg(struct device *dev, struct de
 	struct sensor_device_attribute *sensor_attr = \
 		to_sensor_dev_attr(attr); \
 	int nr = sensor_attr->index; \
-	return sprintf(buf, "%d\n", \
-		       temp_from_reg(data->addr[nr], data->reg[nr])); \
+	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->reg[nr])); \
 }
 show_temp_reg(reg_temp, temp);
 show_temp_reg(reg_temp_over, temp_max);
@@ -1181,9 +1183,8 @@ store_##reg(struct device *dev, struct d
 	if (err < 0) \
 		return err; \
 	mutex_lock(&data->update_lock); \
-	data->reg[nr] = temp_to_reg(data->addr[nr], val); \
-	w83627ehf_write_value(data, data->addr[nr], \
-			      data->reg[nr]); \
+	data->reg[nr] = LM75_TEMP_TO_REG(val); \
+	w83627ehf_write_temp(data, data->addr[nr], data->reg[nr]); \
 	mutex_unlock(&data->update_lock); \
 	return count; \
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
