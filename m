From: stefan@desire.ch (Stefan Ott)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [patch] fscpos upgrade for sensor library
Message-Id: <20050120175758.GM26072@desire.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050119213747.GB26072@desire.ch>
In-Reply-To: <20050119213747.GB26072@desire.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

Okay, I misunderstood that one. Here's the patch which just adds the new
features and leaves the old ones alone :)

diff -Nru lm-sensors-2.9.0-orig/etc/sensors.conf.eg lm-sensors-2.9.0/etc/sensors.conf.eg
--- lm-sensors-2.9.0-orig/etc/sensors.conf.eg	2004-11-25 20:40:09.000000000 +0100
+++ lm-sensors-2.9.0/etc/sensors.conf.eg	2005-01-20 15:48:14.000000000 +0100
@@ -1583,19 +1583,22 @@
 
     label temp1       "Temp1/CPU"
     label temp2       "Temp2/MB"
-    label temp3       "Temp2/AUX"
+    label temp3       "Temp3/AUX"
 
 # Fans
 
-    label  fan1       "Fan1"
-    ignore  fan2
-    ignore  fan3
+    label fan1        "Fan1"
+    label fan2        "Fan2"
+    label fan3        "Fan3"
 
 # Voltage
 
     label volt12      "+12V"
     label volt5       "+5V"
     label voltbatt    "+3.3V"
+    label in0_input   "+12V"
+    label in1_input   "+5V"
+    label in2_input   "Battery"
 
 
 chip "fscscy-*"
diff -Nru lm-sensors-2.9.0-orig/lib/chips.c lm-sensors-2.9.0/lib/chips.c
--- lm-sensors-2.9.0-orig/lib/chips.c	2004-11-24 05:31:40.000000000 +0100
+++ lm-sensors-2.9.0/lib/chips.c	2005-01-20 15:43:17.000000000 +0100
@@ -4017,12 +4017,11 @@
     { SENSORS_FSCPOS_CONTROL, "control", NOMAP, NOMAP,
                         RW, FSCPOS_SYSCTL_CONTROL, VALUE(1), 0 },
     { SENSORS_FSCPOS_VOLTAGE1, "volt12", NOMAP, NOMAP,
-                        R, FSCPOS_SYSCTL_VOLT0, VALUE(1), 2 },
+                        R, FSCPOS_SYSCTL_VOLT0, VALUE(1), 2, "in0_input", 3 },
     { SENSORS_FSCPOS_VOLTAGE2, "volt5", NOMAP, NOMAP,
-                        R, FSCPOS_SYSCTL_VOLT1, VALUE(1), 2 },
-    { SENSORS_FSCPOS_VOLTAGE3, "voltbatt", NOMAP,
-			NOMAP, R, 
-			FSCPOS_SYSCTL_VOLT2, VALUE(1), 2 },
+                        R, FSCPOS_SYSCTL_VOLT1, VALUE(1), 2, "in1_input", 3 },
+    { SENSORS_FSCPOS_VOLTAGE3, "voltbatt", NOMAP, NOMAP,
+			R, FSCPOS_SYSCTL_VOLT2, VALUE(1), 2, "in2_input", 3 },
     { SENSORS_FSCPOS_TEMP1, "temp1", NOMAP, NOMAP,
                         R, FSCPOS_SYSCTL_TEMP0, VALUE(2), 0 },
     { SENSORS_FSCPOS_TEMP2, "temp2", NOMAP, NOMAP,
@@ -4046,10 +4045,10 @@
                         R, FSCPOS_SYSCTL_FAN2, VALUE(4), 0 },
     { SENSORS_FSCPOS_FAN1_MIN, "fan1_min", SENSORS_FSCPOS_FAN1, 
 			SENSORS_FSCPOS_FAN1, RW, 
-			FSCPOS_SYSCTL_FAN0, VALUE(2), 0 },
+			FSCPOS_SYSCTL_FAN0, VALUE(2), 0, "pwm1", 0 },
     { SENSORS_FSCPOS_FAN2_MIN, "fan2_min", SENSORS_FSCPOS_FAN2, 
 			SENSORS_FSCPOS_FAN2, RW, 
-			FSCPOS_SYSCTL_FAN1, VALUE(2), 0 },
+			FSCPOS_SYSCTL_FAN1, VALUE(2), 0, "pwm2", 0 },
     { SENSORS_FSCPOS_FAN1_STATE, "fan1_state", SENSORS_FSCPOS_FAN1, 
 			SENSORS_FSCPOS_FAN1, RW, 
 			FSCPOS_SYSCTL_FAN0, VALUE(1), 0 },
diff -Nru lm-sensors-2.9.0-orig/lib/chips.h lm-sensors-2.9.0/lib/chips.h
--- lm-sensors-2.9.0-orig/lib/chips.h	2004-11-24 05:31:40.000000000 +0100
+++ lm-sensors-2.9.0/lib/chips.h	2005-01-20 15:47:15.000000000 +0100
@@ -1502,6 +1502,8 @@
 #define SENSORS_FSCPOS_WDOG_PRESET 25/* RW */
 #define SENSORS_FSCPOS_WDOG_STATE 26/* RW */
 #define SENSORS_FSCPOS_WDOG_CONTROL 27/* RW */
+#define SENSORS_FSCPOS_PWM1 28/* RW */
+#define SENSORS_FSCPOS_PWM2 29/* RW */
 
 /* fsc scylla chip */
 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050120/77fd18e7/attachment.bin
