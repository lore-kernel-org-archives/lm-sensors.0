From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 01 Aug 2014 02:03:09 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (ads1015) Fix out-of-bounds array access
Message-Id: <1406858589.21842.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Current code uses data_rate as array index in ads1015_read_adc() and uses pga
as array index in ads1015_reg_to_mv, so we must make sure both data_rate and
pga settings are in valid value range. If the setting is out-of-range, don't
apply it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ads1015.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
index 22e0c92..db7a448 100644
--- a/drivers/hwmon/ads1015.c
+++ b/drivers/hwmon/ads1015.c
@@ -212,6 +212,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
 				dev_err(&client->dev,
 					"invalid gain on %s\n",
 					node->full_name);
+				continue;
 			}
 		}
 
@@ -222,6 +223,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
 				dev_err(&client->dev,
 					"invalid data_rate on %s\n",
 					node->full_name);
+				continue;
 			}
 		}
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
