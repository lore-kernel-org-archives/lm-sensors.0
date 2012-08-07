From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:59 +0000
Subject: [lm-sensors] [PATCH 10/39] hwmon: (ads7871) Convert to use devm_ functions
Message-Id: <1344352828-25143-11-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ads7871.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index e65c6e4..e837707 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -189,20 +189,17 @@ static int __devinit ads7871_probe(struct spi_device *spi)
 	 * because there is no other error checking on an SPI bus
 	 * we need to make sure we really have a chip
 	 */
-	if (val != ret) {
-		err = -ENODEV;
-		goto exit;
-	}
+	if (val != ret)
+		return -ENODEV;
 
-	pdata = kzalloc(sizeof(struct ads7871_data), GFP_KERNEL);
-	if (!pdata) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	pdata = devm_kzalloc(&spi->dev, sizeof(struct ads7871_data),
+			     GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
 	err = sysfs_create_group(&spi->dev.kobj, &ads7871_group);
 	if (err < 0)
-		goto error_free;
+		return err;
 
 	spi_set_drvdata(spi, pdata);
 
@@ -216,9 +213,6 @@ static int __devinit ads7871_probe(struct spi_device *spi)
 
 error_remove:
 	sysfs_remove_group(&spi->dev.kobj, &ads7871_group);
-error_free:
-	kfree(pdata);
-exit:
 	return err;
 }
 
@@ -228,7 +222,6 @@ static int __devexit ads7871_remove(struct spi_device *spi)
 
 	hwmon_device_unregister(pdata->hwmon_dev);
 	sysfs_remove_group(&spi->dev.kobj, &ads7871_group);
-	kfree(pdata);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
