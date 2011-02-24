From: Durgadoss R <durgadoss.r@intel.com>
Date: Thu, 24 Feb 2011 01:14:10 +0000
Subject: [lm-sensors] [PATCH] v3:Merge_Pkgtemp_with_Coretemp
Message-Id: <1298509330-11953-1-git-send-email-durgadoss.r@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch merges the pkg temp driver with the coretemp driver.

Changes from v2 of this patch:
There will be one hwmon device per physical CPU. This device will
have all the attributes for the temperature sensors supported by
the physical CPU

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/hwmon/coretemp.c |  514 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 362 insertions(+), 152 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 42de98d..463873b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -39,119 +39,136 @@
 
 #define DRVNAME	"coretemp"
 
-typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
-		SHOW_NAME } SHOW;
-
-/*
- * Functions declaration
+#define CORES_PER_CPU		16	/* No of Real Cores per CPU */
+#define CORETEMP_NAME_LENGTH	30	/* String Length of attrs */
+#define MAX_ATTRS		5	/* Maximum no of per-core attrs */
+
+/* Per-Core Temperature Data
+ * @last_updated: The time when the current temperature value was updated
+ *		earlier (in jiffies).
+ * @cpu_id:	The CPU Core from which temperature values should be read
+ *		This value is passed as "id" field to rdmsr/wrmsr functions.
+ * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
+ *		from where the temperature values should be read.
+ * @is_pkg_data:If this is 1, the temp_data holds pkgtemp data.
+ *		Otherwise, temp_data holds coretemp data.
  */
-
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
+struct temp_data {
 	int temp;
-	int tjmax;
 	int ttarget;
-	u8 alarm;
+	int tjmax;
+	u8 crit_alarm;
+	u8 max_alarm;
+	unsigned long last_updated;
+	u32 cpu_id;
+	u32 status_reg;
+	int is_pkg_data;
+	struct sensor_device_attribute sd_attrs[MAX_ATTRS];
+	struct mutex update_lock;
 };
 
-/*
- * Sysfs stuff
+/* Platform Data per Physical CPU
+ * @pkg_support:	If 1, this CPU has pkgtemp support
+ * @core_count:		Number of real cores(not HT ones) in a CPU
+ * @phys_proc_id:	The physical CPU id
  */
+struct platform_data {
+	struct device *hwmon_dev;
+	char name[CORETEMP_NAME_LENGTH];
+	int pkg_support;
+	int core_count;
+	u16 phys_proc_id;
+	struct temp_data *core_data[CORES_PER_CPU];
+	struct device_attribute name_attr;
+};
 
 static ssize_t show_name(struct device *dev, struct device_attribute
-			  *devattr, char *buf)
+							  *devattr, char *buf)
 {
-	int ret;
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct coretemp_data *data = dev_get_drvdata(dev);
+	struct platform_data *pdata = dev_get_drvdata(dev);
 
-	if (attr->index = SHOW_NAME)
-		ret = sprintf(buf, "%s\n", data->name);
-	else	/* show label */
-		ret = sprintf(buf, "Core %d\n", data->core_id);
-	return ret;
+	return sprintf(buf, "%s\n", pdata->name);
 }
 
-static ssize_t show_alarm(struct device *dev, struct device_attribute
-			  *devattr, char *buf)
+static ssize_t show_label(struct device *dev, struct device_attribute
+							  *devattr, char *buf)
 {
-	struct coretemp_data *data = coretemp_update_device(dev);
-	/* read the Out-of-spec log, never clear */
-	return sprintf(buf, "%d\n", data->alarm);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct temp_data *tdata = pdata->core_data[attr->index];
+
+	if (tdata->is_pkg_data)
+		return sprintf(buf, "Physical id %d\n", pdata->phys_proc_id);
+
+	return sprintf(buf, "Core %d\n", tdata->cpu_id);
 }
 
-static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+static ssize_t show_crit_alarm(struct device *dev, struct device_attribute
+							  *devattr, char *buf)
 {
+	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct coretemp_data *data = coretemp_update_device(dev);
-	int err;
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct temp_data *tdata = pdata->core_data[attr->index];
 
-	if (attr->index = SHOW_TEMP)
-		err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
-	else if (attr->index = SHOW_TJMAX)
-		err = sprintf(buf, "%d\n", data->tjmax);
-	else
-		err = sprintf(buf, "%d\n", data->ttarget);
-	return err;
+	rdmsr_on_cpu(tdata->cpu_id, tdata->status_reg, &eax, &edx);
+	tdata->crit_alarm = (eax >> 5) & 1;
+
+	return sprintf(buf, "%d\n", tdata->crit_alarm);
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
-
-static struct attribute *coretemp_attributes[] = {
-	&sensor_dev_attr_name.dev_attr.attr,
-	&sensor_dev_attr_temp1_label.dev_attr.attr,
-	&dev_attr_temp1_crit_alarm.attr,
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	NULL
-};
+static ssize_t show_tjmax(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
 
-static const struct attribute_group coretemp_group = {
-	.attrs = coretemp_attributes,
-};
+	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->tjmax);
+}
 
