From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 01 Aug 2014 04:38:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ibmpowernv) Use of_property_read_u32 at appropriate place
Message-Id: <1406867927.25393.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify the code a bit and also improve readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ibmpowernv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index e6b652a..d2bf2c9 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -227,7 +227,7 @@ static int __init create_device_attrs(struct platform_device *pdev)
 	const struct attribute_group **pgroups = pdata->attr_groups;
 	struct device_node *opal, *np;
 	struct sensor_data *sdata;
-	const __be32 *sensor_id;
+	u32 sensor_id;
 	enum sensors type;
 	u32 count = 0;
 	int err = 0;
@@ -252,15 +252,14 @@ static int __init create_device_attrs(struct platform_device *pdev)
 		if (type = MAX_SENSOR_TYPE)
 			continue;
 
-		sensor_id = of_get_property(np, "sensor-id", NULL);
-		if (!sensor_id) {
+		if (of_property_read_u32(np, "sensor-id", &sensor_id)) {
 			dev_info(&pdev->dev,
 				 "'sensor-id' missing in the node '%s'\n",
 				 np->name);
 			continue;
 		}
 
-		sdata[count].id = be32_to_cpup(sensor_id);
+		sdata[count].id = sensor_id;
 		sdata[count].type = type;
 		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
 					     sdata[count].name);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
