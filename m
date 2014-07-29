From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 29 Jul 2014 15:06:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max6697) Use of_property_read_bool at appropriate places
Message-Id: <1406646382.6132.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This slightly improves readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/max6697.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 7fd3eaf..f03a717 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -495,15 +495,13 @@ static void max6697_get_config_of(struct device_node *node,
 	int len;
 	const __be32 *prop;
 
-	prop = of_get_property(node, "smbus-timeout-disable", &len);
-	if (prop)
-		pdata->smbus_timeout_disable = true;
-	prop = of_get_property(node, "extended-range-enable", &len);
-	if (prop)
-		pdata->extended_range_enable = true;
-	prop = of_get_property(node, "beta-compensation-enable", &len);
-	if (prop)
-		pdata->beta_compensation = true;
+	pdata->smbus_timeout_disable +		of_property_read_bool(node, "smbus-timeout-disable");
+	pdata->extended_range_enable +		of_property_read_bool(node, "extended-range-enable");
+	pdata->beta_compensation +		of_property_read_bool(node, "beta-compensation-enable");
+
 	prop = of_get_property(node, "alert-mask", &len);
 	if (prop && len = sizeof(u32))
 		pdata->alert_mask = be32_to_cpu(prop[0]);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
