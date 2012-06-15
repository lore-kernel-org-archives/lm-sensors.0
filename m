From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:22:49 +0000
Subject: [lm-sensors] [PATCH 08/95] hwmon: (adm1021) Convert to use devm_ functions
Message-Id: <1339773856-3443-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1021.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 4394e7e..fd1d1b1 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -366,11 +366,11 @@ static int adm1021_probe(struct i2c_client *client,
 	struct adm1021_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct adm1021_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct adm1021_data),
+			    GFP_KERNEL);
 	if (!data) {
-		pr_debug("adm1021: detect failed, kzalloc failed!\n");
-		err = -ENOMEM;
-		goto error0;
+		pr_debug("adm1021: detect failed, devm_kzalloc failed!\n");
+		return -ENOMEM;
 	}
 
 	i2c_set_clientdata(client, data);
@@ -384,21 +384,18 @@ static int adm1021_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &adm1021_group);
 	if (err)
-		goto error1;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-		goto error3;
+		goto error;
 	}
 
 	return 0;
 
-error3:
+error:
 	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
-error1:
-	kfree(data);
-error0:
 	return err;
 }
 
@@ -418,7 +415,6 @@ static int adm1021_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
