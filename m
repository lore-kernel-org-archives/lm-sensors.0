From: Durgadoss R <durgadoss.r@intel.com>
Date: Tue, 08 Feb 2011 18:14:03 +0000
Subject: [lm-sensors] [PATCH RFC] Merging_Pkgtemp_with_Coretemp
Message-Id: <1297188123-8924-1-git-send-email-durgadoss.r@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch merges the pkgtemp driver with the coretemp driver, by
creating the required pkg temp interfaces under the same
hwmonX/device directory as that of the coretemp.
None of the coretemp interfaces are changed.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/hwmon/coretemp.c |  378 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 285 insertions(+), 93 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 42de98d..b3dae75 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -39,87 +39,134 @@
 
 #define DRVNAME	"coretemp"
 
-typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
-		SHOW_NAME } SHOW;
+static DEFINE_MUTEX(update_lock);
 
-/*
- * Functions declaration
- */
+enum { COREID, PHYS_PROCID, DRV_NAME };
+enum { CORE_TEMP, CORE_TJMAX, CORE_TTARGET, PKG_TEMP, PKG_TJMAX, PKG_TTARGET };
+enum { CORE_CRIT_ALARM, CORE_MAX_ALARM, PKG_CRIT_ALARM, PKG_MAX_ALARM };
 
-static struct coretemp_data *coretemp_update_device(struct device *dev);
-
-struct coretemp_data {
-	struct device *hwmon_dev;
-	struct mutex update_lock;
-	const char *name;
-	u32 id;
-	u16 core_id;
-	char valid;		/* zero until following fields are valid */
-	unsigned long last_updated;	/* in jiffies */
+struct temp_data {	/* Temperature Data common to both pkg and core */
 	int temp;
 	int tjmax;
 	int ttarget;
-	u8 alarm;
+	u8 crit_alarm;
+	u8 max_alarm;
+	unsigned long last_updated;	/* in jiffies */
 };
 
+struct cpu_id_info {
+	u32 id;
+	u16 core_id;
+	u16 phys_proc_id;
+};
+
+struct platform_data {
+	struct device *hwmon_dev;
+	const char *name;
+	int pkg_support;
+	struct cpu_id_info *cpu_data;
+	struct temp_data *core_data;
+	struct temp_data *pkg_data;
+};
+
+/* Functions Declaration */
+static int update_curr_temp(struct platform_data *pdata, int index);
+static void update_alarm(struct platform_data *pdata, int index);
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
-
-	if (attr->index = SHOW_NAME)
-		ret = sprintf(buf, "%s\n", data->name);
-	else	/* show label */
-		ret = sprintf(buf, "Core %d\n", data->core_id);
-	return ret;
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
 }
 
 static ssize_t show_alarm(struct device *dev, struct device_attribute
-			  *devattr, char *buf)
+							  *devattr, char *buf)
 {
-	struct coretemp_data *data = coretemp_update_device(dev);
-	/* read the Out-of-spec log, never clear */
-	return sprintf(buf, "%d\n", data->alarm);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *data = dev_get_drvdata(dev);
+
+	update_alarm(data, attr->index);
+
+	switch (attr->index) {
+	case CORE_CRIT_ALARM:
+		return sprintf(buf, "%d\n", data->core_data->crit_alarm);
+	case CORE_MAX_ALARM:
+		return sprintf(buf, "%d\n", data->core_data->max_alarm);
+	case PKG_CRIT_ALARM:
+		return sprintf(buf, "%d\n", data->pkg_data->crit_alarm);
+	case PKG_MAX_ALARM:
+		return sprintf(buf, "%d\n", data->pkg_data->max_alarm);
+	default:
+		return -EINVAL;
+	}
 }
 
 static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+				struct device_attribute *devattr, char *buf)
 {
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
+	case CORE_TEMP:
+		err = update_curr_temp(data, CORE_TEMP);
+		return err ? err : sprintf(buf, "%d\n", data->core_data->temp);
+	case PKG_TEMP:
+		err = update_curr_temp(data, PKG_TEMP);
+		return err ? err : sprintf(buf, "%d\n", data->pkg_data->temp);
+	case CORE_TJMAX:
+		return sprintf(buf, "%d\n", data->core_data->tjmax);
+	case CORE_TTARGET:
+		return sprintf(buf, "%d\n", data->core_data->ttarget);
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
+/* Coretemp attributes */
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, CORE_TEMP);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL, CORE_TJMAX);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL, CORE_TTARGET);
+static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL,
+							CORE_CRIT_ALARM);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
+							CORE_MAX_ALARM);
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, COREID);
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, DRV_NAME);
+/* Packagetemp attributes */
+static SENSOR_DEVICE_ATTR(temp1_pkg_input, S_IRUGO, show_temp, NULL, PKG_TEMP);
+static SENSOR_DEVICE_ATTR(temp1_pkg_crit_alarm, S_IRUGO, show_alarm, NULL,
+							PKG_CRIT_ALARM);
+static SENSOR_DEVICE_ATTR(temp1_pkg_max_alarm, S_IRUGO, show_alarm, NULL,
+							PKG_MAX_ALARM);
+static SENSOR_DEVICE_ATTR(temp1_pkg_id, S_IRUGO, show_name, NULL, PHYS_PROCID);
+
 
 static struct attribute *coretemp_attributes[] = {
-	&sensor_dev_attr_name.dev_attr.attr,
-	&sensor_dev_attr_temp1_label.dev_attr.attr,
-	&dev_attr_temp1_crit_alarm.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_name.dev_attr.attr,
 	NULL
 };
 
