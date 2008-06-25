From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jun 2008 11:52:01 +0000
Subject: [lm-sensors] [PATCH 5/6] hwmon: (lm90) Convert some macros to
Message-Id: <20080625135201.0a3d3a95@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Nate Case <ncase@xes-inc.com>

Use static functions instead of the TEMPx_FROM_REG* and TEMPx_TO_REG*
macros.  This will ensure type safety and eliminate any side effects
from arguments passed in since the macros referenced 'val' multiple
times.  This change should not affect functionality.

Signed-off-by: Nate Case <ncase@xes-inc.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm90.c |  128 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 83 insertions(+), 45 deletions(-)

--- linux-2.6.26-rc8.orig/drivers/hwmon/lm90.c	2008-06-25 10:23:29.000000000 +0200
+++ linux-2.6.26-rc8/drivers/hwmon/lm90.c	2008-06-25 11:00:39.000000000 +0200
@@ -138,40 +138,6 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99,
 #define MAX6657_REG_R_LOCAL_TEMPL	0x11
 
 /*
- * Conversions and various macros
- * For local temperatures and limits, critical limits and the hysteresis
- * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celsius.
- * For remote temperatures and limits, it uses signed 11-bit values with
- * LSB = 0.125 degree Celsius, left-justified in 16-bit registers.
- */
-
-#define TEMP1_FROM_REG(val)	((val) * 1000)
-#define TEMP1_TO_REG(val)	((val) <= -128000 ? -128 : \
-				 (val) >= 127000 ? 127 : \
-				 (val) < 0 ? ((val) - 500) / 1000 : \
-				 ((val) + 500) / 1000)
-#define TEMP2_FROM_REG(val)	((val) / 32 * 125)
-#define TEMP2_TO_REG(val)	((val) <= -128000 ? 0x8000 : \
-				 (val) >= 127875 ? 0x7FE0 : \
-				 (val) < 0 ? ((val) - 62) / 125 * 32 : \
-				 ((val) + 62) / 125 * 32)
-#define HYST_TO_REG(val)	((val) <= 0 ? 0 : (val) >= 30500 ? 31 : \
-				 ((val) + 500) / 1000)
-
-/* 
- * ADT7461 is almost identical to LM90 except that attempts to write
- * values that are outside the range 0 < temp < 127 are treated as
- * the boundary value. 
- */
-
-#define TEMP1_TO_REG_ADT7461(val) ((val) <= 0 ? 0 : \
-				 (val) >= 127000 ? 127 : \
-				 ((val) + 500) / 1000)
-#define TEMP2_TO_REG_ADT7461(val) ((val) <= 0 ? 0 : \
-				 (val) >= 127750 ? 0x7FC0 : \
-				 ((val) + 125) / 250 * 64)
-
-/*
  * Functions declaration
  */
 
@@ -221,6 +187,78 @@ struct lm90_data {
 };
 
 /*
+ * Conversions
+ * For local temperatures and limits, critical limits and the hysteresis
+ * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celsius.
+ * For remote temperatures and limits, it uses signed 11-bit values with
+ * LSB = 0.125 degree Celsius, left-justified in 16-bit registers.
+ */
+
+static inline int temp1_from_reg(s8 val)
+{
+	return val * 1000;
+}
+
+static inline int temp2_from_reg(s16 val)
+{
+	return val / 32 * 125;
+}
+
+static s8 temp1_to_reg(long val)
+{
+	if (val <= -128000)
+		return -128;
+	if (val >= 127000)
+		return 127;
+	if (val < 0)
+		return (val - 500) / 1000;
+	return (val + 500) / 1000;
+}
+
+static s16 temp2_to_reg(long val)
+{
+	if (val <= -128000)
+		return 0x8000;
+	if (val >= 127875)
+		return 0x7FE0;
+	if (val < 0)
+		return (val - 62) / 125 * 32;
+	return (val + 62) / 125 * 32;
+}
+
+static u8 hyst_to_reg(long val)
+{
+	if (val <= 0)
+		return 0;
+	if (val >= 30500)
+		return 31;
+	return (val + 500) / 1000;
+}
+
+/*
+ * ADT7461 is almost identical to LM90 except that attempts to write
+ * values that are outside the range 0 < temp < 127 are treated as
+ * the boundary value.
+ */
+static u8 temp1_to_reg_adt7461(long val)
+{
+	if (val <= 0)
+		return 0;
+	if (val >= 127000)
+		return 127;
+	return (val + 500) / 1000;
+}
+
+static u16 temp2_to_reg_adt7461(long val)
+{
+	if (val <= 0)
+		return 0;
+	if (val >= 127750)
+		return 0x7FC0;
+	return (val + 125) / 250 * 64;
+}
+
+/*
  * Sysfs stuff
  */
 
@@ -229,7 +267,7 @@ static ssize_t show_temp8(struct device 
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp8[attr->index]));
+	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index]));
 }
 
 static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
@@ -250,9 +288,9 @@ static ssize_t set_temp8(struct device *
 
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
-		data->temp8[nr] = TEMP1_TO_REG_ADT7461(val);
+		data->temp8[nr] = temp1_to_reg_adt7461(val);
 	else
-		data->temp8[nr] = TEMP1_TO_REG(val);
+		data->temp8[nr] = temp1_to_reg(val);
 	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -263,7 +301,7 @@ static ssize_t show_temp11(struct device
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP2_FROM_REG(data->temp11[attr->index]));
+	return sprintf(buf, "%d\n", temp2_from_reg(data->temp11[attr->index]));
 }
 
 static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
@@ -286,11 +324,11 @@ static ssize_t set_temp11(struct device 
 
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
-		data->temp11[nr] = TEMP2_TO_REG_ADT7461(val);
+		data->temp11[nr] = temp2_to_reg_adt7461(val);
 	else if (data->kind = max6657 || data->kind = max6680)
-		data->temp11[nr] = TEMP1_TO_REG(val) << 8;
+		data->temp11[nr] = temp1_to_reg(val) << 8;
 	else
-		data->temp11[nr] = TEMP2_TO_REG(val);
+		data->temp11[nr] = temp2_to_reg(val);
 
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
 				  data->temp11[nr] >> 8);
@@ -306,8 +344,8 @@ static ssize_t show_temphyst(struct devi
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp8[attr->index])
-		       - TEMP1_FROM_REG(data->temp_hyst));
+	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index])
+		       - temp1_from_reg(data->temp_hyst));
 }
 
 static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
@@ -319,9 +357,9 @@ static ssize_t set_temphyst(struct devic
 	long hyst;
 
 	mutex_lock(&data->update_lock);
-	hyst = TEMP1_FROM_REG(data->temp8[2]) - val;
+	hyst = temp1_from_reg(data->temp8[2]) - val;
 	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
-				  HYST_TO_REG(hyst));
+				  hyst_to_reg(hyst));
 	mutex_unlock(&data->update_lock);
 	return count;
 }

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
