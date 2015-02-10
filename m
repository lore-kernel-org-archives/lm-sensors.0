From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 10 Feb 2015 10:24:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads7828) Check return value of devm_regmap_init_i2c
Message-Id: <1423563847.17306.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

devm_regmap_init_i2c() can fail, thus add return value checking.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ads7828.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index bce4e9f..6c99ee7 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -147,6 +147,9 @@ static int ads7828_probe(struct i2c_client *client,
 						    &ads2830_regmap_config);
 	}
 
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
 	data->cmd_byte = ext_vref ? ADS7828_CMD_PD1 : ADS7828_CMD_PD3;
 	if (!diff_input)
 		data->cmd_byte |= ADS7828_CMD_SD_SE;
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
