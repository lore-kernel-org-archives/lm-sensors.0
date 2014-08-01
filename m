From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 01 Aug 2014 02:07:25 +0000
Subject: [lm-sensors] [PATCH] hwmon: (g762) Use of_property_read_u32 at appropriate place
Message-Id: <1406858845.21842.5.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify the code a bit and also improve readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/g762.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 7dbc8c9..6aac695 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -649,15 +649,12 @@ static int g762_of_prop_import_one(struct i2c_client *client,
 				   int (*psetter)(struct device *dev,
 						  unsigned long val))
 {
-	const __be32 *prop;
-	int len, ret;
+	int ret;
 	u32 pval;
 
-	prop = of_get_property(client->dev.of_node, pname, &len);
-	if (!prop || len != sizeof(u32))
+	if (of_property_read_u32(client->dev.of_node, pname, &pval))
 		return 0;
 
-	pval = be32_to_cpu(prop[0]);
 	dev_dbg(&client->dev, "found %s (%d)\n", pname, pval);
 	ret = (*psetter)(&client->dev, pval);
 	if (ret)
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
