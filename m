From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:52 +0000
Subject: [lm-sensors] [PATCH 03/39] hwmon: (ad7314) Convert to use devm_ functions
Message-Id: <1344352828-25143-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ad7314.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index cfec802..455294f 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -104,16 +104,16 @@ static int __devinit ad7314_probe(struct spi_device *spi_dev)
 	int ret;
 	struct ad7314_data *chip;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip = NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	chip = devm_kzalloc(&spi_dev->dev, sizeof(*chip), GFP_KERNEL);
+	if (chip = NULL)
+		return -ENOMEM;
+
 	dev_set_drvdata(&spi_dev->dev, chip);
 
 	ret = sysfs_create_group(&spi_dev->dev.kobj, &ad7314_group);
 	if (ret < 0)
-		goto error_free_chip;
+		return ret;
+
 	chip->hwmon_dev = hwmon_device_register(&spi_dev->dev);
 	if (IS_ERR(chip->hwmon_dev)) {
 		ret = PTR_ERR(chip->hwmon_dev);
@@ -124,9 +124,6 @@ static int __devinit ad7314_probe(struct spi_device *spi_dev)
 	return 0;
 error_remove_group:
 	sysfs_remove_group(&spi_dev->dev.kobj, &ad7314_group);
-error_free_chip:
-	kfree(chip);
-error_ret:
 	return ret;
 }
 
@@ -136,7 +133,6 @@ static int __devexit ad7314_remove(struct spi_device *spi_dev)
 
 	hwmon_device_unregister(chip->hwmon_dev);
 	sysfs_remove_group(&spi_dev->dev.kobj, &ad7314_group);
-	kfree(chip);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
