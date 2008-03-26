From: Juerg Haefliger <juergh@gmail.com>
Date: Wed, 26 Mar 2008 04:49:02 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon (dme1737): demacrofy for readability
Message-Id: <47E9D5BE.8020905@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080104070803080107010908"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080104070803080107010908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch gets rid of a couple of macros previously used for sysfs 
attribute generation and manipulation. This makes the source a little 
bigger but a lot more readable and maintainable. It also fixes an issue 
with pwm5 & pwm6 attributes not being created read-only initially.

Signed-Off-By: Juerg Haefliger <juergh at gmail.com>


--------------080104070803080107010908
Content-Type: text/plain;
 name="dme1737-demacrofy-for-readability.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="dme1737-demacrofy-for-readability.patch"

This patch gets rid of a couple of macros previously used for sysfs attribute
generation and manipulation. This makes the source a little bigger but a lot
more readable and maintainable. It also fixes an issue with pwm5 & pwm6
attributes not being created read-only initially.

Signed-Off-By: Juerg Haefliger <juergh at gmail.com>

Index: linux/drivers/hwmon/dme1737.c
===================================================================
--- linux.orig/drivers/hwmon/dme1737.c	2008-03-11 20:32:44.000000000 -0700
+++ linux/drivers/hwmon/dme1737.c	2008-03-15 22:12:39.000000000 -0700
@@ -1501,9 +1501,9 @@
 /* PWMs 5-6 */
 
 #define SENSOR_DEVICE_ATTR_PWM_5TO6(ix) \
