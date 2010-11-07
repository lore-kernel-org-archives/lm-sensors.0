From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Nov 2010 15:47:59 +0000
Subject: [lm-sensors] [PATCH 7/7] hwmon: (w83795) Check for BEEP pin
Message-Id: <20101107164759.7e64110f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On the W83795ADG, there's a single pin for BEEP and OVT#, so you
can't have both. Check the configuration and don't create beep
attributes when BEEP pin is not available.

The W83795G has a dedicated BEEP pin so the functionality is always
available there.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 w83795.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 7 deletions(-)

--- a/drivers/hwmon/w83795.c	2010-11-06 22:40:03.000000000 +0100
+++ b/drivers/hwmon/w83795.c	2010-11-06 22:55:15.000000000 +0100
@@ -171,6 +171,9 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  #define W83795_REG_CLR_CHASSIS		0x4D
 #define W83795_REG_BEEP(index)		(0x50 + (index))
 
+#define W83795_REG_OVT_CFG		0x58
+#define OVT_CFG_SEL			(1 << 7)
+
 
 #define W83795_REG_FCMS1		0x201
 #define W83795_REG_FCMS2		0x208
@@ -378,6 +381,7 @@ struct w83795_data {
 	u8 setup_pwm[3];	/* Register value */
 
 	u8 alarms[6];		/* Register value */
+	u8 enable_beep;
 	u8 beeps[6];		/* Register value */
 
 	char valid;
@@ -508,8 +512,11 @@ static void w83795_update_limits(struct
 	}
 
 	/* Read beep settings */
-	for (i = 0; i < ARRAY_SIZE(data->beeps); i++)
-		data->beeps[i] = w83795_read(client, W83795_REG_BEEP(i));
+	if (data->enable_beep) {
+		for (i = 0; i < ARRAY_SIZE(data->beeps); i++)
+			data->beeps[i] +				w83795_read(client, W83795_REG_BEEP(i));
+	}
 
 	data->valid_limits = 1;
 }
@@ -1588,7 +1595,7 @@ store_sf_setup(struct device *dev, struc
 
 #define NOT_USED			-1
 
-/* Don't change the attribute order, _max and _min are accessed by index
+/* Don't change the attribute order, _max, _min and _beep are accessed by index
  * somewhere else in the code */
 #define SENSOR_ATTR_IN(index) {						\
 	SENSOR_ATTR_2(in##index##_input, S_IRUGO, show_in, NULL,	\
@@ -1603,6 +1610,8 @@ store_sf_setup(struct device *dev, struc
 		show_alarm_beep, store_beep, BEEP_ENABLE,		\
 		index + ((index > 14) ? 1 : 0)) }
 
+/* Don't change the attribute order, _beep is accessed by index
+ * somewhere else in the code */
 #define SENSOR_ATTR_FAN(index) {					\
 	SENSOR_ATTR_2(fan##index##_input, S_IRUGO, show_fan,		\
 		NULL, FAN_INPUT, index - 1), \
@@ -1631,6 +1640,8 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(fan##index##_target, S_IWUSR | S_IRUGO, \
 		show_fanin, store_fanin, FANIN_TARGET, index - 1) }
 
+/* Don't change the attribute order, _beep is accessed by index
+ * somewhere else in the code */
 #define SENSOR_ATTR_DTS(index) {					\
 	SENSOR_ATTR_2(temp##index##_type, S_IRUGO ,		\
 		show_dts_mode, NULL, NOT_USED, index - 7),	\
@@ -1649,6 +1660,8 @@ store_sf_setup(struct device *dev, struc
 	SENSOR_ATTR_2(temp##index##_beep, S_IWUSR | S_IRUGO,		\
 		show_alarm_beep, store_beep, BEEP_ENABLE, index + 17) }
 
+/* Don't change the attribute order, _beep is accessed by index
+ * somewhere else in the code */
 #define SENSOR_ATTR_TEMP(index) {					\
 	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 4 ? S_IWUSR : 0), \
 		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
