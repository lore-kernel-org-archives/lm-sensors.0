From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jan 2014 18:40:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: (iio_hwmon) Convert to use hwmon_device_register_with_groups
Message-Id: <1390243248-19684-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and create name attribute automatically.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/iio_hwmon.c |   37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 708081b..9fbb1b1 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -31,6 +31,7 @@ struct iio_hwmon_state {
 	int num_channels;
 	struct device *hwmon_dev;
 	struct attribute_group attr_group;
+	const struct attribute_group *groups[2];
 	struct attribute **attrs;
 };
 
@@ -56,19 +57,6 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
 	return sprintf(buf, "%d\n", result);
 }
 
-static ssize_t show_name(struct device *dev, struct device_attribute *attr,
-			 char *buf)
-{
-	const char *name = "iio_hwmon";
-
-	if (dev->of_node && dev->of_node->name)
-		name = dev->of_node->name;
-
-	return sprintf(buf, "%s\n", name);
-}
-
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
 static int iio_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -78,6 +66,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	int in_i = 1, temp_i = 1, curr_i = 1;
 	enum iio_chan_type type;
 	struct iio_channel *channels;
+	const char *name = "iio_hwmon";
+
+	if (dev->of_node && dev->of_node->name)
+		name = dev->of_node->name;
 
 	channels = iio_channel_get_all(dev);
 	if (IS_ERR(channels))
@@ -96,7 +88,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		st->num_channels++;
 
 	st->attrs = devm_kzalloc(dev,
-				 sizeof(*st->attrs) * (st->num_channels + 2),
+				 sizeof(*st->attrs) * (st->num_channels + 1),
 				 GFP_KERNEL);
 	if (st->attrs = NULL) {
 		ret = -ENOMEM;
@@ -144,22 +136,18 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		a->index = i;
 		st->attrs[i] = &a->dev_attr.attr;
 	}
-	st->attrs[st->num_channels] = &dev_attr_name.attr;
-	st->attr_group.attrs = st->attrs;
-	platform_set_drvdata(pdev, st);
-	ret = sysfs_create_group(&dev->kobj, &st->attr_group);
-	if (ret < 0)
-		goto error_release_channels;
 
-	st->hwmon_dev = hwmon_device_register(dev);
+	st->attr_group.attrs = st->attrs;
+	st->groups[0] = &st->attr_group;
+	st->hwmon_dev = hwmon_device_register_with_groups(dev, name, st,
+							  st->groups);
 	if (IS_ERR(st->hwmon_dev)) {
 		ret = PTR_ERR(st->hwmon_dev);
-		goto error_remove_group;
+		goto error_release_channels;
 	}
+	platform_set_drvdata(pdev, st);
 	return 0;
 
-error_remove_group:
-	sysfs_remove_group(&dev->kobj, &st->attr_group);
 error_release_channels:
 	iio_channel_release_all(channels);
 	return ret;
@@ -170,7 +158,6 @@ static int iio_hwmon_remove(struct platform_device *pdev)
 	struct iio_hwmon_state *st = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(st->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &st->attr_group);
 	iio_channel_release_all(st->channels);
 
 	return 0;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
