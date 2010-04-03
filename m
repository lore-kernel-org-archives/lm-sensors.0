From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Apr 2010 16:05:51 +0000
Subject: [lm-sensors] [PATCH] hwmon: (sht15) Properly handle the case
Message-Id: <20100403180551.4299abac@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When CONFIG_REGULATOR isn't set, regulator_get_voltage() returns 0.
Properly handle this case by not trusting the value.

Reported-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/hwmon/sht15.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.34-rc3.orig/drivers/hwmon/sht15.c	2010-04-03 09:44:22.000000000 +0200
+++ linux-2.6.34-rc3/drivers/hwmon/sht15.c	2010-04-03 17:44:59.000000000 +0200
@@ -541,7 +541,12 @@ static int __devinit sht15_probe(struct
 /* If a regulator is available, query what the supply voltage actually is!*/
 	data->reg = regulator_get(data->dev, "vcc");
 	if (!IS_ERR(data->reg)) {
-		data->supply_uV = regulator_get_voltage(data->reg);
+		int voltage;
+
+		voltage = regulator_get_voltage(data->reg);
+		if (voltage)
+			data->supply_uV = voltage;
+
 		regulator_enable(data->reg);
 		/* setup a notifier block to update this if another device
 		 *  causes the voltage to change */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
