From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 01:01:17 +0000
Subject: [lm-sensors] [PATCH v2 2/4] hwmon: (lm90) Always use the dev variable in the probe function
Message-Id: <1392771679-14666-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: New patch. Separated out from other patches as it is logically
    a different change.

 drivers/hwmon/lm90.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 733b42e..07ffd10 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1536,12 +1536,11 @@ static int lm90_probe(struct i2c_client *client,
 
 	err = regulator_enable(regulator);
 	if (err < 0) {
-		dev_err(&client->dev,
-			"Failed to enable regulator: %d\n", err);
+		dev_err(dev, "Failed to enable regulator: %d\n", err);
 		return err;
 	}
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm90_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm90_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
