From: Keerthy <j-keerthy@ti.com>
Date: Wed, 10 Aug 2011 12:37:18 +0000
Subject: [lm-sensors] [RFC PATCH 2/6] OMAP4: Adding the temperature sensor
Message-Id: <1312979122-5896-3-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, j-keerthy@ti.com

OMAP4460 specific temperature sensor register bit fields are added.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../include/mach/ctrl_module_core_44xx.h           |   70 ++++++++++++++++----
 1 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
index 2f7ac70..725c1e1 100644
--- a/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
+++ b/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
@@ -256,19 +256,63 @@
 #define OMAP4_LDOSRAMCORE_ACTMODE_VSET_OUT_SHIFT	0
 #define OMAP4_LDOSRAMCORE_ACTMODE_VSET_OUT_MASK		(0x1f << 0)
 
-/* TEMP_SENSOR */
-#define OMAP4_BGAP_TEMPSOFF_SHIFT			12
-#define OMAP4_BGAP_TEMPSOFF_MASK			(1 << 12)
-#define OMAP4_BGAP_TSHUT_SHIFT				11
-#define OMAP4_BGAP_TSHUT_MASK				(1 << 11)
-#define OMAP4_BGAP_TEMP_SENSOR_CONTCONV_SHIFT		10
-#define OMAP4_BGAP_TEMP_SENSOR_CONTCONV_MASK		(1 << 10)
-#define OMAP4_BGAP_TEMP_SENSOR_SOC_SHIFT		9
-#define OMAP4_BGAP_TEMP_SENSOR_SOC_MASK			(1 << 9)
-#define OMAP4_BGAP_TEMP_SENSOR_EOCZ_SHIFT		8
-#define OMAP4_BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 8)
-#define OMAP4_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
-#define OMAP4_BGAP_TEMP_SENSOR_DTEMP_MASK		(0xff << 0)
+/* TEMP_SENSOR OMAP4430 */
+#define OMAP4430_BGAP_TEMPSOFF_SHIFT			12
+#define OMAP4430_BGAP_TEMPSOFF_MASK			(1 << 12)
+#define OMAP4430_BGAP_TSHUT_SHIFT				11
+#define OMAP4430_BGAP_TSHUT_MASK				(1 << 11)
+#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_SHIFT		10
+#define OMAP4430_BGAP_TEMP_SENSOR_CONTCONV_MASK		(1 << 10)
+#define OMAP4430_BGAP_TEMP_SENSOR_SOC_SHIFT		9
+#define OMAP4430_BGAP_TEMP_SENSOR_SOC_MASK			(1 << 9)
+#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_SHIFT		8
+#define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 8)
+#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
+#define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
+
+/* TEMP_SENSOR OMAP4460 */
+#define OMAP4460_BGAP_TEMPSOFF_SHIFT			13
+#define OMAP4460_BGAP_TEMPSOFF_MASK			(1 << 13)
+#define OMAP4460_BGAP_TEMP_SENSOR_SOC_SHIFT		11
+#define OMAP4460_BGAP_TEMP_SENSOR_SOC_MASK		(1 << 11)
+#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_SHIFT		10
+#define OMAP4460_BGAP_TEMP_SENSOR_EOCZ_MASK		(1 << 10)
+#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_SHIFT		0
+#define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
+
+/* BANDGAP_CTRL */
+#define OMAP4460_SINGLE_MODE_SHIFT			31
+#define OMAP4460_SINGLE_MODE_MASK			(1 << 31)
+#define OMAP4460_MASK_HOT_SHIFT				1
+#define OMAP4460_MASK_HOT_MASK				(1 << 1)
+#define OMAP4460_MASK_COLD_SHIFT			0
+#define OMAP4460_MASK_COLD_MASK				(1 << 0)
+
+/* BANDGAP_COUNTER */
+#define OMAP4460_COUNTER_SHIFT				0
+#define OMAP4460_COUNTER_MASK				(0xffffff << 0)
+
+/* BANDGAP_THRESHOLD */
+#define OMAP4460_T_HOT_SHIFT				16
+#define OMAP4460_T_HOT_MASK				(0x3ff << 16)
+#define OMAP4460_T_COLD_SHIFT				0
+#define OMAP4460_T_COLD_MASK				(0x3ff << 0)
+
+/* TSHUT_THRESHOLD */
+#define OMAP4460_TSHUT_HOT_SHIFT			16
+#define OMAP4460_TSHUT_HOT_MASK				(0x3ff << 16)
+#define OMAP4460_TSHUT_COLD_SHIFT			0
+#define OMAP4460_TSHUT_COLD_MASK			(0x3ff << 0)
+
+/* BANDGAP_STATUS */
+#define OMAP4460_CLEAN_STOP_SHIFT			3
+#define OMAP4460_CLEAN_STOP_MASK			(1 << 3)
+#define OMAP4460_BGAP_ALERT_SHIFT			2
+#define OMAP4460_BGAP_ALERT_MASK			(1 << 2)
+#define OMAP4460_HOT_FLAG_SHIFT				1
+#define OMAP4460_HOT_FLAG_MASK				(1 << 1)
+#define OMAP4460_COLD_FLAG_SHIFT			0
+#define OMAP4460_COLD_FLAG_MASK				(1 << 0)
 
 /* DPLL_NWELL_TRIM_0 */
 #define OMAP4_DPLL_ABE_NWELL_TRIM_MUX_CTRL_SHIFT	29
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
