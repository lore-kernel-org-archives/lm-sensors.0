From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 09 Sep 2013 05:29:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ina2xx) Remove casting the return value which is a void pointer
Message-Id: <004f01cead1d$904daeb0$b0e90c10$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/ina2xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 18c0623..70a39a8 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -233,8 +233,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	if (dev_get_platdata(&client->dev)) {
-		pdata -		  (struct ina2xx_platform_data *)dev_get_platdata(&client->dev);
+		pdata = dev_get_platdata(&client->dev);
 		shunt = pdata->shunt_uohms;
 	} else if (!of_property_read_u32(client->dev.of_node,
 				"shunt-resistor", &val)) {
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
