From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 22 Apr 2014 18:52:32 +0000
Subject: [lm-sensors] [PATCH] sensors.conf.5: Enhance the hysteresis documentation
Message-Id: <20140422205232.24654c42@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mention all supported temperature hysteresis attributes. Recommend
setting each limit before its hysteresis.
---
 etc/sensors.conf.eg |   22 +++++++++++-----------
 lib/sensors.conf.5  |    9 ++++++++-
 2 files changed, 19 insertions(+), 12 deletions(-)

--- lm-sensors.orig/lib/sensors.conf.5	2014-03-20 11:07:28.528881046 +0100
+++ lm-sensors/lib/sensors.conf.5	2014-04-22 20:50:06.896996307 +0200
@@ -356,7 +356,7 @@ statements are needed.
 
 On top of the usual features, temperatures can have two specific
 sub\-features: temperature sensor type (tempX_type) and hysteresis
-values (tempX_max_hyst and tempX_crit_hyst).
+values (tempX_max_hyst, tempX_crit_hyst etc.).
 
 .SS THERMAL SENSOR TYPES
 
@@ -407,6 +407,8 @@ again immediately.
 
 So, in addition to tempX_max, many chips have a tempX_max_hyst
 sub-feature. Likewise, tempX_crit often comes with tempX_crit_hyst.
+tempX_emerg_hyst, tempX_min_hyst and tempX_lcrit_hyst exist too but
+aren't as common.
 Example:
 
 .RS
@@ -419,6 +421,11 @@ set temp1_max_hyst 56
 The hysteresis mechanism can be disabled by giving both limits the same
 value.
 
+Note that it is strongly recommended to set the hysteresis value after
+the limit value it relates to in the configuration file. Implementation
+details on the hardware or driver side may cause unexpected results if
+the hysteresis value is set first.
+
 .SH BEEPS
 
 Some chips support alarms with beep warnings. When an alarm is triggered
--- lm-sensors.orig/etc/sensors.conf.eg	2014-01-19 16:58:09.571352160 +0100
+++ lm-sensors/etc/sensors.conf.eg	2014-04-22 20:46:10.780694002 +0200
@@ -745,10 +745,10 @@ chip "lm80-*"
 # All 4 of these limits apply to the single temperature sensor.
 # "crit" may or may not do anything on your motherboard but it should
 #  be set higher than the "max" thresholds.
-#    set temp1_max_hyst   45
 #    set temp1_max        52
-#    set temp1_crit_hyst  57
+#    set temp1_max_hyst   45
 #    set temp1_crit       62
+#    set temp1_crit_hyst  57
 
 
 chip "via686a-*"
@@ -822,12 +822,12 @@ chip "via686a-*"
 # we would still get some oscillation when the temp hovers around the limit
 # due to noise.)
 
-#    set temp1_max_hyst 40
 #    set temp1_max      45
-#    set temp2_max_hyst 55
+#    set temp1_max_hyst 40
 #    set temp2_max      60
-#    set temp3_max_hyst 60
+#    set temp2_max_hyst 55
 #    set temp3_max      65
+#    set temp3_max_hyst 60
 
 # You could set your fan limits too, but the defaults should be fine.
 
@@ -1452,14 +1452,14 @@ chip "vt1211-*"
     compute temp7  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
                    2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
 
-#    set temp1_max_hyst 80
 #    set temp1_max      85
-#    set temp2_max_hyst 60
+#    set temp1_max_hyst 80
 #    set temp2_max      65
-#    set temp3_max_hyst 60
+#    set temp2_max_hyst 60
 #    set temp3_max      65
-#    set temp4_max_hyst 40
+#    set temp3_max_hyst 60
 #    set temp4_max      45
+#    set temp4_max_hyst 40
 
 #    set fan1_min 3000
 #    set fan2_min 3000
@@ -1520,10 +1520,10 @@ chip "vt8231-*"
     compute temp3  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) - 273.15, \
                    2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 + @))))
 
-#    set temp1_max_hyst 60
 #    set temp1_max      65
-#    set temp2_max_hyst 40
+#    set temp1_max_hyst 60
 #    set temp2_max      45
+#    set temp2_max_hyst 40
 
 #    set fan1_min 3000
 #    set fan2_min 3000


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
