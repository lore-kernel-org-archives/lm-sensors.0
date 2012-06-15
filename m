From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:32 +0000
Subject: [lm-sensors] [PATCH 51/95] hwmon: (lm90) Convert to use devm_ functions
Message-Id: <1339773856-3443-52-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 22b14a68..863412a 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1399,11 +1399,10 @@ static int lm90_probe(struct i2c_client *client,
 	struct lm90_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct lm90_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct lm90_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
@@ -1474,8 +1473,6 @@ exit_remove_files:
 	lm90_remove_files(client, data);
 exit_restore:
 	lm90_restore_conf(client, data);
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -1487,7 +1484,6 @@ static int lm90_remove(struct i2c_client *client)
 	lm90_remove_files(client, data);
 	lm90_restore_conf(client, data);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