@@ -127,31 +174,62 @@ static const struct attribute_group coretemp_group = {
 	.attrs = coretemp_attributes,
 };
 
-static struct coretemp_data *coretemp_update_device(struct device *dev)
+static void update_alarm(struct platform_data *data, int index)
+{
+	u32 eax, edx;
+	struct temp_data *tdata;
+
+	if (index = CORE_CRIT_ALARM || index = CORE_MAX_ALARM) {
+		rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_THERM_STATUS,
+								&eax, &edx);
+		tdata = data->core_data;
+	} else {
+		rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_PACKAGE_THERM_STATUS,
+								&eax, &edx);
+		tdata = data->pkg_data;
+	}
+	/* Update the critical temperature alarm */
+	tdata->crit_alarm = (eax >> 5) & 1;
+	return;
+}
+
+static int update_curr_temp(struct platform_data *data, int index)
 {
-	struct coretemp_data *data = dev_get_drvdata(dev);
+	struct temp_data *tdata;
+	struct cpu_id_info *cdata;
+	u32 eax, edx;
+	int err = 0;
+
+	mutex_lock(&update_lock);
 
-	mutex_lock(&data->update_lock);
+	cdata = data->cpu_data;
 
-	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
-		u32 eax, edx;
+	if (index = CORE_TEMP) {
+		tdata = data->core_data;
+		rdmsr_on_cpu(cdata->id, MSR_IA32_THERM_STATUS, &eax, &edx);
+	} else {
+		tdata = data->pkg_data;
+		rdmsr_on_cpu(cdata->id, MSR_IA32_PACKAGE_THERM_STATUS,
+								&eax, &edx);
+	}
 
-		data->valid = 0;
-		rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
-		data->alarm = (eax >> 5) & 1;
+	if (time_after(jiffies, tdata->last_updated + HZ)) {
 		/* update only if data has been valid */
 		if (eax & 0x80000000) {
-			data->temp = data->tjmax - (((eax >> 16)
+			tdata->temp = tdata->tjmax - (((eax >> 16)
 							& 0x7f) * 1000);
-			data->valid = 1;
 		} else {
-			dev_dbg(dev, "Temperature data invalid (0x%x)\n", eax);
+			dev_dbg(data->hwmon_dev,
+				"Temperature data invalid (0x%x)\n", eax);
+			err = -EINVAL;
+			goto exit;
 		}
-		data->last_updated = jiffies;
+		tdata->last_updated = jiffies;
 	}
 
-	mutex_unlock(&data->update_lock);
-	return data;
+exit:
+	mutex_unlock(&update_lock);
+	return err;
 }
 
 static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
@@ -298,32 +376,135 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
 	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
 }
 
+static int init_core_data(struct platform_data *pdata)
+{
+	struct cpu_id_info *cinfo;
+	struct temp_data *core_data;
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
+static int enable_pkg_attrs(struct platform_device *pdev, int flag)
+{
+	int err = 0;
+	u32 eax, edx;
+
+	/* If flag is Zero, remove all interfaces.
+	 * If non-zero, create pkg temp interfaces
+	 */
+	if (!flag)
+		goto exit_pkg_id;
+
+
+	/* Test if we can access the PACKAGE_THERM_STATUS MSR.
+	 * If we cannot access, do not create any interfaces; just return
+	 */
+	err = rdmsr_safe_on_cpu(pdev->id, MSR_IA32_PACKAGE_THERM_STATUS,
+								&eax, &edx);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Can't read PACKAGE_THERM_STATUS MSR:%d\n", err);
+		return err;
+	}
+
+	err = device_create_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_input.dev_attr);
+	if (err)
+		return err;
+
+	err = device_create_file(&pdev->dev,
+			&sensor_dev_attr_temp1_pkg_crit_alarm.dev_attr);
+	if (err)
+		goto exit_input;
+
+	err = device_create_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_max_alarm.dev_attr);
+	if (err)
+		goto exit_crit_alarm;
+
+	err = device_create_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_id.dev_attr);
+	if (err)
+		goto exit_max_alarm;
+
+	return err;
+
+exit_pkg_id:
+	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_pkg_id.dev_attr);
+exit_max_alarm:
+	device_remove_file(&pdev->dev,
+			&sensor_dev_attr_temp1_pkg_max_alarm.dev_attr);
+exit_crit_alarm:
+	device_remove_file(&pdev->dev,
+			&sensor_dev_attr_temp1_pkg_crit_alarm.dev_attr);
+exit_input:
+	device_remove_file(&pdev->dev,
+				&sensor_dev_attr_temp1_pkg_input.dev_attr);
+	return err;
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
-		goto exit;
+		return -ENOMEM;
+	}
+
+	if (init_core_data(pdata)) {
+		dev_err(&pdev->dev, "Out of memory\n");
+		kfree(pdata);
+		return -ENOMEM;
+	}
+
+	/* Initialize Package Temp data */
+	pdata->pkg_support = cpu_has(c, X86_FEATURE_PTS) ? 1 : 0;
+	if (pdata->pkg_support) {
+		pdata->pkg_data = kzalloc(sizeof(struct temp_data),
+								GFP_KERNEL);
+		if (!pdata->pkg_data) {
+			err = -ENOMEM;
+			goto exit_free;
+		}
+		err = enable_pkg_attrs(pdev, 1);
+		if (err) {
+			pdata->pkg_support = 0;
+			kfree(pdata->pkg_data);
+			goto exit_free;
+		}
 	}
 