-static SENSOR_DEVICE_ATTR_2(pwm##ix, S_IRUGO | S_IWUSR, \
+static SENSOR_DEVICE_ATTR_2(pwm##ix, S_IRUGO, \
 	show_pwm, set_pwm, SYS_PWM, ix-1); \
-static SENSOR_DEVICE_ATTR_2(pwm##ix##_freq, S_IRUGO | S_IWUSR, \
+static SENSOR_DEVICE_ATTR_2(pwm##ix##_freq, S_IRUGO, \
 	show_pwm, set_pwm, SYS_PWM_FREQ, ix-1); \
 static SENSOR_DEVICE_ATTR_2(pwm##ix##_enable, S_IRUGO, \
 	show_pwm, NULL, SYS_PWM_ENABLE, ix-1)
@@ -1517,91 +1517,75 @@
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);   /* for ISA devices */
 
-#define SENSOR_DEV_ATTR_IN(ix) \
-&sensor_dev_attr_in##ix##_input.dev_attr.attr, \
-&sensor_dev_attr_in##ix##_min.dev_attr.attr, \
-&sensor_dev_attr_in##ix##_max.dev_attr.attr, \
-&sensor_dev_attr_in##ix##_alarm.dev_attr.attr
-
-/* These attributes are read-writeable only if the chip is *not* locked */
-#define SENSOR_DEV_ATTR_TEMP_LOCK(ix) \
-&sensor_dev_attr_temp##ix##_offset.dev_attr.attr
-
-#define SENSOR_DEV_ATTR_TEMP(ix) \
-SENSOR_DEV_ATTR_TEMP_LOCK(ix), \
-&sensor_dev_attr_temp##ix##_input.dev_attr.attr, \
-&sensor_dev_attr_temp##ix##_min.dev_attr.attr, \
-&sensor_dev_attr_temp##ix##_max.dev_attr.attr, \
-&sensor_dev_attr_temp##ix##_alarm.dev_attr.attr, \
-&sensor_dev_attr_temp##ix##_fault.dev_attr.attr
-
-/* These attributes are read-writeable only if the chip is *not* locked */
-#define SENSOR_DEV_ATTR_ZONE_LOCK(ix) \
-&sensor_dev_attr_zone##ix##_auto_point1_temp_hyst.dev_attr.attr, \
-&sensor_dev_attr_zone##ix##_auto_point1_temp.dev_attr.attr, \
-&sensor_dev_attr_zone##ix##_auto_point2_temp.dev_attr.attr, \
-&sensor_dev_attr_zone##ix##_auto_point3_temp.dev_attr.attr
-
-#define SENSOR_DEV_ATTR_ZONE(ix) \
-SENSOR_DEV_ATTR_ZONE_LOCK(ix), \
-&sensor_dev_attr_zone##ix##_auto_channels_temp.dev_attr.attr
-
-#define SENSOR_DEV_ATTR_FAN_1TO4(ix) \
-&sensor_dev_attr_fan##ix##_input.dev_attr.attr, \
-&sensor_dev_attr_fan##ix##_min.dev_attr.attr, \
-&sensor_dev_attr_fan##ix##_alarm.dev_attr.attr, \
-&sensor_dev_attr_fan##ix##_type.dev_attr.attr
-
-#define SENSOR_DEV_ATTR_FAN_5TO6(ix) \
-&sensor_dev_attr_fan##ix##_input.dev_attr.attr, \
-&sensor_dev_attr_fan##ix##_min.dev_attr.attr, \
-&sensor_dev_attr_fan##ix##_alarm.dev_attr.attr, \
-&sensor_dev_attr_fan##ix##_max.dev_attr.attr
-
-/* These attributes are read-writeable only if the chip is *not* locked */
-#define SENSOR_DEV_ATTR_PWM_1TO3_LOCK(ix) \
-&sensor_dev_attr_pwm##ix##_freq.dev_attr.attr, \
-&sensor_dev_attr_pwm##ix##_enable.dev_attr.attr, \
-&sensor_dev_attr_pwm##ix##_ramp_rate.dev_attr.attr, \
-&sensor_dev_attr_pwm##ix##_auto_channels_zone.dev_attr.attr, \
-&sensor_dev_attr_pwm##ix##_auto_pwm_min.dev_attr.attr, \
-&sensor_dev_attr_pwm##ix##_auto_point1_pwm.dev_attr.attr
-
-#define SENSOR_DEV_ATTR_PWM_1TO3(ix) \
-SENSOR_DEV_ATTR_PWM_1TO3_LOCK(ix), \
-&sensor_dev_attr_pwm##ix.dev_attr.attr, \
-&sensor_dev_attr_pwm##ix##_auto_point2_pwm.dev_attr.attr
-
-/* These attributes are read-writeable only if the chip is *not* locked */
-#define SENSOR_DEV_ATTR_PWM_5TO6_LOCK(ix) \
-&sensor_dev_attr_pwm##ix.dev_attr.attr, \
-&sensor_dev_attr_pwm##ix##_freq.dev_attr.attr
-
-#define SENSOR_DEV_ATTR_PWM_5TO6(ix) \
-SENSOR_DEV_ATTR_PWM_5TO6_LOCK(ix), \
-&sensor_dev_attr_pwm##ix##_enable.dev_attr.attr
-
 /* This struct holds all the attributes that are always present and need to be
  * created unconditionally. The attributes that need modification of their
  * permissions are created read-only and write permissions are added or removed
  * on the fly when required */
 static struct attribute *dme1737_attr[] ={
 	/* Voltages */
-	SENSOR_DEV_ATTR_IN(0),
-	SENSOR_DEV_ATTR_IN(1),
-	SENSOR_DEV_ATTR_IN(2),
-	SENSOR_DEV_ATTR_IN(3),
-	SENSOR_DEV_ATTR_IN(4),
-	SENSOR_DEV_ATTR_IN(5),
-	SENSOR_DEV_ATTR_IN(6),
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,
 	/* Temperatures */
-	SENSOR_DEV_ATTR_TEMP(1),
-	SENSOR_DEV_ATTR_TEMP(2),
-	SENSOR_DEV_ATTR_TEMP(3),
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_fault.dev_attr.attr,
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 	/* Zones */
-	SENSOR_DEV_ATTR_ZONE(1),
-	SENSOR_DEV_ATTR_ZONE(2),
-	SENSOR_DEV_ATTR_ZONE(3),
+	&sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_zone1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_zone1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_zone1_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_zone1_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_channels_temp.dev_attr.attr,
 	/* Misc */
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
@@ -1616,23 +1600,48 @@
  * Their creation depends on the chip configuration which is determined during
  * module load. */
 static struct attribute *dme1737_attr_pwm1[] = {
-	SENSOR_DEV_ATTR_PWM_1TO3(1),
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm1_ramp_rate.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_channels_zone.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_pwm2[] = {
-	SENSOR_DEV_ATTR_PWM_1TO3(2),
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_ramp_rate.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels_zone.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_pwm3[] = {
-	SENSOR_DEV_ATTR_PWM_1TO3(3),
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3_ramp_rate.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_channels_zone.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_pwm5[] = {
-	SENSOR_DEV_ATTR_PWM_5TO6(5),
+	&sensor_dev_attr_pwm5.dev_attr.attr,
+	&sensor_dev_attr_pwm5_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm5_enable.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_pwm6[] = {
-	SENSOR_DEV_ATTR_PWM_5TO6(6),
+	&sensor_dev_attr_pwm6.dev_attr.attr,
+	&sensor_dev_attr_pwm6_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm6_enable.dev_attr.attr,
 	NULL
 };
 
@@ -1649,27 +1658,45 @@
  * Their creation depends on the chip configuration which is determined during
  * module load. */
 static struct attribute *dme1737_attr_fan1[] = {
-	SENSOR_DEV_ATTR_FAN_1TO4(1),
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan1_type.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_fan2[] = {
-	SENSOR_DEV_ATTR_FAN_1TO4(2),
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan2_type.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_fan3[] = {
-	SENSOR_DEV_ATTR_FAN_1TO4(3),
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan3_type.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_fan4[] = {
-	SENSOR_DEV_ATTR_FAN_1TO4(4),
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan4_type.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_fan5[] = {
-	SENSOR_DEV_ATTR_FAN_5TO6(5),
+	&sensor_dev_attr_fan5_input.dev_attr.attr,
+	&sensor_dev_attr_fan5_min.dev_attr.attr,
+	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan5_max.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_fan6[] = {
-	SENSOR_DEV_ATTR_FAN_5TO6(6),
+	&sensor_dev_attr_fan6_input.dev_attr.attr,
+	&sensor_dev_attr_fan6_min.dev_attr.attr,
+	&sensor_dev_attr_fan6_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan6_max.dev_attr.attr,
 	NULL
 };
 
@@ -1686,13 +1713,22 @@
  * writeable if the chip is *not* locked. Otherwise they stay read-only. */
 static struct attribute *dme1737_attr_lock[] = {
 	/* Temperatures */
-	SENSOR_DEV_ATTR_TEMP_LOCK(1),
-	SENSOR_DEV_ATTR_TEMP_LOCK(2),
-	SENSOR_DEV_ATTR_TEMP_LOCK(3),
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 	/* Zones */
-	SENSOR_DEV_ATTR_ZONE_LOCK(1),
-	SENSOR_DEV_ATTR_ZONE_LOCK(2),
-	SENSOR_DEV_ATTR_ZONE_LOCK(3),
+	&sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_zone1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_zone1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_zone1_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_zone2_auto_point3_temp.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_point1_temp_hyst.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_zone3_auto_point3_temp.dev_attr.attr,
 	NULL
 };
 
@@ -1704,23 +1740,40 @@
  * writeable if the chip is *not* locked and the respective PWM is available.
  * Otherwise they stay read-only. */
 static struct attribute *dme1737_attr_pwm1_lock[] = {
-	SENSOR_DEV_ATTR_PWM_1TO3_LOCK(1),
+	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm1_ramp_rate.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_channels_zone.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_pwm2_lock[] = {
-	SENSOR_DEV_ATTR_PWM_1TO3_LOCK(2),
+	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_ramp_rate.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels_zone.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_pwm3_lock[] = {
-	SENSOR_DEV_ATTR_PWM_1TO3_LOCK(3),
+	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3_ramp_rate.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_channels_zone.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_pwm5_lock[] = {
-	SENSOR_DEV_ATTR_PWM_5TO6_LOCK(5),
+	&sensor_dev_attr_pwm5.dev_attr.attr,
+	&sensor_dev_attr_pwm5_freq.dev_attr.attr,
 	NULL
 };
 static struct attribute *dme1737_attr_pwm6_lock[] = {
-	SENSOR_DEV_ATTR_PWM_5TO6_LOCK(6),
+	&sensor_dev_attr_pwm6.dev_attr.attr,
+	&sensor_dev_attr_pwm6_freq.dev_attr.attr,
 	NULL
 };
 

--------------080104070803080107010908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080104070803080107010908--
