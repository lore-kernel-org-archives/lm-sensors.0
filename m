From: Wei Ni <wni@nvidia.com>
Date: Mon, 18 Feb 2013 11:30:30 +0000
Subject: [lm-sensors] [RFC PATCH 8/9] ARM: dt: t30 cardhu: add dt entry for thermal driver
Message-Id: <1361187031-3679-9-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Enable thermal driver in the dts file.
Set sensor as lm90 remote sensor, and set throttle data.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../devicetree/bindings/thermal/tegra3-thermal.txt |   41 ++++++++++++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   19 +++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/tegra3-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt b/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt
new file mode 100644
index 0000000..dc3f922
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt
@@ -0,0 +1,41 @@
+* Nvidia Tegra30 Thermal
+
+** Thermal node properties:
+
+- compatible : "nvidia,tegra30-thermal";
+- sensors: the sensor device node which we want to use in the thermal zone,
+  the arguments is the index of the sensor in sensor device node;
+- passive-delay: passive delay;
+- num-passive-trips : number of passive trip points, this is required, set
+  it 0 if none, if greater than 0, the following properties must be defined;
+- passive-trips : temperature of passive trip points;
+- num-active-trips: number of active trip points, this is required, set
+  it 0 if none, if greater than 0, the following properties must be defined;
+- active-trips: temperature of active trip points;
+- throt-tab-size: size of the throttle table, it's the max cooling state.
+- throt-tab: throttle table. the cooling state will be defined according to
+  this table.
+
+Usually these properties are separated in board related dts files.
+
+Example:
+thermal {
+	compatible = "nvidia,tegra30-thermal";
+	sensors = <&nct1008 0>;
+	passive-delay = <2000>;
+	num-passive-trips = <3>;
+	passive-trips = <70 80 90>;
+	num-active-trips = <4>;
+	active-trips = < 60 70 80 90>;
+	throt-tab-size = <10>;
+	throt-tab = <0 1000
+		640000 1000
+		640000 1000
+		640000 1000
+		640000 1000
+		640000 1000
+		760000 1050
+		760000 1050
+		1000000 1050
+		1000000 1050>;
+};
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 3f6ab89..9748b9b 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -492,4 +492,23 @@
 		nvidia,spkr-en-gpios = <&wm8903 2 0>;
 		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
 	};
+
+	thermal {
+		compatible = "nvidia,tegra30-thermal";
+		sensors = <&nct1008 0>;
+		passive-delay = <2000>;
+		num-passive-trips = <1>;
+		passive-trips = <80>;
+		throt-tab-size = <10>;
+		throt-tab = <0 1000
+			640000 1000
+			640000 1000
+			640000 1000
+			640000 1000
+			640000 1000
+			760000 1050
+			760000 1050
+			1000000 1050
+			1000000 1050>;
+	};
 };
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
