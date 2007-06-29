From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jun 2007 07:19:14 +0000
Subject: [lm-sensors] [PATCH] hwmon/f71805f: Add temperature-tracking fan
Message-Id: <20070629091914.64e2ae93@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: "Phil Endecott" <kernel@chezphil.org>

Add support for the "temperature mode" fan speed control. In this mode,
the user can define 3 temperature/speed trip points, and the chip will
set the speed automatically according to the temperature changes.

Signed-off-by: Phil Endecott <kernel@chezphil.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Mark, please add this patch to your hwmon-testing tree, thanks.

 Documentation/hwmon/f71805f |   39 ++++++----
 drivers/hwmon/f71805f.c     |  167 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 190 insertions(+), 16 deletions(-)

--- linux-2.6.22-rc6.orig/drivers/hwmon/f71805f.c	2007-06-29 08:06:11.000000000 +0200
+++ linux-2.6.22-rc6/drivers/hwmon/f71805f.c	2007-06-29 09:10:27.000000000 +0200
@@ -127,6 +127,13 @@ superio_exit(int base)
 #define F71805F_REG_TEMP_HIGH(nr)	(0x54 + 2 * (nr))
 #define F71805F_REG_TEMP_HYST(nr)	(0x55 + 2 * (nr))
 #define F71805F_REG_TEMP_MODE		0x01
+/* pwm/fan pwmnr from 0 to 2, auto point apnr from 0 to 2 */
+/* map Fintek numbers to our numbers as follows: 9->0, 5->1, 1->2 */
+#define F71805F_REG_PWM_AUTO_POINT_TEMP(pwmnr, apnr) \
+					(0xA0 + 0x10 * (pwmnr) + (2 - (apnr)))
+#define F71805F_REG_PWM_AUTO_POINT_FAN(pwmnr, apnr) \
+					(0xA4 + 0x10 * (pwmnr) + \
+						2 * (2 - (apnr)))
 
 #define F71805F_REG_START		0x00
 /* status nr from 0 to 2 */
@@ -144,6 +151,11 @@ superio_exit(int base)
  * Data structures and manipulation thereof
  */
 
+struct f71805f_auto_point {
+	u8 temp[3];
+	u16 fan[3];
+};
+
 struct f71805f_data {
 	unsigned short addr;
 	const char *name;
@@ -170,6 +182,7 @@ struct f71805f_data {
 	u8 temp_hyst[3];
 	u8 temp_mode;
 	unsigned long alarms;
+	struct f71805f_auto_point auto_points[3];
 };
 
 struct f71805f_sio_data {
@@ -312,7 +325,7 @@ static void f71805f_write16(struct f7180
 static struct f71805f_data *f71805f_update_device(struct device *dev)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
-	int nr;
+	int nr, apnr;
 
 	mutex_lock(&data->update_lock);
 
@@ -342,6 +355,18 @@ static struct f71805f_data *f71805f_upda
 					      F71805F_REG_TEMP_HYST(nr));
 		}
 		data->temp_mode = f71805f_read8(data, F71805F_REG_TEMP_MODE);
+		for (nr = 0; nr < 3; nr++) {
+			for (apnr = 0; apnr < 3; apnr++) {
+				data->auto_points[nr].temp[apnr] +					f71805f_read8(data,
+					F71805F_REG_PWM_AUTO_POINT_TEMP(nr,
+									apnr));
+				data->auto_points[nr].fan[apnr] +					f71805f_read16(data,
+					F71805F_REG_PWM_AUTO_POINT_FAN(nr,
+								       apnr));
+			}
+		}
 
 		data->last_limits = jiffies;
 	}
@@ -705,6 +730,70 @@ static ssize_t set_pwm_freq(struct devic
 	return count;
 }
 
