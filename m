From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 01 May 2011 15:34:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: twl4030-madc-hwmon: Return proper error
Message-Id: <1304264095.2327.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: J Keerthy <j-keerthy@ti.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/twl4030-madc-hwmon.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
index de58191..5724074 100644
--- a/drivers/hwmon/twl4030-madc-hwmon.c
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -98,7 +98,6 @@ static const struct attribute_group twl4030_madc_group = {
 static int __devinit twl4030_madc_hwmon_probe(struct platform_device *pdev)
 {
 	int ret;
-	int status;
 	struct device *hwmon;
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &twl4030_madc_group);
@@ -107,7 +106,7 @@ static int __devinit twl4030_madc_hwmon_probe(struct platform_device *pdev)
 	hwmon = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(hwmon)) {
 		dev_err(&pdev->dev, "hwmon_device_register failed.\n");
-		status = PTR_ERR(hwmon);
+		ret = PTR_ERR(hwmon);
 		goto err_reg;
 	}
 
-- 
1.7.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
