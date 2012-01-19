From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:17 +0000
Subject: [lm-sensors] [PATCH 23/82] hwmon: (f71882fg) Fix multi-line comments
Message-Id: <1327017376-20466-24-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f71882fg.c |   65 +++++++++++++++++++++++++++++-----------------
 1 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 2cada92..30bb3df 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -1,4 +1,5 @@
-/***************************************************************************
+/*
+ ***************************************************************************
  *   Copyright (C) 2006 by Hans Edgington <hans@edgington.nl>              *
  *   Copyright (C) 2007-2011 Hans de Goede <hdegoede@redhat.com>           *
  *                                                                         *
@@ -16,7 +17,8 @@
  *   along with this program; if not, write to the                         *
  *   Free Software Foundation, Inc.,                                       *
  *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
- ***************************************************************************/
+ ***************************************************************************
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -252,9 +254,11 @@ struct f71882fg_data {
 	u16	fan_full_speed[4];
 	u8	fan_status;
 	u8	fan_beep;
-	/* Note: all models have max 3 temperature channels, but on some
-	   they are addressed as 0-2 and on others as 1-3, so for coding
-	   convenience we reserve space for 4 channels */
+	/*
+	 * Note: all models have max 3 temperature channels, but on some
+	 * they are addressed as 0-2 and on others as 1-3, so for coding
+	 * convenience we reserve space for 4 channels
+	 */
 	u16	temp[4];
 	u8	temp_ovt[4];
 	u8	temp_high[4];
@@ -376,8 +380,10 @@ static struct platform_driver f71882fg_driver = {
 
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-/* Temp attr for the f71858fg, the f71858fg is special as it has its
-   temperature indexes start at 0 (the others start at 1) */
+/*
+ * Temp attr for the f71858fg, the f71858fg is special as it has its
+ * temperature indexes start at 0 (the others start at 1)
+ */
 static struct sensor_device_attribute_2 f71858fg_temp_attr[] = {
 	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
 	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
@@ -424,9 +430,11 @@ static struct sensor_device_attribute_2 fxxxx_temp_attr[3][9] = { {
 		store_temp_max, 0, 1),
 	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
 		store_temp_max_hyst, 0, 1),
-	/* Should really be temp1_max_alarm, but older versions did not handle
-	   the max and crit alarms separately and lm_sensors v2 depends on the
-	   presence of temp#_alarm files. The same goes for temp2/3 _alarm. */
+	/*
+	 * Should really be temp1_max_alarm, but older versions did not handle
+	 * the max and crit alarms separately and lm_sensors v2 depends on the
+	 * presence of temp#_alarm files. The same goes for temp2/3 _alarm.
+	 */
 	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
 		store_temp_crit, 0, 1),
@@ -485,10 +493,11 @@ static struct sensor_device_attribute_2 fxxxx_temp_beep_attr[3][2] = { {
 		store_temp_beep, 0, 7),
 } };
 
-/* Temp attr for the f8000
-   Note on the f8000 temp_ovt (crit) is used as max, and temp_high (max)
-   is used as hysteresis value to clear alarms
-   Also like the f71858fg its temperature indexes start at 0
+/*
+ * Temp attr for the f8000
+ * Note on the f8000 temp_ovt (crit) is used as max, and temp_high (max)
+ * is used as hysteresis value to clear alarms
+ * Also like the f71858fg its temperature indexes start at 0
  */
 static struct sensor_device_attribute_2 f8000_temp_attr[] = {
 	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
@@ -603,8 +612,10 @@ static struct sensor_device_attribute_2 fxxxx_fan_beep_attr[] = {
 		store_fan_beep, 0, 3),
 };
 
-/* PWM attr for the f71862fg, fewer pwms and fewer zones per pwm than the
-   standard models */
+/*
+ * PWM attr for the f71862fg, fewer pwms and fewer zones per pwm than the
+ * standard models
+ */
 static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[3][7] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
@@ -673,9 +684,11 @@ static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[3][7] = { {
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
 } };
 
-/* PWM attr for the f71808e/f71869, almost identical to the f71862fg, but the
-   pwm setting when the temperature is above the pwmX_auto_point1_temp can be
-   programmed instead of being hardcoded to 0xff */
+/*
+ * PWM attr for the f71808e/f71869, almost identical to the f71862fg, but the
+ * pwm setting when the temperature is above the pwmX_auto_point1_temp can be
+ * programmed instead of being hardcoded to 0xff
+ */
 static struct sensor_device_attribute_2 f71869_auto_pwm_attr[3][8] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
@@ -925,9 +938,11 @@ static struct sensor_device_attribute_2 f8000_fan_attr[] = {
 	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
 };
 
-/* PWM attr for the f8000, zones mapped to temp instead of to pwm!
-   Also the register block at offset A0 maps to TEMP1 (so our temp2, as the
-   F8000 starts counting temps at 0), B0 maps the TEMP2 and C0 maps to TEMP0 */
+/*
+ * PWM attr for the f8000, zones mapped to temp instead of to pwm!
+ * Also the register block at offset A0 maps to TEMP1 (so our temp2, as the
+ * F8000 starts counting temps at 0), B0 maps the TEMP2 and C0 maps to TEMP0
+ */
 static struct sensor_device_attribute_2 f8000_auto_pwm_attr[3][14] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
@@ -2295,8 +2310,10 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 			data->temp_config  				f71882fg_read8(data, F71882FG_REG_TEMP_CONFIG);
 			if (data->temp_config & 0x10)
-				/* The f71858fg temperature alarms behave as
-				   the f8000 alarms in this mode */
+				/*
+				 * The f71858fg temperature alarms behave as
+				 * the f8000 alarms in this mode
+				 */
 				err = f71882fg_create_sysfs_files(pdev,
 					f8000_temp_attr,
 					ARRAY_SIZE(f8000_temp_attr));
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
