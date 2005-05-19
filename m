From: stefan@desire.ch (Stefan Ott)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [patch] fscpos upgrade for sensor library
Message-Id: <20050119213747.GB26072@desire.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

The following patch changes lm_sensors in order to work properly with the new
fscpos driver.

Regards
Stefan

diff -Nru lm_sensors-2.9.0-orig/etc/sensors.conf.eg lm-sensors-2.9.0/etc/sensors.conf.eg
--- lm_sensors-2.9.0-orig/etc/sensors.conf.eg	2004-11-25 20:40:09.000000000 +0100
+++ lm-sensors-2.9.0/etc/sensors.conf.eg	2005-01-19 22:12:57.000000000 +0100
@@ -1587,15 +1587,15 @@
 
 # Fans
 
-    label  fan1       "Fan1"
-    ignore  fan2
-    ignore  fan3
+    label fan1        "Fan1"
+    label fan2        "Fan2"
+    label fan3        "Fan3"
 
 # Voltage
 
-    label volt12      "+12V"
-    label volt5       "+5V"
-    label voltbatt    "+3.3V"
+    label in0_input   "+12V"
+    label in1_input   "+5V"
+    label in2_input   "Battery"
 
 
 chip "fscscy-*"
diff -Nru lm_sensors-2.9.0-orig/lib/chips.c lm-sensors-2.9.0/lib/chips.c
--- lm_sensors-2.9.0-orig/lib/chips.c	2004-11-24 05:31:40.000000000 +0100
+++ lm-sensors-2.9.0/lib/chips.c	2005-01-19 22:08:14.000000000 +0100
@@ -4010,17 +4010,13 @@
 
 static sensors_chip_feature fscpos_features[]    {
-    { SENSORS_FSCPOS_REV, "rev", NOMAP, NOMAP,
-                        R, FSCPOS_SYSCTL_REV, VALUE(1), 0 },
     { SENSORS_FSCPOS_EVENT, "event", NOMAP, NOMAP,
                         R, FSCPOS_SYSCTL_EVENT, VALUE(1), 0 },
-    { SENSORS_FSCPOS_CONTROL, "control", NOMAP, NOMAP,
-                        RW, FSCPOS_SYSCTL_CONTROL, VALUE(1), 0 },
-    { SENSORS_FSCPOS_VOLTAGE1, "volt12", NOMAP, NOMAP,
+    { SENSORS_FSCPOS_VOLTAGE1, "in0_input", NOMAP, NOMAP,
                         R, FSCPOS_SYSCTL_VOLT0, VALUE(1), 2 },
-    { SENSORS_FSCPOS_VOLTAGE2, "volt5", NOMAP, NOMAP,
+    { SENSORS_FSCPOS_VOLTAGE2, "in1_input", NOMAP, NOMAP,
                         R, FSCPOS_SYSCTL_VOLT1, VALUE(1), 2 },
-    { SENSORS_FSCPOS_VOLTAGE3, "voltbatt", NOMAP,
+    { SENSORS_FSCPOS_VOLTAGE3, "in2_input", NOMAP,
 			NOMAP, R, 
 			FSCPOS_SYSCTL_VOLT2, VALUE(1), 2 },
     { SENSORS_FSCPOS_TEMP1, "temp1", NOMAP, NOMAP,
@@ -4044,10 +4040,10 @@
                         R, FSCPOS_SYSCTL_FAN1, VALUE(4), 0 },
     { SENSORS_FSCPOS_FAN3, "fan3", NOMAP, NOMAP,
                         R, FSCPOS_SYSCTL_FAN2, VALUE(4), 0 },
-    { SENSORS_FSCPOS_FAN1_MIN, "fan1_min", SENSORS_FSCPOS_FAN1, 
+    { SENSORS_FSCPOS_PWM2, "pwm1", SENSORS_FSCPOS_FAN1, 
 			SENSORS_FSCPOS_FAN1, RW, 
 			FSCPOS_SYSCTL_FAN0, VALUE(2), 0 },
-    { SENSORS_FSCPOS_FAN2_MIN, "fan2_min", SENSORS_FSCPOS_FAN2, 
+    { SENSORS_FSCPOS_PWM2, "pwm2", SENSORS_FSCPOS_FAN2, 
 			SENSORS_FSCPOS_FAN2, RW, 
 			FSCPOS_SYSCTL_FAN1, VALUE(2), 0 },
     { SENSORS_FSCPOS_FAN1_STATE, "fan1_state", SENSORS_FSCPOS_FAN1, 
diff -Nru lm_sensors-2.9.0-orig/lib/chips.h lm-sensors-2.9.0/lib/chips.h
--- lm_sensors-2.9.0-orig/lib/chips.h	2004-11-24 05:31:40.000000000 +0100
+++ lm-sensors-2.9.0/lib/chips.h	2005-01-19 21:48:56.000000000 +0100
@@ -1475,15 +1475,12 @@
 
 #define SENSORS_FSCPOS_PREFIX "fscpos"
 
-#define SENSORS_FSCPOS_REV 1 /* R */
 #define SENSORS_FSCPOS_EVENT 2 /* R */
-#define SENSORS_FSCPOS_CONTROL 3 /* RW */
 #define SENSORS_FSCPOS_FAN1 4 /* R */
 #define SENSORS_FSCPOS_FAN2 5 /* R */
 #define SENSORS_FSCPOS_FAN3 6 /* R */
-#define SENSORS_FSCPOS_FAN1_MIN 7 /* RW */
-#define SENSORS_FSCPOS_FAN2_MIN 8 /* RW */
-#define SENSORS_FSCPOS_FAN3_MIN 9 /* RW */
+#define SENSORS_FSCPOS_PWM1 7 /* RW */
+#define SENSORS_FSCPOS_PWM2 8 /* RW */
 #define SENSORS_FSCPOS_FAN1_STATE 10 /* RW */
 #define SENSORS_FSCPOS_FAN2_STATE 11 /* RW */
 #define SENSORS_FSCPOS_FAN3_STATE 12 /* RW */
