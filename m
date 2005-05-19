From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] PATCH lm_sensors: add adm9240 example to sensors.conf,
Message-Id: <a15j81ddj1db841b4le9aeo58cfsnqpsql@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds a sensors.conf example for adm9240 on Intel 
SE440BX-2 mainboard.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 sensors.conf.eg |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+)

--- lm_sensors2/etc/sensors.conf.eg	2005-05-16 08:31:02.000000000 +1000
+++ lm_sensors2a/etc/sensors.conf.eg	2005-05-17 16:45:36.000000000 +1000
@@ -1490,6 +1490,43 @@
 #   compute Vccp2 xxx
 #   compute temp xxx
 
+# Example: Intel SE440BX-2 with ADM9240 by Grant Coady 2005-05-16
+
+    label "2.5V"  "  2.5V"
+    label "3.3V"  "  3.3V"
+    label "5V"    "    5V"
+    label "12V"   "   12V"
+    label Vccp1   "   -5V"
+    label Vccp2   "  -12V"
+    label fan1    "PS Fan"
+    label temp    "  Temp"
+
+    # no computes for internally scaled: "2.5V" "3.3V" "5V" "12V"
+    # compute lines for -5V and -12V must account for drift in +5V
+    # -5V
+    compute Vccp1 "5V"+((@-"5V")*(1+(27/12))), "5V"-(("5V"-@)/(1+(27/12)))
+    # -12V
+    compute Vccp2 "5V"+((@-"5V")*(1+(82/15))), "5V"-(("5V"-@)/(1+(82/15)))
+
+    set "2.5V_min" 1.5 * 0.91
+    set "2.5V_max" 1.5 * 1.09
+    set "3.3V_min" 3.3 * 0.95
+    set "3.3V_max" 3.3 * 1.05
+    set "5V_min"     5 * 0.95
+    set "5V_max"     5 * 1.05
+    set "12V_min"   12 * 0.95
+    set "12V_max"   12 * 1.05
+    set Vccp1_max   -5 * 0.90
+    set Vccp1_min   -5 * 1.10
+    set Vccp2_max  -12 * 0.90
+    set Vccp2_min  -12 * 1.10
+
+    # do *NOT* set fan1_div or fan2_div on 2.6 driver, it is automatic.
+    set fan1_min 1200
+    ignore fan2
+    set temp_over  50
+    set temp_hyst  45
+
 chip "adm1024-*"
 #
 # These settings work for me, adjust for your system

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
