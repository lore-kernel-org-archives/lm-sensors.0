From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 14 Mar 2013 08:27:18 +0000
Subject: [lm-sensors] [PATCH] hwmon: lineage-pem: Add missing terminating entry for pem_[input|fan]_attribute
Message-Id: <1363249638.15861.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lineage-pem.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/lineage-pem.c b/drivers/hwmon/lineage-pem.c
index 41df29f..ebbb9f4 100644
--- a/drivers/hwmon/lineage-pem.c
+++ b/drivers/hwmon/lineage-pem.c
@@ -422,6 +422,7 @@ static struct attribute *pem_input_attributes[] = {
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_power1_input.dev_attr.attr,
+	NULL
 };
 
 static const struct attribute_group pem_input_group = {
@@ -432,6 +433,7 @@ static struct attribute *pem_fan_attributes[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	NULL
 };
 
 static const struct attribute_group pem_fan_group = {
-- 
1.7.9.5




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
