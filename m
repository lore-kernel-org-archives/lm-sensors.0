From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: [PATCH] libsensors (chips.c, chips.h) update for 2.6.X lm85 fan
Message-Id: <20041004201808.GF22290@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Here is a patch for lm_sensors/lib/chips.h and lm_sensors/lib/chips.c to 
update the lm85 entries and keep them in step with the patch for lm85 fan 
control in the 2.6.X lm85 driver.

Again, feedback appreciated.

Sincerely,

Justin Thiessen
------------------------------
jthiessen@penguincomputing.com
http://www.penguincomputing.com

Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com>


===============================

diff -U 2 -r lm_sensors2/lib/chips.c lm_sensors2_lm85-changes/lib/chips.c
--- lm_sensors2/lib/chips.c	2004-09-25 04:30:02.000000000 -0700
+++ lm_sensors2_lm85-changes/lib/chips.c	2004-10-04 12:29:42.586512296 -0700
@@ -3272,31 +3272,31 @@
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG3, VALUE(1), 1 },
-    { SENSORS_LM85_PWM1_MIN, "pwm1_min", SENSORS_LM85_PWM1, 
+    { SENSORS_LM85_PWM1_AUTO_PWM_MIN, "pwm1_auto_pwm_min", SENSORS_LM85_PWM1, 
                          NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG1, VALUE(2), 1 },
-    { SENSORS_LM85_PWM2_MIN, "pwm2_min", SENSORS_LM85_PWM2, 
+                         LM85_SYSCTL_PWM_CFG1, VALUE(2), 0 },
+    { SENSORS_LM85_PWM2_AUTO_PWM_MIN, "pwm2_auto_pwm_min", SENSORS_LM85_PWM2, 
                          NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG2, VALUE(2), 1 },
-    { SENSORS_LM85_PWM3_MIN, "pwm3_min", SENSORS_LM85_PWM3, 
+                         LM85_SYSCTL_PWM_CFG2, VALUE(2), 0 },
+    { SENSORS_LM85_PWM3_AUTO_PWM_MIN, "pwm3_auto_pwm_min", SENSORS_LM85_PWM3, 
                          NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG3, VALUE(2), 1 },
-    { SENSORS_LM85_PWM1_FREQ, "pwm1_freq", SENSORS_LM85_PWM1, 
+                         LM85_SYSCTL_PWM_CFG3, VALUE(2), 0 },
+    { SENSORS_LM85_PWM1_AUTO_PWM_FREQ, "pwm1_auto_pwm_freq", SENSORS_LM85_PWM1, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG1, VALUE(3), 1 },
-    { SENSORS_LM85_PWM2_FREQ, "pwm2_freq", SENSORS_LM85_PWM2, 
+    { SENSORS_LM85_PWM2_AUTO_PWM_FREQ, "pwm2_auto_pwm_freq", SENSORS_LM85_PWM2, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG2, VALUE(3), 1 },
-    { SENSORS_LM85_PWM3_FREQ, "pwm3_freq", SENSORS_LM85_PWM3, 
+    { SENSORS_LM85_PWM3_AUTO_PWM_FREQ, "pwm3_auto_pwm_freq", SENSORS_LM85_PWM3, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG3, VALUE(3), 1 },
-    { SENSORS_LM85_PWM1_MIN_CTL, "pwm1_min_ctl", SENSORS_LM85_PWM1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG1, VALUE(4), 1 },
-    { SENSORS_LM85_PWM2_MIN_CTL, "pwm2_min_ctl", SENSORS_LM85_PWM2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG2, VALUE(4), 1 },
-    { SENSORS_LM85_PWM3_MIN_CTL, "pwm3_min_ctl", SENSORS_LM85_PWM3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG3, VALUE(4), 1 },
+    { SENSORS_LM85_PWM1_AUTO_PWM_MINCTL, "pwm1_auto_pwm_minctl",
+                         SENSORS_LM85_PWM1, NOMAP, RW, 
+                         LM85_SYSCTL_PWM_CFG1, VALUE(4), 0 },
+    { SENSORS_LM85_PWM2_AUTO_PWM_MINCTL, "pwm2_auto_pwm_minctl",
+                         SENSORS_LM85_PWM2, NOMAP, RW, 
+                         LM85_SYSCTL_PWM_CFG2, VALUE(4), 0 },
+    { SENSORS_LM85_PWM3_AUTO_PWM_MINCTL, "pwm3_auto_pwm_minctl",
+                         SENSORS_LM85_PWM3, NOMAP, RW, 
+                         LM85_SYSCTL_PWM_CFG3, VALUE(4), 0 },
     { SENSORS_LM85_PWM1_INVERT, "pwm1_invert", SENSORS_LM85_PWM1, 
                          NOMAP, RW, 
@@ -3308,50 +3308,49 @@
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG3, VALUE(5), 0 },
-    { SENSORS_LM85_PWM1_ZONE, "pwm1_zone", SENSORS_LM85_PWM1, 
-                         NOMAP, RW, 
+    { SENSORS_LM85_PWM1_AUTO_CHANNELS, "pwm1_auto_channels",
+                         SENSORS_LM85_PWM1, NOMAP, RW, 
                          LM85_SYSCTL_PWM_ZONE1, VALUE(1), 0 },
-    { SENSORS_LM85_PWM2_ZONE, "pwm2_zone", SENSORS_LM85_PWM2, 
-                         NOMAP, RW, 
+    { SENSORS_LM85_PWM2_AUTO_CHANNELS, "pwm2_auto_channels",
+                         SENSORS_LM85_PWM2, NOMAP, RW, 
                          LM85_SYSCTL_PWM_ZONE2, VALUE(1), 0 },
-    { SENSORS_LM85_PWM3_ZONE, "pwm3_zone", SENSORS_LM85_PWM3, 
-                         NOMAP, RW, 
+    { SENSORS_LM85_PWM3_AUTO_CHANNELS, "pwm3_auto_channels",
+                         SENSORS_LM85_PWM3, NOMAP, RW, 
                          LM85_SYSCTL_PWM_ZONE3, VALUE(1), 0 },
-    { SENSORS_LM85_ZONE1_LIMIT, "zone1_limit", SENSORS_LM85_TEMP1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE1, VALUE(1), 1 },
-    { SENSORS_LM85_ZONE2_LIMIT, "zone2_limit", SENSORS_LM85_TEMP2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE2, VALUE(1), 1 },
-    { SENSORS_LM85_ZONE3_LIMIT, "zone3_limit", SENSORS_LM85_TEMP3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE3, VALUE(1), 1 },
-    { SENSORS_LM85_ZONE1_HYST, "zone1_hyst", SENSORS_LM85_TEMP1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE1, VALUE(2), 1 },
-    { SENSORS_LM85_ZONE2_HYST, "zone2_hyst", SENSORS_LM85_TEMP2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE2, VALUE(2), 1 },
-    { SENSORS_LM85_ZONE3_HYST, "zone3_hyst", SENSORS_LM85_TEMP3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE3, VALUE(2), 1 },
-    { SENSORS_LM85_ZONE1_RANGE, "zone1_range", SENSORS_LM85_TEMP1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE1, VALUE(3), 1 },
-    { SENSORS_LM85_ZONE2_RANGE, "zone2_range", SENSORS_LM85_TEMP2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE2, VALUE(3), 1 },
-    { SENSORS_LM85_ZONE3_RANGE, "zone3_range", SENSORS_LM85_TEMP3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE3, VALUE(3), 1 },
-    { SENSORS_LM85_ZONE1_CRITICAL, "zone1_critical", SENSORS_LM85_TEMP1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE1, VALUE(4), 1 },
-    { SENSORS_LM85_ZONE2_CRITICAL, "zone2_critical", SENSORS_LM85_TEMP2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE2, VALUE(4), 1 },
-    { SENSORS_LM85_ZONE3_CRITICAL, "zone3_critical", SENSORS_LM85_TEMP3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE3, VALUE(4), 1 },
-
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_MIN, "temp1_auto_temp_min",
+                         SENSORS_LM85_TEMP1, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE1, VALUE(1), 3 },
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_MIN, "temp2_auto_temp_min",
+                         SENSORS_LM85_TEMP2, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE2, VALUE(1), 3 },
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_MIN, "temp3_auto_temp_min",
+                         SENSORS_LM85_TEMP3, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE3, VALUE(1), 3 },
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_OFF, "temp1_auto_temp_off",
+                         SENSORS_LM85_TEMP1, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE1, VALUE(2), 3 },
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_OFF, "temp2_auto_temp_off",
+                         SENSORS_LM85_TEMP2, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE2, VALUE(2), 3 },
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_OFF, "temp3_auto_temp_off",
+                         SENSORS_LM85_TEMP3, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE3, VALUE(2), 3 },
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_MAX, "temp1_auto_temp_max",
+                         SENSORS_LM85_TEMP1, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE1, VALUE(3), 3 },
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_MAX, "temp2_auto_temp_max",
+                         SENSORS_LM85_TEMP2, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE2, VALUE(3), 3 },
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_MAX, "temp3_auto_temp_max",
+                         SENSORS_LM85_TEMP3, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE3, VALUE(3), 3 },
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_CRIT, "temp1_auto_temp_crit",
+                         SENSORS_LM85_TEMP1, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE1, VALUE(4), 3 },
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_CRIT, "temp2_auto_temp_crit",
+                         SENSORS_LM85_TEMP2, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE2, VALUE(4), 3 },
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_CRIT, "temp3_auto_temp_crit",
+                         SENSORS_LM85_TEMP3, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE3, VALUE(4), 3 },
     { SENSORS_LM85_PWM1_SPINUP_CTL, "pwm1_spinup_ctl", SENSORS_LM85_PWM1, 
                          NOMAP, RW, 
@@ -3372,11 +3371,11 @@
                          NOMAP, RW, 
                          LM85_SYSCTL_TACH_MODE, VALUE(3), 0 },