+static ssize_t show_pwm_auto_point_temp(struct device *dev,
+					struct device_attribute *devattr,
+					char* buf)
+{
+	struct f71805f_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int pwmnr = attr->nr;
+	int apnr = attr->index;
+
+	return sprintf(buf, "%ld\n",
+		       temp_from_reg(data->auto_points[pwmnr].temp[apnr]));
+}
+
+static ssize_t set_pwm_auto_point_temp(struct device *dev,
+				       struct device_attribute *devattr,
+				       const char* buf, size_t count)
+{
+	struct f71805f_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int pwmnr = attr->nr;
+	int apnr = attr->index;
+	unsigned long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->auto_points[pwmnr].temp[apnr] = temp_to_reg(val);
+	f71805f_write8(data, F71805F_REG_PWM_AUTO_POINT_TEMP(pwmnr, apnr),
+		       data->auto_points[pwmnr].temp[apnr]);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_fan(struct device *dev,
+				       struct device_attribute *devattr,
+				       char* buf)
+{
+	struct f71805f_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int pwmnr = attr->nr;
+	int apnr = attr->index;
+
+	return sprintf(buf, "%ld\n",
+		       fan_from_reg(data->auto_points[pwmnr].fan[apnr]));
+}
+
+static ssize_t set_pwm_auto_point_fan(struct device *dev,
+				      struct device_attribute *devattr,
+				      const char* buf, size_t count)
+{
+	struct f71805f_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int pwmnr = attr->nr;
+	int apnr = attr->index;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->auto_points[pwmnr].fan[apnr] = fan_to_reg(val);
+	f71805f_write16(data, F71805F_REG_PWM_AUTO_POINT_FAN(pwmnr, apnr),
+		        data->auto_points[pwmnr].fan[apnr]);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
@@ -932,6 +1021,63 @@ static SENSOR_DEVICE_ATTR(pwm3_freq, S_I
 			  show_pwm_freq, set_pwm_freq, 2);
 static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
 
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    0, 0);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    0, 1);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    0, 1);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    0, 2);
+static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    0, 2);
+
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    1, 0);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    1, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    1, 1);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    1, 2);
+static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    1, 2);
+
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    2, 0);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    2, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    2, 1);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
+			    2, 2);
+static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_fan, S_IRUGO | S_IWUSR,
+			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
+			    2, 2);
+
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
 static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
@@ -1014,6 +1160,25 @@ static struct attribute *f71805f_attribu
 	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp3_type.dev_attr.attr,
 
+	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_fan.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_fan.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point3_fan.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_fan.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_fan.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point3_fan.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_fan.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_fan.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point3_fan.dev_attr.attr,
+
 	&sensor_dev_attr_in0_alarm.dev_attr.attr,
 	&sensor_dev_attr_in1_alarm.dev_attr.attr,
 	&sensor_dev_attr_in2_alarm.dev_attr.attr,
--- linux-2.6.22-rc6.orig/Documentation/hwmon/f71805f	2007-06-29 08:06:11.000000000 +0200
+++ linux-2.6.22-rc6/Documentation/hwmon/f71805f	2007-06-29 08:55:57.000000000 +0200
@@ -5,11 +5,11 @@ Supported chips:
   * Fintek F71805F/FG
     Prefix: 'f71805f'
     Addresses scanned: none, address read from Super I/O config space
-    Datasheet: Provided by Fintek on request
+    Datasheet: Available from the Fintek website
   * Fintek F71872F/FG
     Prefix: 'f71872f'
     Addresses scanned: none, address read from Super I/O config space
-    Datasheet: Provided by Fintek on request
+    Datasheet: Available from the Fintek website
 
 Author: Jean Delvare <khali@linux-fr.org>
 
@@ -128,7 +128,9 @@ it.
 When the PWM method is used, you can select the operating frequency,
 from 187.5 kHz (default) to 31 Hz. The best frequency depends on the
 fan model. As a rule of thumb, lower frequencies seem to give better
-control, but may generate annoying high-pitch noise. Fintek recommends
+control, but may generate annoying high-pitch noise. So a frequency just
+above the audible range, such as 25 kHz, may be a good choice; if this
+doesn't give you good linear control, try reducing it. Fintek recommends
 not going below 1 kHz, as the fan tachometers get confused by lower
 frequencies as well.
 
@@ -136,16 +138,23 @@ When the DC method is used, Fintek recom
 corresponds to a pwm value of 106 for the driver. The driver doesn't
 enforce this limit though.
 
-Three different fan control modes are supported:
+Three different fan control modes are supported; the mode number is written
+to the pwm<n>_enable file.
 
-* Manual mode
-  You ask for a specific PWM duty cycle or DC voltage.
-
-* Fan speed mode
-  You ask for a specific fan speed. This mode assumes that pwm1
-  corresponds to fan1, pwm2 to fan2 and pwm3 to fan3.
-
-* Temperature mode
-  You define 3 temperature/fan speed trip points, and the fan speed is
-  adjusted depending on the measured temperature, using interpolation.
-  This mode is not yet supported by the driver.
+* 1: Manual mode
+  You ask for a specific PWM duty cycle or DC voltage by writing to the
+  pwm<n> file.
+
+* 2: Temperature mode
+  You define 3 temperature/fan speed trip points using the
+  pwm<n>_auto_point<m>_temp and _fan files. These define a staircase
+  relationship between temperature and fan speed with two additional points
+  interpolated between the values that you define. When the temperature
+  is below auto_point1_temp the fan is switched off.
+
+* 3: Fan speed mode
+  You ask for a specific fan speed by writing to the fan<n>_target file.
+
+Both of the automatic modes require that pwm1 corresponds to fan1, pwm2 to
+fan2 and pwm3 to fan3. Temperature mode also requires that temp1 corresponds
+to pwm1 and fan1, etc.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
