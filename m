From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 11 Sep 2013 04:31:52 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (tmp421) Fix return value
Message-Id: <1378873192-6297-5-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Propagate return value obtained from i2c_smbus_read_byte_data()
instead of hardcoding.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Andre Prendel <andre.prendel@gmx.de>
---
 drivers/hwmon/tmp421.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 964c1d6..ae26b06 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -210,7 +210,7 @@ static int tmp421_init_client(struct i2c_client *client)
 	if (config < 0) {
 		dev_err(&client->dev,
 			"Could not read configuration register (%d)\n", config);
-		return -ENODEV;
+		return config;
 	}
 
 	config_orig = config;
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
