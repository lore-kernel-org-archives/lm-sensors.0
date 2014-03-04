From: Wei Ni <wni@nvidia.com>
Date: Tue, 04 Mar 2014 11:31:04 +0000
Subject: [lm-sensors] [PATCH v2 3/3] ARM: tegra: dalmore: add thermal zones for nct1008
Message-Id: <1393932664-13319-4-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393932664-13319-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1393932664-13319-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add dt node to describe the thermal zone for the nct1008.

Change-Id: I0256836e52d73ec282574e4fd91df52958936e35
Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 8de5437..453f5ea 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -780,12 +780,14 @@
 				<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 		};
 
-		temperature-sensor@4c {
+		nct1008: temperature-sensor@4c {
 			compatible = "onnn,nct1008";
 			reg = <0x4c>;
 			vcc-supply = <&palmas_ldo6_reg>;
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
+
+			#thermal-sensor-cells = <1>;
 		};
 	};
 
@@ -1276,4 +1278,20 @@
 			 <&tegra_car TEGRA114_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	thermal-zones {
+		nct1008-local {
+			polling-delay-passive = <2000>; /* milliseconds */
+			polling-delay = <0>; /* milliseconds */
+
+			thermal-sensors = <&nct1008 0>;
+		};
+
+		nct1008-remote {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <0>; /* milliseconds */
+
+			thermal-sensors = <&nct1008 1>;
+		};
+	};
 };
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
