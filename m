From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: RFC PATCH libsensors: add adm9240 info to sensors.conf.eg
Message-Id: <sd49815eav894q1uu8hjf7ej1ohshg49ee@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

Patch adds example adm9240 settings to suit Intel SE440BX-2 mobo 
and warning not to set fan_div for 2.6 version driver.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 sensors.conf.eg |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)

--- lm_sensors2/etc/sensors.conf.eg	2005-05-03 17:54:09.000000000 +1000
+++ lm_sensors2a/etc/sensors.conf.eg	2005-05-13 21:36:20.000000000 +1000
@@ -1475,8 +1475,8 @@
 #   set "12V_max" xxx
 #   set Vccp2_max xxx
 #
-#   set fan1_div xxx
-#   set fan2_div xxx
+#   set fan1_div xxx	Note: do not uncomment with kernel 2.6 driver
+#   set fan2_div xxx	Note: do not uncomment with kernel 2.6 driver
 #   set fan1_min xxx
 #   set fan2_min xxx
 #   set temp1_hyst xxx
@@ -1490,6 +1490,43 @@
 #   compute Vccp2 xxx
 #   compute temp xxx
 
+# Example for Intel SE440BX-2 Mainboard:
+
+    label "2.5V"    "   1.5V"
+    label "3.3V"    "   3.3V"
+    label "5V"      "     5V"
+    label "12V"     "    12V"
+    label "Vccp1"   "    -5V"
+    label "Vccp2"   "   -12V"
+    label fan1      "PSU Fan"
+    ignore fan2
+    label temp      "Ambient"
+    # +V internally scaled
+    compute "2.5V"  @, @
+    compute "3.3V"  @, @
+    compute "5V"    @, @
+    compute "12V"   @, @
+    # -5V
+    compute "Vccp1" "5V"+((@-"5V")*(1+(27/12))), "5V"-(("5V"-@)/(1+(27/12)))
+    # -12V
+    compute "Vccp2" "5V"+((@-"5V")*(1+(82/15))), "5V"-(("5V"-@)/(1+(82/15)))
+
+    set "2.5V_min"  1.5 * 0.91
+    set "2.5V_max"  1.5 * 1.09
+    set "3.3V_min"  3.3 * 0.95
+    set "3.3V_max"  3.3 * 1.05
+    set "5V_min"      5 * 0.95
+    set "5V_max"      5 * 1.05
+    set "12V_min"    12 * 0.95
+    set "12V_max"    12 * 1.05
+    set "Vccp1_max"  -5 * 0.90
+    set "Vccp1_min"  -5 * 1.10
+    set "Vccp2_max" -12 * 0.90
+    set "Vccp2_min" -12 * 1.10
+    set fan1_min    1200
+    set temp_over   50
+    set temp_hyst   45
+
 chip "adm1024-*"
 #
 # These settings work for me, adjust for your system
