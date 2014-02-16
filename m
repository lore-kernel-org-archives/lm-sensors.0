From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 23:59:35 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (coretemp) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1392595175-7589-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach sysfs attributes to hwmon device.

For this driver, the only attribute created is the name attribute.
Other attributes are still created and removed dynamically as cores
are added or removed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |   49 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 944f850..87e0fa9 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -116,12 +116,6 @@ struct pdev_entry {
 static LIST_HEAD(pdev_list);
 static DEFINE_MUTEX(pdev_list_mutex);
 
-static ssize_t show_name(struct device *dev,
-			struct device_attribute *devattr, char *buf)
-{
-	return sprintf(buf, "%s\n", DRVNAME);
-}
-
 static ssize_t show_label(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
@@ -395,16 +389,6 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	return adjust_tjmax(c, id, dev);
 }
 
-static int create_name_attr(struct platform_data *pdata,
-				      struct device *dev)
-{
-	sysfs_attr_init(&pdata->name_attr.attr);
-	pdata->name_attr.attr.name = "name";
-	pdata->name_attr.attr.mode = S_IRUGO;
-	pdata->name_attr.show = show_name;
-	return device_create_file(dev, &pdata->name_attr);
-}
-
 static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 			     int attr_no)
 {
@@ -524,7 +508,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		goto exit_free;
 
 	/* We can access status register. Get Critical Temperature */
-	tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
+	tdata->tjmax = get_tjmax(c, cpu, pdata->hwmon_dev);
 
 	/*
 	 * Read the still undocumented bits 8:15 of IA32_TEMPERATURE_TARGET.
@@ -544,7 +528,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	pdata->core_data[attr_no] = tdata;
 
 	/* Create sysfs interfaces */
-	err = create_core_attrs(tdata, &pdev->dev, attr_no);
+	err = create_core_attrs(tdata, pdata->hwmon_dev, attr_no);
 	if (err)
 		goto exit_free;
 
@@ -569,12 +553,12 @@ static void coretemp_add_core(unsigned int cpu, int pkg_flag)
 }
 
 static void coretemp_remove_core(struct platform_data *pdata,
-				struct device *dev, int indx)
+				 int indx)
 {
 	struct temp_data *tdata = pdata->core_data[indx];
 
 	/* Remove the sysfs attributes */
-	sysfs_remove_group(&dev->kobj, &tdata->attr_group);
+	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
 
 	kfree(pdata->core_data[indx]);
 	pdata->core_data[indx] = NULL;
@@ -584,31 +568,18 @@ static int coretemp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct platform_data *pdata;
-	int err;
 
 	/* Initialize the per-package data structures */
 	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	err = create_name_attr(pdata, dev);
-	if (err)
-		return err;
-
 	pdata->phys_proc_id = pdev->id;
 	platform_set_drvdata(pdev, pdata);
 
-	pdata->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(pdata->hwmon_dev)) {
-		err = PTR_ERR(pdata->hwmon_dev);
-		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
-		goto exit_name;
-	}
-	return 0;
-
-exit_name:
-	device_remove_file(&pdev->dev, &pdata->name_attr);
-	return err;
+	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
+								  pdata, NULL);
+	return PTR_ERR_OR_ZERO(pdata->hwmon_dev);
 }
 
 static int coretemp_remove(struct platform_device *pdev)
@@ -618,10 +589,8 @@ static int coretemp_remove(struct platform_device *pdev)
 
 	for (i = MAX_CORE_DATA - 1; i >= 0; --i)
 		if (pdata->core_data[i])
-			coretemp_remove_core(pdata, &pdev->dev, i);
+			coretemp_remove_core(pdata, i);
 
-	device_remove_file(&pdev->dev, &pdata->name_attr);
-	hwmon_device_unregister(pdata->hwmon_dev);
 	return 0;
 }
 
@@ -769,7 +738,7 @@ static void put_core_offline(unsigned int cpu)
 		return;
 
 	if (pdata->core_data[indx] && pdata->core_data[indx]->cpu = cpu)
-		coretemp_remove_core(pdata, &pdev->dev, indx);
+		coretemp_remove_core(pdata, indx);
 
 	/*
 	 * If a HT sibling of a core is taken offline, but another HT sibling
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
