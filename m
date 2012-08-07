From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:04 +0000
Subject: [lm-sensors] [PATCH 15/39] hwmon: (asb100) Convert to use devm_ functions
Message-Id: <1344352828-25143-16-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/asb100.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 4b8814d..a227be4 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -787,12 +787,10 @@ static int asb100_probe(struct i2c_client *client,
 	int err;
 	struct asb100_data *data;
 
-	data = kzalloc(sizeof(struct asb100_data), GFP_KERNEL);
-	if (!data) {
-		pr_debug("probe failed, kzalloc failed!\n");
-		err = -ENOMEM;
-		goto ERROR0;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct asb100_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->lock);
@@ -801,7 +799,7 @@ static int asb100_probe(struct i2c_client *client,
 	/* Attach secondary lm75 clients */
 	err = asb100_detect_subclients(client);
 	if (err)
-		goto ERROR1;
+		return err;
 
 	/* Initialize the chip */
 	asb100_init_client(client);
@@ -829,9 +827,6 @@ ERROR4:
 ERROR3:
 	i2c_unregister_device(data->lm75[1]);
 	i2c_unregister_device(data->lm75[0]);
-ERROR1:
-	kfree(data);
-ERROR0:
 	return err;
 }
 
@@ -845,8 +840,6 @@ static int asb100_remove(struct i2c_client *client)
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
