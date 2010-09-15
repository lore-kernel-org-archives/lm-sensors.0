From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:01:39 +0000
Subject: [lm-sensors] [patch 28/36] hwmon: (w83795) Simplify temperature
Message-Id: <20100915160139.34e9616a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All 3 temperature sensor type sysfs functions (show_temp_mode,
store_temp_mode and show_dts_mode) can be simplified. We don't
create these files when the correponding input isn't in temperature
monitoring mode, so there is no point in handling that case.
Likewise, we don't allow changing inputs from temperature to voltage,
so the code handling this case is dead and can be removed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |  107 ++++++++++--------------------------------------
 1 file changed, 24 insertions(+), 83 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:14:08.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:14:11.000000000 +0200
@@ -66,23 +66,6 @@ MODULE_PARM_DESC(reset, "Set to 1 to res
 #define W83795_REG_FANIN_CTRL2		0x07
 #define W83795_REG_VMIGB_CTRL		0x08
 
-#define TEMP_CTRL_DISABLE		0
-#define TEMP_CTRL_TD			1
-#define TEMP_CTRL_VSEN			2
-#define TEMP_CTRL_TR			3
-#define TEMP_CTRL_SHIFT			4
-#define TEMP_CTRL_HASIN_SHIFT		5
-/* temp mode may effect VSEN17-12 (in20-15) */
-static const u16 W83795_REG_TEMP_CTRL[][6] = {
-	/* Disable, TD, VSEN, TR, register shift value, has_in shift num */
-	{0x00, 0x01, 0x02, 0x03, 0, 17},	/* TR1 */
-	{0x00, 0x04, 0x08, 0x0C, 2, 18},	/* TR2 */
-	{0x00, 0x10, 0x20, 0x30, 4, 19},	/* TR3 */
-	{0x00, 0x40, 0x80, 0xC0, 6, 20},	/* TR4 */
-	{0x00, 0x00, 0x02, 0x03, 0, 15},	/* TR5 */
-	{0x00, 0x00, 0x08, 0x0C, 2, 16},	/* TR6 */
-};
-
 #define TEMP_READ			0
 #define TEMP_CRIT			1
 #define TEMP_CRIT_HYST			2
@@ -359,7 +342,7 @@ struct w83795_data {
 	u8 has_temp;		/* Enable monitor temp6-1 or not */
 	s8 temp[6][5];		/* current, crit, crit_hyst, warn, warn_hyst */
 	u8 temp_read_vrlsb[6];
-	u8 temp_mode;		/* bit 0: TR mode, bit 1: TD mode */
+	u8 temp_mode;		/* Bit vector, 0 = TR, 1 = TD */
 	u8 temp_src[3];		/* Register value */
 
 	u8 enable_dts;		/* Enable PECI and SB-TSI,
@@ -509,13 +492,6 @@ static struct w83795_data *w83795_update
 
 	/* Update temperature */
 	for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
-		/* even stop monitor, register still keep value, just read out
-		 * it */
-		if (!(data->has_temp & (1 << i))) {
-			data->temp[i][TEMP_READ] = 0;
-			data->temp_read_vrlsb[i] = 0;
-			continue;
-		}
 		data->temp[i][TEMP_READ]  			w83795_read(client, W83795_REG_TEMP[i][TEMP_READ]);
 		data->temp_read_vrlsb[i] @@ -1163,22 +1139,12 @@ show_dts_mode(struct device *dev, struct
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83795_data *data = i2c_get_clientdata(client);
-	struct sensor_device_attribute_2 *sensor_attr -	    to_sensor_dev_attr_2(attr);
-	int index = sensor_attr->index;
-	u8 tmp;
+	int tmp;
 
-	if (data->enable_dts = 0)
-		return sprintf(buf, "%d\n", 0);
-
-	if ((data->has_dts >> index) & 0x01) {
-		if (data->enable_dts & 2)
-			tmp = 5;
-		else
-			tmp = 6;
-	} else {
-		tmp = 0;
-	}
+	if (data->enable_dts & 2)
+		tmp = 5;
+	else
+		tmp = 6;
 
 	return sprintf(buf, "%d\n", tmp);
 }
@@ -1231,14 +1197,6 @@ store_dts_ext(struct device *dev, struct
 }
 
 
-/*
-	Type 3:  Thermal diode
-	Type 4:  Thermistor
-
-	Temp5-6, default TR
-	Temp1-4, default TD
-*/
-
 static ssize_t
 show_temp_mode(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -1247,20 +1205,17 @@ show_temp_mode(struct device *dev, struc
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int index = sensor_attr->index;
-	u8 tmp;
+	int tmp;
 
-	if (data->has_temp >> index & 0x01) {
-		if (data->temp_mode >> index & 0x01)
-			tmp = 3;
-		else
-			tmp = 4;
-	} else {
-		tmp = 0;
-	}
+	if (data->temp_mode & (1 << index))
+		tmp = 3;	/* Thermal diode */
+	else
+		tmp = 4;	/* Thermistor */
 
 	return sprintf(buf, "%d\n", tmp);
 }
 
+/* Only for temp1-4 (temp5-6 can only be thermistor) */
 static ssize_t
 store_temp_mode(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
@@ -1270,45 +1225,31 @@ store_temp_mode(struct device *dev, stru
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int index = sensor_attr->index;
+	int reg_shift;
 	unsigned long val;
 	u8 tmp;
-	u32 mask;
 
 	if (strict_strtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 	if ((val != 4) && (val != 3))
 		return -EINVAL;
-	if ((index > 3) && (val = 3))
-		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 	if (val = 3) {
-		val = TEMP_CTRL_TD;
-		data->has_temp |= 1 << index;
+		/* Thermal diode */
+		val = 0x01;
 		data->temp_mode |= 1 << index;
 	} else if (val = 4) {
-		val = TEMP_CTRL_TR;
-		data->has_temp |= 1 << index;
-		tmp = 1 << index;
-		data->temp_mode &= ~tmp;
+		/* Thermistor */
+		val = 0x03;
+		data->temp_mode &= ~(1 << index);
 	}
 
-	if (index > 3)
-		tmp = w83795_read(client, W83795_REG_TEMP_CTRL1);
-	else
-		tmp = w83795_read(client, W83795_REG_TEMP_CTRL2);
-
-	mask = 0x03 << W83795_REG_TEMP_CTRL[index][TEMP_CTRL_SHIFT];
-	tmp &= ~mask;
-	tmp |= W83795_REG_TEMP_CTRL[index][val];
-
-	mask = 1 << W83795_REG_TEMP_CTRL[index][TEMP_CTRL_HASIN_SHIFT];
-	data->has_in &= ~mask;
-
-	if (index > 3)
-		w83795_write(client, W83795_REG_TEMP_CTRL1, tmp);
-	else
-		w83795_write(client, W83795_REG_TEMP_CTRL2, tmp);
+	reg_shift = 2 * index;
+	tmp = w83795_read(client, W83795_REG_TEMP_CTRL2);
+	tmp &= ~(0x03 << reg_shift);
+	tmp |= val << reg_shift;
+	w83795_write(client, W83795_REG_TEMP_CTRL2, tmp);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1506,7 +1447,7 @@ store_sf_setup(struct device *dev, struc
 		show_alarm_beep, store_beep, BEEP_ENABLE, index + 17) }
 
 #define SENSOR_ATTR_TEMP(index) {					\
-	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | S_IWUSR,		\
+	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 4 ? S_IWUSR : 0), \
 		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
 	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_temp,		\
 		NULL, TEMP_READ, index - 1),				\


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
