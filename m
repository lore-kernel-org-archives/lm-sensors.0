From: Wei Ni <wni@nvidia.com>
Date: Thu, 12 Sep 2013 11:24:21 +0000
Subject: [lm-sensors] [PATCH v4 3/3] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <1378985061-28547-4-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378985061-28547-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1378985061-28547-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, linux@roeck-us.net, broonie@kernel.org, swarren@wwwdotorg.org
Cc: lm-sensors@lm-sensors.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Add OF document for LM90 in Documentation/devicetree/.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 Documentation/devicetree/bindings/hwmon/lm90.txt |   44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt

diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
new file mode 100644
index 0000000..6888498
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
@@ -0,0 +1,44 @@
+* LM90 series thermometer.
+
+Required node properties:
+- compatible: manufacturer and chip name, one of
+		"adi,adm1032"
+		"adi,adt7461"
+		"adi,adt7461a"
+		"gmt,g781"
+		"national,lm90"
+		"national,lm86"
+		"national,lm89"
+		"national,lm99"
+		"dallas,max6646"
+		"dallas,max6647"
+		"dallas,max6649"
+		"dallas,max6657"
+		"dallas,max6658"
+		"dallas,max6659"
+		"dallas,max6680"
+		"dallas,max6681"
+		"dallas,max6695"
+		"dallas,max6696"
+		"onnn,nct1008"
+		"winbond,w83l771"
+		"nxp,sa56004"
+
+- reg: I2C bus address of the device
+
+Optional properties:
+- vcc-supply: vcc regulator for the supply voltage.
+              If this is not set, assuming vcc is always powered.
+- interrupts: Contains a single interrupt specifier which describes the
+              LM90 "-ALERT" pin output.
+              See interrupt-controller/interrupts.txt for the format.
+
+Example LM90 node:
+
+temp-sensor {
+	compatible = "onnn,nct1008";
+	reg = <0x4c>;
+	vcc-supply = <&palmas_ldo6_reg>;
+	interrupt-parent = <&gpio>;
+	interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
+}
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
