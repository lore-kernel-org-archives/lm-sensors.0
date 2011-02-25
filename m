From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 25 Feb 2011 18:57:24 +0000
Subject: [lm-sensors] [PATCH v4 2/4] hwmon: (lm85) Use function to remove
Message-Id: <1298660246-6484-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 2253676..590226a 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1281,6 +1281,15 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
+static void lm85_remove_files(struct i2c_client *client, struct lm85_data *data)
+{
+	sysfs_remove_group(&client->dev.kobj, &lm85_group);
+	if (!data->has_vid5)
+		sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
+	if (data->type = emc6d100)
+		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
+}
+
 static int lm85_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
@@ -1349,10 +1358,7 @@ static int lm85_probe(struct i2c_client *client,
 
 	/* Error out and cleanup code */
  err_remove_files:
-	sysfs_remove_group(&client->dev.kobj, &lm85_group);
-	sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
-	if (data->type = emc6d100)
-		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
+	lm85_remove_files(client, data);
  err_kfree:
 	kfree(data);
 	return err;
@@ -1362,10 +1368,7 @@ static int lm85_remove(struct i2c_client *client)
 {
 	struct lm85_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm85_group);
-	sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
-	if (data->type = emc6d100)
-		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
+	lm85_remove_files(client, data);
 	kfree(data);
 	return 0;
 }
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
