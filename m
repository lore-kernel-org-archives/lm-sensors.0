From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: w83781d and alarms for temp2 and temp3
Message-Id: <20040505122833.GA10959@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040501224829.GA13732@pc.aurel32.lan>
In-Reply-To: <20040501224829.GA13732@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 02, 2004 at 12:48:29AM +0200, Aurelien Jarno wrote:
> I found a small bug in sensors and sensord when used with a w83781d
> chip. On this chip the alarms for temp2 and temp3 are merged. However
> that is not handled in sensors and sensord.

Please find attached two patches to fix that, one concerning sensors and
the other one concerning sensord.

The patch for sensors is almost the same as the previous one, but now
the code would compile!

The patch for sensord looks like a little bit long. That's because the
code was shared between w83781d and as99127f chips. With this patch, the
two chips are handled separatly

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/prog/sensors/chips.c lm_sensors2/prog/sensors/chips.c
--- lm_sensors2.orig/prog/sensors/chips.c	2004-05-05 14:03:37.000000000 +0200
+++ lm_sensors2/prog/sensors/chips.c	2004-05-05 14:03:53.000000000 +0200
@@ -2080,8 +2080,9 @@
   char *label = NULL;
   double cur,min,max,fdiv,sens;
   int alarms,beeps;
-  int is82d, is83s, is697hf, is627thf, valid;
+  int is81d, is82d, is83s, is697hf, is627thf, valid;
 
+  is81d = !strcmp(name->prefix,"w83781d");
   is82d = (!strcmp(name->prefix,"w83782d")) ||
           (!strcmp(name->prefix,"w83627hf")) ||
           (!strcmp(name->prefix,"w83637hf")) ||
