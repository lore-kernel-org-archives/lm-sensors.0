From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 24 Jul 2014 00:59:34 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Remove num_attr_groups from struct nct6775_data
Message-Id: <1406163574.7561.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

num_attr_groups is only used in nct6775_probe(), make it to be local variable.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/nct6775.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 1c98655..504cbdd 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -735,7 +735,6 @@ struct nct6775_data {
 	enum kinds kind;
 	const char *name;
 
-	int num_attr_groups;
 	const struct attribute_group *groups[6];
 
 	u16 reg_temp[5][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
@@ -3276,6 +3275,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	u8 cr2a;
 	struct attribute_group *group;
 	struct device *hwmon_dev;
+	int num_attr_groups = 0;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
@@ -3907,29 +3907,29 @@ static int nct6775_probe(struct platform_device *pdev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
-	data->groups[data->num_attr_groups++] = group;
+	data->groups[num_attr_groups++] = group;
 
 	group = nct6775_create_attr_group(dev, &nct6775_in_template_group,
 					  fls(data->have_in));
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
-	data->groups[data->num_attr_groups++] = group;
+	data->groups[num_attr_groups++] = group;
 
 	group = nct6775_create_attr_group(dev, &nct6775_fan_template_group,
 					  fls(data->has_fan));
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
-	data->groups[data->num_attr_groups++] = group;
+	data->groups[num_attr_groups++] = group;
 
 	group = nct6775_create_attr_group(dev, &nct6775_temp_template_group,
 					  fls(data->have_temp));
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
-	data->groups[data->num_attr_groups++] = group;
-	data->groups[data->num_attr_groups++] = &nct6775_group_other;
+	data->groups[num_attr_groups++] = group;
+	data->groups[num_attr_groups++] = &nct6775_group_other;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, data->name,
 							   data, data->groups);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
