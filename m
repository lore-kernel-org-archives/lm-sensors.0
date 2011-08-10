From: Keerthy <j-keerthy@ti.com>
Date: Wed, 10 Aug 2011 12:37:19 +0000
Subject: [lm-sensors] [RFC PATCH 3/6] OMAP4: Hwmod: OMAP temperature sensor
Message-Id: <1312979122-5896-4-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, j-keerthy@ti.com

From: Benoit Cousson <b-cousson@ti.com>

OMAP4460 temperature sensor hwmod cannot be auto generated
since it is part of ctrl module. Hence populating the
necessary hwmod info manually.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   61 ++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..28bf6d3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -29,6 +29,7 @@
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
 #include <plat/i2c.h>
+#include <plat/temperature_sensor.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -832,6 +833,63 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 };
 
 /*
+ * 'temperature_sensor' class
+ * temperature sensor module inside the bandgap / control module
+ */
+
+static struct omap_hwmod_class omap44xx_temperature_sensor_hwmod_class = {
+	.name   = "temperature_sensor",
+};
+
+static struct omap_hwmod_irq_info omap44xx_temperature_sensor_irqs[] = {
+	{ .name = "thermal_alert", .irq = 126 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_temperature_sensor_addrs[] = {
+	{
+		.pa_start       = 0x4a00232c,
+		.pa_end         = 0x4a00238b,
+	},
+};
+
+static struct omap_hwmod omap44xx_temperature_sensor_hwmod;
+/* l4_cfg -> ctrl_module_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__temperature_sensor = {
+	.master         = &omap44xx_l4_cfg_hwmod,
+	.slave          = &omap44xx_temperature_sensor_hwmod,
+	.clk            = "l4_div_ck",
+	.addr           = omap44xx_temperature_sensor_addrs,
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* ctrl_module_core slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_temperature_sensor_slaves[] = {
+	&omap44xx_l4_cfg__temperature_sensor,
+};
+
+/* temperature sensor dev_attr */
+static struct omap_temp_sensor_dev_attr temp_sensor_dev_attr = {
+	.name	= "mpu",
+};
+
+static struct omap_hwmod omap44xx_temperature_sensor_hwmod = {
+	.name           = "temperature_sensor_mpu",
+	.class          = &omap44xx_temperature_sensor_hwmod_class,
+	.mpu_irqs       = omap44xx_temperature_sensor_irqs,
+	.main_clk       = "bandgap_ts_fclk",
+	.slaves		= omap44xx_temperature_sensor_slaves,
+	.slaves_cnt     = ARRAY_SIZE(omap44xx_temperature_sensor_slaves),
+	.clkdm_name     = "l4_wkup_clkdm",
+	.prcm           = {
+		.omap4 = {
+		.clkctrl_offs = OMAP4_CM_WKUP_BANDGAP_CLKCTRL_OFFSET,
+		},
+	},
+	.dev_attr	= &temp_sensor_dev_attr,
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'bandgap' class
  * bangap reference for ldo regulators
  */
@@ -5469,6 +5527,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_timer10_hwmod,
 	&omap44xx_timer11_hwmod,
 
+	/* temperature sensor hwmod */
+	&omap44xx_temperature_sensor_hwmod,
+
 	/* uart class */
 	&omap44xx_uart1_hwmod,
 	&omap44xx_uart2_hwmod,
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