-	data->id = pdev->id;
+	pdata->cpu_data->id = pdev->id;
 #ifdef CONFIG_SMP
-	data->core_id = c->cpu_core_id;
+	pdata->cpu_data->core_id = c->cpu_core_id;
+	pdata->cpu_data->phys_proc_id = c->phys_proc_id;
 #endif
-	data->name = "coretemp";
-	mutex_init(&data->update_lock);
+	pdata->name = "coretemp";
 
 	/* test if we can access the THERM_STATUS MSR */
-	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
+	err = rdmsr_safe_on_cpu(pdev->id, MSR_IA32_THERM_STATUS, &eax, &edx);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Unable to access THERM_STATUS MSR, giving up\n");
-		goto exit_free;
+		goto exit_pkg;
 	}
 
 	/* Check if we have problem with errata AE18 of Core processors:
@@ -333,25 +514,25 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
 
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
+	pdata->core_data->tjmax = get_tjmax(c, pdev->id, &pdev->dev);
+	platform_set_drvdata(pdev, pdata);
 
 	/*
 	 * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
@@ -360,29 +541,28 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
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
+			pdata->core_data->ttarget = pdata->core_data->tjmax -
 					(((eax >> 8) & 0xff) * 1000);
 			err = device_create_file(&pdev->dev,
 					&sensor_dev_attr_temp1_max.dev_attr);
 			if (err)
-				goto exit_free;
+				goto exit_pkg;
 		}
 	}
 
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
 		goto exit_dev;
 
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
 
@@ -392,19 +572,31 @@ exit_class:
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
 exit_dev:
 	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
+exit_pkg:
+	if (pdata->pkg_support) {
+		enable_pkg_attrs(pdev, 0);
+		kfree(pdata->pkg_data);
+	}
 exit_free:
-	kfree(data);
-exit:
+	kfree(pdata->cpu_data);
+	kfree(pdata->core_data);
+	kfree(pdata);
 	return err;
 }
 
 static int __devexit coretemp_remove(struct platform_device *pdev)
 {
-	struct coretemp_data *data = platform_get_drvdata(pdev);
+	struct platform_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
 	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	if (data->pkg_support) {
+		enable_pkg_attrs(pdev, 0);
+		kfree(data->pkg_data);
+	}
+	kfree(data->cpu_data);
+	kfree(data->core_data);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return 0;
-- 
1.6.5.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
