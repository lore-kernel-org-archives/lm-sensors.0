From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 20 Oct 2008 09:29:04 +0000
Subject: [lm-sensors] PATCH: f71882fg-sensor_attr2.patch [1/2]
Message-Id: <48FC4F60.8030003@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090303050705050509060100"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090303050705050509060100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>

Hi Jean (and all),

Add pwm support to the f71882fg driver. Changes made by me to the latest
revision submitted by Mark van Doesburg:
-Remove whitespace only changes from the patch (undo Lindent damage)
-Change pwm#_auto_point#_temp unit from degrees to milli degrees celcius
-Remove incomplete ability to turn of pwm (pwm#_enable = 0), as the hardware
  does not support this
-Made handling of out of range input to sysfs files more robust
-When we write a new setting to IC update our local cached copy of the register
  being written

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
CC: Mark van Doesburg <mark.vandoesburg@hetnet.nl>

Regards,

Hans



--------------090303050705050509060100
Content-Type: text/plain;
 name="f71882fg-pwm-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="f71882fg-pwm-support.patch"

From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>

Add pwm support to the f71882fg driver. Changes made by me to the latest
revision submitted by Mark van Doesburg:
-Remove whitespace only changes from the patch (undo Lindent damage)
-Change pwm#_auto_point#_temp unit from degrees to milli degrees celcius
-Remove incomplete ability to turn of pwm (pwm#_enable = 0), as the hardware
 does not support this
-Made handling of out of range input to sysfs files more robust
-When we write a new setting to IC update our local cached copy of the register
 being written

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
CC: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
--- f71882fg.c.orig	2008-10-20 09:53:36.000000000 +0200
+++ f71882fg.c	2008-10-20 10:44:11.000000000 +0200
@@ -27,11 +27,11 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #define DRVNAME "f71882fg"
 
-#define SIO_F71882FG_LD_HWM	0x04	/* Hardware monitor logical device*/
+#define SIO_F71882FG_LD_HWM	0x04	/* Hardware monitor logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
 #define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
 
@@ -57,6 +57,8 @@
 #define F71882FG_REG_IN1_HIGH		0x32
 
 #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
+#define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
+#define F71882FG_REG_FAN_FULL_SPEED(nr)	(0xA4 + (16 * (nr)))
 #define F71882FG_REG_FAN_STATUS		0x92
 #define F71882FG_REG_FAN_BEEP		0x93
 
@@ -70,6 +72,17 @@
 #define F71882FG_REG_TEMP_TYPE		0x6B
 #define F71882FG_REG_TEMP_DIODE_OPEN	0x6F
 
+#define F71882FG_REG_PWM(nr)            (0xA3 + (16 * (nr)))
+#define F71882FG_REG_PWM_TYPE		0x94
+#define F71882FG_REG_PWM_ENABLE         0x96
+
+#define F71882FG_REG_FAN_HYST0		0x98
+#define F71882FG_REG_FAN_HYST1		0x99
+
+#define F71882FG_REG_POINT_PWM(pwm, point)	(0xAA + point + (16 * (pwm)))
+#define F71882FG_REG_POINT_TEMP(pwm, point)	(0xA6 + point + (16 * (pwm)))
+#define F71882FG_REG_POINT_MAPPING(nr)		(0xAF + 16*(nr))
+
 #define	F71882FG_REG_START		0x01
 
 #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
@@ -78,7 +91,13 @@
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-static struct platform_device *f71882fg_pdev = NULL;
+static int fan_mode[4] = { 0, 0, 0, 0 };
+module_param_array(fan_mode, int, NULL, 0644);
+MODULE_PARM_DESC(fan_mode, "List of fan control modes (f71882fg only)"
+		 "(0=don't change, 1=pwm, 2=rpm)\n"
+		 "Note: this needs a write to pwm#_enable to take effect");
+
+static struct platform_device *f71882fg_pdev;
 
 /* Super-I/O Function prototypes */
 static inline int superio_inb(int base, int reg);
@@ -102,6 +121,8 @@
 	u8	in_status;
 	u8	in_beep;
 	u16	fan[4];
+	u16	fan_target[4];
+	u16	fan_full_speed[4];
 	u8	fan_status;
 	u8	fan_beep;
 	u8	temp[3];
@@ -112,9 +133,15 @@
 	u8	temp_status;
 	u8	temp_beep;
 	u8	temp_diode_open;
+	u8	pwm[4];
+	u8	pwm_enable;
+	u8	pwm_auto_point_hyst[2];
+	u8	pwm_auto_point_mapping[4];
+	u8	pwm_auto_point_pwm[4][5];
+	u8	pwm_auto_point_temp[4][4];
 };
 
-/* Sysfs in*/
+/* Sysfs in */
 static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
 	char *buf);
 static ssize_t show_in_max(struct device *dev, struct device_attribute
@@ -130,6 +157,10 @@
 /* Sysfs Fan */
 static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
 	char *buf);
