From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 09 Sep 2011 10:12:33 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon/f71882fg: Make all fan/pwm attr
Message-Id: <1315563155-15774-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a preparation patch for not registering fan/pwm attributes for
some fans (rather then register them for all or for none).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |   50 +++++++++++++++++++++++----------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 2d96ed2..c0805aa 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -605,7 +605,7 @@ static struct sensor_device_attribute_2 fxxxx_fan_beep_attr[] = {
 
 /* PWM attr for the f71862fg, fewer pwms and fewer zones per pwm than the
    standard models */
-static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
+static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[3][7] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 0),
@@ -627,7 +627,7 @@ static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
 		      0, 0),
 	SENSOR_ATTR_2(pwm1_auto_point2_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
-
+}, {
 	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 1),
@@ -649,7 +649,7 @@ static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
 		      0, 1),
 	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
-
+}, {
 	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 2),
@@ -671,12 +671,12 @@ static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
 		      0, 2),
 	SENSOR_ATTR_2(pwm3_auto_point2_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
-};
+} };
 
 /* PWM attr for the f71808e/f71869, almost identical to the f71862fg, but the
    pwm setting when the temperature is above the pwmX_auto_point1_temp can be
    programmed instead of being hardcoded to 0xff */
-static struct sensor_device_attribute_2 f71869_auto_pwm_attr[] = {
+static struct sensor_device_attribute_2 f71869_auto_pwm_attr[3][8] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 0),
@@ -701,7 +701,7 @@ static struct sensor_device_attribute_2 f71869_auto_pwm_attr[] = {
 		      0, 0),
 	SENSOR_ATTR_2(pwm1_auto_point2_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
-
+}, {
 	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 1),
@@ -726,7 +726,7 @@ static struct sensor_device_attribute_2 f71869_auto_pwm_attr[] = {
 		      0, 1),
 	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
-
+}, {
 	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 2),
@@ -751,7 +751,7 @@ static struct sensor_device_attribute_2 f71869_auto_pwm_attr[] = {
 		      0, 2),
 	SENSOR_ATTR_2(pwm3_auto_point2_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
-};
+} };
 
 /* PWM attr for the standard models */
 static struct sensor_device_attribute_2 fxxxx_auto_pwm_attr[4][14] = { {
@@ -928,7 +928,7 @@ static struct sensor_device_attribute_2 f8000_fan_attr[] = {
 /* PWM attr for the f8000, zones mapped to temp instead of to pwm!
    Also the register block at offset A0 maps to TEMP1 (so our temp2, as the
    F8000 starts counting temps at 0), B0 maps the TEMP2 and C0 maps to TEMP0 */
-static struct sensor_device_attribute_2 f8000_auto_pwm_attr[] = {
+static struct sensor_device_attribute_2 f8000_auto_pwm_attr[3][14] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 0),
@@ -969,7 +969,7 @@ static struct sensor_device_attribute_2 f8000_auto_pwm_attr[] = {
 		      show_pwm_auto_point_temp_hyst, NULL, 2, 2),
 	SENSOR_ATTR_2(temp1_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
-
+}, {
 	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 1),
@@ -1010,7 +1010,7 @@ static struct sensor_device_attribute_2 f8000_auto_pwm_attr[] = {
 		      show_pwm_auto_point_temp_hyst, NULL, 2, 0),
 	SENSOR_ATTR_2(temp2_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
-
+}, {
 	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 2),
@@ -1051,7 +1051,7 @@ static struct sensor_device_attribute_2 f8000_auto_pwm_attr[] = {
 		      show_pwm_auto_point_temp_hyst, NULL, 2, 1),
 	SENSOR_ATTR_2(temp3_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
-};
+} };
 
 /* Super I/O functions */
 static inline int superio_inb(int base, int reg)
@@ -2351,14 +2351,15 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 			break;
 		case f71862fg:
 			err = f71882fg_create_sysfs_files(pdev,
-					f71862fg_auto_pwm_attr,
-					ARRAY_SIZE(f71862fg_auto_pwm_attr));
+				&f71862fg_auto_pwm_attr[0][0],
+				ARRAY_SIZE(f71862fg_auto_pwm_attr[0]) *
+					nr_fans);
 			break;
 		case f71808e:
 		case f71869:
 			err = f71882fg_create_sysfs_files(pdev,
-					f71869_auto_pwm_attr,
-					ARRAY_SIZE(f71869_auto_pwm_attr));
+				&f71869_auto_pwm_attr[0][0],
+				ARRAY_SIZE(f71869_auto_pwm_attr[0]) * nr_fans);
 			break;
 		case f8000:
 			err = f71882fg_create_sysfs_files(pdev,
@@ -2367,8 +2368,8 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 			if (err)
 				goto exit_unregister_sysfs;
 			err = f71882fg_create_sysfs_files(pdev,
-					f8000_auto_pwm_attr,
-					ARRAY_SIZE(f8000_auto_pwm_attr));
+				&f8000_auto_pwm_attr[0][0],
+				ARRAY_SIZE(f8000_auto_pwm_attr[0]) * nr_fans);
 			break;
 		default:
 			err = f71882fg_create_sysfs_files(pdev,
@@ -2476,22 +2477,23 @@ static int f71882fg_remove(struct platform_device *pdev)
 			break;
 		case f71862fg:
 			f71882fg_remove_sysfs_files(pdev,
-					f71862fg_auto_pwm_attr,
-					ARRAY_SIZE(f71862fg_auto_pwm_attr));
+				&f71862fg_auto_pwm_attr[0][0],
+				ARRAY_SIZE(f71862fg_auto_pwm_attr[0]) *
+					nr_fans);
 			break;
 		case f71808e:
 		case f71869:
 			f71882fg_remove_sysfs_files(pdev,
-					f71869_auto_pwm_attr,
-					ARRAY_SIZE(f71869_auto_pwm_attr));
+				&f71869_auto_pwm_attr[0][0],
+				ARRAY_SIZE(f71869_auto_pwm_attr[0]) * nr_fans);
 			break;
 		case f8000:
 			f71882fg_remove_sysfs_files(pdev,
 					f8000_fan_attr,
 					ARRAY_SIZE(f8000_fan_attr));
 			f71882fg_remove_sysfs_files(pdev,
-					f8000_auto_pwm_attr,
-					ARRAY_SIZE(f8000_auto_pwm_attr));
+				&f8000_auto_pwm_attr[0][0],
+				ARRAY_SIZE(f8000_auto_pwm_attr[0]) * nr_fans);
 			break;
 		default:
 			f71882fg_remove_sysfs_files(pdev,
-- 
1.7.6.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
