From: Julien D'Ascenzio <jdascenzio@yahoo.fr>
Date: Wed, 25 Jun 2014 20:00:31 +0000
Subject: [lm-sensors] [PATCH] hwmon: (gpio-fan) Change name used in hwmon_device_register_with_groups
Message-Id: <1403726431-18749-1-git-send-email-jdascenzio@yahoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since commit 648cd48c9e566f53c5df30d79857e0937ae13b09
The hwmon name attributes must not include '-' so the name must be
rename from gpio-fan to gpio_fan

Signed-off-by: Julien D'Ascenzio <jdascenzio@yahoo.fr>
---
 drivers/hwmon/gpio-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 73181be..160ca00 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -538,7 +538,7 @@ static int gpio_fan_probe(struct platform_device *pdev)
 
 	/* Make this driver part of hwmon class. */
 	fan_data->hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
-						"gpio-fan", fan_data,
+						"gpio_fan", fan_data,
 						gpio_fan_groups);
 	if (IS_ERR(fan_data->hwmon_dev))
 		return PTR_ERR(fan_data->hwmon_dev);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
