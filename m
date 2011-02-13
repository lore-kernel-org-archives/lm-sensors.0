From: Durgadoss R <durgadoss.r@intel.com>
Date: Sun, 13 Feb 2011 23:06:41 +0000
Subject: [lm-sensors] [PATCH-v2:RFC][hwmon]:Merging_Pkgtemp_with_Coretemp
Message-Id: <1297637681-1275-1-git-send-email-durgadoss.r@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch merges the pkg temp driver with the coretemp driver.

The data common to both the pkgtemp and coretemp is moved to a
common structure temp_data. The CPU id related info are stored in
struct cpu_id_info.

Changes from v1 of this patch:
There will be one hwmon device per physical CPU. This device will
have all the attributes for the temperature sensors supported by
the physical CPU.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/hwmon/coretemp.c |  363 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 253 insertions(+), 110 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 42de98d..63874a6 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -39,87 +39,151 @@
 
 #define DRVNAME	"coretemp"
 
-typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
-		SHOW_NAME } SHOW;
+static DEFINE_MUTEX(update_lock);
 
-/*
- * Functions declaration
- */
+enum { COREID, PHYS_PROCID, DRV_NAME };
 
-static struct coretemp_data *coretemp_update_device(struct device *dev);
+struct temp_data {	/* Temperature Data common to both pkg and core */
+	int temp;
+	int ttarget;
+	u8 crit_alarm;
+	u8 max_alarm;
+	unsigned long last_updated;	/* in jiffies */
+};
 
-struct coretemp_data {
-	struct device *hwmon_dev;
-	struct mutex update_lock;
-	const char *name;
+struct cpu_id_info {
 	u32 id;
 	u16 core_id;
-	char valid;		/* zero until following fields are valid */
-	unsigned long last_updated;	/* in jiffies */
-	int temp;
+	u16 phys_proc_id;
+};
+
+struct platform_data {
+	struct device *hwmon_dev;
+	const char *name;
 	int tjmax;
-	int ttarget;
-	u8 alarm;
+	int pkg_support;
+	struct cpu_id_info *cpu_data;
+	struct temp_data *core_data;
+	struct temp_data *pkg_data;
 };
 
+/* Functions Declaration */
+static int update_curr_temp(struct temp_data *tdata, u32 eax, int tjmax);
+
 /*
  * Sysfs stuff
  */
 
 static ssize_t show_name(struct device *dev, struct device_attribute
-			  *devattr, char *buf)
+							  *devattr, char *buf)
 {
-	int ret;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct coretemp_data *data = dev_get_drvdata(dev);
+	struct platform_data *data = dev_get_drvdata(dev);
+
+	switch (attr->index) {
+	case DRV_NAME:
+		return sprintf(buf, "%s\n", data->name);
+	case COREID:
+		return sprintf(buf, "Core %d\n", data->cpu_data->core_id);
+	case PHYS_PROCID:
+		return sprintf(buf, "Physical id %d\n",
+						data->cpu_data->phys_proc_id);
+	default:
+		return -EINVAL;
+	}
+}
 
-	if (attr->index = SHOW_NAME)
-		ret = sprintf(buf, "%s\n", data->name);
-	else	/* show label */
-		ret = sprintf(buf, "Core %d\n", data->core_id);
-	return ret;
+static ssize_t show_crit_alarm(struct device *dev, struct device_attribute
+							  *devattr, char *buf)
+{
+	u32 eax, edx;
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *data = dev_get_drvdata(dev);
+
+	switch (attr->index) {
+	case 0:
+		rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_THERM_STATUS,
+								&eax, &edx);
+		data->core_data->crit_alarm = (eax >> 5) & 1;
+		return sprintf(buf, "%d\n", data->core_data->crit_alarm);
+	case 1:
+		rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_PACKAGE_THERM_STATUS,
+								&eax, &edx);
+		data->pkg_data->crit_alarm = (eax >> 5) & 1;
+		return sprintf(buf, "%d\n", data->pkg_data->crit_alarm);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t show_tjmax(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct platform_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", data->tjmax);
 }
 
