From: Simon Guinot <simon@sequanux.org>
Date: Sun, 17 Oct 2010 15:50:12 +0000
Subject: [lm-sensors] [PATCH 2/2] [ARM] Kirkwood: add fan support for
Message-Id: <1287330612-11256-2-git-send-email-simon@sequanux.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
In-Reply-To: <1287330612-11256-1-git-send-email-simon@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/netspace_v2-setup.c |   43 ++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index fed264d..8e14147 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -30,6 +30,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
+#include <linux/gpio-fan.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
@@ -137,6 +138,46 @@ static struct platform_device netspace_v2_leds = {
 };
 
 /*****************************************************************************
+ * GPIO fan
+ ****************************************************************************/
+
+/* Designed for fan 40x40x16: ADDA AD0412LB-D50 6000rpm@12v */
+static struct gpio_fan_speed netspace_max_v2_fan_speed[] = {
+	{    0,  0 },
+	{ 1500,	15 },
+	{ 1700,	14 },
+	{ 1800,	13 },
+	{ 2100,	12 },
+	{ 3100,	11 },
+	{ 3300,	10 },
+	{ 4300,	 9 },
+	{ 5500,	 8 },
+};
+
+static unsigned netspace_max_v2_fan_ctrl[] = { 22, 7, 33, 23 };
+
+static struct gpio_fan_alarm netspace_max_v2_fan_alarm = {
+	.gpio		= 25,
+	.active_low	= 1,
+};
+
+static struct gpio_fan_platform_data netspace_max_v2_fan_data = {
+	.num_ctrl	= ARRAY_SIZE(netspace_max_v2_fan_ctrl),
+	.ctrl		= netspace_max_v2_fan_ctrl,
+	.alarm		= &netspace_max_v2_fan_alarm,
+	.num_speed	= ARRAY_SIZE(netspace_max_v2_fan_speed),
+	.speed		= netspace_max_v2_fan_speed,
+};
+
+static struct platform_device netspace_max_v2_gpio_fan = {
+	.name	= "gpio-fan",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &netspace_max_v2_fan_data,
+	},
+};
+
+/*****************************************************************************
  * General Setup
  ****************************************************************************/
 
@@ -205,6 +246,8 @@ static void __init netspace_v2_init(void)
 	platform_device_register(&netspace_v2_leds);
 	platform_device_register(&netspace_v2_gpio_leds);
 	platform_device_register(&netspace_v2_gpio_buttons);
+	if (machine_is_netspace_max_v2())
+		platform_device_register(&netspace_max_v2_gpio_fan);
 
 	if (gpio_request(NETSPACE_V2_GPIO_POWER_OFF, "power-off") = 0 &&
 	    gpio_direction_output(NETSPACE_V2_GPIO_POWER_OFF, 0) = 0)
-- 
1.6.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
