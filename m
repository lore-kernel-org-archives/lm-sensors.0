From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Wed, 06 Nov 2013 20:23:03 +0000
Subject: [lm-sensors] [PATCHv2 3/7] arm: dts: dra7: add bandgap entry
Message-Id: <1383769383-13500-1-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380652344-18819-4-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1380652344-18819-4-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, grant.likely@linaro.org, bcousson@baylibre.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, Eduardo Valentin <eduardo.valentin@ti.com>

This patch adds bandgap IP entry on DRA7 dtsi device tree file.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)
---
Hi all,

Difference from V1: now the BG node belongs to OCP.

Tero, this is the patch you were asking for.

Thanks,

Eduardo

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 3a746c2..d3d467b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -102,6 +102,18 @@
 			pinctrl-single,function-mask = <0x3fffffff>;
 		};
 
+		bandgap: bandgap {
+			reg = <0x4a0021e0 0xc
+				0x4a00232c 0xc
+				0x4a002380 0x2c
+				0x4a0023C0 0x3c
+				0x4a002564 0x8
+				0x4a002574 0x50>;
+			compatible = "ti,dra752-bandgap";
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-- 
1.8.2.1.342.gfa7285d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
