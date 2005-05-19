From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: w83781d and alarms for temp2 and temp3
Message-Id: <20040507082400.GC30648@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040501224829.GA13732@pc.aurel32.lan>
In-Reply-To: <20040501224829.GA13732@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 06, 2004 at 07:34:24PM +0200, Jean Delvare wrote:
> About the sensors patch: fix is correct, but indentation isn't. I'll
> take care of that though, no need to resend.
Ok, thanks.

> About the sensord patch: I don't like it. You do not need to define
> separate constants for the AS99127F in lib/chips.h. We can do without
> them. Just use the SENSORS_W83781D defines in the as99127f_features
> array (much like w83697hf_features uses the SENSORS_W83782D defines).
> 
> Care to provide a new patch?
Yes, I hope the new patch attached is better.


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
--- lm_sensors2/prog/sensord/chips.c.orig	21 Mar 2004 10:35:49 -0000	1.11
+++ lm_sensors2/prog/sensord/chips.c	7 May 2004 07:42:00 -0000
@@ -585,6 +585,6 @@ static const ChipDescriptor it87_chip = 
 
-/** W83781D **/
+/** AS99127F **/
 
 static const char *
-fmtTemps_W83781D
+fmtTemps_AS99127F_W83781D
 (const double values[], int alarm, int beep) {
@@ -600,8 +600,7 @@ fmtTemps_W83781D
 
-static const char *w83781d_names[] = {
-  SENSORS_W83781D_PREFIX, SENSORS_AS99127F_PREFIX, NULL
+static const char *as99127f_names[] = {
+  SENSORS_AS99127F_PREFIX, NULL
 };
 
-/* TODO: beeps inverted for as99127f */
-static const FeatureDescriptor w83781d_features[] = {
+static const FeatureDescriptor as99127f_features[] = {
   { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN0, W83781D_ALARM_IN0,
@@ -626,3 +625,3 @@ static const FeatureDescriptor w83781d_f
     { SENSORS_W83781D_FAN3, SENSORS_W83781D_FAN3_MIN, SENSORS_W83781D_FAN3_DIV, -1 } },
-  { fmtTemps_W83781D, rrdF0, DataType_temperature, W83781D_ALARM_TEMP1, W83781D_ALARM_TEMP1,
+  { fmtTemps_AS99127F_W83781D, rrdF0, DataType_temperature, W83781D_ALARM_TEMP1, W83781D_ALARM_TEMP1,
     { SENSORS_W83781D_TEMP1, SENSORS_W83781D_TEMP1_OVER, SENSORS_W83781D_TEMP1_HYST, -1 } },
@@ -641,2 +640,48 @@ static const FeatureDescriptor w83781d_f
 
+static const ChipDescriptor as99127f_chip = {
+  as99127f_names, as99127f_features, SENSORS_W83781D_ALARMS, SENSORS_W83781D_BEEPS
+};
+
+/** W83781D **/
+
+static const char *w83781d_names[] = {
+  SENSORS_W83781D_PREFIX, NULL
+};
+
+static const FeatureDescriptor w83781d_features[] = {
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
+  { fmtTemps_AS99127F_W83781D, rrdF0, DataType_temperature, W83781D_ALARM_TEMP1, W83781D_ALARM_TEMP1,
+    { SENSORS_W83781D_TEMP1, SENSORS_W83781D_TEMP1_OVER, SENSORS_W83781D_TEMP1_HYST, -1 } },
+  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP23, W83781D_ALARM_TEMP23,
+    { SENSORS_W83781D_TEMP2, SENSORS_W83781D_TEMP2_OVER, SENSORS_W83781D_TEMP2_HYST, -1 } },
+  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP23, W83781D_ALARM_TEMP23,
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
 static const ChipDescriptor w83781d_chip = {
@@ -977,2 +1022,3 @@ const ChipDescriptor * const knownChips[
   &via686a_chip,
+  &as99127f_chip,
   &w83781d_chip,
