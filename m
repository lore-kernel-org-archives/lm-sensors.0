From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Feb 2012 16:56:48 +0000
Subject: [lm-sensors] [PATCH 6/7] hwmon: (smm665) Convert to use devm_kzalloc
Message-Id: <1329929809-6085-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marginally less code and eliminate the possibility of memory leaks.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smm665.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index 5877078..cbc51fb 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -584,10 +584,9 @@ static int smm665_probe(struct i2c_client *client,
 	if (i2c_smbus_read_byte_data(client, SMM665_ADOC_ENABLE) < 0)
 		return -ENODEV;
 
-	ret = -ENOMEM;
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-		goto out_return;
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
@@ -596,7 +595,7 @@ static int smm665_probe(struct i2c_client *client,
 	data->cmdreg = i2c_new_dummy(adapter, (client->addr & ~SMM665_REGMASK)
 				     | SMM665_CMDREG_BASE);
 	if (!data->cmdreg)
-		goto out_kfree;
+		return -ENOMEM;
 
 	switch (data->type) {
 	case smm465:
@@ -679,9 +678,6 @@ out_remove_group:
 	sysfs_remove_group(&client->dev.kobj, &smm665_group);
 out_unregister:
 	i2c_unregister_device(data->cmdreg);
-out_kfree:
-	kfree(data);
-out_return:
 	return ret;
 }
 
@@ -693,8 +689,6 @@ static int smm665_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &smm665_group);
 
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
