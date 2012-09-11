From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 20:52:51 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (adcxx) Simplify show_name function
Message-Id: <1347396773-32108-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Display device name using to_spi_device(dev)->modalias instead of computing it
from the number of ADC channels. This is cleaner and reduces code size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adcxx.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index 111af7c..f4c5867 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -141,10 +141,7 @@ static ssize_t adcxx_set_max(struct device *dev,
 static ssize_t adcxx_show_name(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct adcxx *adc = spi_get_drvdata(spi);
-
-	return sprintf(buf, "adcxx%ds\n", adc->channels);
+	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
 }
 
 static struct sensor_device_attribute ad_input[] = {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
