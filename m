From: Wei Ni <wni@nvidia.com>
Date: Thu, 08 Aug 2013 06:56:31 +0000
Subject: [lm-sensors] [PATCH v2 3/3] Documentation: dt: hwmon: add OF document for lm90
Message-Id: <1375944991-29182-4-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1375944991-29182-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, linux@roeck-us.net, swarren@wwwdotorg.org
Cc: MLongnecker@nvidia.com, linux-arm-kernel@lists.infradead.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>

Add OF document for lm90 in Documentation/devicetree/.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 Documentation/devicetree/bindings/hwmon/lm90.txt |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt

diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
new file mode 100644
index 0000000..8024f11
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
@@ -0,0 +1,20 @@
+* LM90 series thermometer.
+
+Required node properties:
+- compatible: manufacture and chip name,
+              which are listed in the Documentation/hwmon/lm90
+- reg: I2C bus address of the device
+
+Optional properties:
+- vdd-supply: vdd regulator for the supply voltage. If this is not set,
+              assuming vdd is always powered.
+- interrupts: lm90 can support interrupt mode, you can set interrupt here.
+
+Example lm90 node:
+
+nct1008 {
+	compatible = "onnn,nct1008";
+	reg = <0x4c>;
+	vdd-supply = <&palmas_ldo6_reg>;
+	interrupt-parent = <&gpio>;
+	interrupts = <TEGRA_GPIO(O, 4) IRQ_TYPE_LEVEL_LOW>;
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