-static ssize_t show_alarm(struct device *dev, struct device_attribute
-			  *devattr, char *buf)
+static ssize_t show_ttarget(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
-	struct coretemp_data *data = coretemp_update_device(dev);
-	/* read the Out-of-spec log, never clear */
-	return sprintf(buf, "%d\n", data->alarm);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *data = dev_get_drvdata(dev);
+
+	switch (attr->index) {
+	case 0:
+		return sprintf(buf, "%d\n", data->core_data->ttarget);
+	case 1:
+		return sprintf(buf, "%d\n", data->pkg_data->ttarget);
+	default:
+		return -EINVAL;
+	}
 }
 
 static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+				struct device_attribute *devattr, char *buf)
 {
+	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct coretemp_data *data = coretemp_update_device(dev);
+	struct platform_data *data = dev_get_drvdata(dev);
 	int err;
 
-	if (attr->index = SHOW_TEMP)
-		err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
-	else if (attr->index = SHOW_TJMAX)
-		err = sprintf(buf, "%d\n", data->tjmax);
-	else
-		err = sprintf(buf, "%d\n", data->ttarget);
-	return err;
+	switch (attr->index) {
+	case 0:
+		rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_THERM_STATUS,
+								&eax, &edx);
+		err = update_curr_temp(data->core_data, eax, data->tjmax);
+		return err ? err : sprintf(buf, "%d\n", data->core_data->temp);
+	case 1:
+		rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_PACKAGE_THERM_STATUS,
+								&eax, &edx);
+		err = update_curr_temp(data->pkg_data, eax, data->tjmax);
+		return err ? err : sprintf(buf, "%d\n", data->pkg_data->temp);
+	default:
+		return -EINVAL;
+	}
 }
 
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
-			  SHOW_TEMP);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
-			  SHOW_TJMAX);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
-			  SHOW_TTARGET);
-static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
+/* Attributes per physical CPU */
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, DRV_NAME);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_tjmax, NULL, 0);
+/* Coretemp attributes */
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, COREID);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_ttarget, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_crit_alarm, NULL, 0);
+/* Packagetemp attributes */
+static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_name, NULL, PHYS_PROCID);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_ttarget, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_crit_alarm, NULL, 1);
 
 static struct attribute *coretemp_attributes[] = {
 	&sensor_dev_attr_name.dev_attr.attr,
-	&sensor_dev_attr_temp1_label.dev_attr.attr,
-	&dev_attr_temp1_crit_alarm.attr,
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
 	NULL
 };
 
@@ -127,31 +191,36 @@ static const struct attribute_group coretemp_group = {
 	.attrs = coretemp_attributes,
 };
 
-static struct coretemp_data *coretemp_update_device(struct device *dev)
-{
-	struct coretemp_data *data = dev_get_drvdata(dev);
+static struct attribute *pkgtemp_attributes[] = {
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	NULL
+};
 
-	mutex_lock(&data->update_lock);
+static const struct attribute_group pkgtemp_group = {
+	.attrs = pkgtemp_attributes,
+};
 
-	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
-		u32 eax, edx;
+static int update_curr_temp(struct temp_data *tdata, u32 eax, int tjmax)
+{
+	int err = -EINVAL;
 
-		data->valid = 0;
-		rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
-		data->alarm = (eax >> 5) & 1;
-		/* update only if data has been valid */
-		if (eax & 0x80000000) {
-			data->temp = data->tjmax - (((eax >> 16)
-							& 0x7f) * 1000);
-			data->valid = 1;
-		} else {
-			dev_dbg(dev, "Temperature data invalid (0x%x)\n", eax);
-		}
-		data->last_updated = jiffies;
+	mutex_lock(&update_lock);
+	/* Update the current temperature only if:
+	 * 1. The time interval has elapsed _and_
+	 * 2. The data is valid
+	 */
+	if (time_after(jiffies, tdata->last_updated + HZ) &&
+						(eax & 0x80000000)) {
+		tdata->temp = tjmax - (((eax >> 16) & 0x7f) * 1000);
+		tdata->last_updated = jiffies;
+		err = 0;
 	}
 
-	mutex_unlock(&data->update_lock);
-	return data;
+	mutex_unlock(&update_lock);
+	return err;
 }
 
 static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
@@ -298,33 +367,97 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
 	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
 }
 
