From: Nate Case <ncase@xes-inc.com>
Date: Fri, 13 Jun 2008 16:36:13 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm90) Support ADT7461 in extended
Message-Id: <1213374973-3262-3-git-send-email-ncase@xes-inc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Put ADT7461 into extended temperature range mode, which will change
the range of readings from 0..127 to -64..191 degC.  Adjust the
register conversion functions accordingly.  This also eliminates the
need to check the compatibility mode bit during probing since we
always force extended mode now.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 drivers/hwmon/lm90.c |   76 ++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 5f2db18..5a1fc2d 100644
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
+ * The chip is placed into "extended mode" to support a range of
+ * -64..191 degC.  It is mostly compatible with LM90 except for this
+ * data format difference in extended mode. Complete datasheet can be
+ * obtained from Analog's website at:
  *   http://www.analog.com/en/prod/0,2877,ADT7461,00.html
  *
  * Since the LM90 was the first chipset supported by this driver, most
@@ -242,22 +241,32 @@ static s16 temp2_to_reg(int val)
 }
 
 /*
- * ADT7461 is almost identical to LM90 except that attempts to write
- * values that are outside the range 0 < temp < 127 are treated as
- * the boundary value.
+ * ADT7461 versions of the above for "extended mode" operation
+ * which follows the same data format as LM90, but with an offset
+ * of 64 and unsigned integers.  The range is restricted to -64..191 degC.
  */
+static int temp1_from_reg_adt7461(s8 val)
+{
+	return ((u8) val - 64) * 1000;
+}
+
+static int temp2_from_reg_adt7461(s16 val)
+{
+	return ((u16) val - 0x4000) / 32 * 125;
+}
+
 static s8 temp1_to_reg_adt7461(int val)
 {
-	return val <= 0 ? 0 :
-			  val >= 127000 ? 127 :
-			  (val + 500) / 1000;
+	return val <= -64000 ? 0 :
+			       val >= 191000 ? (s8) 0xff :
+			       (s8) ((val + 500) / 1000 + 64);
 }
 
 static s16 temp2_to_reg_adt7461(int val)
 {
-	return val <= 0 ? 0 :
-			  val >= 127750 ? 0x7FC0 :
-			  (val + 125) / 250 * 64;
+	return val <= -64000 ? 0 :
+			       val >= 191750 ? (s16) 0xffc0 :
+			       (s16) ((val + 125) / 250 * 64 + 0x4000);
 }
 
 /*
@@ -269,7 +278,14 @@ static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index]));
+	int temp;
+
+	if (data->kind = adt7461)
+		temp = temp1_from_reg_adt7461(data->temp8[attr->index]);
+	else
+		temp = temp1_from_reg(data->temp8[attr->index]);
+
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
@@ -303,7 +319,14 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp2_from_reg(data->temp11[attr->index]));
+	int temp;
+
+	if (data->kind = adt7461)
+		temp = temp2_from_reg_adt7461(data->temp11[attr->index]);
+	else
+		temp = temp2_from_reg(data->temp11[attr->index]);
+
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
@@ -342,8 +365,14 @@ static ssize_t show_temphyst(struct device *dev, struct device_attribute *devatt
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index])
-		       - temp1_from_reg(data->temp_hyst));
+	int temp;
+
+	if (data->kind = adt7461)
+		temp = temp1_from_reg_adt7461(data->temp8[attr->index]);
+	else
+		temp = temp1_from_reg(data->temp8[attr->index]);
+
+	return sprintf(buf, "%d\n", temp - temp1_from_reg(data->temp_hyst));
 }
 
 static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
@@ -600,7 +629,6 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
 				kind = adm1032;
 			} else
 			if (chip_id = 0x51 /* ADT7461 */
-			 && (reg_config1 & 0x1F) = 0x00 /* check compat mode */
 			 && reg_convrate <= 0x0A) {
 				kind = adt7461;
 			}
@@ -733,6 +761,14 @@ static void lm90_init_client(struct i2c_client *client)
 		config |= 0x18;
 	}
 
+	/*
+	 * Put ADT7461 into extended temperature range mode, which will
+	 * change the range of readings from 0..127 to -64..191 degC.
+	 * This also affects the format of the limit registers.
+	 */
+	if (data->kind = adt7461)
+		config |= 0x04;
+
 	config &= 0xBF;	/* run */
 	if (config != config_orig) /* Only write if changed */
 		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
-- 
1.5.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