-static struct coretemp_data *coretemp_update_device(struct device *dev)
+static ssize_t show_ttarget(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
-	struct coretemp_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
 
-	mutex_lock(&data->update_lock);
+	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget);
+}
 
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
+	mutex_lock(&tdata->update_lock);
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
+	mutex_unlock(&tdata->update_lock);
+	return err;
+}
+
+static ssize_t show_temp(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	u32 eax, edx;
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct temp_data *tdata = pdata->core_data[attr->index];
+	int err;
+
+	rdmsr_on_cpu(tdata->cpu_id, tdata->status_reg, &eax, &edx);
+	err = update_curr_temp(tdata, eax, tdata->tjmax);
+
+	return err ? err : sprintf(buf, "%d\n", tdata->temp);
+
 }
 
 static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
@@ -298,115 +315,301 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
 	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
 }
 
-static int __devinit coretemp_probe(struct platform_device *pdev)
+static int get_pkg_tjmax(int cpu, struct device *dev)
 {
-	struct coretemp_data *data;
-	struct cpuinfo_x86 *c = &cpu_data(pdev->id);
+	int default_tjmax = 100000;
 	int err;
 	u32 eax, edx;
+	u32 val;
 
-	if (!(data = kzalloc(sizeof(struct coretemp_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		dev_err(&pdev->dev, "Out of memory\n");
-		goto exit;
+	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+	if (!err) {
+		val = (eax >> 16) & 0xff;
+		if ((val > 80) && (val < 120))
+			return val * 1000;
 	}
+	dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%d\n", cpu);
+	return default_tjmax;
+}
 
-	data->id = pdev->id;
-#ifdef CONFIG_SMP
-	data->core_id = c->cpu_core_id;
-#endif
-	data->name = "coretemp";
-	mutex_init(&data->update_lock);
+static int create_name_attr(struct platform_data *pdata,
+					struct platform_device *pdev, int flag)
+{
+	/* A non-zero flag creates the 'name' attribute.
+	 * A zero flag removes it.
+	 */
+	if (flag) {
+		pdata->name_attr.attr.name = "name";
+		pdata->name_attr.attr.mode = S_IRUGO;
+		pdata->name_attr.show = show_name;
+		return device_create_file(&pdev->dev, &pdata->name_attr);
+	} else {
+		device_remove_file(&pdev->dev, &pdata->name_attr);
+		return 0;
+	}
+}
 
-	/* test if we can access the THERM_STATUS MSR */
-	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Unable to access THERM_STATUS MSR, giving up\n");
-		goto exit_free;
+static int create_core_attrs(struct platform_data *pdata,
+						struct platform_device *pdev)
+{
+	int err, i;
+	char *names[MAX_ATTRS];
+	int attr_no = pdata->core_count;
+	struct temp_data *tdata = pdata->core_data[attr_no];
+	ssize_t (*rd_ptr[MAX_ATTRS]) (struct device *dev,
+			struct device_attribute *devattr, char *buf) = {
+			show_label, show_crit_alarm, show_ttarget,
+			show_temp, show_tjmax };
+
+	/* Increment attr_no since the sysfs interfaces start with temp1_* */
+	attr_no++;
+
+	for (i = 0; i < MAX_ATTRS; i++) {
+		names[i] = kzalloc(CORETEMP_NAME_LENGTH, GFP_KERNEL);
+		if (!names[i])
+			return -ENOMEM;
 	}
 
-	/* Check if we have problem with errata AE18 of Core processors:
-	   Readings might stop update when processor visited too deep sleep,
-	   fixed for stepping D0 (6EC).
-	*/
+	snprintf(names[0], CORETEMP_NAME_LENGTH, "temp%d_label", attr_no);
+	snprintf(names[1], CORETEMP_NAME_LENGTH, "temp%d_crit_alarm", attr_no);
+	snprintf(names[2], CORETEMP_NAME_LENGTH, "temp%d_max", attr_no);
+	snprintf(names[3], CORETEMP_NAME_LENGTH, "temp%d_input", attr_no);
+	snprintf(names[4], CORETEMP_NAME_LENGTH, "temp%d_crit", attr_no);
+
+	for (i = 0; i < MAX_ATTRS; i++) {
+		tdata->sd_attrs[i].dev_attr.attr.name = names[i];
+		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
+		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
+		tdata->sd_attrs[i].dev_attr.store = NULL;
+		tdata->sd_attrs[i].index = pdata->core_count;
+		err = device_create_file(&pdev->dev,
+						&tdata->sd_attrs[i].dev_attr);
+		if (err)
+			goto exit_free;
+	}
+
+	return 0;
+
+exit_free:
+	while (--i >= 0)
+		device_remove_file(&pdev->dev, &tdata->sd_attrs[i].dev_attr);
+	return err;
+}
+
+static void remove_core_attrs(struct platform_data *pdata,
+						struct platform_device *pdev)
+{
+	int i;
+	int indx = pdata->core_count - 1;
+	struct temp_data *tdata;
+
+	/* Remove all sysfs interfaces for this Physical CPU */
+	while (--indx >= 0) {
+		tdata = pdata->core_data[indx];
+		for (i = 0; i < MAX_ATTRS; i++) {
+			device_remove_file(&pdev->dev,
+						&tdata->sd_attrs[i].dev_attr);
+		}
+		kfree(tdata);
+	}
+
+}
 
+static void update_ttarget(struct cpuinfo_x86 *c, struct platform_data *pdata,
+						struct platform_device *pdev)
+{
+	int err;
+	u32 eax, edx;
+	int indx = pdata->core_count;
+	struct temp_data *tdata = pdata->core_data[indx];
+
+	/* Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
+	 * on older CPUs but not in this register,
+	 * Atoms don't have it either.
+	 */
+
+	if ((c->x86_model > 0xe) && (c->x86_model != 0x1c)) {
+		err = rdmsr_safe_on_cpu(tdata->cpu_id,
+				MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+		if (err) {
+			dev_warn(&pdev->dev, "Unable to read"
+					" IA32_TEMPERATURE_TARGET MSR\n");
+
+		} else {
+			tdata->ttarget = tdata->tjmax -
+					(((eax >> 8) & 0xff) * 1000);
+		}
+	}
+}
+
+static int update_microcode(struct cpuinfo_x86 *c,
+						struct platform_device *pdev)
+{
+	int err;
+	u32 edx;
+
+	/* Check if we have problem with errata AE18 of Core processors:
+	 * Readings might stop update when processor visited too deep sleep,
+	 * fixed for stepping D0 (6EC).
+	 */
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
-			err = -ENODEV;
-			goto exit_free;
+				"CPU#%u (%d)!\n", pdev->id, err);
+			return -ENODEV;
 		} else if (edx < 0x39) {
-			err = -ENODEV;
 			dev_err(&pdev->dev,
 				"Errata AE18 not fixed, update BIOS or "
 				"microcode of the CPU!\n");
-			goto exit_free;
+			return -ENODEV;
 		}
 	}
 
-	data->tjmax = get_tjmax(c, data->id, &pdev->dev);
-	platform_set_drvdata(pdev, data);
+	return 0;
+}
 
-	/*
-	 * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
-	 * on older CPUs but not in this register,
-	 * Atoms don't have it either.
+static int init_temp_data(struct platform_data *pdata, int cpuid, int pkg_flag)
+{
+	struct temp_data *tdata;
+	u32 eax, edx;
+	int err;
+
+	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
+	if (!tdata)
+		return -ENOMEM;
+
+	tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
+							MSR_IA32_THERM_STATUS;
+	tdata->is_pkg_data = pkg_flag;
+	tdata->cpu_id = cpuid;
+
+	/* Test if we can access the status register */
+	err = rdmsr_safe_on_cpu(cpuid, tdata->status_reg, &eax, &edx);
+	if (err)
+		kfree(tdata);
+
+	if (err && pkg_flag)
+		pdata->pkg_support = 0;
+
+	mutex_init(&tdata->update_lock);
+	pdata->core_data[pdata->core_count] = tdata;
+
+	return err;
+}
+
+static int __devinit coretemp_probe(struct platform_device *pdev)
+{
+	struct platform_data *pdata;
+	struct temp_data *tdata;
+	struct cpuinfo_x86 *c = &cpu_data(pdev->id);
+	int i, err;
+	int core_id = -1;
+
+	/* Initialize the per-package data structures. */
+	pdata = kzalloc(sizeof(struct platform_data), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(&pdev->dev, "Out of memory\n");
+		return -ENOMEM;
+	}
+
+	pdata->core_count = 0;
+	strcpy(pdata->name, DRVNAME);
+	pdata->phys_proc_id = c->phys_proc_id;
+
+	err = create_name_attr(pdata, pdev, 1);
+	if (err)
+		goto exit_free;
+
+	/* Check whether we have pkg temp support */
+	pdata->pkg_support = cpu_has(c, X86_FEATURE_PTS) ? 1 : 0;
+	if (pdata->pkg_support) {
+
+		/* If so, initialize Package Temp data */
+		err = init_temp_data(pdata, pdev->id, 1);
+		if (err)
+			goto exit_name;
+
+		/* Get Critical Temperature for PkgTemp */
+		tdata = pdata->core_data[pdata->core_count];
+		tdata->tjmax = get_pkg_tjmax(pdev->id, &pdev->dev);
+
+		update_ttarget(c, pdata, pdev);
+
+		/* Create sysfs interfaces for Pkgtemp */
+		err = create_core_attrs(pdata, pdev);
+		if (err)
+			goto exit_class;
+
+		pdata->core_count++;
+	}
+
+	/* For all the real cores (not HT ones) in this Physical CPU,
+	 * initialize coretemp data and create sysfs interfaces.
 	 */
+	for_each_online_cpu(i) {
+		c = &cpu_data(i);
+		if ((c->phys_proc_id = pdata->phys_proc_id)
+					&& (c->cpu_core_id != core_id)) {
 
-	if ((c->x86_model > 0xe) && (c->x86_model != 0x1c)) {
-		err = rdmsr_safe_on_cpu(data->id, MSR_IA32_TEMPERATURE_TARGET,
-		    &eax, &edx);
-		if (err) {
-			dev_warn(&pdev->dev, "Unable to read"
-					" IA32_TEMPERATURE_TARGET MSR\n");
-		} else {
-			data->ttarget = data->tjmax -
-					(((eax >> 8) & 0xff) * 1000);
-			err = device_create_file(&pdev->dev,
-					&sensor_dev_attr_temp1_max.dev_attr);
+			core_id = c->cpu_core_id;
+
+			/* Initialize Coretemp data */
+			err = init_temp_data(pdata, core_id, 0);
 			if (err)
-				goto exit_free;
+				goto exit_class;
+
+			/* Get Critical Temperature for this core */
+			tdata = pdata->core_data[pdata->core_count];
+			tdata->tjmax = get_tjmax(c, core_id, &pdev->dev);
+
+			update_ttarget(c, pdata, pdev);
+
+			err = update_microcode(c, pdev);
+			if (err)
+				goto exit_class;
+
+			/* Create sysfs interfaces for this core */
+			err = create_core_attrs(pdata, pdev);
+			if (err)
+				goto exit_class;
+
+			pdata->core_count++;
 		}
 	}
 
-	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
-		goto exit_dev;
+	platform_set_drvdata(pdev, pdata);
 
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
 
 	return 0;
 
 exit_class:
-	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-exit_dev:
-	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	remove_core_attrs(pdata, pdev);
+exit_name:
+	create_name_attr(pdata, pdev, 0);
 exit_free:
-	kfree(data);
-exit:
+	kfree(pdata);
 	return err;
 }
 
 static int __devexit coretemp_remove(struct platform_device *pdev)
 {
-	struct coretemp_data *data = platform_get_drvdata(pdev);
+	struct platform_data *pdata = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
-	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
+	hwmon_device_unregister(pdata->hwmon_dev);
+	create_name_attr(pdata, pdev, 0);
+	remove_core_attrs(pdata, pdev);
 	platform_set_drvdata(pdev, NULL);
-	kfree(data);
+	kfree(pdata);
 	return 0;
 }
 
@@ -549,6 +752,7 @@ static struct notifier_block coretemp_cpu_notifier __refdata = {
 static int __init coretemp_init(void)
 {
 	int i, err = -ENODEV;
+	int phys_id = -1;
 
 	/* quick check if we run Intel */
 	if (cpu_data(0).x86_vendor != X86_VENDOR_INTEL)
@@ -558,8 +762,14 @@ static int __init coretemp_init(void)
 	if (err)
 		goto exit;
 
-	for_each_online_cpu(i)
-		coretemp_device_add(i);
+	/* Add a coretemp device for a Physical CPU only */
+	for_each_online_cpu(i) {
+		struct cpuinfo_x86 *c = &cpu_data(i);
+		if (c->phys_proc_id != phys_id) {
+			phys_id = c->phys_proc_id;
+			coretemp_device_add(i);
+		}
+	}
 
 #ifndef CONFIG_HOTPLUG_CPU
 	if (list_empty(&pdev_list)) {
-- 
1.7.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