@@ -2343,8 +2344,12 @@
         if(!is82d) {
           print_label(label,10);
           print_temp_info( cur, max, min, HYST, 1, 0);
+          if (!is81d)
           printf(" %s  %s\n", alarms&W83781D_ALARM_TEMP3 ?"ALARM":"     ",
                  beeps&W83781D_ALARM_TEMP3?"(beep)":"");
+          else
+            printf(" %s  %s\n", alarms&W83781D_ALARM_TEMP23 ?"ALARM":"     ",
+                   beeps&W83781D_ALARM_TEMP23?"(beep)":"");
         } else {
           if(!sensors_get_feature(*name,SENSORS_W83781D_SENS3,&sens)) {
             print_label(label,10);
-------------- next part --------------
diff -urN lm_sensors2.orig/lib/chips.h lm_sensors2/lib/chips.h
--- lm_sensors2.orig/lib/chips.h	2004-05-05 14:03:37.000000000 +0200
+++ lm_sensors2/lib/chips.h	2004-05-05 14:03:53.000000000 +0200
@@ -461,6 +461,58 @@
 #define SENSORS_LM90_REMOTE_TCRIT_HYST 80 /* R, see driver source */
 #define SENSORS_LM90_ALARMS 81 /* R */
 
+/* Asus AS99127F chips */
+
+#define SENSORS_AS99127F_PREFIX "as99127f"
+
+#define SENSORS_AS99127F_IN0 1 /* R */
+#define SENSORS_AS99127F_IN1 2 /* R */
+#define SENSORS_AS99127F_IN2 3 /* R */
+#define SENSORS_AS99127F_IN3 4 /* R */
+#define SENSORS_AS99127F_IN4 5 /* R */
+#define SENSORS_AS99127F_IN5 6 /* R */
+#define SENSORS_AS99127F_IN6 7 /* R */
+#define SENSORS_AS99127F_IN0_MIN 11 /* RW */
+#define SENSORS_AS99127F_IN1_MIN 12 /* RW */
+#define SENSORS_AS99127F_IN2_MIN 13 /* RW */
+#define SENSORS_AS99127F_IN3_MIN 14 /* RW */
+#define SENSORS_AS99127F_IN4_MIN 15 /* RW */
+#define SENSORS_AS99127F_IN5_MIN 16 /* RW */
+#define SENSORS_AS99127F_IN6_MIN 17 /* RW */
+#define SENSORS_AS99127F_IN0_MAX 21 /* RW */
+#define SENSORS_AS99127F_IN1_MAX 22 /* RW */
+#define SENSORS_AS99127F_IN2_MAX 23 /* RW */
+#define SENSORS_AS99127F_IN3_MAX 24 /* RW */
+#define SENSORS_AS99127F_IN4_MAX 25 /* RW */
+#define SENSORS_AS99127F_IN5_MAX 26 /* RW */
+#define SENSORS_AS99127F_IN6_MAX 27 /* RW */
+#define SENSORS_AS99127F_FAN1 31 /* R */
+#define SENSORS_AS99127F_FAN2 32 /* R */
+#define SENSORS_AS99127F_FAN3 33 /* R */
+#define SENSORS_AS99127F_FAN1_MIN 41 /* RW */
+#define SENSORS_AS99127F_FAN2_MIN 42 /* RW */
+#define SENSORS_AS99127F_FAN3_MIN 43 /* RW */
+#define SENSORS_AS99127F_TEMP1 51 /* R */
+#define SENSORS_AS99127F_TEMP1_HYST 52 /* RW */
+#define SENSORS_AS99127F_TEMP1_OVER 53 /* RW */
+#define SENSORS_AS99127F_TEMP2 54 /* R */
+#define SENSORS_AS99127F_TEMP2_HYST 55 /* RW */
+#define SENSORS_AS99127F_TEMP2_OVER 56 /* RW */
+#define SENSORS_AS99127F_TEMP3 57 /* R */
+#define SENSORS_AS99127F_TEMP3_HYST 58 /* RW */
+#define SENSORS_AS99127F_TEMP3_OVER 59 /* RW */
+#define SENSORS_AS99127F_VID 61 /* R */
+#define SENSORS_AS99127F_VRM 62 /* RW */
+#define SENSORS_AS99127F_FAN1_DIV 71 /* RW */
+#define SENSORS_AS99127F_FAN2_DIV 72 /* RW */
+#define SENSORS_AS99127F_FAN3_DIV 73 /* R (yes, really! */
+#define SENSORS_AS99127F_ALARMS 81 /* R */
+#define SENSORS_AS99127F_BEEP_ENABLE 82 /* RW */
+#define SENSORS_AS99127F_BEEPS 83 /* RW */
+#define SENSORS_AS99127F_SENS1 91 /* RW */
+#define SENSORS_AS99127F_SENS2 92 /* RW */
+#define SENSORS_AS99127F_SENS3 93 /* RW */
+
 /* Winbond W83781D chips */
 
 #define SENSORS_W83781D_PREFIX "w83781d"
@@ -599,7 +651,6 @@
 
 
 
-#define SENSORS_AS99127F_PREFIX "as99127f"
 
 #define SENSORS_W83782D_IN0 1 /* R */
 #define SENSORS_W83782D_IN1 2 /* R */
diff -urN lm_sensors2.orig/prog/sensord/chips.c lm_sensors2/prog/sensord/chips.c
--- lm_sensors2.orig/prog/sensord/chips.c	2004-05-05 14:03:37.000000000 +0200
+++ lm_sensors2/prog/sensord/chips.c	2004-05-05 14:03:53.000000000 +0200
@@ -583,6 +583,66 @@
   it87_names, it87_features, SENSORS_IT87_ALARMS, 0
 };
 
+/** AS99127F **/
+
+static const char *
+fmtTemps_AS99127F
+(const double values[], int alarm, int beep) {
+  if (values[2] = 127) {
+    sprintf (buff, "%.0f C (limit = %.0f C)",
+             values[0], values[1]);
+  } else {
+    sprintf (buff, "%.0f C (limit = %.0f C, hysteresis = %.0f C)",
+             values[0], values[1], values[2]);
+  }
+  return fmtExtra (alarm, beep);
+}
+
+static const char *as99127f_names[] = {
+  SENSORS_AS99127F_PREFIX, NULL
+};
+
+static const FeatureDescriptor as99127f_features[] = {
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN0, W83781D_ALARM_IN0,
+    { SENSORS_AS99127F_IN0, SENSORS_AS99127F_IN0_MIN, SENSORS_AS99127F_IN0_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN1, W83781D_ALARM_IN1,
+    { SENSORS_AS99127F_IN1, SENSORS_AS99127F_IN1_MIN, SENSORS_AS99127F_IN1_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN2, W83781D_ALARM_IN2,
+    { SENSORS_AS99127F_IN2, SENSORS_AS99127F_IN2_MIN, SENSORS_AS99127F_IN2_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN3, W83781D_ALARM_IN3,
+    { SENSORS_AS99127F_IN3, SENSORS_AS99127F_IN3_MIN, SENSORS_AS99127F_IN3_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN4, W83781D_ALARM_IN4,
+    { SENSORS_AS99127F_IN4, SENSORS_AS99127F_IN4_MIN, SENSORS_AS99127F_IN4_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN5, W83781D_ALARM_IN5,
+    { SENSORS_AS99127F_IN5, SENSORS_AS99127F_IN5_MIN, SENSORS_AS99127F_IN5_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN6, W83781D_ALARM_IN6,
+    { SENSORS_AS99127F_IN6, SENSORS_AS99127F_IN6_MIN, SENSORS_AS99127F_IN6_MAX, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, W83781D_ALARM_FAN1, W83781D_ALARM_FAN1,
+    { SENSORS_AS99127F_FAN1, SENSORS_AS99127F_FAN1_MIN, SENSORS_AS99127F_FAN1_DIV, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, W83781D_ALARM_FAN2, W83781D_ALARM_FAN2,
+    { SENSORS_AS99127F_FAN2, SENSORS_AS99127F_FAN2_MIN, SENSORS_AS99127F_FAN2_DIV, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, W83781D_ALARM_FAN3, W83781D_ALARM_FAN3,
+    { SENSORS_AS99127F_FAN3, SENSORS_AS99127F_FAN3_MIN, SENSORS_AS99127F_FAN3_DIV, -1 } },
+  { fmtTemps_AS99127F, rrdF0, DataType_temperature, W83781D_ALARM_TEMP1, W83781D_ALARM_TEMP1,
+    { SENSORS_AS99127F_TEMP1, SENSORS_AS99127F_TEMP1_OVER, SENSORS_AS99127F_TEMP1_HYST, -1 } },
+  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP2, W83781D_ALARM_TEMP2,
+    { SENSORS_AS99127F_TEMP2, SENSORS_AS99127F_TEMP2_OVER, SENSORS_AS99127F_TEMP2_HYST, -1 } },
+  { fmtTemps_1_0, rrdF1, DataType_temperature, W83781D_ALARM_TEMP3, W83781D_ALARM_TEMP3,
+    { SENSORS_AS99127F_TEMP3, SENSORS_AS99127F_TEMP3_OVER, SENSORS_AS99127F_TEMP3_HYST, -1 } },
+  { fmtVolt_3, rrdF3, DataType_voltage, 0, 0,
+    { SENSORS_AS99127F_VID, -1 } },
+  { fmtChassisIntrusionDetection, NULL, DataType_other, W83781D_ALARM_CHAS, W83781D_ALARM_CHAS,
+    { SENSORS_AS99127F_ALARMS, -1 } },
+  { fmtSoundAlarm, NULL, DataType_other, 0, 0,
+    { SENSORS_AS99127F_BEEP_ENABLE, -1 } },
+  { NULL }
+};
+
+static const ChipDescriptor as99127f_chip = {
+  as99127f_names, as99127f_features, SENSORS_AS99127F_ALARMS, SENSORS_AS99127F_BEEPS
+};
+
+
 /** W83781D **/
 
 static const char *
@@ -599,10 +659,9 @@
 }
 
 static const char *w83781d_names[] = {
-  SENSORS_W83781D_PREFIX, SENSORS_AS99127F_PREFIX, NULL
+  SENSORS_W83781D_PREFIX, NULL
 };
 
-/* TODO: beeps inverted for as99127f */
 static const FeatureDescriptor w83781d_features[] = {
   { fmtVolts_2, rrdF2, DataType_voltage, W83781D_ALARM_IN0, W83781D_ALARM_IN0,
     { SENSORS_W83781D_IN0, SENSORS_W83781D_IN0_MIN, SENSORS_W83781D_IN0_MAX, -1 } },
@@ -626,9 +685,9 @@
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
@@ -975,6 +1034,7 @@
   &maxilife_chip,
   &sis5595_chip,
   &via686a_chip,
+  &as99127f_chip,
   &w83781d_chip,
   &w83782d_chip,
   &w83783s_chip,
