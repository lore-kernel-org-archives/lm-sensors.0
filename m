From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sat, 28 May 2005 01:36:17 +0000
Subject: [lm-sensors] PATCH libsensors: ds1780 fix
Message-Id: <2ebf911gp0e3p9u82e78a758o7v4o623hr@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

A user reported problems with sensors being unable to access DS1780 
IN0..IN5 with 2.6 adm9240 driver port.

This patch removes separate ds1780 defines and links them instead 
to adm92450 as is done for LM81 register compatible.  Compile tested

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 chips.c |   90 ++--------------------------------------------------------------
 1 files changed, 3 insertions(+), 87 deletions(-)

--- lm_sensors2/lib/chips.c	2005-05-13 21:01:57.000000000 +1000
+++ lm_sensors2a/lib/chips.c	2005-05-28 09:28:47.000000000 +1000
@@ -2126,91 +2126,6 @@ static sensors_chip_feature adm1024_feat
     { 0 }
   };
 
-static sensors_chip_feature ds1780_features[] -  { 
-    { SENSORS_DS1780_IN0, "2.5V", NOMAP, NOMAP, 
-                        R, ADM9240_SYSCTL_IN0, VALUE(3), 2 },
-    { SENSORS_DS1780_IN1, "Vccp1", NOMAP, NOMAP,
-                        R, ADM9240_SYSCTL_IN1, VALUE(3), 2 },
-    { SENSORS_DS1780_IN2, "3.3V", NOMAP, NOMAP,
-                        R, ADM9240_SYSCTL_IN2, VALUE(3), 2 },
-    { SENSORS_DS1780_IN3, "5V", NOMAP, NOMAP,
-                        R, ADM9240_SYSCTL_IN3, VALUE(3), 2 },
-    { SENSORS_DS1780_IN4, "12V", NOMAP, NOMAP,
-                        R, ADM9240_SYSCTL_IN4, VALUE(3), 2 },
-    { SENSORS_DS1780_IN5, "Vccp2", NOMAP, NOMAP,
-                        R, ADM9240_SYSCTL_IN5, VALUE(3), 2 },
-    { SENSORS_DS1780_IN0_MIN, "2.5V_min", SENSORS_DS1780_IN0, 
-                        SENSORS_DS1780_IN0, RW, 
-                        ADM9240_SYSCTL_IN0, VALUE(1), 2 },
-    { SENSORS_DS1780_IN1_MIN, "Vccp1_min", SENSORS_DS1780_IN1, 
-                        SENSORS_DS1780_IN1, RW, 
-                        ADM9240_SYSCTL_IN1, VALUE(1), 2 },
-    { SENSORS_DS1780_IN2_MIN, "3.3V_min", SENSORS_DS1780_IN2, 
-                        SENSORS_DS1780_IN2, RW, 
-                        ADM9240_SYSCTL_IN2, VALUE(1), 2 },
-    { SENSORS_DS1780_IN3_MIN, "5V_min", SENSORS_DS1780_IN3, 
-                        SENSORS_DS1780_IN3, RW, 
-                        ADM9240_SYSCTL_IN3, VALUE(1), 2 },
-    { SENSORS_DS1780_IN4_MIN, "12V_min", SENSORS_DS1780_IN4, 
-                        SENSORS_DS1780_IN4, RW, 
-                        ADM9240_SYSCTL_IN4, VALUE(1), 2 },
-    { SENSORS_DS1780_IN5_MIN, "Vccp2_min", SENSORS_DS1780_IN5, 
-                        SENSORS_DS1780_IN5, RW, 
-                        ADM9240_SYSCTL_IN5, VALUE(1), 2 },
-    { SENSORS_DS1780_IN0_MAX, "2.5V_max", SENSORS_DS1780_IN0, 
-                        SENSORS_DS1780_IN0, RW,
-                        ADM9240_SYSCTL_IN0, VALUE(2), 2 },
-    { SENSORS_DS1780_IN1_MAX, "Vccp1_max", SENSORS_DS1780_IN1, 
-                        SENSORS_DS1780_IN1, RW, 
-                        ADM9240_SYSCTL_IN1, VALUE(2), 2 },
-    { SENSORS_DS1780_IN2_MAX, "3.3V_max", SENSORS_DS1780_IN2, 
-                        SENSORS_DS1780_IN2, RW, 
-                        ADM9240_SYSCTL_IN2, VALUE(2), 2 },
-    { SENSORS_DS1780_IN3_MAX, "5V_max", SENSORS_DS1780_IN3, 
-                        SENSORS_DS1780_IN3, RW, 
-                        ADM9240_SYSCTL_IN3, VALUE(2), 2 },
-    { SENSORS_DS1780_IN4_MAX, "12V_max", SENSORS_DS1780_IN4, 
-                        SENSORS_DS1780_IN4, RW,
-                        ADM9240_SYSCTL_IN4, VALUE(2), 2 },
-    { SENSORS_DS1780_IN5_MAX, "Vccp2_max", SENSORS_DS1780_IN5, 
-                        SENSORS_DS1780_IN5, RW, 
-                        ADM9240_SYSCTL_IN5, VALUE(2), 2 },
-    { SENSORS_DS1780_FAN1, "fan1", NOMAP, NOMAP,
-                        R, ADM9240_SYSCTL_FAN1, VALUE(2), 0 },
-    { SENSORS_DS1780_FAN2, "fan2", NOMAP, NOMAP,
-                        R, ADM9240_SYSCTL_FAN2, VALUE(2), 0 },
-    { SENSORS_DS1780_FAN1_MIN, "fan1_min", SENSORS_DS1780_FAN1,
-                        SENSORS_DS1780_FAN1, RW, 
-                        ADM9240_SYSCTL_FAN1, VALUE(1), 0 },
-    { SENSORS_DS1780_FAN2_MIN, "fan2_min", SENSORS_DS1780_FAN2, 
-                        SENSORS_DS1780_FAN2, RW, 
-                        ADM9240_SYSCTL_FAN2, VALUE(1), 0 },
-    { SENSORS_DS1780_TEMP, "temp", NOMAP, NOMAP,
-                         R, ADM9240_SYSCTL_TEMP, VALUE(3), 1 },
-    { SENSORS_DS1780_TEMP_HYST, "temp_hyst", SENSORS_DS1780_TEMP,
-                         SENSORS_DS1780_TEMP, RW, 
-                         ADM9240_SYSCTL_TEMP, VALUE(2), 1 },
-    { SENSORS_DS1780_TEMP_OVER, "temp_over", SENSORS_DS1780_TEMP,
-                         SENSORS_DS1780_TEMP, RW, 
-                         ADM9240_SYSCTL_TEMP, VALUE(1), 1 },
-
-    { SENSORS_DS1780_VID, "vid", NOMAP, NOMAP,
-                         R, ADM9240_SYSCTL_VID, VALUE(1), 2 },
-    { SENSORS_DS1780_FAN1_DIV, "fan1_div", SENSORS_DS1780_FAN1, 
-                         NOMAP, RW, 
-                         ADM9240_SYSCTL_FAN_DIV, VALUE(1), 0 },
-    { SENSORS_DS1780_FAN2_DIV, "fan2_div", SENSORS_DS1780_FAN2, 
-                         NOMAP, RW, 
-                         ADM9240_SYSCTL_FAN_DIV, VALUE(2), 0 },
-    { SENSORS_DS1780_ALARMS, "alarms", NOMAP, NOMAP, 
-                         R, ADM9240_SYSCTL_ALARMS, VALUE(1), 0 },
-    { SENSORS_DS1780_ANALOG_OUT, "analog_out", NOMAP,
-                         NOMAP, RW,
-                         ADM9240_SYSCTL_ANALOG_OUT, VALUE(1), 0 },
-    { 0 }
-  };
-
 static sensors_chip_feature sis5595_features[]    { 
     { SENSORS_SIS5595_IN0, "in0", NOMAP, NOMAP, 
@@ -5526,9 +5441,10 @@ sensors_chip_features sensors_chip_featu
  { SENSORS_AS99127F_PREFIX, as99127f_features },
  { SENSORS_ASB100_PREFIX, asb100_features },
  { SENSORS_ADM9240_PREFIX, adm9240_features },
-		/* Cheat on LM81 for now - no separate #defines */
+		/* Cheat on LM81 - register compatible */
  { SENSORS_LM81_PREFIX, adm9240_features },
- { SENSORS_DS1780_PREFIX, ds1780_features },
+		/* Cheat on DS1780 - register compatible */
+ { SENSORS_DS1780_PREFIX, adm9240_features },
  { SENSORS_ADM1021_PREFIX, adm1021_features },
  { SENSORS_MAX1617_PREFIX, max1617_features },
  { SENSORS_MC1066_PREFIX, max1617_features },
