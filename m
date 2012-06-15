From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:07 +0000
Subject: [lm-sensors] [PATCH 26/95] hwmon: (ds1621) Convert to use devm_ functions
Message-Id: <1339773856-3443-27-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ds1621.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index f647a33..1c56873 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -249,11 +249,10 @@ static int ds1621_probe(struct i2c_client *client,
 	struct ds1621_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct ds1621_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct ds1621_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -264,7 +263,7 @@ static int ds1621_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &ds1621_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -276,9 +275,6 @@ static int ds1621_probe(struct i2c_client *client,
 
  exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
- exit_free:
-	kfree(data);
- exit:
 	return err;
 }
 
@@ -289,8 +285,6 @@ static int ds1621_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
 
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
