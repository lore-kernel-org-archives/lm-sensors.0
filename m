From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Oct 2012 15:56:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ina2xx) Use module_i2c_driver macro
Message-Id: <1349970986.9548.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Lothar Felten <l-felten@ti.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ina2xx.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 2b72634..8e7158c 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -302,19 +302,8 @@ static struct i2c_driver ina2xx_driver = {
 	.id_table	= ina2xx_id,
 };
 
-static int __init ina2xx_init(void)
-{
-	return i2c_add_driver(&ina2xx_driver);
-}
-
-static void __exit ina2xx_exit(void)
-{
-	i2c_del_driver(&ina2xx_driver);
-}
+module_i2c_driver(ina2xx_driver);
 
 MODULE_AUTHOR("Lothar Felten <l-felten@ti.com>");
 MODULE_DESCRIPTION("ina2xx driver");
 MODULE_LICENSE("GPL");
-
-module_init(ina2xx_init);
-module_exit(ina2xx_exit);
-- 
1.7.9.5




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
