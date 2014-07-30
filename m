From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 30 Jul 2014 03:13:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads1015) Fix off-by-one for valid channel index checking
Message-Id: <1406690032.6636.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Current code uses channel as array index, so the valid channel value is
0 .. ADS1015_CHANNELS - 1.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 7f9dc2f..22e0c92 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -198,7 +198,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
 		}
 
 		channel = be32_to_cpup(property);
-		if (channel > ADS1015_CHANNELS) {
+		if (channel >= ADS1015_CHANNELS) {
 			dev_err(&client->dev,
 				"invalid channel index %d on %s\n",
 				channel, node->full_name);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
