From: Mark Brown <broonie@kernel.org>
Date: Sun, 18 Aug 2013 16:43:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (sht15) Use devm_regulator_get_optional()
Message-Id: <1376844227-30352-1-git-send-email-broonie@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

Since the sht15 driver supports operation without an external vref
regulator the driver should use the new devm_regulator_get_optional() to
indicate that a stub regulator should not be provided.

Signed-off-by: Mark Brown <broonie@linaro.org>
---

Since devm_regulator_get_optional() is not yet merged either the branch
adding it would need be be merged into the hwmon tree or I'd need to
apply this to the regualtor tree.

 drivers/hwmon/sht15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 883d291..97cd45a 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -957,7 +957,7 @@ static int sht15_probe(struct platform_device *pdev)
 	 * If a regulator is available,
 	 * query what the supply voltage actually is!
 	 */
-	data->reg = devm_regulator_get(data->dev, "vcc");
+	data->reg = devm_regulator_get_optional(data->dev, "vcc");
 	if (!IS_ERR(data->reg)) {
 		int voltage;
 
-- 
1.8.4.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
