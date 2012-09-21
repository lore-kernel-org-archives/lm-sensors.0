From: Sven Schuchmann <schuchmann@schleissheimer.de>
Date: Fri, 21 Sep 2012 11:04:21 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (mcp3021) Prepare MCP3021 driver
Message-Id: <1348225462-16767-1-git-send-email-schuchmann@schleissheimer.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This Patch is to prepare the MCP3021 driver to support
other chips like the MCP3221. The hard defined chip data
is now stored within the data struct of each chip.

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
---
 drivers/hwmon/mcp3021.c |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
index d0afc0c..3862c2c 100644
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2008-2009, 2012 Freescale Semiconductor, Inc.
  * Author: Mingkai Hu <Mingkai.hu@freescale.com>
+ * Reworked by Sven Schuchmann <schuchmann@schleissheimer.de>
  *
  * This driver export the value of analog input voltage to sysfs, the
  * voltage unit is mV. Through the sysfs interface, lm-sensors tool
@@ -34,16 +35,24 @@
 #define MCP3021_OUTPUT_RES	10	/* 10-bit resolution */
 #define MCP3021_OUTPUT_SCALE	4
 
+enum chips {
+	mcp3021
+};
 /*
  * Client data (each client gets its own)
  */
 struct mcp3021_data {
 	struct device *hwmon_dev;
 	u32 vdd;	/* device power supply */
+	u16 sar_shift;
+	u16 sar_mask;
+	u8 output_res;
+	u8 output_scale;
 };
 
 static int mcp3021_read16(struct i2c_client *client)
 {
+	struct mcp3021_data *data = i2c_get_clientdata(client);
 	int ret;
 	u16 reg;
 	__be16 buf;
@@ -61,20 +70,20 @@ static int mcp3021_read16(struct i2c_client *client)
 	 * The ten-bit output code is composed of the lower 4-bit of the
 	 * first byte and the upper 6-bit of the second byte.
 	 */
-	reg = (reg >> MCP3021_SAR_SHIFT) & MCP3021_SAR_MASK;
+	reg = (reg >> data->sar_shift) & data->sar_mask;
 
 	return reg;
 }
 
-static inline u16 volts_from_reg(u16 vdd, u16 val)
+static inline u16 volts_from_reg(struct mcp3021_data *data, u16 val)
 {
 	if (val = 0)
 		return 0;
 
-	val = val * MCP3021_OUTPUT_SCALE - MCP3021_OUTPUT_SCALE / 2;
+	val = val * data->output_scale - data->output_scale / 2;
 
-	return val * DIV_ROUND_CLOSEST(vdd,
-			(1 << MCP3021_OUTPUT_RES) * MCP3021_OUTPUT_SCALE);
+	return val * DIV_ROUND_CLOSEST(data->vdd,
+			(1 << data->output_res) * data->output_scale);
 }
 
 static ssize_t show_in_input(struct device *dev, struct device_attribute *attr,
@@ -88,7 +97,8 @@ static ssize_t show_in_input(struct device *dev, struct device_attribute *attr,
 	if (reg < 0)
 		return reg;
 
-	in_input = volts_from_reg(data->vdd, reg);
+	in_input = volts_from_reg(data, reg);
+
 	return sprintf(buf, "%d\n", in_input);
 }
 
@@ -109,6 +119,15 @@ static int mcp3021_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 
+	switch (id->driver_data) {
+	case mcp3021:
+		data->sar_shift = MCP3021_SAR_SHIFT;
+		data->sar_mask = MCP3021_SAR_MASK;
+		data->output_res = MCP3021_OUTPUT_RES;
+		data->output_scale = MCP3021_OUTPUT_SCALE;
+		break;
+	}
+
 	if (client->dev.platform_data) {
 		data->vdd = *(u32 *)client->dev.platform_data;
 		if (data->vdd > MCP3021_VDD_MAX ||
@@ -150,7 +169,7 @@ static int mcp3021_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp3021_id[] = {
-	{ "mcp3021", 0 },
+	{ "mcp3021", mcp3021 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp3021_id);
-- 
1.6.0.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
