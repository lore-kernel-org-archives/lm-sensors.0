From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:02 +0000
Subject: [lm-sensors] [PATCH 21/95] hwmon: (amc6821) Convert to use devm_ functions
Message-Id: <1339773856-3443-22-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amc6821.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index f600fa1..5f444ab 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -862,7 +862,8 @@ static int amc6821_probe(
 	struct amc6821_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct amc6821_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct amc6821_data),
+			    GFP_KERNEL);
 	if (!data) {
 		dev_err(&client->dev, "out of memory.\n");
 		return -ENOMEM;
@@ -877,11 +878,11 @@ static int amc6821_probe(
 	 */
 	err = amc6821_init_client(client);
 	if (err)
-		goto err_free;
+		return err;
 
 	err = sysfs_create_group(&client->dev.kobj, &amc6821_attr_grp);
 	if (err)
-		goto err_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (!IS_ERR(data->hwmon_dev))
@@ -890,8 +891,6 @@ static int amc6821_probe(
 	err = PTR_ERR(data->hwmon_dev);
 	dev_err(&client->dev, "error registering hwmon device.\n");
 	sysfs_remove_group(&client->dev.kobj, &amc6821_attr_grp);
-err_free:
-	kfree(data);
 	return err;
 }
 
@@ -902,8 +901,6 @@ static int amc6821_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &amc6821_attr_grp);
 
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