-    { SENSORS_LM85_ZONE1_SMOOTH, "zone1_smooth", SENSORS_LM85_TEMP1, 
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_SMOOTH, "zone1_smooth", SENSORS_LM85_TEMP1, 
                          NOMAP, RW, 
                          LM85_SYSCTL_SMOOTH1, VALUE(1), 1 },
-    { SENSORS_LM85_ZONE2_SMOOTH, "zone2_smooth", SENSORS_LM85_TEMP2, 
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_SMOOTH, "zone2_smooth", SENSORS_LM85_TEMP2, 
                          NOMAP, RW, 
                          LM85_SYSCTL_SMOOTH2, VALUE(1), 1 },
-    { SENSORS_LM85_ZONE3_SMOOTH, "zone3_smooth", SENSORS_LM85_TEMP3, 
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_SMOOTH, "zone3_smooth", SENSORS_LM85_TEMP3, 
                          NOMAP, RW, 
                          LM85_SYSCTL_SMOOTH3, VALUE(1), 1 },
@@ -3478,31 +3477,31 @@
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG3, VALUE(1), 1 },
-    { SENSORS_LM85_PWM1_MIN, "pwm1_min", SENSORS_LM85_PWM1, 
+    { SENSORS_LM85_PWM1_AUTO_PWM_MIN, "pwm1_auto_pwm_min", SENSORS_LM85_PWM1, 
                          NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG1, VALUE(2), 1 },
-    { SENSORS_LM85_PWM2_MIN, "pwm2_min", SENSORS_LM85_PWM2, 
+                         LM85_SYSCTL_PWM_CFG1, VALUE(2), 0 },
+    { SENSORS_LM85_PWM2_AUTO_PWM_MIN, "pwm2_auto_pwm_min", SENSORS_LM85_PWM2, 
                          NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG2, VALUE(2), 1 },
-    { SENSORS_LM85_PWM3_MIN, "pwm3_min", SENSORS_LM85_PWM3, 
+                         LM85_SYSCTL_PWM_CFG2, VALUE(2), 0 },
+    { SENSORS_LM85_PWM3_AUTO_PWM_MIN, "pwm3_auto_pwm_min", SENSORS_LM85_PWM3, 
                          NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG3, VALUE(2), 1 },
-    { SENSORS_LM85_PWM1_FREQ, "pwm1_freq", SENSORS_LM85_PWM1, 
+                         LM85_SYSCTL_PWM_CFG3, VALUE(2), 0 },
+    { SENSORS_LM85_PWM1_AUTO_PWM_FREQ, "pwm1_auto_pwm_freq", SENSORS_LM85_PWM1, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG1, VALUE(3), 1 },
-    { SENSORS_LM85_PWM2_FREQ, "pwm2_freq", SENSORS_LM85_PWM2, 
+    { SENSORS_LM85_PWM2_AUTO_PWM_FREQ, "pwm2_auto_pwm_freq", SENSORS_LM85_PWM2, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG2, VALUE(3), 1 },
-    { SENSORS_LM85_PWM3_FREQ, "pwm3_freq", SENSORS_LM85_PWM3, 
+    { SENSORS_LM85_PWM3_AUTO_PWM_FREQ, "pwm3_auto_pwm_freq", SENSORS_LM85_PWM3, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG3, VALUE(3), 1 },
-    { SENSORS_LM85_PWM1_MIN_CTL, "pwm1_min_ctl", SENSORS_LM85_PWM1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG1, VALUE(4), 1 },
-    { SENSORS_LM85_PWM2_MIN_CTL, "pwm2_min_ctl", SENSORS_LM85_PWM2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG2, VALUE(4), 1 },
-    { SENSORS_LM85_PWM3_MIN_CTL, "pwm3_min_ctl", SENSORS_LM85_PWM3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_PWM_CFG3, VALUE(4), 1 },
+    { SENSORS_LM85_PWM1_AUTO_PWM_MINCTL, "pwm1_auto_pwm_minctl",
+                         SENSORS_LM85_PWM1, NOMAP, RW, 
+                         LM85_SYSCTL_PWM_CFG1, VALUE(4), 0 },
+    { SENSORS_LM85_PWM2_AUTO_PWM_MINCTL, "pwm2_auto_pwm_minctl",
+                         SENSORS_LM85_PWM2, NOMAP, RW, 
+                         LM85_SYSCTL_PWM_CFG2, VALUE(4), 0 },
+    { SENSORS_LM85_PWM3_AUTO_PWM_MINCTL, "pwm3_auto_pwm_minctl",
+                         SENSORS_LM85_PWM3, NOMAP, RW, 
+                         LM85_SYSCTL_PWM_CFG3, VALUE(4), 0 },
     { SENSORS_LM85_PWM1_INVERT, "pwm1_invert", SENSORS_LM85_PWM1, 
                          NOMAP, RW, 
@@ -3514,50 +3513,49 @@
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_CFG3, VALUE(5), 0 },
-    { SENSORS_LM85_PWM1_ZONE, "pwm1_zone", SENSORS_LM85_PWM1, 
+    { SENSORS_LM85_PWM1_AUTO_CHANNELS, "pwm1_auto_channels", SENSORS_LM85_PWM1, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_ZONE1, VALUE(1), 0 },
-    { SENSORS_LM85_PWM2_ZONE, "pwm2_zone", SENSORS_LM85_PWM2, 
+    { SENSORS_LM85_PWM2_AUTO_CHANNELS, "pwm2_auto_channels", SENSORS_LM85_PWM2, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_ZONE2, VALUE(1), 0 },
-    { SENSORS_LM85_PWM3_ZONE, "pwm3_zone", SENSORS_LM85_PWM3, 
+    { SENSORS_LM85_PWM3_AUTO_CHANNELS, "pwm3_auto_channels", SENSORS_LM85_PWM3, 
                          NOMAP, RW, 
                          LM85_SYSCTL_PWM_ZONE3, VALUE(1), 0 },
-    { SENSORS_LM85_ZONE1_LIMIT, "zone1_limit", SENSORS_LM85_TEMP1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE1, VALUE(1), 1 },
-    { SENSORS_LM85_ZONE2_LIMIT, "zone2_limit", SENSORS_LM85_TEMP2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE2, VALUE(1), 1 },
-    { SENSORS_LM85_ZONE3_LIMIT, "zone3_limit", SENSORS_LM85_TEMP3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE3, VALUE(1), 1 },
-    { SENSORS_LM85_ZONE1_HYST, "zone1_hyst", SENSORS_LM85_TEMP1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE1, VALUE(2), 1 },
-    { SENSORS_LM85_ZONE2_HYST, "zone2_hyst", SENSORS_LM85_TEMP2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE2, VALUE(2), 1 },
-    { SENSORS_LM85_ZONE3_HYST, "zone3_hyst", SENSORS_LM85_TEMP3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE3, VALUE(2), 1 },
-    { SENSORS_LM85_ZONE1_RANGE, "zone1_range", SENSORS_LM85_TEMP1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE1, VALUE(3), 1 },
-    { SENSORS_LM85_ZONE2_RANGE, "zone2_range", SENSORS_LM85_TEMP2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE2, VALUE(3), 1 },
-    { SENSORS_LM85_ZONE3_RANGE, "zone3_range", SENSORS_LM85_TEMP3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE3, VALUE(3), 1 },
-    { SENSORS_LM85_ZONE1_CRITICAL, "zone1_critical", SENSORS_LM85_TEMP1, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE1, VALUE(4), 1 },
-    { SENSORS_LM85_ZONE2_CRITICAL, "zone2_critical", SENSORS_LM85_TEMP2, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE2, VALUE(4), 1 },
-    { SENSORS_LM85_ZONE3_CRITICAL, "zone3_critical", SENSORS_LM85_TEMP3, 
-                         NOMAP, RW, 
-                         LM85_SYSCTL_ZONE3, VALUE(4), 1 },
-
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_MIN, "temp1_auto_temp_min",
+                         SENSORS_LM85_TEMP1, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE1, VALUE(1), 3 },
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_MIN, "temp2_auto_temp_min",
+                         SENSORS_LM85_TEMP2, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE2, VALUE(1), 3 },
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_MIN, "temp3_auto_temp_min",
+                         SENSORS_LM85_TEMP3, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE3, VALUE(1), 3 },
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_OFF, "temp1_auto_temp_off",
+                         SENSORS_LM85_TEMP1, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE1, VALUE(2), 3 },
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_OFF, "temp2_auto_temp_off",
+                         SENSORS_LM85_TEMP2, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE2, VALUE(2), 3 },
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_OFF, "temp3_auto_temp_off",
+                         SENSORS_LM85_TEMP3, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE3, VALUE(2), 3 },
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_MAX, "temp1_auto_temp_max",
+                         SENSORS_LM85_TEMP1, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE1, VALUE(3), 3 },
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_MAX, "temp2_auto_temp_max",
+                         SENSORS_LM85_TEMP2, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE2, VALUE(3), 3 },
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_MAX, "temp3_auto_temp_max",
+                         SENSORS_LM85_TEMP3, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE3, VALUE(3), 3 },
+    { SENSORS_LM85_TEMP1_AUTO_TEMP_CRIT, "temp1_auto_temp_crit",
+                         SENSORS_LM85_TEMP1, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE1, VALUE(4), 3 },
+    { SENSORS_LM85_TEMP2_AUTO_TEMP_CRIT, "temp2_auto_temp_crit",
+                         SENSORS_LM85_TEMP2, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE2, VALUE(4), 3 },
+    { SENSORS_LM85_TEMP3_AUTO_TEMP_CRIT, "temp3_auto_temp_crit",
+                         SENSORS_LM85_TEMP3, NOMAP, RW, 
+                         LM85_SYSCTL_ZONE3, VALUE(4), 3 },
     { SENSORS_ADM1027_FAN1_TACH_MODE, "fan1_tach_mode", SENSORS_LM85_FAN1, 
                          NOMAP, RW, 
diff -U 2 -r lm_sensors2/lib/chips.h lm_sensors2_lm85-changes/lib/chips.h
--- lm_sensors2/lib/chips.h	2004-09-28 13:45:02.000000000 -0700
+++ lm_sensors2_lm85-changes/lib/chips.h	2004-10-04 12:29:34.435751400 -0700
@@ -374,105 +374,105 @@
 #define SENSORS_EMC6D100_PREFIX "emc6d100"
 
-#define SENSORS_ADM1027_ALARM_MASK           1  /* RW -- alarm_mask  */
-#define SENSORS_ADM1027_FAN1_PPR             2  /* RW -- fan1_ppr  */
-#define SENSORS_ADM1027_FAN1_TACH_MODE       3  /* RW -- fan1_tach_mode  */
-#define SENSORS_ADM1027_FAN2_PPR             4  /* RW -- fan2_ppr  */
-#define SENSORS_ADM1027_FAN2_TACH_MODE       5  /* RW -- fan2_tach_mode  */
-#define SENSORS_ADM1027_FAN3_PPR             6  /* RW -- fan3_ppr  */
-#define SENSORS_ADM1027_FAN3_TACH_MODE       7  /* RW -- fan3_tach_mode  */
-#define SENSORS_ADM1027_FAN4_PPR             8  /* RW -- fan4_ppr  */
-#define SENSORS_ADM1027_FAN4_TACH_MODE       9  /* RW -- fan4_tach_mode  */
-#define SENSORS_ADM1027_PWM1_SMOOTH         10  /* RW -- pwm1_smooth  */
-#define SENSORS_ADM1027_PWM2_SMOOTH         11  /* RW -- pwm2_smooth  */
-#define SENSORS_ADM1027_PWM3_SMOOTH         12  /* RW -- pwm3_smooth  */
-#define SENSORS_ADM1027_TEMP1_OFFSET        13  /* RW -- temp1_offset  */
-#define SENSORS_ADM1027_TEMP2_OFFSET        14  /* RW -- temp2_offset  */
-#define SENSORS_ADM1027_TEMP3_OFFSET        15  /* RW -- temp3_offset  */
-#define SENSORS_LM85_ALARMS                 16  /* R  -- alarms  */
-#define SENSORS_LM85_VID                    17  /* R  -- vid  */
-#define SENSORS_LM85_VRM                    18  /* RW -- vrm  */
-#define SENSORS_LM85_FAN1                   19  /* R  -- fan1  */
-#define SENSORS_LM85_FAN1_MIN               20  /* RW -- fan1_min  */
-#define SENSORS_LM85_FAN1_TACH_MODE         21  /* RW -- fan1_tach_mode  */
-#define SENSORS_LM85_FAN2                   22  /* R  -- fan2  */
-#define SENSORS_LM85_FAN2_MIN               23  /* RW -- fan2_min  */
-#define SENSORS_LM85_FAN2_TACH_MODE         24  /* RW -- fan2_tach_mode  */
-#define SENSORS_LM85_FAN3                   25  /* R  -- fan3  */
-#define SENSORS_LM85_FAN3_MIN               26  /* RW -- fan3_min  */
-#define SENSORS_LM85_FAN3_TACH_MODE         27  /* RW -- fan3_tach_mode  */
-#define SENSORS_LM85_FAN4                   28  /* R  -- fan4  */
-#define SENSORS_LM85_FAN4_MIN               29  /* RW -- fan4_min  */
-#define SENSORS_LM85_IN0                    30  /* R  -- in0  */
-#define SENSORS_LM85_IN0_MAX                31  /* RW -- in0_max  */
-#define SENSORS_LM85_IN0_MIN                32  /* RW -- in0_min  */
-#define SENSORS_LM85_IN1                    33  /* R  -- in1  */
-#define SENSORS_LM85_IN1_MAX                34  /* RW -- in1_max  */
-#define SENSORS_LM85_IN1_MIN                35  /* RW -- in1_min  */
-#define SENSORS_LM85_IN2                    36  /* R  -- in2  */
-#define SENSORS_LM85_IN2_MAX                37  /* RW -- in2_max  */
-#define SENSORS_LM85_IN2_MIN                38  /* RW -- in2_min  */
-#define SENSORS_LM85_IN3                    39  /* R  -- in3  */
-#define SENSORS_LM85_IN3_MAX                40  /* RW -- in3_max  */
-#define SENSORS_LM85_IN3_MIN                41  /* RW -- in3_min  */
-#define SENSORS_LM85_IN4                    42  /* R  -- in4  */
-#define SENSORS_LM85_IN4_MAX                43  /* RW -- in4_max  */
-#define SENSORS_LM85_IN4_MIN                44  /* RW -- in4_min  */
-#define SENSORS_LM85_IN5                    45  /* R  -- in5  */
-#define SENSORS_LM85_IN5_MAX                46  /* RW -- in5_max  */
-#define SENSORS_LM85_IN5_MIN                47  /* RW -- in5_min  */
-#define SENSORS_LM85_IN6                    48  /* R  -- in6  */
-#define SENSORS_LM85_IN6_MAX                49  /* RW -- in6_max  */
-#define SENSORS_LM85_IN6_MIN                50  /* RW -- in6_min  */
-#define SENSORS_LM85_IN7                    51  /* R  -- in7  */
-#define SENSORS_LM85_IN7_MAX                52  /* RW -- in7_max  */
-#define SENSORS_LM85_IN7_MIN                53  /* RW -- in7_min  */
-#define SENSORS_LM85_PWM1                   54  /* RW -- pwm1  */
-#define SENSORS_LM85_PWM1_FREQ              55  /* RW -- pwm1_freq  */
-#define SENSORS_LM85_PWM1_INVERT            56  /* RW -- pwm1_invert  */
-#define SENSORS_LM85_PWM1_MIN               57  /* RW -- pwm1_min  */
-#define SENSORS_LM85_PWM1_MIN_CTL           58  /* RW -- pwm1_min_ctl  */
-#define SENSORS_LM85_PWM1_SPINUP            59  /* RW -- pwm1_spinup  */
-#define SENSORS_LM85_PWM1_SPINUP_CTL        60  /* RW -- pwm1_spinup_ctl  */
-#define SENSORS_LM85_PWM1_ZONE              61  /* RW -- pwm1_zone  */
-#define SENSORS_LM85_PWM2                   62  /* RW -- pwm2  */
-#define SENSORS_LM85_PWM2_FREQ              63  /* RW -- pwm2_freq  */
-#define SENSORS_LM85_PWM2_INVERT            64  /* RW -- pwm2_invert  */
-#define SENSORS_LM85_PWM2_MIN               65  /* RW -- pwm2_min  */
-#define SENSORS_LM85_PWM2_MIN_CTL           66  /* RW -- pwm2_min_ctl  */
-#define SENSORS_LM85_PWM2_SPINUP            67  /* RW -- pwm2_spinup  */
-#define SENSORS_LM85_PWM2_SPINUP_CTL        68  /* RW -- pwm2_spinup_ctl  */
-#define SENSORS_LM85_PWM2_ZONE              69  /* RW -- pwm2_zone  */
-#define SENSORS_LM85_PWM3                   70  /* RW -- pwm3  */
-#define SENSORS_LM85_PWM3_FREQ              71  /* RW -- pwm3_freq  */
-#define SENSORS_LM85_PWM3_INVERT            72  /* RW -- pwm3_invert  */
-#define SENSORS_LM85_PWM3_MIN               73  /* RW -- pwm3_min  */
-#define SENSORS_LM85_PWM3_MIN_CTL           74  /* RW -- pwm3_min_ctl  */
-#define SENSORS_LM85_PWM3_SPINUP            75  /* RW -- pwm3_spinup  */
-#define SENSORS_LM85_PWM3_SPINUP_CTL        76  /* RW -- pwm3_spinup_ctl  */
-#define SENSORS_LM85_PWM3_ZONE              77  /* RW -- pwm3_zone  */
-#define SENSORS_LM85_TEMP1                  78  /* R  -- temp1  */
-#define SENSORS_LM85_TEMP1_MAX              79  /* RW -- temp1_max  */
-#define SENSORS_LM85_TEMP1_MIN              80  /* RW -- temp1_min  */
-#define SENSORS_LM85_TEMP2                  81  /* R  -- temp2  */
-#define SENSORS_LM85_TEMP2_MAX              82  /* RW -- temp2_max  */
-#define SENSORS_LM85_TEMP2_MIN              83  /* RW -- temp2_min  */
-#define SENSORS_LM85_TEMP3                  84  /* R  -- temp3  */
-#define SENSORS_LM85_TEMP3_MAX              85  /* RW -- temp3_max  */
-#define SENSORS_LM85_TEMP3_MIN              86  /* RW -- temp3_min  */
-#define SENSORS_LM85_ZONE1_CRITICAL         87  /* RW -- zone1_critical  */
-#define SENSORS_LM85_ZONE1_HYST             88  /* RW -- zone1_hyst  */
-#define SENSORS_LM85_ZONE1_LIMIT            89  /* RW -- zone1_limit  */
-#define SENSORS_LM85_ZONE1_RANGE            90  /* RW -- zone1_range  */
-#define SENSORS_LM85_ZONE1_SMOOTH           91  /* RW -- zone1_smooth  */
-#define SENSORS_LM85_ZONE2_CRITICAL         92  /* RW -- zone2_critical  */
-#define SENSORS_LM85_ZONE2_HYST             93  /* RW -- zone2_hyst  */
-#define SENSORS_LM85_ZONE2_LIMIT            94  /* RW -- zone2_limit  */
-#define SENSORS_LM85_ZONE2_RANGE            95  /* RW -- zone2_range  */
-#define SENSORS_LM85_ZONE2_SMOOTH           96  /* RW -- zone2_smooth  */
-#define SENSORS_LM85_ZONE3_CRITICAL         97  /* RW -- zone3_critical  */
-#define SENSORS_LM85_ZONE3_HYST             98  /* RW -- zone3_hyst  */
-#define SENSORS_LM85_ZONE3_LIMIT            99  /* RW -- zone3_limit  */
-#define SENSORS_LM85_ZONE3_RANGE           100  /* RW -- zone3_range  */
-#define SENSORS_LM85_ZONE3_SMOOTH          101  /* RW -- zone3_smooth  */
+#define SENSORS_ADM1027_ALARM_MASK            1  /* RW -- alarm_mask  */
+#define SENSORS_ADM1027_FAN1_PPR              2  /* RW -- fan1_ppr  */
+#define SENSORS_ADM1027_FAN1_TACH_MODE        3  /* RW -- fan1_tach_mode  */
+#define SENSORS_ADM1027_FAN2_PPR              4  /* RW -- fan2_ppr  */
+#define SENSORS_ADM1027_FAN2_TACH_MODE        5  /* RW -- fan2_tach_mode  */
+#define SENSORS_ADM1027_FAN3_PPR              6  /* RW -- fan3_ppr  */
+#define SENSORS_ADM1027_FAN3_TACH_MODE        7  /* RW -- fan3_tach_mode  */
+#define SENSORS_ADM1027_FAN4_PPR              8  /* RW -- fan4_ppr  */
+#define SENSORS_ADM1027_FAN4_TACH_MODE        9  /* RW -- fan4_tach_mode  */
+#define SENSORS_ADM1027_PWM1_SMOOTH          10  /* RW -- pwm1_smooth  */
+#define SENSORS_ADM1027_PWM2_SMOOTH          11  /* RW -- pwm2_smooth  */
+#define SENSORS_ADM1027_PWM3_SMOOTH          12  /* RW -- pwm3_smooth  */
+#define SENSORS_ADM1027_TEMP1_OFFSET         13  /* RW -- temp1_offset  */
+#define SENSORS_ADM1027_TEMP2_OFFSET         14  /* RW -- temp2_offset  */
+#define SENSORS_ADM1027_TEMP3_OFFSET         15  /* RW -- temp3_offset  */
+#define SENSORS_LM85_ALARMS                  16  /* R  -- alarms  */
+#define SENSORS_LM85_VID                     17  /* R  -- vid  */
+#define SENSORS_LM85_VRM                     18  /* RW -- vrm  */
+#define SENSORS_LM85_FAN1                    19  /* R  -- fan1  */
+#define SENSORS_LM85_FAN1_MIN                20  /* RW -- fan1_min  */
+#define SENSORS_LM85_FAN1_TACH_MODE          21  /* RW -- fan1_tach_mode  */
+#define SENSORS_LM85_FAN2                    22  /* R  -- fan2  */
+#define SENSORS_LM85_FAN2_MIN                23  /* RW -- fan2_min  */
+#define SENSORS_LM85_FAN2_TACH_MODE          24  /* RW -- fan2_tach_mode  */
+#define SENSORS_LM85_FAN3                    25  /* R  -- fan3  */
+#define SENSORS_LM85_FAN3_MIN                26  /* RW -- fan3_min  */
+#define SENSORS_LM85_FAN3_TACH_MODE          27  /* RW -- fan3_tach_mode  */
+#define SENSORS_LM85_FAN4                    28  /* R  -- fan4  */
+#define SENSORS_LM85_FAN4_MIN                29  /* RW -- fan4_min  */
+#define SENSORS_LM85_IN0                     30  /* R  -- in0  */
+#define SENSORS_LM85_IN0_MAX                 31  /* RW -- in0_max  */
+#define SENSORS_LM85_IN0_MIN                 32  /* RW -- in0_min  */
+#define SENSORS_LM85_IN1                     33  /* R  -- in1  */
+#define SENSORS_LM85_IN1_MAX                 34  /* RW -- in1_max  */
+#define SENSORS_LM85_IN1_MIN                 35  /* RW -- in1_min  */
+#define SENSORS_LM85_IN2                     36  /* R  -- in2  */
+#define SENSORS_LM85_IN2_MAX                 37  /* RW -- in2_max  */
+#define SENSORS_LM85_IN2_MIN                 38  /* RW -- in2_min  */
+#define SENSORS_LM85_IN3                     39  /* R  -- in3  */
+#define SENSORS_LM85_IN3_MAX                 40  /* RW -- in3_max  */
+#define SENSORS_LM85_IN3_MIN                 41  /* RW -- in3_min  */
+#define SENSORS_LM85_IN4                     42  /* R  -- in4  */
+#define SENSORS_LM85_IN4_MAX                 43  /* RW -- in4_max  */
+#define SENSORS_LM85_IN4_MIN                 44  /* RW -- in4_min  */
+#define SENSORS_LM85_IN5                     45  /* R  -- in5  */
+#define SENSORS_LM85_IN5_MAX                 46  /* RW -- in5_max  */
+#define SENSORS_LM85_IN5_MIN                 47  /* RW -- in5_min  */
+#define SENSORS_LM85_IN6                     48  /* R  -- in6  */
+#define SENSORS_LM85_IN6_MAX                 49  /* RW -- in6_max  */
+#define SENSORS_LM85_IN6_MIN                 50  /* RW -- in6_min  */
+#define SENSORS_LM85_IN7                     51  /* R  -- in7  */
+#define SENSORS_LM85_IN7_MAX                 52  /* RW -- in7_max  */
+#define SENSORS_LM85_IN7_MIN                 53  /* RW -- in7_min  */
+#define SENSORS_LM85_PWM1                    54  /* RW -- pwm1  */
+#define SENSORS_LM85_PWM1_AUTO_PWM_FREQ      55  /* RW -- pwm1_auto_pwm_freq  */
+#define SENSORS_LM85_PWM1_INVERT             56  /* RW -- pwm1_invert  */
+#define SENSORS_LM85_PWM1_AUTO_PWM_MIN       57  /* RW -- pwm1_auto_pwm_min  */
+#define SENSORS_LM85_PWM1_AUTO_PWM_MINCTL    58  /* RW -- pwm1_auto_pwm_minctl  */
+#define SENSORS_LM85_PWM1_SPINUP             59  /* RW -- pwm1_spinup  */
+#define SENSORS_LM85_PWM1_SPINUP_CTL         60  /* RW -- pwm1_spinup_ctl  */
+#define SENSORS_LM85_PWM1_AUTO_CHANNELS      61  /* RW -- pwm1_auto_channels  */
+#define SENSORS_LM85_PWM2                    62  /* RW -- pwm2  */
+#define SENSORS_LM85_PWM2_AUTO_PWM_FREQ      63  /* RW -- pwm2_auto_pwm_freq  */
+#define SENSORS_LM85_PWM2_INVERT             64  /* RW -- pwm2_invert  */
+#define SENSORS_LM85_PWM2_AUTO_PWM_MIN       65  /* RW -- pwm2_auto_pwm_min  */
+#define SENSORS_LM85_PWM2_AUTO_PWM_MINCTL    66  /* RW -- pwm2_auto_pwm_minctl  */
+#define SENSORS_LM85_PWM2_SPINUP             67  /* RW -- pwm2_spinup  */
+#define SENSORS_LM85_PWM2_SPINUP_CTL         68  /* RW -- pwm2_spinup_ctl  */
+#define SENSORS_LM85_PWM2_AUTO_CHANNELS      69  /* RW -- pwm2_auto_channels  */
+#define SENSORS_LM85_PWM3                    70  /* RW -- pwm3  */
+#define SENSORS_LM85_PWM3_AUTO_PWM_FREQ      71  /* RW -- pwm3_auto_pwm_freq  */
+#define SENSORS_LM85_PWM3_INVERT             72  /* RW -- pwm3_invert  */
+#define SENSORS_LM85_PWM3_AUTO_PWM_MIN       73  /* RW -- pwm3_auto_pwm_min  */
+#define SENSORS_LM85_PWM3_AUTO_PWM_MINCTL    74  /* RW -- pwm3_auto_pwm_minctl  */
+#define SENSORS_LM85_PWM3_SPINUP             75  /* RW -- pwm3_spinup  */
+#define SENSORS_LM85_PWM3_SPINUP_CTL         76  /* RW -- pwm3_spinup_ctl  */
+#define SENSORS_LM85_PWM3_AUTO_CHANNELS      77  /* RW -- pwm3_auto_channels  */
+#define SENSORS_LM85_TEMP1                   78  /* R  -- temp1  */
+#define SENSORS_LM85_TEMP1_MAX               79  /* RW -- temp1_max  */
+#define SENSORS_LM85_TEMP1_MIN               80  /* RW -- temp1_min  */
+#define SENSORS_LM85_TEMP2                   81  /* R  -- temp2  */
+#define SENSORS_LM85_TEMP2_MAX               82  /* RW -- temp2_max  */
+#define SENSORS_LM85_TEMP2_MIN               83  /* RW -- temp2_min  */
+#define SENSORS_LM85_TEMP3                   84  /* R  -- temp3  */
+#define SENSORS_LM85_TEMP3_MAX               85  /* RW -- temp3_max  */
+#define SENSORS_LM85_TEMP3_MIN               86  /* RW -- temp3_min  */
+#define SENSORS_LM85_TEMP1_AUTO_TEMP_CRIT    87  /* RW -- temp1_auto_temp_critical  */
+#define SENSORS_LM85_TEMP1_AUTO_TEMP_OFF     88  /* RW -- temp1_auto_temp_off  */
+#define SENSORS_LM85_TEMP1_AUTO_TEMP_MIN     89  /* RW -- temp1_auto_temp_min  */
+#define SENSORS_LM85_TEMP1_AUTO_TEMP_MAX     90  /* RW -- temp1_auto_temp_max  */
+#define SENSORS_LM85_TEMP1_AUTO_TEMP_SMOOTH  91  /* RW -- temp1_auto_temp_smooth  */
+#define SENSORS_LM85_TEMP2_AUTO_TEMP_CRIT    92  /* RW -- temp2_auto_temp_critical  */
+#define SENSORS_LM85_TEMP2_AUTO_TEMP_OFF     93  /* RW -- temp2_auto_temp_off  */
+#define SENSORS_LM85_TEMP2_AUTO_TEMP_MIN     94  /* RW -- temp2_auto_temp_min  */
+#define SENSORS_LM85_TEMP2_AUTO_TEMP_MAX     95  /* RW -- temp2_auto_temp_max  */
+#define SENSORS_LM85_TEMP2_AUTO_TEMP_SMOOTH  96  /* RW -- temp2_auto_temp_smooth  */
+#define SENSORS_LM85_TEMP3_AUTO_TEMP_CRIT    97  /* RW -- temp3_auto_temp_critical  */
+#define SENSORS_LM85_TEMP3_AUTO_TEMP_OFF     98  /* RW -- temp3_auto_temp_off  */
+#define SENSORS_LM85_TEMP3_AUTO_TEMP_MIN     99  /* RW -- temp3_auto_temp_min  */
+#define SENSORS_LM85_TEMP3_AUTO_TEMP_MAX    100  /* RW -- temp3_auto_temp_max  */
+#define SENSORS_LM85_TEMP3_AUTO_TEMP_SMOOTH 101  /* RW -- temp3_auto_temp_smooth  */
 
 /* LM86/LM89/LM90/LM99/ADM1032/MAX6657 chips */



