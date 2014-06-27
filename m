From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 27 Jun 2014 14:49:29 +0000
Subject: [lm-sensors] [PATCH RFT] hwmon: (tmp103) Add missing i2c_set_clientdata call in tmp103_probe
Message-Id: <1403880569.12833.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add missing i2c_set_clientdata() call in tmp103_probe, this makes the
dev_get_drvdata() call in tmp103_suspend/tmp103_resume return correct
address.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/tmp103.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/tmp103.c b/drivers/hwmon/tmp103.c
index e69dbca..c9f99e0 100644
--- a/drivers/hwmon/tmp103.c
+++ b/drivers/hwmon/tmp103.c
@@ -151,6 +151,7 @@ static int tmp103_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	i2c_set_clientdata(client, regmap);
 	hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
 						      regmap, tmp103_groups);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
