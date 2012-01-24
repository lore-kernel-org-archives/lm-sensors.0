From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:55 +0000
Subject: [lm-sensors] [PATCH 76/79] hwmon: (lm70) Register hwmon device after creating attribute files, and r
Message-Id: <1327373398-997-77-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Register hwmon device as last operation in the probe function to ensure that all
attribute files exist when accessed from user applications. Otherwise, there
is a short time frame where the device is registered as hwmon device but
sysfs attributes do not yet exist. This could result in applications erroneously
not detecting attributes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm70.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 9c12ef3..61c2ffb 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -156,13 +156,6 @@ static int __devinit lm70_probe(struct spi_device *spi)
 	mutex_init(&p_lm70->lock);
 	p_lm70->chip = chip;
 
-	/* sysfs hook */
-	p_lm70->hwmon_dev = hwmon_device_register(&spi->dev);
-	if (IS_ERR(p_lm70->hwmon_dev)) {
-		dev_dbg(&spi->dev, "hwmon_device_register failed.\n");
-		status = PTR_ERR(p_lm70->hwmon_dev);
-		goto out_dev_reg_failed;
-	}
 	spi_set_drvdata(spi, p_lm70);
 
 	if ((status = device_create_file(&spi->dev, &dev_attr_temp1_input))
@@ -171,12 +164,20 @@ static int __devinit lm70_probe(struct spi_device *spi)
 		goto out_dev_create_file_failed;
 	}
 
+	/* sysfs hook */
+	p_lm70->hwmon_dev = hwmon_device_register(&spi->dev);
+	if (IS_ERR(p_lm70->hwmon_dev)) {
+		dev_dbg(&spi->dev, "hwmon_device_register failed.\n");
+		status = PTR_ERR(p_lm70->hwmon_dev);
+		goto out_dev_reg_failed;
+	}
+
 	return 0;
 
+out_dev_reg_failed:
+	device_remove_file(&spi->dev, &dev_attr_name);
 out_dev_create_file_failed:
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
-	hwmon_device_unregister(p_lm70->hwmon_dev);
-out_dev_reg_failed:
 	spi_set_drvdata(spi, NULL);
 	kfree(p_lm70);
 	return status;
@@ -186,9 +187,9 @@ static int __devexit lm70_remove(struct spi_device *spi)
 {
 	struct lm70 *p_lm70 = spi_get_drvdata(spi);
 
+	hwmon_device_unregister(p_lm70->hwmon_dev);
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
 	device_remove_file(&spi->dev, &dev_attr_name);
-	hwmon_device_unregister(p_lm70->hwmon_dev);
 	spi_set_drvdata(spi, NULL);
 	kfree(p_lm70);
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
