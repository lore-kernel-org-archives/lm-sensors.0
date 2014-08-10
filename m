From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 10 Aug 2014 09:42:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: (tmp103) Remove duplicate test for I2C_FUNC_SMBUS_BYTE_DATA functionalit
Message-Id: <1407663721.6912.9.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since commit b42261078a91 ("regmap: i2c: fallback to SMBus if the adapter
does not support standard I2C"), regmap-i2c will check the
I2C_FUNC_SMBUS_[BYTE|WORD]_DATA functionality based on the regmap_config
setting if the adapter does not support standard I2C.

So remove the I2C_FUNC_SMBUS_BYTE_DATA functionality check in the driver code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/tmp103.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/hwmon/tmp103.c b/drivers/hwmon/tmp103.c
index c74d2da..e42964f 100644
--- a/drivers/hwmon/tmp103.c
+++ b/drivers/hwmon/tmp103.c
@@ -131,13 +131,6 @@ static int tmp103_probe(struct i2c_client *client,
 	struct regmap *regmap;
 	int ret;
 
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(&client->dev,
-			"adapter doesn't support SMBus byte transactions\n");
-		return -ENODEV;
-	}
-
 	regmap = devm_regmap_init_i2c(client, &tmp103_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "failed to allocate register map\n");
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