+static int init_core_data(struct platform_data *pdata, int cpuid)
+{
+	struct cpu_id_info *cinfo;
+	struct temp_data *core_data;
+	int err;
+	u32 eax, edx;
+
+	/* Test if we can access the THERM_STATUS MSR
+	 * If it is not accessible, do not create any data structures,
+	 * Just return.
+	 */
+	err = rdmsr_safe_on_cpu(cpuid, MSR_IA32_THERM_STATUS, &eax, &edx);
+	if (err)
+		return err;
+
+	cinfo = kzalloc(sizeof(struct cpu_id_info), GFP_KERNEL);
+	if (!cinfo)
+		return -ENOMEM;
+
+	core_data = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
+	if (!core_data) {
+		kfree(cinfo);
+		return -ENOMEM;
+	}
+
+	pdata->cpu_data = cinfo;
+	pdata->core_data = core_data;
+
+	return 0;
+}
+
+static int init_pkg_data(struct platform_data *pdata, int cpuid)
+{
+	u32 eax, edx;
+	int err;
+
+	pdata->pkg_data = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
+	if (!pdata->pkg_data)
+		return -ENOMEM;
+
+	/* Test if we can access the PACKAGE_THERM_STATUS MSR. */
+	err = rdmsr_safe_on_cpu(cpuid, MSR_IA32_PACKAGE_THERM_STATUS,
+								&eax, &edx);
+	if (err) {
+		kfree(pdata->pkg_data);
+		pdata->pkg_support = 0;
+	}
+
+	return err;
+
+}
+
 static int __devinit coretemp_probe(struct platform_device *pdev)
 {
-	struct coretemp_data *data;
+	struct platform_data *pdata;
 	struct cpuinfo_x86 *c = &cpu_data(pdev->id);
 	int err;
 	u32 eax, edx;
 
-	if (!(data = kzalloc(sizeof(struct coretemp_data), GFP_KERNEL))) {
-		err = -ENOMEM;
+	pdata = kzalloc(sizeof(struct platform_data), GFP_KERNEL);
+	if (!pdata) {
 		dev_err(&pdev->dev, "Out of memory\n");
+		return -ENOMEM;
+	}
+
+	err = init_core_data(pdata, pdev->id);
+	if (err) {
+		dev_err(&pdev->dev,
+			"coretemp data initialization failed: %d\n", err);
 		goto exit;
 	}
 
-	data->id = pdev->id;
+	/* Check whether we have pkg temp support.
+	 * If so, initialize Package Temp data */
+	pdata->pkg_support = cpu_has(c, X86_FEATURE_PTS) ? 1 : 0;
+	if (pdata->pkg_support) {
+		err = init_pkg_data(pdata, pdev->id);
+		if (err) {
+			dev_err(&pdev->dev,
+			"pkgtemp data initialization failed: %d\n", err);
+			goto exit_core;
+		}
+	}
+
+	pdata->cpu_data->id = pdev->id;
 #ifdef CONFIG_SMP
-	data->core_id = c->cpu_core_id;
+	pdata->cpu_data->core_id = c->cpu_core_id;
+	pdata->cpu_data->phys_proc_id = c->phys_proc_id;
 #endif
-	data->name = "coretemp";
-	mutex_init(&data->update_lock);
+	pdata->name = "coretemp";
 
-	/* test if we can access the THERM_STATUS MSR */
-	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Unable to access THERM_STATUS MSR, giving up\n");
-		goto exit_free;
-	}
 
 	/* Check if we have problem with errata AE18 of Core processors:
 	   Readings might stop update when processor visited too deep sleep,
@@ -333,25 +466,25 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
 
 	if ((c->x86_model = 0xe) && (c->x86_mask < 0xc)) {
 		/* check for microcode update */
-		err = smp_call_function_single(data->id, get_ucode_rev_on_cpu,
-					       &edx, 1);
+		err = smp_call_function_single(pdev->id, get_ucode_rev_on_cpu,
+								&edx, 1);
 		if (err) {
 			dev_err(&pdev->dev,
 				"Cannot determine microcode revision of "
-				"CPU#%u (%d)!\n", data->id, err);
+				"CPU#%u (%d)!\n", pdev->id, err);
 			err = -ENODEV;
-			goto exit_free;
+			goto exit_pkg;
 		} else if (edx < 0x39) {
 			err = -ENODEV;
 			dev_err(&pdev->dev,
 				"Errata AE18 not fixed, update BIOS or "
 				"microcode of the CPU!\n");
-			goto exit_free;
+			goto exit_pkg;
 		}
 	}
 
