From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 04:18:42 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm70) Remove redundant spi_set_drvdata
Message-Id: <1379650002-13127-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kaiwan N Billimoria <kaiwan@designergraphix.com>
---
compile tested.
---
 drivers/hwmon/lm70.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 016efa2..505a59e 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -174,7 +174,6 @@ out_dev_reg_failed:
 out_dev_create_file_failed:
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
 out_dev_create_temp_file_failed:
-	spi_set_drvdata(spi, NULL);
 	return status;
 }
 
@@ -185,7 +184,6 @@ static int lm70_remove(struct spi_device *spi)
 	hwmon_device_unregister(p_lm70->hwmon_dev);
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
 	device_remove_file(&spi->dev, &dev_attr_name);
-	spi_set_drvdata(spi, NULL);
 
 	return 0;
 }
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
