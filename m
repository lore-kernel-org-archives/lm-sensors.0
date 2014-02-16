From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 02:16:12 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (ltc4245) Remove devicetree conditionals
Message-Id: <1392516972-27576-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Devicetree functions are stubbed out if CONFIG_OF is undefined.
Therefore, conditional compilation is unnecessary and can be removed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4245.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 0a3eddb..f67e967 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -470,19 +470,15 @@ static void ltc4245_sysfs_add_groups(struct ltc4245_data *data)
 static bool ltc4245_use_extra_gpios(struct i2c_client *client)
 {
 	struct ltc4245_platform_data *pdata = dev_get_platdata(&client->dev);
-#ifdef CONFIG_OF
 	struct device_node *np = client->dev.of_node;
-#endif
 
 	/* prefer platform data */
 	if (pdata)
 		return pdata->use_extra_gpios;
 
-#ifdef CONFIG_OF
 	/* fallback on OF */
 	if (of_find_property(np, "ltc4245,use-extra-gpios", NULL))
 		return true;
-#endif
 
 	return false;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
