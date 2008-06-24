From: Nate Case <ncase@xes-inc.com>
Date: Tue, 24 Jun 2008 20:49:06 +0000
Subject: [lm-sensors] [PATCH v3 2/2] hwmon: (lm90) Support ADT7461 in
Message-Id: <1214340546-18208-3-git-send-email-ncase@xes-inc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Support ADT7461 in extended temperature range mode, which will change
the range of readings from 0..127 to -64..191 degC.  Adjust the
register conversion functions accordingly.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 drivers/hwmon/lm90.c |  119 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 711a7e1..848892f 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -51,12 +51,11 @@
  * The MAX6680 and MAX6681 only differ in the pinout so they can be
  * treated identically.
  *
- * This driver also supports the ADT7461 chip from Analog Devices but
- * only in its "compatability mode". If an ADT7461 chip is found but
- * is configured in non-compatible mode (where its temperature
- * register values are decoded differently) it is ignored by this
- * driver. Complete datasheet can be obtained from Analog's website
- * at:
+ * This driver also supports the ADT7461 chip from Analog Devices.
+ * It's supported in both compatibility and extended mode.  It is mostly
+ * compatible with LM90 except for a data format difference for the
+ * temperature value registers.  Complete datasheet can be obtained from
+ * Analog's website at:
  *   http://www.analog.com/en/prod/0,2877,ADT7461,00.html
  *
  * Since the LM90 was the first chipset supported by this driver, most
@@ -152,6 +151,11 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680);
 #define LM90_REG_W_TCRIT_HYST		0x21
 
 /*
+ * Device flags
+ */
+#define LM90_FLAG_ADT7461_EXT		0x01	/* ADT7461 extended mode */
+
+/*
  * Functions declaration
  */
 
@@ -186,6 +190,7 @@ struct lm90_data {
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 	int kind;
+	int flags;
 
 	/* registers values */
 	s8 temp8[5];	/* 0: local input
@@ -251,26 +256,61 @@ static u8 hyst_to_reg(long val)
 }
 
 /*
- * ADT7461 is almost identical to LM90 except that attempts to write
- * values that are outside the range 0 < temp < 127 are treated as
- * the boundary value.
+ * ADT7461 in compatibility mode is almost identical to LM90 except that
+ * attempts to write values that are outside the range 0 < temp < 127 are
+ * treated as the boundary value.
+ *
+ * ADT7461 in "extended mode" operation uses unsigned integers offset by
+ * 64 (e.g., 0 -> -64 degC).  The range is restricted to -64..191 degC.
  */
-static u8 temp1_to_reg_adt7461(long val)
+static inline int temp1_from_reg_adt7461(struct lm90_data *data, u8 val)
 {
-	if (val <= 0)
-		return 0;
-	if (val >= 127000)
-		return 127;
-	return (val + 500) / 1000;
+	if (data->flags & LM90_FLAG_ADT7461_EXT)
+		return (val - 64) * 1000;
+	else
+		return temp1_from_reg(val);
 }
 
-static u16 temp2_to_reg_adt7461(long val)
+static inline int temp2_from_reg_adt7461(struct lm90_data *data, u16 val)
 {
-	if (val <= 0)
-		return 0;
-	if (val >= 127750)
-		return 0x7FC0;
-	return (val + 125) / 250 * 64;
+	if (data->flags & LM90_FLAG_ADT7461_EXT)
+		return (val - 0x4000) / 64 * 250;
+	else
+		return temp2_from_reg(val);
+}
+
+static u8 temp1_to_reg_adt7461(struct lm90_data *data, long val)
+{
+	if (data->flags & LM90_FLAG_ADT7461_EXT) {
+		if (val <= -64000)
+			return 0;
+		if (val >= 191000)
+			return 0xFF;
+		return (val + 500 + 64000) / 1000;
+	} else {
+		if (val <= 0)
+			return 0;
+		if (val >= 127000)
+			return 127;
+		return (val + 500) / 1000;
+	}
+}
+
+static u16 temp2_to_reg_adt7461(struct lm90_data *data, long val)
+{
+	if (data->flags & LM90_FLAG_ADT7461_EXT) {
+		if (val <= -64000)
+			return 0;
+		if (val >= 191750)
+			return 0xFFC0;
+		return (val + 64000 + 125) / 250 * 64;
+	} else {
+		if (val <= 0)
+			return 0;
+		if (val >= 127750)
+			return 0x7FC0;
+		return (val + 125) / 250 * 64;
+	}
 }
 
 /*
@@ -282,7 +322,14 @@ static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index]));
+	int temp;
+
+	if (data->kind = adt7461)
+		temp = temp1_from_reg_adt7461(data, data->temp8[attr->index]);
+	else
+		temp = temp1_from_reg(data->temp8[attr->index]);
+
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
@@ -303,7 +350,7 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
-		data->temp8[nr] = temp1_to_reg_adt7461(val);
+		data->temp8[nr] = temp1_to_reg_adt7461(data, val);
 	else
 		data->temp8[nr] = temp1_to_reg(val);
 	i2c_smbus_write_byte_data(client, reg[nr - 1], data->temp8[nr]);
@@ -316,7 +363,14 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp2_from_reg(data->temp11[attr->index]));
+	int temp;
+
+	if (data->kind = adt7461)
+		temp = temp2_from_reg_adt7461(data, data->temp11[attr->index]);
+	else
+		temp = temp2_from_reg(data->temp11[attr->index]);
+
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
@@ -339,7 +393,7 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
-		data->temp11[nr] = temp2_to_reg_adt7461(val);
+		data->temp11[nr] = temp2_to_reg_adt7461(data, val);
 	else
 		data->temp11[nr] = temp2_to_reg(val);
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
@@ -355,8 +409,14 @@ static ssize_t show_temphyst(struct device *dev, struct device_attribute *devatt
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index])
-		       - temp1_from_reg(data->temp_hyst));
+	int temp;
+
+	if (data->kind = adt7461)
+		temp = temp1_from_reg_adt7461(data, data->temp8[attr->index]);
+	else
+		temp = temp1_from_reg(data->temp8[attr->index]);
+
+	return sprintf(buf, "%d\n", temp - temp1_from_reg(data->temp_hyst));
 }
 
 static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
@@ -613,9 +673,12 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
 				kind = adm1032;
 			} else
 			if (chip_id = 0x51 /* ADT7461 */
-			 && (reg_config1 & 0x1F) = 0x00 /* check compat mode */
+			 && (reg_config1 & 0x1B) = 0x00
 			 && reg_convrate <= 0x0A) {
 				kind = adt7461;
+				/* Check Temperature Range Select */
+				if (reg_config1 & 0x04)
+					data->flags |= LM90_FLAG_ADT7461_EXT;
 			}
 		} else
 		if (man_id = 0x4D) { /* Maxim */
-- 
1.5.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
