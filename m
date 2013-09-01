From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Sep 2013 02:49:01 +0000
Subject: [lm-sensors] [PATCH v2 8/9] hwmon: (nct6775) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1378003742-18685-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378003742-18685-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1378003742-18685-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index bf0c35f..1b22871 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -724,8 +724,6 @@ struct nct6775_data {
 	enum kinds kind;
 	const char *name;
 
-	struct device *hwmon_dev;
-
 	int num_attr_groups;
 	const struct attribute_group *groups[6];
 
@@ -3259,6 +3257,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	int num_reg_temp;
 	u8 cr2a;
 	struct attribute_group *group;
+	struct device *hwmon_dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(&pdev->dev, res->start, IOREGION_LENGTH,
@@ -3860,19 +3859,10 @@ static int nct6775_probe(struct platform_device *pdev)
 	data->groups[data->num_attr_groups++] = group;
 	data->groups[data->num_attr_groups++] = &nct6775_group_other;
 
-	data->hwmon_dev = hwmon_device_register_with_groups(dev, data->name,
-							    data, data->groups);
-	if (IS_ERR(data->hwmon_dev))
-		return PTR_ERR(data->hwmon_dev);
-
-	return 0;
-}
-
-static int nct6775_remove(struct platform_device *pdev)
-{
-	struct nct6775_data *data = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(data->hwmon_dev);
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, data->name,
+							   data, data->groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
 	return 0;
 }
@@ -3963,7 +3953,6 @@ static struct platform_driver nct6775_driver = {
 		.pm	= NCT6775_DEV_PM_OPS,
 	},
 	.probe		= nct6775_probe,
-	.remove		= nct6775_remove,
 };
 
 static const char * const nct6775_sio_names[] __initconst = {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
