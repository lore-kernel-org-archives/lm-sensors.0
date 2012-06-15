From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:10 +0000
Subject: [lm-sensors] [PATCH 89/95] hwmon: (w83791d) Convert to use devm_ functions
Message-Id: <1339773856-3443-90-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83791d.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 2f446f9..9ade4d4 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1384,18 +1384,17 @@ static int w83791d_probe(struct i2c_client *client,
 			(val1 >> 5) & 0x07, (val1 >> 1) & 0x0f, val1);
 #endif
 
-	data = kzalloc(sizeof(struct w83791d_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto error0;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct w83791d_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
 	err = w83791d_detect_subclients(client);
 	if (err)
-		goto error1;
+		return err;
 
 	/* Initialize the chip */
 	w83791d_init_client(client);
@@ -1440,9 +1439,6 @@ error3:
 		i2c_unregister_device(data->lm75[0]);
 	if (data->lm75[1] != NULL)
 		i2c_unregister_device(data->lm75[1]);
-error1:
-	kfree(data);
-error0:
 	return err;
 }
 
@@ -1458,7 +1454,6 @@ static int w83791d_remove(struct i2c_client *client)
 	if (data->lm75[1] != NULL)
 		i2c_unregister_device(data->lm75[1]);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
