From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:49 +0000
Subject: [lm-sensors] [PATCH 68/95] hwmon: (pcf8591) Convert to use devm_ functions
Message-Id: <1339773856-3443-69-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pcf8591.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index 4174c74..825883d 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -200,11 +200,10 @@ static int pcf8591_probe(struct i2c_client *client,
 	struct pcf8591_data *data;
 	int err;
 
-	data = kzalloc(sizeof(struct pcf8591_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct pcf8591_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -215,7 +214,7 @@ static int pcf8591_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&client->dev.kobj, &pcf8591_attr_group);
 	if (err)
-		goto exit_kfree;
+		return err;
 
 	/* Register input2 if not in "two differential inputs" mode */
 	if (input_mode != 3) {
@@ -242,9 +241,6 @@ static int pcf8591_probe(struct i2c_client *client,
 exit_sysfs_remove:
 	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group_opt);
 	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group);
-exit_kfree:
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -255,7 +251,6 @@ static int pcf8591_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group_opt);
 	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
