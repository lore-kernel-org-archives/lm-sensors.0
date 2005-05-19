From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: w83781d and alarms for temp2 and temp3
Message-Id: <20040508104131.GA25641@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040501224829.GA13732@pc.aurel32.lan>
In-Reply-To: <20040501224829.GA13732@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 07, 2004 at 10:37:08PM +0200, Jean Delvare wrote:
>  static const char *
> -fmtTemps_W83781D
> +fmtTemps_AS99127F_W83781D
>  (const double values[], int alarm, int beep) {
> 
> Please don't rename that function. It adds noise to the patch with no
> benefit. What's more, the AS99127F is admittedly an undocumented clone
> of the Winbond chips. It doesn't deserve additional attention or credit.

Ok, new try. Patch is attached.


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/prog/sensord/chips.c lm_sensors2/prog/sensord/chips.c
--- lm_sensors2.orig/prog/sensord/chips.c	2004-05-08 12:30:47.000000000 +0200
+++ lm_sensors2/prog/sensord/chips.c	2004-05-08 12:36:41.000000000 +0200
@@ -599,10 +599,9 @@
 }
 
 static const char *w83781d_names[] = {
-  SENSORS_W83781D_PREFIX, SENSORS_AS99127F_PREFIX, NULL
+  SENSORS_W83781D_PREFIX, NULL
 };
 
-/* TODO: beeps inverted for as99127f */
 static const FeatureDescriptor w83781d_features[] = {
   { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN0, W83781D_ALARM_IN0,
     { SENSORS_W83781D_IN0, SENSORS_W83781D_IN0_MIN, SENSORS_W83781D_IN0_MAX, -1 } },
@@ -626,9 +625,9 @@
     { SENSORS_W83781D_FAN3, SENSORS_W83781D_FAN3_MIN, SENSORS_W83781D_FAN3_DIV, -1 } },
   { fmtTemps_W83781D, rrdF0, DataType_temperature, W83781D_ALARM_TEMP1, W83781D_ALARM_TEMP1,
     { SENSORS_W83781D_TEMP1, SENSORS_W83781D_TEMP1_OVER, SENSORS_W83781D_TEMP1_HYST, -1 } },
-  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP2, W83781D_ALARM_TEMP2,
+  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP23, W83781D_ALARM_TEMP23,
     { SENSORS_W83781D_TEMP2, SENSORS_W83781D_TEMP2_OVER, SENSORS_W83781D_TEMP2_HYST, -1 } },
-  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP3, W83781D_ALARM_TEMP3,
+  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP23, W83781D_ALARM_TEMP23,
     { SENSORS_W83781D_TEMP3, SENSORS_W83781D_TEMP3_OVER, SENSORS_W83781D_TEMP3_HYST, -1 } },
   { fmtVolt_3, rrdF3, DataType_voltage, 0, 0,
     { SENSORS_W83781D_VID, -1 } },
@@ -643,6 +642,52 @@
   w83781d_names, w83781d_features, SENSORS_W83781D_ALARMS, SENSORS_W83781D_BEEPS
 };
 
+/** AS99127F **/
+
+static const char *as99127f_names[] = {
+  SENSORS_AS99127F_PREFIX, NULL
+};
+
+static const FeatureDescriptor as99127f_features[] = {
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN0, W83781D_ALARM_IN0,
+    { SENSORS_W83781D_IN0, SENSORS_W83781D_IN0_MIN, SENSORS_W83781D_IN0_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN1, W83781D_ALARM_IN1,
+    { SENSORS_W83781D_IN1, SENSORS_W83781D_IN1_MIN, SENSORS_W83781D_IN1_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN2, W83781D_ALARM_IN2,
+    { SENSORS_W83781D_IN2, SENSORS_W83781D_IN2_MIN, SENSORS_W83781D_IN2_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN3, W83781D_ALARM_IN3,
+    { SENSORS_W83781D_IN3, SENSORS_W83781D_IN3_MIN, SENSORS_W83781D_IN3_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN4, W83781D_ALARM_IN4,
+    { SENSORS_W83781D_IN4, SENSORS_W83781D_IN4_MIN, SENSORS_W83781D_IN4_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN5, W83781D_ALARM_IN5,
+    { SENSORS_W83781D_IN5, SENSORS_W83781D_IN5_MIN, SENSORS_W83781D_IN5_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN6, W83781D_ALARM_IN6,
+    { SENSORS_W83781D_IN6, SENSORS_W83781D_IN6_MIN, SENSORS_W83781D_IN6_MAX, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, W83781D_ALARM_FAN1, W83781D_ALARM_FAN1,
+    { SENSORS_W83781D_FAN1, SENSORS_W83781D_FAN1_MIN, SENSORS_W83781D_FAN1_DIV, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, W83781D_ALARM_FAN2, W83781D_ALARM_FAN2,
+    { SENSORS_W83781D_FAN2, SENSORS_W83781D_FAN2_MIN, SENSORS_W83781D_FAN2_DIV, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, W83781D_ALARM_FAN3, W83781D_ALARM_FAN3,
+    { SENSORS_W83781D_FAN3, SENSORS_W83781D_FAN3_MIN, SENSORS_W83781D_FAN3_DIV, -1 } },
+  { fmtTemps_W83781D, rrdF0, DataType_temperature, W83781D_ALARM_TEMP1, W83781D_ALARM_TEMP1,
+    { SENSORS_W83781D_TEMP1, SENSORS_W83781D_TEMP1_OVER, SENSORS_W83781D_TEMP1_HYST, -1 } },
+  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP2, W83781D_ALARM_TEMP2,
+    { SENSORS_W83781D_TEMP2, SENSORS_W83781D_TEMP2_OVER, SENSORS_W83781D_TEMP2_HYST, -1 } },
+  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP3, W83781D_ALARM_TEMP3,
+    { SENSORS_W83781D_TEMP3, SENSORS_W83781D_TEMP3_OVER, SENSORS_W83781D_TEMP3_HYST, -1 } },
+  { fmtVolt_3, rrdF3, DataType_voltage, 0, 0,
+    { SENSORS_W83781D_VID, -1 } },
+  { fmtChassisIntrusionDetection, NULL, DataType_other, W83781D_ALARM_CHAS, W83781D_ALARM_CHAS,
+    { SENSORS_W83781D_ALARMS, -1 } },
+  { fmtSoundAlarm, NULL, DataType_other, 0, 0,
+    { SENSORS_W83781D_BEEP_ENABLE, -1 } },
+  { NULL }
+};
+
+static const ChipDescriptor as99127f_chip = {
+  as99127f_names, as99127f_features, SENSORS_W83781D_ALARMS, SENSORS_W83781D_BEEPS
+};
+
 /** W83782D **/
 
 static const char *
@@ -975,6 +1020,7 @@
   &maxilife_chip,
   &sis5595_chip,
   &via686a_chip,
+  &as99127f_chip,
   &w83781d_chip,
   &w83782d_chip,
   &w83783s_chip,
