From: <atull@opensource.altera.com>
Date: Wed, 15 Oct 2014 18:55:07 +0000
Subject: [lm-sensors] [PATCH v6 1/4] hwmon: ltc2978: device tree bindings documentation
Message-Id: <1413399310-19277-2-git-send-email-atull@opensource.altera.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
In-Reply-To: <1413399310-19277-1-git-send-email-atull@opensource.altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Alan Tull <atull@opensource.altera.com>

From: Alan Tull <atull@opensource.altera.com>

Add device tree bindings documentation for ltc2978.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
---
v2: clean whitespace

v3: list compatible strings in single column
    add vendor as lltc
    mention regulators.txt instead of documenting regulator-name
    s/vout_en/vout/
    remove size_cells, address-cells
    use node name to identify regulators
---
 .../devicetree/bindings/hwmon/ltc2978.txt          |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
new file mode 100644
index 0000000..16c1227
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
@@ -0,0 +1,39 @@
+ltc2978
+
+Required properties:
+- compatible: should contain one of:
+  * "lltc,ltc2974"
+  * "lltc,ltc2977"
+  * "lltc,ltc2978"
+  * "lltc,ltc3880"
+  * "lltc,ltc3883"
+  * "lltc,ltm4676"
+- reg: I2C slave address
+
+Optional properties:
+- regulators: A node that houses a sub-node for each regulator controlled by
+  the device. Each sub-node is identified using the node's name, with valid
+  values listed below. The content of each sub-node is defined by the
+  standard binding for regulators; see regulator.txt.
+
+Valid names of regulators depend on number of supplies supported per device:
+  * ltc2974 : vout0 - vout3
+  * ltc2977 : vout0 - vout7
+  * ltc2978 : vout0 - vout7
+  * ltc3880 : vout0 - vout1
+  * ltc3883 : vout0
+  * ltm4676 : vout0 - vout1
+
+Example:
+ltc2978@5e {
+	compatible = "ltc2978";
+	reg = <0x5e>;
+	regulators {
+		vout0 {
+			regulator-name = "FPGA-2.5V";
+		};
+		vout2 {
+			regulator-name = "FPGA-1.5V";
+		};
+	};
+};
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