+static ssize_t show_fan_full_speed(struct device *dev,
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_fan_full_speed(struct device *dev,
+	struct device_attribute *devattr, const char *buf, size_t count);
 static ssize_t show_fan_beep(struct device *dev, struct device_attribute
 	*devattr, char *buf);
 static ssize_t store_fan_beep(struct device *dev, struct device_attribute
@@ -163,6 +194,35 @@
 	*devattr, char *buf);
 static ssize_t show_temp_fault(struct device *dev, struct device_attribute
 	*devattr, char *buf);
+/* PWM and Auto point control */
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
+	char *buf);
+static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
+	const char *buf, size_t count);
+static ssize_t show_pwm_enable(struct device *dev,
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_enable(struct device *dev,
+	struct device_attribute	*devattr, const char *buf, size_t count);
+static ssize_t show_pwm_interpolate(struct device *dev,
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_interpolate(struct device *dev,
+	struct device_attribute *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_channel(struct device *dev,
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_auto_point_channel(struct device *dev,
+	struct device_attribute *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_temp_hyst(struct device *dev,
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev,
+	struct device_attribute *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_pwm(struct device *dev,
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_auto_point_pwm(struct device *dev,
+	struct device_attribute *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_temp(struct device *dev,
+	struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_auto_point_temp(struct device *dev,
+	struct device_attribute *devattr, const char *buf, size_t count);
 /* Sysfs misc */
 static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
 	char *buf);
@@ -248,26 +308,220 @@
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2)
 };
 
-static struct sensor_device_attribute_2 f71882fg_fan_attr[] =
-{
+static struct sensor_device_attribute_2 f71882fg_fan_attr[] = {
 	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
+	SENSOR_ATTR_2(fan1_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 0),
 	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 0),
 	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
 	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
+	SENSOR_ATTR_2(fan2_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 1),
 	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 1),
 	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
+	SENSOR_ATTR_2(fan3_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 2),
 	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 2),
 	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
 	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
+	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 3),
 	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 3),
-	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3)
-};
+	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
 
+	SENSOR_ATTR_2(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 0),
+	SENSOR_ATTR_2(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 0),
+	SENSOR_ATTR_2(pwm1_interpolate, S_IRUGO|S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 0),
+	SENSOR_ATTR_2(pwm1_auto_point4_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 0),
+	SENSOR_ATTR_2(pwm1_auto_point5_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 0),
+	SENSOR_ATTR_2(pwm1_auto_point4_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 0),
+	SENSOR_ATTR_2(pwm1_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
+
+	SENSOR_ATTR_2(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 1),
+	SENSOR_ATTR_2(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 1),
+	SENSOR_ATTR_2(pwm2_interpolate, S_IRUGO|S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 1),
+	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 1),
+	SENSOR_ATTR_2(pwm2_auto_point4_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 1),
+	SENSOR_ATTR_2(pwm2_auto_point5_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 1),
+	SENSOR_ATTR_2(pwm2_auto_point4_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 1),
+	SENSOR_ATTR_2(pwm2_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
+
+	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
+	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 2),
+	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO|S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 2),
+	SENSOR_ATTR_2(pwm3_auto_point5_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
+
+	SENSOR_ATTR_2(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 3),
+	SENSOR_ATTR_2(pwm4_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 3),
+	SENSOR_ATTR_2(pwm4_interpolate, S_IRUGO|S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 3),
+	SENSOR_ATTR_2(pwm4_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 3),
+	SENSOR_ATTR_2(pwm4_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 3),
+	SENSOR_ATTR_2(pwm4_auto_point5_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 3),
+	SENSOR_ATTR_2(pwm4_auto_point3_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 3),
+	SENSOR_ATTR_2(pwm4_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 3)
+};
 
 /* Super I/O functions */
 static inline int superio_inb(int base, int reg)
