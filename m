From: Andres Salomon <dilinger@queued.net>
Date: Fri, 18 Feb 2011 03:07:10 +0000
Subject: [lm-sensors] [PATCH 03/29] jz4740: mfd_cell is now implicitly
Message-Id: <1297998456-7615-4-git-send-email-dilinger@queued.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297998456-7615-1-git-send-email-dilinger@queued.net>
In-Reply-To: <1297998456-7615-1-git-send-email-dilinger@queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Anton Vorontsov <cbouatmailru@gmail.com>, lm-sensors@lm-sensors.org

No need to explicitly set the cell's platform_data/data_size.

Modify clients to use mfd_get_cell helper function instead of
accessing platform_data directly.

Signed-off-by: Andres Salomon <dilinger@queued.net>
Acked-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/jz4740-hwmon.c   |    2 +-
 drivers/mfd/jz4740-adc.c       |    4 ----
 drivers/power/jz4740-battery.c |    2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index 1c8b3d9..40f106d 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -112,7 +112,7 @@ static int __devinit jz4740_hwmon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	hwmon->cell = pdev->dev.platform_data;
+	hwmon->cell = mfd_get_cell(pdev);
 
 	hwmon->irq = platform_get_irq(pdev, 0);
 	if (hwmon->irq < 0) {
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
index 0cc5979..aa518b9 100644
--- a/drivers/mfd/jz4740-adc.c
+++ b/drivers/mfd/jz4740-adc.c
@@ -232,8 +232,6 @@ const struct mfd_cell jz4740_adc_cells[] = {
 		.name = "jz4740-hwmon",
 		.num_resources = ARRAY_SIZE(jz4740_hwmon_resources),
 		.resources = jz4740_hwmon_resources,
-		.platform_data = (void *)&jz4740_adc_cells[0],
-		.data_size = sizeof(struct mfd_cell),
 
 		.enable = jz4740_adc_cell_enable,
 		.disable = jz4740_adc_cell_disable,
@@ -243,8 +241,6 @@ const struct mfd_cell jz4740_adc_cells[] = {
 		.name = "jz4740-battery",
 		.num_resources = ARRAY_SIZE(jz4740_battery_resources),
 		.resources = jz4740_battery_resources,
-		.platform_data = (void *)&jz4740_adc_cells[1],
-		.data_size = sizeof(struct mfd_cell),
 
 		.enable = jz4740_adc_cell_enable,
 		.disable = jz4740_adc_cell_disable,
diff --git a/drivers/power/jz4740-battery.c b/drivers/power/jz4740-battery.c
index 02414db..0938650 100644
--- a/drivers/power/jz4740-battery.c
+++ b/drivers/power/jz4740-battery.c
@@ -258,7 +258,7 @@ static int __devinit jz_battery_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	jz_battery->cell = pdev->dev.platform_data;
+	jz_battery->cell = mfd_get_cell(pdev);
 
 	jz_battery->irq = platform_get_irq(pdev, 0);
 	if (jz_battery->irq < 0) {
-- 
1.7.2.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
