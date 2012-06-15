From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:11 +0000
Subject: [lm-sensors] [PATCH 30/95] hwmon: (emc6w201) Convert to use devm_ functions
Message-Id: <1339773856-3443-31-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc6w201.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
index 840f511..ada12a9 100644
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -492,11 +492,10 @@ static int emc6w201_probe(struct i2c_client *client,
 	struct emc6w201_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct emc6w201_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct emc6w201_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -504,7 +503,7 @@ static int emc6w201_probe(struct i2c_client *client,
 	/* Create sysfs attribute */
 	err = sysfs_create_group(&client->dev.kobj, &emc6w201_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	/* Expose as a hwmon device */
 	data->hwmon_dev = hwmon_device_register(&client->dev);
@@ -517,9 +516,6 @@ static int emc6w201_probe(struct i2c_client *client,
 
  exit_remove:
 	sysfs_remove_group(&client->dev.kobj, &emc6w201_group);
- exit_free:
-	kfree(data);
- exit:
 	return err;
 }
 
@@ -529,7 +525,6 @@ static int emc6w201_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &emc6w201_group);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
