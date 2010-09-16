From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Sep 2010 01:52:26 +0000
Subject: [lm-sensors] [PATCH v2 3/7] hwmon: (lm90) Introduce function to
Message-Id: <1284601950-7381-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284038750-8833-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284038750-8833-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm90.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index f628f2a..9b1d205 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -815,6 +815,15 @@ static int lm90_detect(struct i2c_client *new_client,
 	return 0;
 }
 
+static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
+{
+	if (data->flags & LM90_HAVE_OFFSET)
+		device_remove_file(&client->dev,
+				   &sensor_dev_attr_temp2_offset.dev_attr);
+	device_remove_file(&client->dev, &dev_attr_pec);
+	sysfs_remove_group(&client->dev.kobj, &lm90_group);
+}
+
 static int lm90_probe(struct i2c_client *new_client,
 		      const struct i2c_device_id *id)
 {
@@ -889,8 +898,7 @@ static int lm90_probe(struct i2c_client *new_client,
 	return 0;
 
 exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &lm90_group);
-	device_remove_file(&new_client->dev, &dev_attr_pec);
+	lm90_remove_files(new_client, data);
 exit_free:
 	kfree(data);
 exit:
@@ -937,11 +945,7 @@ static int lm90_remove(struct i2c_client *client)
 	struct lm90_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm90_group);
-	device_remove_file(&client->dev, &dev_attr_pec);
-	if (data->flags & LM90_HAVE_OFFSET)
-		device_remove_file(&client->dev,
-				   &sensor_dev_attr_temp2_offset.dev_attr);
+	lm90_remove_files(client, data);
 
 	/* Restore initial configuration */
 	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
