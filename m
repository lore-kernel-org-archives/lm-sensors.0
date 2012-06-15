From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:14 +0000
Subject: [lm-sensors] [PATCH 93/95] hwmon: (smsc47m192) Convert to use devm_ functions
Message-Id: <1339773856-3443-94-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m192.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 4705a8b..36a3478 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -554,11 +554,10 @@ static int smsc47m192_probe(struct i2c_client *client,
 	int config;
 	int err;
 
-	data = kzalloc(sizeof(struct smsc47m192_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct smsc47m192_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	data->vrm = vid_which_vrm();
@@ -570,7 +569,7 @@ static int smsc47m192_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &smsc47m192_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	/* Pin 110 is either in4 (+12V) or VID4 */
 	config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);
@@ -592,9 +591,6 @@ static int smsc47m192_probe(struct i2c_client *client,
 exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
-exit_free:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -606,8 +602,6 @@ static int smsc47m192_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
 
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
