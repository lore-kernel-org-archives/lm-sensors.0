From: Sanchayan Maity <maitysanchayan@gmail.com>
Date: Tue, 16 Feb 2016 05:12:54 +0000
Subject: [lm-sensors] [PATCH v3 2/3] ARM: dts: Change iio_hwmon nodes to use hypen in node names
Message-Id: <c47b13603fe72737ef67ed8b90fc61516cfa2a20.1455597464.git.maitysanchayan@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1455597464.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1455597464.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, shawnguo@kernel.org
Cc: jdelvare@suse.com, stefan@agner.ch, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Sanchayan Maity <maitysanchayan@gmail.com>

Change iio_hwmon nodes to use hypen in node names instead of
underscore.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 Documentation/devicetree/bindings/iio/iio-bindings.txt | 2 +-
 arch/arm/boot/dts/imx23.dtsi                           | 2 +-
 arch/arm/boot/dts/imx28.dtsi                           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index 0b447d9..68d6f8c 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -82,7 +82,7 @@ vdd channel is connected to output 0 of the &ref device.
 
 	...
 
-	iio_hwmon {
+	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
 			<&adc 3>, <&adc 4>, <&adc 5>,
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 1c6c075..302d116 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -569,7 +569,7 @@
 		};
 	};
 
-	iio_hwmon {
+	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&lradc 8>;
 	};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index fae7b90..f637ec9 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1256,7 +1256,7 @@
 		};
 	};
 
-	iio_hwmon {
+	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&lradc 8>;
 	};
-- 
2.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
