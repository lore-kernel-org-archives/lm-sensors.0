From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 05 Apr 2013 01:51:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ad7314) use spi_get_drvdata() and spi_set_drvdata()
Message-Id: <000901ce31a0$1798a090$46c9e1b0$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use the wrapper functions for getting and setting the driver data using
spi_device instead of using dev_{get|set}_drvdata with &spi->dev, so we
can directly pass a struct spi_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/ad7314.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index f3c6001..f4f9b21 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -116,7 +116,7 @@ static int ad7314_probe(struct spi_device *spi_dev)
 	if (chip = NULL)
 		return -ENOMEM;
 
-	dev_set_drvdata(&spi_dev->dev, chip);
+	spi_set_drvdata(spi_dev, chip);
 
 	ret = sysfs_create_group(&spi_dev->dev.kobj, &ad7314_group);
 	if (ret < 0)
@@ -137,7 +137,7 @@ error_remove_group:
 
 static int ad7314_remove(struct spi_device *spi_dev)
 {
-	struct ad7314_data *chip = dev_get_drvdata(&spi_dev->dev);
+	struct ad7314_data *chip = spi_get_drvdata(spi_dev);
 
 	hwmon_device_unregister(chip->hwmon_dev);
 	sysfs_remove_group(&spi_dev->dev.kobj, &ad7314_group);
-- 
1.7.2.5



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
