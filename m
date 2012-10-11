From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 11 Oct 2012 14:03:51 +0000
Subject: [lm-sensors] [PATCH] hwmon: da9052: Use da9052_reg_update for rmw operations
Message-Id: <1349964231.9925.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: David Dajun Chen <dchen@diasemi.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/da9052-hwmon.c |   27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index b8d01c5..1970494 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -60,30 +60,17 @@ static inline int vbbat_reg_to_mV(int value)
 	return DIV_ROUND_CLOSEST(value * 2500, 512);
 }
 
-static int da9052_enable_vddout_channel(struct da9052 *da9052)
+static inline int da9052_enable_vddout_channel(struct da9052 *da9052)
 {
-	int ret;
-
-	ret = da9052_reg_read(da9052, DA9052_ADC_CONT_REG);
-	if (ret < 0)
-		return ret;
-
-	ret |= DA9052_ADCCONT_AUTOVDDEN;
-
-	return da9052_reg_write(da9052, DA9052_ADC_CONT_REG, ret);
+	return da9052_reg_update(da9052, DA9052_ADC_CONT_REG,
+				 DA9052_ADCCONT_AUTOVDDEN,
+				 DA9052_ADCCONT_AUTOVDDEN);
 }
 
-static int da9052_disable_vddout_channel(struct da9052 *da9052)
+static inline int da9052_disable_vddout_channel(struct da9052 *da9052)
 {
-	int ret;
-
-	ret = da9052_reg_read(da9052, DA9052_ADC_CONT_REG);
-	if (ret < 0)
-		return ret;
-
-	ret &= ~DA9052_ADCCONT_AUTOVDDEN;
-
-	return da9052_reg_write(da9052, DA9052_ADC_CONT_REG, ret);
+	return da9052_reg_update(da9052, DA9052_ADC_CONT_REG,
+				 DA9052_ADCCONT_AUTOVDDEN, 0);
 }
 
 static ssize_t da9052_read_vddout(struct device *dev,
-- 
1.7.9.5




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
