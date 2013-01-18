From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Date: Fri, 18 Jan 2013 05:36:52 +0000
Subject: [lm-sensors] [patch v1 3/5] hwmon: da9055 change irq state to default
Message-Id: <1358486692.14373.12.camel@dhruva>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>, lm-sensors@lm-sensors.org, David Dajun Chen <dchen@diasemi.com>, linux-kernel@vger.kernel.org

This patch changes the irq state from high to the now default low
state.

This patch is dependent on the DA9055 MFD.

This patch is tested on smdk6410 board.

Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
---
 drivers/hwmon/da9055-hwmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index 9465c05..dfd0db1 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -284,7 +284,7 @@ static int da9055_hwmon_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(&pdev->dev, hwmon_irq,
 					NULL, da9055_auxadc_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					"adc-irq", hwmon);
 	if (ret != 0) {
 		dev_err(hwmon->da9055->dev, "DA9055 ADC IRQ failed ret=%d\n",
-- 
1.7.0.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
