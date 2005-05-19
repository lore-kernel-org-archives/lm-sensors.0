From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC PATCH libsensors: change vid for adm1025, adm1026 and adm9240
Message-Id: <7bd381pbap6v9k0l51b80728rplvfvhvqk@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Help!?

Does this do the expected changes?, last attempt was back in 
http://archives.andrew.net.au/lm-sensors/msg30079.html

I'm lost in libsensors :)

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 chips.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- lm_sensors2/lib/chips.c	2005-03-28 01:44:53.000000000 +1000
+++ lm_sensors2a/lib/chips.c	2005-05-11 17:40:57.000000000 +1000
@@ -2010,7 +2010,7 @@ static sensors_chip_feature adm9240_feat
                          ADM9240_SYSCTL_TEMP, VALUE(1), 1, "temp1_max", 3 },
 
     { SENSORS_ADM9240_VID, "vid", NOMAP, NOMAP,
-                         R, ADM9240_SYSCTL_VID, VALUE(1), 2, "in1_ref", 3 },
+                         R, ADM9240_SYSCTL_VID, VALUE(1), 2, "cpu0_vid", 3 },
     { SENSORS_ADM9240_FAN1_DIV, "fan1_div", SENSORS_ADM9240_FAN1, 
                          NOMAP, RW, 
                          ADM9240_SYSCTL_FAN_DIV, VALUE(1), 0 },
@@ -2021,7 +2021,7 @@ static sensors_chip_feature adm9240_feat
                          R, ADM9240_SYSCTL_ALARMS, VALUE(1), 0 },
     { SENSORS_ADM9240_ANALOG_OUT, "analog_out", NOMAP,
                          NOMAP, RW,
-                         ADM9240_SYSCTL_ANALOG_OUT, VALUE(1), 0 },
+                         ADM9240_SYSCTL_ANALOG_OUT, VALUE(1), 0, "aout_output", 3 },
     { 0 }
   };
 
@@ -2658,8 +2658,8 @@ static sensors_chip_feature adm1025_feat
     { SENSORS_ADM1025_TEMP2_HIGH, "temp2_high", SENSORS_ADM1025_TEMP2,
                          SENSORS_ADM1025_TEMP2, RW, 
                          ADM1025_SYSCTL_TEMP, VALUE(1), 1 },
-    { SENSORS_ADM1025_VID, "vid", NOMAP, NOMAP,
-                         R, ADM1025_SYSCTL_VID, VALUE(1), 3 , "in1_ref", 3 },
+    { SENSORS_ADM1025_VID, "vid", NOMAP, NOMAP, R, ADM1025_SYSCTL_VID,
+	    		VALUE(1), 3, "cpu0_vid", 3, "in1_ref" },
     { SENSORS_ADM1025_VRM, "vrm", NOMAP, NOMAP,
                          RW, ADM1025_SYSCTL_VRM, VALUE(1), 1 },
     { SENSORS_ADM1025_ALARMS, "alarms", NOMAP, NOMAP, 
@@ -2683,7 +2683,7 @@ static sensors_chip_feature adm1026_feat
 		ADM1026_SYSCTL_GPIO_MASK, VALUE(1), 0 },
     { SENSORS_ADM1026_VID, "vid",
 		NOMAP, NOMAP, RW,
-		ADM1026_SYSCTL_VID, VALUE(1), 3 },
+		ADM1026_SYSCTL_VID, VALUE(1), 3, "cpu0_vid" },
     { SENSORS_ADM1026_VRM, "vrm",
 		NOMAP, NOMAP, RW,
 		ADM1026_SYSCTL_VRM, VALUE(1), 1 },
