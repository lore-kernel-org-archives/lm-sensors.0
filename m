From: Sven Schuchmann <schuchmann@schleissheimer.de>
Date: Fri, 21 Sep 2012 11:04:22 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (mcp3021) Add MCP3221 support
Message-Id: <1348225462-16767-2-git-send-email-schuchmann@schleissheimer.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This Patch adds support for mcp3221 chip to the
mcp3021 driver.

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
---
 Documentation/hwmon/mcp3021 |   23 +++++++++++++++--------
 drivers/hwmon/Kconfig       |    7 ++++---
 drivers/hwmon/mcp3021.c     |   21 ++++++++++++++++++---
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/mcp3021 b/Documentation/hwmon/mcp3021
index 325fd87..74a6b72 100644
--- a/Documentation/hwmon/mcp3021
+++ b/Documentation/hwmon/mcp3021
@@ -5,18 +5,25 @@ Supported chips:
   * Microchip Technology MCP3021
     Prefix: 'mcp3021'
     Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/21805a.pdf
+  * Microchip Technology MCP3221
+    Prefix: 'mcp3221'
+    Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/21732c.pdf
 
-Author: Mingkai Hu
+Authors:
+   Mingkai Hu
+   Sven Schuchmann <schuchmann@schleissheimer.de>
 
 Description
 -----------
 
-This driver implements support for the Microchip Technology MCP3021 chip.
+This driver implements support for the Microchip Technology MCP3021 and
+MCP3221 chip.
 
 The Microchip Technology Inc. MCP3021 is a successive approximation A/D
-converter (ADC) with 10-bit resolution.
-This device provides one single-ended input with very low power consumption.
-Communication to the MCP3021 is performed using a 2-wire I2C compatible
-interface. Standard (100 kHz) and Fast (400 kHz) I2C modes are available.
-The default I2C device address is 0x4d (contact the Microchip factory for
-additional address options).
+converter (ADC) with 10-bit resolution. The MCP3221 has 12-bit resolution.
+
+These devices provide one single-ended input with very low power consumption.
+Communication to the MCP3021/MCP3221  is performed using a 2-wire I2C
+compatible interface. Standard (100 kHz) and Fast (400 kHz) I2C modes are
+available. The default I2C device address is 0x4d (contact the Microchip
+factory for additional address options).
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b0a2e4c..364d49f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -835,11 +835,12 @@ config SENSORS_MAX6650
 	  will be called max6650.
 
 config SENSORS_MCP3021
-	tristate "Microchip MCP3021"
+	tristate "Microchip MCP3021/MCP3221"
 	depends on I2C && EXPERIMENTAL
 	help
-	  If you say yes here you get support for the MCP3021 chip
-	  that is a A/D converter (ADC) with 10-bit resolution.
+	  If you say yes here you get support for the MCP3021 and
+	  MCP3221 chip. The MCP3021 is a A/D converter (ADC) with
+	  10-bit and the MCP3221 with 12-bit resolution.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called mcp3021.
diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
index 3862c2c..eea86cf 100644
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -1,5 +1,5 @@
 /*
- * mcp3021.c - driver for the Microchip MCP3021 chip
+ * mcp3021.c - driver for the Microchip MCP3021/MCP3221 chip
  *
  * Copyright (C) 2008-2009, 2012 Freescale Semiconductor, Inc.
  * Author: Mingkai Hu <Mingkai.hu@freescale.com>
@@ -35,9 +35,16 @@
 #define MCP3021_OUTPUT_RES	10	/* 10-bit resolution */
 #define MCP3021_OUTPUT_SCALE	4
 
+#define MCP3221_SAR_SHIFT	0
+#define MCP3221_SAR_MASK	0xfff
+#define MCP3221_OUTPUT_RES	12	/* 12-bit resolution */
+#define MCP3221_OUTPUT_SCALE	1
+
 enum chips {
-	mcp3021
+	mcp3021,
+	mcp3221
 };
+
 /*
  * Client data (each client gets its own)
  */
@@ -126,6 +133,13 @@ static int mcp3021_probe(struct i2c_client *client,
 		data->output_res = MCP3021_OUTPUT_RES;
 		data->output_scale = MCP3021_OUTPUT_SCALE;
 		break;
+
+	case mcp3221:
+		data->sar_shift = MCP3221_SAR_SHIFT;
+		data->sar_mask = MCP3221_SAR_MASK;
+		data->output_res = MCP3221_OUTPUT_RES;
+		data->output_scale = MCP3221_OUTPUT_SCALE;
+		break;
 	}
 
 	if (client->dev.platform_data) {
@@ -170,6 +184,7 @@ static int mcp3021_remove(struct i2c_client *client)
 
 static const struct i2c_device_id mcp3021_id[] = {
 	{ "mcp3021", mcp3021 },
+	{ "mcp3221", mcp3221 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp3021_id);
@@ -186,5 +201,5 @@ static struct i2c_driver mcp3021_driver = {
 module_i2c_driver(mcp3021_driver);
 
 MODULE_AUTHOR("Mingkai Hu <Mingkai.hu@freescale.com>");
-MODULE_DESCRIPTION("Microchip MCP3021 driver");
+MODULE_DESCRIPTION("Microchip MCP3021/MCP3221 driver");
 MODULE_LICENSE("GPL");
-- 
1.6.0.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
