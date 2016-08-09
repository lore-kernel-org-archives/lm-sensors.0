From: Mike Looijmans <mike.looijmans@topic.nl>
Date: Tue, 09 Aug 2016 07:30:27 +0000
Subject: [lm-sensors] [RFC][PATCH] hwmon/max6650.c: Optionally retrieve voltage and prescaler from devicetree
Message-Id: <1470727827-15907-1-git-send-email-mike.looijmans@topic.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Parse devicetree parameters for voltage and prescaler setting. This allows
using multiple max6550 devices with varying settings, and also makes it
possible to instantiate and configure the device using devicetree.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

This patch just does the minimal to get the device working properly with devicetree config.
What is the better path here, move to devicetree completely and remove the module parameters,
or do we need to keep backward compatibility with the moduel parameter (allowing only one
config for all chips)?
(in case of DT-only, the "clock" value could be obtained using the clock framework)

 arch/arm/boot/dts/topic-miamiplus.dtsi |  1 +
 drivers/hwmon/max6650.c                | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/topic-miamiplus.dtsi b/arch/arm/boot/dts/topic-miamiplus.dtsi
index d433101..e927ff9 100644
--- a/arch/arm/boot/dts/topic-miamiplus.dtsi
+++ b/arch/arm/boot/dts/topic-miamiplus.dtsi
@@ -56,6 +56,7 @@
 		reg = <0x1b>; /* ADD pins high-Z, hence address 0011011b */
 		compatible = "max6650";
 		voltage = <12>;
+		prescaler = <8>;
 	};
 };
 
diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 162a520..c190954 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -566,6 +566,15 @@ static int max6650_init_client(struct max6650_data *data,
 	struct device *dev = &client->dev;
 	int config;
 	int err = -EIO;
+	u32 local_fan_voltage = (u32)fan_voltage;
+	u32 local_prescaler = (u32)prescaler;
+
+#ifdef CONFIG_OF
+	of_property_read_u32(client->dev.of_node,
+			     "voltage", &local_fan_voltage);
+	of_property_read_u32(client->dev.of_node,
+			     "prescaler", &local_prescaler);
+#endif
 
 	config = i2c_smbus_read_byte_data(client, MAX6650_REG_CONFIG);
 
@@ -574,7 +583,7 @@ static int max6650_init_client(struct max6650_data *data,
 		return err;
 	}
 
-	switch (fan_voltage) {
+	switch (local_fan_voltage) {
 	case 0:
 		break;
 	case 5:
@@ -585,13 +594,13 @@ static int max6650_init_client(struct max6650_data *data,
 		break;
 	default:
 		dev_err(dev, "illegal value for fan_voltage (%d)\n",
-			fan_voltage);
+			local_fan_voltage);
 	}
 
 	dev_info(dev, "Fan voltage is set to %dV.\n",
 		 (config & MAX6650_CFG_V12) ? 12 : 5);
 
-	switch (prescaler) {
+	switch (local_prescaler) {
 	case 0:
 		break;
 	case 1:
@@ -614,7 +623,8 @@ static int max6650_init_client(struct max6650_data *data,
 			 | MAX6650_CFG_PRESCALER_16;
 		break;
 	default:
-		dev_err(dev, "illegal value for prescaler (%d)\n", prescaler);
+		dev_err(dev, "illegal value for prescaler (%d)\n",
+			local_prescaler);
 	}
 
 	dev_info(dev, "Prescaler is set to %d.\n",
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
