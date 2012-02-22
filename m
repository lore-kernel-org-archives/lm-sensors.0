From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Feb 2012 16:56:45 +0000
Subject: [lm-sensors] [PATCH 3/7] hwmon: (lineage-pem) Convert to use devm_kzalloc
Message-Id: <1329929809-6085-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marginally less code and eliminate the possibility of memory leaks.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lineage-pem.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/lineage-pem.c b/drivers/hwmon/lineage-pem.c
index 5b8c9ae..d264937 100644
--- a/drivers/hwmon/lineage-pem.c
+++ b/drivers/hwmon/lineage-pem.c
@@ -448,7 +448,7 @@ static int pem_probe(struct i2c_client *client,
 				     | I2C_FUNC_SMBUS_WRITE_BYTE))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -462,11 +462,11 @@ static int pem_probe(struct i2c_client *client,
 	ret = pem_read_block(client, PEM_READ_FIRMWARE_REV,
 			     data->firmware_rev, sizeof(data->firmware_rev));
 	if (ret < 0)
-		goto out_kfree;
+		return ret;
 
 	ret = i2c_smbus_write_byte(client, PEM_CLEAR_INFO_FLAGS);
 	if (ret < 0)
-		goto out_kfree;
+		return ret;
 
 	dev_info(&client->dev, "Firmware revision %d.%d.%d\n",
 		 data->firmware_rev[0], data->firmware_rev[1],
@@ -475,7 +475,7 @@ static int pem_probe(struct i2c_client *client,
 	/* Register sysfs hooks */
 	ret = sysfs_create_group(&client->dev.kobj, &pem_group);
 	if (ret)
-		goto out_kfree;
+		return ret;
 
 	/*
 	 * Check if input readings are supported.
@@ -534,8 +534,6 @@ out_remove_groups:
 	sysfs_remove_group(&client->dev.kobj, &pem_input_group);
 	sysfs_remove_group(&client->dev.kobj, &pem_fan_group);
 	sysfs_remove_group(&client->dev.kobj, &pem_group);
-out_kfree:
-	kfree(data);
 	return ret;
 }
 
@@ -549,7 +547,6 @@ static int pem_remove(struct i2c_client *client)
 	sysfs_remove_group(&client->dev.kobj, &pem_fan_group);
 	sysfs_remove_group(&client->dev.kobj, &pem_group);
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
