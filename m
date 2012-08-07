From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:23 +0000
Subject: [lm-sensors] [PATCH 34/39] hwmon: (sht21) Convert to use devm_ functions
Message-Id: <1344352828-25143-35-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Urs Fleisch <urs.fleisch@sensirion.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sht21.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
index 6c2dede..c2565d0 100644
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -199,11 +199,10 @@ static int __devinit sht21_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	sht21 = kzalloc(sizeof(*sht21), GFP_KERNEL);
-	if (!sht21) {
-		dev_dbg(&client->dev, "kzalloc failed\n");
+	sht21 = devm_kzalloc(&client->dev, sizeof(*sht21), GFP_KERNEL);
+	if (!sht21)
 		return -ENOMEM;
-	}
+
 	i2c_set_clientdata(client, sht21);
 
 	mutex_init(&sht21->lock);
@@ -211,7 +210,7 @@ static int __devinit sht21_probe(struct i2c_client *client,
 	err = sysfs_create_group(&client->dev.kobj, &sht21_attr_group);
 	if (err) {
 		dev_dbg(&client->dev, "could not create sysfs files\n");
-		goto fail_free;
+		return err;
 	}
 	sht21->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(sht21->hwmon_dev)) {
@@ -226,9 +225,6 @@ static int __devinit sht21_probe(struct i2c_client *client,
 
 fail_remove_sysfs:
 	sysfs_remove_group(&client->dev.kobj, &sht21_attr_group);
-fail_free:
-	kfree(sht21);
-
 	return err;
 }
 
@@ -242,7 +238,6 @@ static int __devexit sht21_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(sht21->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &sht21_attr_group);
-	kfree(sht21);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
