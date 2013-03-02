From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 02 Mar 2013 07:33:30 +0000
Subject: [lm-sensors] [PATCH] hwmon: (sht15) Check return value of regulator_enable()
Message-Id: <1362209610-12337-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Not having power is a pretty serious error so check that we are able to
enable the supply and error out if we can't.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/hwmon/sht15.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index bfe326e..2507f90 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -965,7 +965,13 @@ static int sht15_probe(struct platform_device *pdev)
 		if (voltage)
 			data->supply_uv = voltage;
 
-		regulator_enable(data->reg);
+		ret = regulator_enable(data->reg);
+		if (ret != 0) {
+			dev_err(&pdev->dev,
+				"failed to enable regulator: %d\n", ret);
+			return ret;
+		}
+
 		/*
 		 * Setup a notifier block to update this if another device
 		 * causes the voltage to change
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
