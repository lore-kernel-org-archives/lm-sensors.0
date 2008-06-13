From: Nate Case <ncase@xes-inc.com>
Date: Fri, 13 Jun 2008 16:36:12 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm90) Convert some macros to
Message-Id: <1213374973-3262-2-git-send-email-ncase@xes-inc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use static functions instead of the TEMPx_FROM_REG* and TEMPx_TO_REG*
macros.  This will ensure type safety and eliminate any side effects
from arguments passed in since the macros referenced 'val' multiple
times.  This change should not affect functionality.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 drivers/hwmon/lm90.c |  113 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 69 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 960df9f..5f2db18 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -152,40 +152,6 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680);
 #define LM90_REG_W_TCRIT_HYST		0x21
 
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
 
@@ -236,6 +202,65 @@ struct lm90_data {
 };
 
 /*
+ * Conversions and various functions
+ * For local temperatures and limits, critical limits and the hysteresis
+ * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celsius.
+ * For remote temperatures and limits, it uses signed 11-bit values with
+ * LSB = 0.125 degree Celsius, left-justified in 16-bit registers.
+ */
+
+static u8 hyst_to_reg(long val)
+{
+	return val <= 0 ? 0 : val >= 30500 ? 31 :
+			      (val + 500) / 1000;
+}
+
+static int temp1_from_reg(s8 val)
+{
+	return val * 1000;
+}
+
+static int temp2_from_reg(s16 val)
+{
+	return val / 32 * 125;
+}
+
+static s8 temp1_to_reg(int val)
+{
+	return val <= -128000 ? -128 :
+				val >= 127000 ? 127 :
+				val < 0 ? (val - 500) / 1000 :
+				(val + 500) / 1000;
+}
+
+static s16 temp2_to_reg(int val)
+{
+	return val <= -128000 ? 0x8000 :
+				val >= 127875 ? 0x7FE0 :
+				val < 0 ? (val - 62) / 125 * 32 :
+				(val + 62) / 125 * 32;
+}
+
+/*
+ * ADT7461 is almost identical to LM90 except that attempts to write
+ * values that are outside the range 0 < temp < 127 are treated as
+ * the boundary value.
+ */
+static s8 temp1_to_reg_adt7461(int val)
+{
+	return val <= 0 ? 0 :
+			  val >= 127000 ? 127 :
+			  (val + 500) / 1000;
+}
+
+static s16 temp2_to_reg_adt7461(int val)
+{
+	return val <= 0 ? 0 :
+			  val >= 127750 ? 0x7FC0 :
+			  (val + 125) / 250 * 64;
+}
+
+/*
  * Sysfs stuff
  */
 
@@ -244,7 +269,7 @@ static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp8[attr->index]));
+	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index]));
 }
 
 static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
@@ -265,9 +290,9 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
-		data->temp8[nr] = TEMP1_TO_REG_ADT7461(val);
+		data->temp8[nr] = temp1_to_reg_adt7461(val);
 	else
-		data->temp8[nr] = TEMP1_TO_REG(val);
+		data->temp8[nr] = temp1_to_reg(val);
 	i2c_smbus_write_byte_data(client, reg[nr - 1], data->temp8[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -278,7 +303,7 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP2_FROM_REG(data->temp11[attr->index]));
+	return sprintf(buf, "%d\n", temp2_from_reg(data->temp11[attr->index]));
 }
 
 static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
@@ -301,9 +326,9 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
-		data->temp11[nr] = TEMP2_TO_REG_ADT7461(val);
+		data->temp11[nr] = temp2_to_reg_adt7461(val);
 	else
-		data->temp11[nr] = TEMP2_TO_REG(val);
+		data->temp11[nr] = temp2_to_reg(val);
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
 				  data->temp11[nr] >> 8);
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
@@ -317,8 +342,8 @@ static ssize_t show_temphyst(struct device *dev, struct device_attribute *devatt
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp8[attr->index])
-		       - TEMP1_FROM_REG(data->temp_hyst));
+	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index])
+		       - temp1_from_reg(data->temp_hyst));
 }
 
 static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
@@ -330,9 +355,9 @@ static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
 	long hyst;
 
 	mutex_lock(&data->update_lock);
-	hyst = TEMP1_FROM_REG(data->temp8[3]) - val;
+	hyst = temp1_from_reg(data->temp8[3]) - val;
 	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
-				  HYST_TO_REG(hyst));
+				  hyst_to_reg(hyst));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-- 
1.5.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
