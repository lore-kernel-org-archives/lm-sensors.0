From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Jan 2015 18:29:35 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (ads2828) Only keep data in device data structure if needed
Message-Id: <1421432975-6218-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The variables diff_input, ext_vref, and vref_mv are only used in the probe
function and therefore don't need to be kept in the device data structure.

Cc: Robert Rosengren <robert.rosengren@axis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile tested only - needs testing

 drivers/hwmon/ads7828.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 83c84ba..6173b75 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -50,9 +50,6 @@ enum ads7828_chips { ads7828, ads7830 };
 /* Client specific data */
 struct ads7828_data {
 	struct regmap *regmap;
-	bool diff_input;		/* Differential input */
-	bool ext_vref;			/* External voltage reference */
-	unsigned int vref_mv;		/* voltage reference value */
 	bool byte_swap;			/* true if need to byte swap result */
 	u8 cmd_byte;			/* Command byte without channel bits */
 	unsigned int lsb_resol;		/* Resolution of the ADC sample LSB */
@@ -125,40 +122,39 @@ static int ads7828_probe(struct i2c_client *client,
 	struct ads7828_platform_data *pdata = dev_get_platdata(dev);
 	struct ads7828_data *data;
 	struct device *hwmon_dev;
+	unsigned int vref_mv = ADS7828_INT_VREF_MV;
+	bool diff_input = false;
+	bool ext_vref = false;
 
 	data = devm_kzalloc(dev, sizeof(struct ads7828_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	if (pdata) {
-		data->diff_input = pdata->diff_input;
-		data->ext_vref = pdata->ext_vref;
-		if (data->ext_vref)
-			data->vref_mv = pdata->vref_mv;
+		diff_input = pdata->diff_input;
+		ext_vref = pdata->ext_vref;
+		if (ext_vref && pdata->vref_mv)
+			vref_mv = pdata->vref_mv;
 	}
 
-	/* Bound Vref with min/max values if it was provided */
-	if (data->vref_mv)
-		data->vref_mv = clamp_val(data->vref_mv,
-					  ADS7828_EXT_VREF_MV_MIN,
-					  ADS7828_EXT_VREF_MV_MAX);
-	else
-		data->vref_mv = ADS7828_INT_VREF_MV;
+	/* Bound Vref with min/max values */
+	vref_mv = clamp_val(vref_mv, ADS7828_EXT_VREF_MV_MIN,
+			    ADS7828_EXT_VREF_MV_MAX);
 
 	/* ADS7828 uses 12-bit samples, while ADS7830 is 8-bit */
 	if (id->driver_data = ads7828) {
-		data->lsb_resol = DIV_ROUND_CLOSEST(data->vref_mv * 1000, 4096);
+		data->lsb_resol = DIV_ROUND_CLOSEST(vref_mv * 1000, 4096);
 		data->regmap = devm_regmap_init_i2c(client,
 						    &ads2828_regmap_config);
 		data->byte_swap = true;
 	} else {
-		data->lsb_resol = DIV_ROUND_CLOSEST(data->vref_mv * 1000, 256);
+		data->lsb_resol = DIV_ROUND_CLOSEST(vref_mv * 1000, 256);
 		data->regmap = devm_regmap_init_i2c(client,
 						    &ads2830_regmap_config);
 	}
 
-	data->cmd_byte = data->ext_vref ? ADS7828_CMD_PD1 : ADS7828_CMD_PD3;
-	if (!data->diff_input)
+	data->cmd_byte = ext_vref ? ADS7828_CMD_PD1 : ADS7828_CMD_PD3;
+	if (!diff_input)
 		data->cmd_byte |= ADS7828_CMD_SD_SE;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