@@ -1802,10 +1815,6 @@ static const struct sensor_device_attrib
 static const struct sensor_device_attribute_2 sda_single_files[] = {
 	SENSOR_ATTR_2(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm_beep,
 		      store_chassis_clear, ALARM_STATUS, 46),
-	SENSOR_ATTR_2(intrusion0_beep, S_IWUSR | S_IRUGO, show_alarm_beep,
-		      store_beep, BEEP_ENABLE, 46),
-	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_alarm_beep,
-		      store_beep, BEEP_ENABLE, 47),
 #ifdef CONFIG_SENSORS_W83795_FANCTRL
 	SENSOR_ATTR_2(speed_cruise_tolerance, S_IWUSR | S_IRUGO, show_fanin,
 		store_fanin, FANIN_TOL, NOT_USED),
@@ -1818,6 +1827,13 @@ static const struct sensor_device_attrib
 #endif
 };
 
+static const struct sensor_device_attribute_2 sda_beep_files[] = {
+	SENSOR_ATTR_2(intrusion0_beep, S_IWUSR | S_IRUGO, show_alarm_beep,
+		      store_beep, BEEP_ENABLE, 46),
+	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_alarm_beep,
+		      store_beep, BEEP_ENABLE, 47),
+};
+
 /*
  * Driver interface
  */
@@ -1947,6 +1963,8 @@ static int w83795_handle_files(struct de
 		if (!(data->has_in & (1 << i)))
 			continue;
 		for (j = 0; j < ARRAY_SIZE(w83795_in[0]); j++) {
+			if (j = 4 && !data->enable_beep)
+				continue;
 			err = fn(dev, &w83795_in[i][j].dev_attr);
 			if (err)
 				return err;
@@ -1957,6 +1975,8 @@ static int w83795_handle_files(struct de
 		if (!(data->has_fan & (1 << i)))
 			continue;
 		for (j = 0; j < ARRAY_SIZE(w83795_fan[0]); j++) {
+			if (j = 3 && !data->enable_beep)
+				continue;
 			err = fn(dev, &w83795_fan[i][j].dev_attr);
 			if (err)
 				return err;
@@ -1978,6 +1998,14 @@ static int w83795_handle_files(struct de
 			return err;
 	}
 
+	if (data->enable_beep) {
+		for (i = 0; i < ARRAY_SIZE(sda_beep_files); i++) {
+			err = fn(dev, &sda_beep_files[i].dev_attr);
+			if (err)
+				return err;
+		}
+	}
+
 #ifdef CONFIG_SENSORS_W83795_FANCTRL
 	for (i = 0; i < data->has_pwm; i++) {
 		for (j = 0; j < ARRAY_SIZE(w83795_pwm[0]); j++) {
@@ -1996,6 +2024,8 @@ static int w83795_handle_files(struct de
 #else
 		for (j = 0; j < 8; j++) {
 #endif
+			if (j = 7 && !data->enable_beep)
+				continue;
 			err = fn(dev, &w83795_temp[i][j].dev_attr);
 			if (err)
 				return err;
@@ -2007,6 +2037,8 @@ static int w83795_handle_files(struct de
 			if (!(data->has_dts & (1 << i)))
 				continue;
 			for (j = 0; j < ARRAY_SIZE(w83795_dts[0]); j++) {
+				if (j = 7 && !data->enable_beep)
+					continue;
 				err = fn(dev, &w83795_dts[i][j].dev_attr);
 				if (err)
 					return err;
@@ -2146,6 +2178,18 @@ static int w83795_probe(struct i2c_clien
 	else
 		data->has_pwm = 2;
 
+	/* Check if BEEP pin is available */
+	if (data->chip_type = w83795g) {
+		/* The W83795G has a dedicated BEEP pin */
+		data->enable_beep = 1;
+	} else {
+		/* The W83795ADG has a shared pin for OVT# and BEEP, so you
+		 * can't have both */
+		tmp = w83795_read(client, W83795_REG_OVT_CFG);
+		if ((tmp & OVT_CFG_SEL) = 0)
+			data->enable_beep = 1;
+	}
+
 	err = w83795_handle_files(dev, device_create_file);
 	if (err)
 		goto exit_remove;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
