From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Jul 2013 17:24:53 +0000
Subject: [lm-sensors] [RFC PATCH 3/5] hwmon: (ds1621) Convert to use hwmon_device_register_groups
Message-Id: <1373131495-13465-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ds1621.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index a26ba7a..f1d0fa0 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -358,11 +358,15 @@ static const struct attribute_group ds1621_group = {
 	.is_visible = ds1621_attribute_visible
 };
 
+static const struct attribute_group *ds1621_groups[] = {
+	&ds1621_group,
+	NULL
+};
+
 static int ds1621_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ds1621_data *data;
-	int err;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct ds1621_data),
 			    GFP_KERNEL);
@@ -377,22 +381,12 @@ static int ds1621_probe(struct i2c_client *client,
 	/* Initialize the DS1621 chip */
 	ds1621_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &ds1621_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
+	data->hwmon_dev = hwmon_device_register_groups(&client->dev, data,
+						       ds1621_groups);
+	if (IS_ERR(data->hwmon_dev))
+		return PTR_ERR(data->hwmon_dev);
 
 	return 0;
-
- exit_remove_files:
-	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
-	return err;
 }
 
 static int ds1621_remove(struct i2c_client *client)
@@ -400,7 +394,6 @@ static int ds1621_remove(struct i2c_client *client)
 	struct ds1621_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
