From: AnilKumar Ch <anilkumar@ti.com>
Date: Tue, 18 Sep 2012 07:57:14 +0000
Subject: [lm-sensors] [PATCH] ARM: dts: AM33XX: Add temperature sensor device tree data to am335x-evm
Message-Id: <1347954859-11611-1-git-send-email-anilkumar@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, linux@roeck-us.net, lm-sensors@lm-sensors.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>, linux-arm-kernel@lists.infradead.org

Add temperature sensor DT data to am335x-evm.dts. In AM335x EVM
tmp275 temperature sensor is connected to I2C2 bus. So this patch
adds child node inside i2c2 node with i2c slave address. This patch
is tested on AM335x EVM.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index be309df..3b1f313 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -78,6 +78,11 @@
 				st,max-limit-y = <550>;
 				st,max-limit-z = <750>;
 			};
+
+			tmp275: tmp275@48 {
+				compatible = "ti,tmp275";
+				reg = <0x48>;
+			};
 		};
 
 		dcan1: d_can@481d0000 {
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