-	data->tjmax = get_tjmax(c, data->id, &pdev->dev);
-	platform_set_drvdata(pdev, data);
+	pdata->tjmax = get_tjmax(c, pdev->id, &pdev->dev);
+	platform_set_drvdata(pdev, pdata);
 
 	/*
 	 * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
@@ -360,29 +493,29 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
 	 */
 
 	if ((c->x86_model > 0xe) && (c->x86_model != 0x1c)) {
-		err = rdmsr_safe_on_cpu(data->id, MSR_IA32_TEMPERATURE_TARGET,
-		    &eax, &edx);
+		err = rdmsr_safe_on_cpu(pdev->id,
+				MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
 		if (err) {
 			dev_warn(&pdev->dev, "Unable to read"
 					" IA32_TEMPERATURE_TARGET MSR\n");
 		} else {
-			data->ttarget = data->tjmax -
+			pdata->core_data->ttarget = pdata->tjmax -
 					(((eax >> 8) & 0xff) * 1000);
-			err = device_create_file(&pdev->dev,
-					&sensor_dev_attr_temp1_max.dev_attr);
-			if (err)
-				goto exit_free;
 		}
 	}
 
-	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
-		goto exit_dev;
+	err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group);
+	if (err)
+		goto exit_pkg;
+
+	err = sysfs_create_group(&pdev->dev.kobj, &pkgtemp_group);
+	if (err)
+		goto exit_pkg;
 
-	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		dev_err(&pdev->dev, "Class registration failed (%d)\n",
-			err);
+	pdata->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(pdata->hwmon_dev)) {
+		err = PTR_ERR(pdata->hwmon_dev);
+		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
 		goto exit_class;
 	}
 
@@ -390,21 +523,31 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
 
 exit_class:
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-exit_dev:
-	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
-exit_free:
-	kfree(data);
+	if (pdata->pkg_support)
+		sysfs_remove_group(&pdev->dev.kobj, &pkgtemp_group);
+exit_pkg:
+	if (pdata->pkg_support)
+		kfree(pdata->pkg_data);
+exit_core:
+	kfree(pdata->cpu_data);
+	kfree(pdata->core_data);
 exit:
+	kfree(pdata);
 	return err;
 }
 
 static int __devexit coretemp_remove(struct platform_device *pdev)
 {
-	struct coretemp_data *data = platform_get_drvdata(pdev);
+	struct platform_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	if (data->pkg_support) {
+		sysfs_remove_group(&pdev->dev.kobj, &pkgtemp_group);
+		kfree(data->pkg_data);
+	}
+	kfree(data->cpu_data);
+	kfree(data->core_data);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return 0;
-- 
1.7.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
