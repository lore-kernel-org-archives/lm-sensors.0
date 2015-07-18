From: Rabin Vincent <rabin@rab.in>
Date: Sat, 18 Jul 2015 22:29:14 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm70) add device tree support
Message-Id: <1437258554-29358-1-git-send-email-rabin@rab.in>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rabin Vincent <rabin@rab.in>

Allow the lm70 to be probed from a device tree.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 Documentation/devicetree/bindings/hwmon/lm70.txt | 21 +++++++++++++++
 drivers/hwmon/lm70.c                             | 34 +++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm70.txt

diff --git a/Documentation/devicetree/bindings/hwmon/lm70.txt b/Documentation/devicetree/bindings/hwmon/lm70.txt
new file mode 100644
index 0000000..e7fd921
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lm70.txt
@@ -0,0 +1,21 @@
+* LM70/TMP121/LM71/LM74 thermometer.
+
+Required properties:
+- compatible: one of
+		"ti,lm70"
+		"ti,tmp121"
+		"ti,lm71"
+		"ti,lm74"
+
+See Documentation/devicetree/bindings/spi/spi-bus.txt for more required and
+optional properties.
+
+Example:
+
+spi_master {
+	temperature-sensor@0 {
+		compatible = "ti,lm70";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+};
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 97204dc..9296e9d 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -37,6 +37,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 
 
 #define DRVNAME		"lm70"
@@ -130,11 +131,41 @@ ATTRIBUTE_GROUPS(lm70);
 
 /*----------------------------------------------------------------------*/
 
+#ifdef CONFIG_OF
+static const struct of_device_id lm70_of_ids[] = {
+	{
+		.compatible = "ti,lm70",
+		.data = (void *) LM70_CHIP_LM70,
+	},
+	{
+		.compatible = "ti,tmp121",
+		.data = (void *) LM70_CHIP_TMP121,
+	},
+	{
+		.compatible = "ti,lm71",
+		.data = (void *) LM70_CHIP_LM71,
+	},
+	{
+		.compatible = "ti,lm74",
+		.data = (void *) LM70_CHIP_LM74,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, lm70_of_ids);
+#endif
+
 static int lm70_probe(struct spi_device *spi)
 {
-	int chip = spi_get_device_id(spi)->driver_data;
+	const struct of_device_id *match;
 	struct device *hwmon_dev;
 	struct lm70 *p_lm70;
+	int chip;
+
+	match = of_match_device(lm70_of_ids, &spi->dev);
+	if (match)
+		chip = (int)(uintptr_t)match->data;
+	else
+		chip = spi_get_device_id(spi)->driver_data;
 
 	/* signaling is SPI_MODE_0 */
 	if (spi->mode & (SPI_CPOL | SPI_CPHA))
@@ -169,6 +200,7 @@ static struct spi_driver lm70_driver = {
 	.driver = {
 		.name	= "lm70",
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(lm70_of_ids),
 	},
 	.id_table = lm70_ids,
 	.probe	= lm70_probe,
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
