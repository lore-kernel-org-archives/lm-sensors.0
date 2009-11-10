From: chudson@kionix.com
Date: Tue, 10 Nov 2009 18:28:48 +0000
Subject: [lm-sensors] [RFC PATCH 2/3] mach-omap2:kxte9 accelerometer support
Message-Id: <1257877729-25647-2-git-send-email-chudson@kionix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>
In-Reply-To: <1257877729-25647-1-git-send-email-chudson@kionix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, Chris Hudson <chudson@kionix.com>

From: Chris Hudson <chudson@kionix.com>

This patch alters board-zoom2.c to add platform data initialization, gpio 
configuration, and i2c-2 bus initialization in support of the kxte9 
accelerometer on the OMAP ZoomII platform.

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 arch/arm/mach-omap2/board-zoom2.c |   58 +++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 4ad9b94..da59d9c 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -27,6 +27,47 @@
 #include "mmc-twl4030.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 
+#ifdef CONFIG_SENSORS_KXTE9
+/* KIONIX KXTE9 Digital Tri-axis Accelerometer */
+#include <plat/mux.h>
+#include <linux/kxte9.h>
+#define ZOOM2_KIONIX_INT_GPIO	156
+
+static void __init zoom2_kionix_init(void)
+{
+	omap_cfg_reg(Y21_34XX_GPIO156);
+	if (gpio_request(ZOOM2_KIONIX_INT_GPIO, "kionix_irq") < 0) {
+		printk(KERN_ERR "kionix error retrieving GPIO\n");
+		return;
+	}
+	gpio_direction_input(ZOOM2_KIONIX_INT_GPIO);
+}
+
+static struct kxte9_platform_data zoom2_kxte9_data = {
+	.min_interval	= 25,
+	.poll_interval	= 200,
+
+	.axis_map_x	= 0,
+	.axis_map_y	= 1,
+	.axis_map_z	= 2,
+
+	.negate_x	= 0,
+	.negate_y	= 0,
+	.negate_z	= 0,
+
+	.ctrl_reg1_init		= TPE | WUFE | B2SE,
+	.engine_odr_init	= OB2S10 | OWUF40,
+	.int_ctrl_init		= KXTE9_IEN | KXTE9_IEA,
+	.tilt_timer_init	= 0x03,
+	.wuf_timer_init		= 0x01,
+	.b2s_timer_init		= 0x01,
+	.wuf_thresh_init	= 0x20,
+	.b2s_thresh_init	= 0x60,
+
+	.gpio = ZOOM2_KIONIX_INT_GPIO,
+};
+#endif
+
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -256,11 +297,25 @@ static struct i2c_board_info __initdata zoom2_i2c_boardinfo[] = {
 	},
 };
 
+#ifdef CONFIG_SENSORS_KXTE9
+static struct i2c_board_info __initdata zoom2_i2c_bus2info[] = {
+	{
+		I2C_BOARD_INFO("kxte9", KXTE9_I2C_ADDR),
+		.platform_data = &zoom2_kxte9_data,
+	},
+};
+#endif
+
 static int __init omap_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, zoom2_i2c_boardinfo,
 			ARRAY_SIZE(zoom2_i2c_boardinfo));
+#ifndef CONFIG_SENSORS_KXTE9
 	omap_register_i2c_bus(2, 400, NULL, 0);
+#else
+	omap_register_i2c_bus(2, 400, zoom2_i2c_bus2info,
+			ARRAY_SIZE(zoom2_i2c_bus2info));
+#endif
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
 }
@@ -269,6 +324,9 @@ extern int __init omap_zoom2_debugboard_init(void);
 
 static void __init omap_zoom2_init(void)
 {
+#ifdef CONFIG_SENSORS_KXTE9
+	zoom2_kionix_init();
+#endif
 	omap_i2c_init();
 	omap_serial_init();
 	omap_zoom2_debugboard_init();
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
