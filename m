From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 07 May 2014 08:27:54 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (gpio-fan) Make of_device_id array const
Message-Id: <020d01cf69ce$3e6b90d0$bb42b270$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/gpio-fan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 73181be..ba35e4d 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -482,7 +482,7 @@ static int gpio_fan_get_of_pdata(struct device *dev,
 	return 0;
 }
 
-static struct of_device_id of_gpio_fan_match[] = {
+static const struct of_device_id of_gpio_fan_match[] = {
 	{ .compatible = "gpio-fan", },
 	{},
 };
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
