From: Wei Ni <wni@nvidia.com>
Date: Fri, 12 Jul 2013 07:49:24 +0000
Subject: [lm-sensors] [PATCH v3 2/2] ARM: dt: t114 dalmore: add dt entry for nct1008
Message-Id: <1373615364-18559-3-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615364-18559-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1373615364-18559-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, swarren@wwwdotorg.org, linux@roeck-us.net, thierry.reding@gmail.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>

Enable thermal sensor nct1008 for t114 dalmore.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index cb640eb..47ec7eb 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -738,6 +738,13 @@
 			realtek,ldo1-en-gpios  				<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 		};
+
+		nct1008 {
+			compatible = "onnn,nct1008";
+			reg = <0x4c>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
+		};
 	};
 
 	i2c@7000d000 {
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
