From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:37 +0000
Subject: [lm-sensors] [PATCH 56/95] hwmon: (max1111) Convert to use devm_ functions
Message-Id: <1339773856-3443-57-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1111.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index 362a40e..f3978a4 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -168,7 +168,7 @@ static int __devinit max1111_probe(struct spi_device *spi)
 	if (err < 0)
 		return err;
 
-	data = kzalloc(sizeof(struct max1111_data), GFP_KERNEL);
+	data = devm_kzalloc(&spi->dev, sizeof(struct max1111_data), GFP_KERNEL);
 	if (data = NULL) {
 		dev_err(&spi->dev, "failed to allocate memory\n");
 		return -ENOMEM;
@@ -176,7 +176,7 @@ static int __devinit max1111_probe(struct spi_device *spi)
 
 	err = setup_transfer(data);
 	if (err)
-		goto err_free_data;
+		return err;
 
 	mutex_init(&data->drvdata_lock);
 
@@ -186,7 +186,7 @@ static int __devinit max1111_probe(struct spi_device *spi)
 	err = sysfs_create_group(&spi->dev.kobj, &max1111_attr_group);
 	if (err) {
 		dev_err(&spi->dev, "failed to create attribute group\n");
-		goto err_free_data;
+		return err;
 	}
 
 	data->hwmon_dev = hwmon_device_register(&spi->dev);
@@ -203,8 +203,6 @@ static int __devinit max1111_probe(struct spi_device *spi)
 
 err_remove:
 	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
-err_free_data:
-	kfree(data);
 	return err;
 }
 
@@ -215,7 +213,6 @@ static int __devexit max1111_remove(struct spi_device *spi)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
 	mutex_destroy(&data->drvdata_lock);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