@@ -309,6 +563,11 @@
 	return reg ? (1500000 / reg) : 0;
 }
 
+static inline u16 fan_to_reg(u16 fan)
+{
+	return fan ? (1500000 / fan) : 0;
+}
+
 static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg)
 {
 	u8 val;
@@ -337,7 +596,15 @@
 	outb(val, data->addr + DATA_REG_OFFSET);
 }
 
-static struct f71882fg_data *f71882fg_update_device(struct device * dev)
+static void f71882fg_write16(struct f71882fg_data *data, u8 reg, u16 val)
+{
+	outb(reg++, data->addr + ADDR_REG_OFFSET);
+	outb(val >> 8, data->addr + DATA_REG_OFFSET);
+	outb(reg, data->addr + ADDR_REG_OFFSET);
+	outb(val & 255, data->addr + DATA_REG_OFFSET);
+}
+
+static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr, reg, reg2;
@@ -383,6 +650,32 @@
 
 		data->fan_beep = f71882fg_read8(data, F71882FG_REG_FAN_BEEP);
 
+		data->pwm_enable = f71882fg_read8(data,
+						  F71882FG_REG_PWM_ENABLE);
+		data->pwm_auto_point_hyst[0] = f71882fg_read8(data,
+						      F71882FG_REG_FAN_HYST0);
+		data->pwm_auto_point_hyst[1] = f71882fg_read8(data,
+						      F71882FG_REG_FAN_HYST1);
+		for (nr = 0; nr < 4; nr++) {
+			int point;
+
+			data->pwm_auto_point_mapping[nr] =
+			    f71882fg_read8(data,
+					   F71882FG_REG_POINT_MAPPING(nr));
+
+			for (point = 0; point < 5; point++) {
+				data->pwm_auto_point_pwm[nr][point] =
+				    f71882fg_read8(data,
+						   F71882FG_REG_POINT_PWM
+						   (nr, point));
+			}
+			for (point = 0; point < 4; point++) {
+				data->pwm_auto_point_temp[nr][point] =
+				    f71882fg_read8(data,
+						   F71882FG_REG_POINT_TEMP
+						   (nr, point));
+			}
+		}
 		data->last_limits = jiffies;
 	}
 
@@ -398,9 +691,17 @@
 
 		data->fan_status = f71882fg_read8(data,
 						F71882FG_REG_FAN_STATUS);
-		for (nr = 0; nr < 4; nr++)
+		for (nr = 0; nr < 4; nr++) {
 			data->fan[nr] = f71882fg_read16(data,
 						F71882FG_REG_FAN(nr));
+			data->fan_target[nr] =
+			    f71882fg_read16(data, F71882FG_REG_FAN_TARGET(nr));
+			data->fan_full_speed[nr] =
+			    f71882fg_read16(data,
+					    F71882FG_REG_FAN_FULL_SPEED(nr));
+			data->pwm[nr] =
+			    f71882fg_read8(data, F71882FG_REG_PWM(nr));
+		}
 
 		data->in_status = f71882fg_read8(data,
 						F71882FG_REG_IN_STATUS);
@@ -431,6 +732,40 @@
 	return sprintf(buf, "%d\n", speed);
 }
 
