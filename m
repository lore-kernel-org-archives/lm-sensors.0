From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 04:18:41 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (adcxx) Remove redundant spi_set_drvdata
Message-Id: <1379650002-13127-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Marc Pignat <marc.pignat@hevs.ch>
---
compile tested.
---
 drivers/hwmon/adcxx.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index 751b1f0..04c08c2 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -203,7 +203,6 @@ out_err:
 	for (i--; i >= 0; i--)
 		device_remove_file(&spi->dev, &ad_input[i].dev_attr);
 
-	spi_set_drvdata(spi, NULL);
 	mutex_unlock(&adc->lock);
 	return status;
 }
@@ -218,7 +217,6 @@ static int adcxx_remove(struct spi_device *spi)
 	for (i = 0; i < 3 + adc->channels; i++)
 		device_remove_file(&spi->dev, &ad_input[i].dev_attr);
 
-	spi_set_drvdata(spi, NULL);
 	mutex_unlock(&adc->lock);
 
 	return 0;
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
