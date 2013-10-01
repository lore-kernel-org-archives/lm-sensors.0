From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Tue, 01 Oct 2013 18:32:20 +0000
Subject: [lm-sensors] [PATCH 3/7] arm: dts: dra7: add bandgap entry
Message-Id: <1380652344-18819-4-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
In-Reply-To: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, grant.likely@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch adds bandgap IP entry on DRA7 dtsi device tree file.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 3a746c2..4e9b159 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -53,6 +53,18 @@
 		};
 	};
 
+	bandgap: bandgap {
+		reg = <0x4a0021e0 0xc
+			0x4a00232c 0xc
+			0x4a002380 0x2c
+			0x4a0023C0 0x3c
+			0x4a002564 0x8
+			0x4a002574 0x50>;
+		compatible = "ti,dra752-bandgap";
+		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+		#thermal-sensor-cells = <1>;
+	};
+
 	gic: interrupt-controller@48211000 {
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
-- 
1.8.2.1.342.gfa7285d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