+static ssize_t show_fan_full_speed(struct device *dev,
+				   struct device_attribute *devattr, char *buf)
+{
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int speed = fan_from_reg(data->fan_full_speed[nr]);
+	return sprintf(buf, "%d\n", speed);
+}
+
+static ssize_t store_fan_full_speed(struct device *dev,
+				    struct device_attribute *devattr,
+				    const char *buf, size_t count)
+{
+	struct f71882fg_data *data = dev_get_drvdata(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	long val = simple_strtol(buf, NULL, 10);
+
+	val = SENSORS_LIMIT(val, 23, 1500000);
+	val = fan_to_reg(val);
+
+	mutex_lock(&data->update_lock);
+	if (data->pwm_enable & (1 << (2 * nr)))
+		/* PWM mode */
+		count = -EINVAL;
+	else {
+		/* RPM mode */
+		f71882fg_write16(data, F71882FG_REG_FAN_FULL_SPEED(nr), val);
+		data->fan_full_speed[nr] = val;
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_fan_beep(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
@@ -738,6 +1073,323 @@
 		return sprintf(buf, "0\n");
 }
 
+static ssize_t show_pwm(struct device *dev,
+			struct device_attribute *devattr, char *buf)
+{
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int val, nr = to_sensor_dev_attr_2(devattr)->index;
+	if (data->pwm_enable & (1 << (2 * nr)))
+		/* PWM mode */
+		val = data->pwm[nr];
+	else {
+		/* RPM mode */
+		mutex_lock(&data->update_lock);
+		val = 255 * fan_from_reg(data->fan_target[nr])
+			/ fan_from_reg(data->fan_full_speed[nr]);
+		mutex_unlock(&data->update_lock);
+	}
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t store_pwm(struct device *dev,
+			 struct device_attribute *devattr, const char *buf,
+			 size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	long val = simple_strtol(buf, NULL, 10);
+	val = SENSORS_LIMIT(val, 0, 255);
+
+	mutex_lock(&data->update_lock);
+	if (data->pwm_enable & (1 << (2 * nr))) {
+		/* PWM mode */
+		f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
+		data->pwm[nr] = val;
+	} else {
+		/* RPM mode */
+		int target = val * fan_from_reg(data->fan_full_speed[nr]) / 255;
+		f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr),
+				 fan_to_reg(target));
+		data->fan_target[nr] = fan_to_reg(target);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_enable(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+
+	if (data->pwm_enable & (2 << (2 * nr)))
+		result = 1;
+	else
+		result = 2;
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
+				*devattr, const char *buf, size_t count)
+{
+	struct f71882fg_data *data = dev_get_drvdata(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	long val = simple_strtol(buf, NULL, 10);
+	if (val < 1 || val > 2)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 1:
+		data->pwm_enable |= 2 << (2 * nr);
+		break;		/* Manual */
+	case 2:
+		data->pwm_enable &= ~(2 << (2 * nr));
+		break;		/* Temperature ctrl */
+	}
+	switch (fan_mode[nr]) {
+	case 1:
+		data->pwm_enable |= 1 << (2 * nr);
+		break;		/* Duty cycle mode */
+	case 2:
+		data->pwm_enable &= ~(1 << (2 * nr));
+		break;		/* RPM mode */
+	}
+	f71882fg_write8(data, F71882FG_REG_PWM_ENABLE, data->pwm_enable);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_pwm(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int pwm = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+
+	if (data->pwm_enable & (1 << (2 * pwm))) {
+		/* PWM mode */
+		result = data->pwm_auto_point_pwm[pwm][point];
+	} else {
+		/* RPM mode */
+		result = 32 * 255 / (32 + data->pwm_auto_point_pwm[pwm][point]);
+	}
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_pwm(struct device *dev,
+					struct device_attribute *devattr,
+					const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int pwm = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+	int val = simple_strtoul(buf, NULL, 10);
+	val = SENSORS_LIMIT(val, 0, 255);
+
+	mutex_lock(&data->update_lock);
+	if (data->pwm_enable & (1 << (2 * pwm))) {
+		/* PWM mode */
+	} else {
+		/* RPM mode */
+		if (val < 29)	/* Prevent negative numbers */
+			val = 255;
+		else
+			val = (255 - val) * 32 / val;
+	}
+	f71882fg_write8(data, F71882FG_REG_POINT_PWM(pwm, point), val);
+	data->pwm_auto_point_pwm[pwm][point] = val;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_temp_hyst(struct device *dev,
+					     struct device_attribute *devattr,
+					     char *buf)
+{
+	int result = 0;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+
+	mutex_lock(&data->update_lock);
+	switch (nr) {
+	case 0:
+		result = data->pwm_auto_point_hyst[0] & 15;
+		break;
+	case 1:
+		result = data->pwm_auto_point_hyst[0] >> 4;
+		break;
+	case 2:
+		result = data->pwm_auto_point_hyst[1] & 15;
+		break;
+	case 3:
+		result = data->pwm_auto_point_hyst[1] >> 4;
+		break;
+	}
+	result = 1000 * (data->pwm_auto_point_temp[nr][point] - result);
+	mutex_unlock(&data->update_lock);
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev,
+					      struct device_attribute *devattr,
+					      const char *buf, size_t count)
+{
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+	long val = simple_strtol(buf, NULL, 10) / 1000;
+
+	mutex_lock(&data->update_lock);
+	val = SENSORS_LIMIT(val, data->pwm_auto_point_temp[nr][point] - 15,
+				data->pwm_auto_point_temp[nr][point]);
+	val = data->pwm_auto_point_temp[nr][point] - val;
+
+	switch (nr) {
+	case 0:
+		val = (data->pwm_auto_point_hyst[0] & 0xf0) | val;
+		break;
+	case 1:
+		val = (data->pwm_auto_point_hyst[0] & 0x0f) | (val << 4);
+		break;
+	case 2:
+		val = (data->pwm_auto_point_hyst[1] & 0xf0) | val;
+		break;
+	case 3:
+		val = (data->pwm_auto_point_hyst[1] & 0x0f) | (val << 4);
+		break;
+	}
+	if (nr == 0 || nr == 1) {
+		f71882fg_write8(data, F71882FG_REG_FAN_HYST0, val);
+		data->pwm_auto_point_hyst[0] = val;
+	} else {
+		f71882fg_write8(data, F71882FG_REG_FAN_HYST1, val);
+		data->pwm_auto_point_hyst[1] = val;
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_interpolate(struct device *dev,
+				    struct device_attribute *devattr, char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+
+	result = (data->pwm_auto_point_mapping[nr] >> 4) & 1;
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_interpolate(struct device *dev,
+				     struct device_attribute *devattr,
+				     const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int val = simple_strtoul(buf, NULL, 10);
+	mutex_lock(&data->update_lock);
+	if (val)
+		val = data->pwm_auto_point_mapping[nr] | (1 << 4);
+	else
+		val = data->pwm_auto_point_mapping[nr] & (~(1 << 4));
+	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val);
+	data->pwm_auto_point_mapping[nr] = val;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_channel(struct device *dev,
+					   struct device_attribute *devattr,
+					   char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+
+	result = 1 << ((data->pwm_auto_point_mapping[nr] & 3) - 1);
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_channel(struct device *dev,
+					    struct device_attribute *devattr,
+					    const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	long val = simple_strtol(buf, NULL, 10);
+	switch (val) {
+	case 1:
+		val = 1;
+		break;
+	case 2:
+		val = 2;
+		break;
+	case 4:
+		val = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+	mutex_lock(&data->update_lock);
+	val = (data->pwm_auto_point_mapping[nr] & 0xfc) | val;
+	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val);
+	data->pwm_auto_point_mapping[nr] = val;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_temp(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int pwm = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+
+	result = data->pwm_auto_point_temp[pwm][point];
+	return sprintf(buf, "%d\n", 1000 * result);
+}
+
+static ssize_t store_pwm_auto_point_temp(struct device *dev,
+					 struct device_attribute *devattr,
+					 const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int pwm = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+	long val = simple_strtol(buf, NULL, 10) / 1000;
+	val = SENSORS_LIMIT(val, 0, 255);
+
+	mutex_lock(&data->update_lock);
+	f71882fg_write8(data, F71882FG_REG_POINT_TEMP(pwm, point), val);
+	data->pwm_auto_point_temp[pwm][point] = val;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
 	char *buf)
 {

--------------090303050705050509060100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090303050705050509060100--
