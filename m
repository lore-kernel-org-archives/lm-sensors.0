From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 10 Jul 2015 05:51:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: Drop owner assignment from i2c_driver
Message-Id: <1436507492-23617-1-git-send-email-k.kozlowski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/hwmon/g762.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 9b55e673b67c..3d845947f584 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -1112,7 +1112,6 @@ static int g762_remove(struct i2c_client *client)
 static struct i2c_driver g762_driver = {
 	.driver = {
 		.name = DRVNAME,
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(g762_dt_match),
 	},
 	.probe	  = g762_probe,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
