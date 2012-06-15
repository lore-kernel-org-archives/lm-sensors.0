From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:03 +0000
Subject: [lm-sensors] [PATCH 22/95] hwmon: (asb100) Convert to use devm_ functions
Message-Id: <1339773856-3443-23-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/asb100.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 4b8814d..7b0acb1 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -787,11 +787,11 @@ static int asb100_probe(struct i2c_client *client,
 	int err;
 	struct asb100_data *data;
 
-	data = kzalloc(sizeof(struct asb100_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct asb100_data),
+			    GFP_KERNEL);
 	if (!data) {
-		pr_debug("probe failed, kzalloc failed!\n");
-		err = -ENOMEM;
-		goto ERROR0;
+		pr_debug("probe failed, devm_kzalloc failed!\n");
+		return -ENOMEM;
 	}
 
 	i2c_set_clientdata(client, data);
@@ -801,7 +801,7 @@ static int asb100_probe(struct i2c_client *client,
 	/* Attach secondary lm75 clients */
 	err = asb100_detect_subclients(client);
 	if (err)
-		goto ERROR1;
+		return err;
 
 	/* Initialize the chip */
 	asb100_init_client(client);
@@ -829,9 +829,6 @@ ERROR4:
 ERROR3:
 	i2c_unregister_device(data->lm75[1]);
 	i2c_unregister_device(data->lm75[0]);
-ERROR1:
-	kfree(data);
-ERROR0:
 	return err;
 }
 
@@ -845,8 +842,6 @@ static int asb100_remove(struct i2c_client *client)
 	i2c_unregister_device(data->lm75[1]);
 	i2c_unregister_device(data->lm75[0]);
 
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
