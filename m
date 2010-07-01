From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Date: Thu, 01 Jul 2010 13:06:13 +0000
Subject: [lm-sensors] [RFC] [PATCH] Board changes for tmp105 temperature
Message-Id: <0680EC522D0CC943BC586913CF3768C003B360315C@dbde02.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <0680EC522D0CC943BC586913CF3768C003B34A6404@dbde02.ent.ti.com>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B34A6404@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Tony Lindgren <tony@atomide.com>

Adding board configuration for the tmp105
temperature sensor. The interface to the sensor
is I2C.
-Removing unwanted file mode change

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4bb2c5d..3e3b222 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -353,6 +353,11 @@ static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
 		.platform_data = &sdp4430_twldata,
 	},
 };
+static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("tmp105", 0x48),
+	},
+};
 static int __init omap4_i2c_init(void)
 {
 	/*
@@ -362,7 +367,8 @@ static int __init omap4_i2c_init(void)
 	omap_register_i2c_bus(1, 400, sdp4430_i2c_boardinfo,
 			ARRAY_SIZE(sdp4430_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
+				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
 	omap_register_i2c_bus(4, 400, NULL, 0);
 	return 0;
 }
-- 
1.5.4.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
