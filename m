From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 11 Jul 2014 08:45:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max16065) Use PTR_ERR_OR_ZERO
Message-Id: <1405068337.12392.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/max16065.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index d4efc79..162401a 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -642,10 +642,7 @@ static int max16065_probe(struct i2c_client *client,
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, data->groups);
-	if (unlikely(IS_ERR(hwmon_dev)))
-		return PTR_ERR(hwmon_dev);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id max16065_id[] = {
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
