From: Wei Ni <wni@nvidia.com>
Date: Wed, 07 Aug 2013 06:52:38 +0000
Subject: [lm-sensors] [PATCH 2/2] ARM: dt: t114 dalmore: add dt entry for nct1008
Message-Id: <1375858358-15070-3-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1375858358-15070-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, swarren@wwwdotorg.org
Cc: linux@roeck-us.net, MLongnecker@nvidia.com, linux-arm-kernel@lists.infradead.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>

Enable thermal sensor nct1008 for t114 dalmore.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index b5a42f0..9d4d2b2 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -738,6 +738,14 @@
 			realtek,ldo1-en-gpios  				<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 		};
+
+		nct1008 {
+			compatible = "onnn,nct1008";
+			reg = <0x4c>;
+			vdd-supply = <&palmas_ldo6_reg>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
+		};
 	};
 
 	i2c@7000d000 {
@@ -945,7 +953,7 @@
 						regulator-max-microvolt = <1800000>;
 					};
 
-					ldo6 {
+					palmas_ldo6_reg: ldo6 {
 						regulator-name = "vdd-sensor-2v85";
 						regulator-min-microvolt = <2850000>;
 						regulator-max-microvolt = <2850000>;
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
