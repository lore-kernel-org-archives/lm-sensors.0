From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 04 Apr 2013 19:11:27 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (coretemp) Add threshold support
Message-Id: <1365102689-12581-3-git-send-email-srinivas.pandruvada@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Added tempX_notify_threshold_1 and tempX_notify_threshold_2 to coretemp sysfs.
These will appear only if the platform supports digital temperature
sensor and has support for thresholds.
Using this interface, uses can set upto thresholds to get notifications.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hwmon/coretemp.c | 130 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 119 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 3f1e297..6767af1 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -52,9 +52,10 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
-#define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
+#define CORETEMP_NAME_LENGTH	26	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
-#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
+#define MAX_NON_CORE_ATTRS	2	/* Maximum no of additional attrs */
+#define TOTAL_ATTRS		(MAX_CORE_ATTRS +  MAX_NON_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
 #define TO_PHYS_ID(cpu)		(cpu_data(cpu).phys_proc_id)
@@ -110,9 +111,92 @@ struct pdev_entry {
 	u16 phys_proc_id;
 };
 
+/* Used to specify attribute name/mode combination */
+struct attribute_info {
+	const char *name;
+	const int mode;
+};
+
 static LIST_HEAD(pdev_list);
 static DEFINE_MUTEX(pdev_list_mutex);
 
+#define define_device_show_thresholds(_index)		\
+static ssize_t show_threshold_##_index(struct device *dev, \
+			struct device_attribute *devattr, char *buf) \
+{ \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
+	struct platform_data *pdata = dev_get_drvdata(dev); \
+	struct temp_data *tdata = pdata->core_data[attr->index]; \
+	ssize_t ret; \
+	u32 l, h; \
+	u32 val; \
+	\
+	ret = rdmsr_on_cpu(tdata->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, \
+		&l, &h); \
+	if (ret < 0) \
+		goto err_ret; \
+	l &= THERM_MASK_THRESHOLD##_index; \
+	val = (l >> THERM_SHIFT_THRESHOLD##_index); \
+	if (!val) \
+		ret = sprintf(buf, "0\n"); \
+	else \
+		ret = sprintf(buf, "%u\n", \
+			pdata->core_data[attr->index]->tjmax - (val * 1000)); \
+	\
+err_ret: \
+	return ret; \
+}
+
+/* Package level threshold bits are applicable to all cores. Set or
+reset on one CPU will apply to all cores in package */
+#define define_device_update_threshold(_index)		\
+static ssize_t store_threshold_##_index( \
+	struct device *dev, \
+	struct device_attribute *devattr, const char *buf, size_t size) \
+{ \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
+	struct platform_data *pdata = dev_get_drvdata(dev); \
+	struct temp_data *tdata = pdata->core_data[attr->index]; \
+	u32 l, h; \
+	u32 val; \
+	ssize_t ret; \
+	\
+	ret = kstrtou32(buf, 0, &val); \
+	if (ret) \
+		goto err_ret; \
+	if (val >= 1000 && val < pdata->core_data[attr->index]->tjmax)\
+		val = (pdata->core_data[attr->index]->tjmax) - val ;\
+	else if (val != 0) {\
+		ret = -EINVAL; \
+		goto err_ret; \
+	} \
+	ret = rdmsr_on_cpu(tdata->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, \
+				&l, &h); \
+	if (ret < 0) \
+		goto err_ret; \
+	l &= ~THERM_MASK_THRESHOLD##_index; \
+	if (!val) \
+		l &= ~THERM_INT_THRESHOLD##_index##_ENABLE; \
+	\
+	else { \
+		l |= (val/1000 << THERM_SHIFT_THRESHOLD##_index); \
+		l |= (THERM_INT_THRESHOLD##_index##_ENABLE); \
+	} \
+	ret = wrmsr_on_cpu(tdata->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, \
+				l, h); \
+	if (ret < 0) \
+		goto err_ret; \
+	ret = size; \
+	\
+err_ret: \
+	return ret; \
+}
+
+define_device_show_thresholds(0);
+define_device_update_threshold(0);
+define_device_show_thresholds(1);
+define_device_update_threshold(1);
+
 static ssize_t show_name(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
@@ -374,19 +458,29 @@ static int __cpuinit create_core_attrs(struct temp_data *tdata,
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
 			struct device_attribute *devattr, char *buf) = {
 			show_label, show_crit_alarm, show_temp, show_tjmax,
-			show_ttarget };
-	static const char *const names[TOTAL_ATTRS] = {
-					"temp%d_label", "temp%d_crit_alarm",
-					"temp%d_input", "temp%d_crit",
-					"temp%d_max" };
+			show_ttarget, show_threshold_0, show_threshold_1 };
+
+	static ssize_t (*const wr_ptr[TOTAL_ATTRS]) (struct device *dev,
+			struct device_attribute *devattr, const char *buf,
+			size_t size) = {
+			NULL, NULL, NULL, NULL, NULL,
+			store_threshold_0, store_threshold_1 };
+
+	static const struct attribute_info attr_info[TOTAL_ATTRS] = {
+	{"temp%d_label", S_IRUGO}, {"temp%d_crit_alarm", S_IRUGO},
+	{"temp%d_input", S_IRUGO}, { "temp%d_crit", S_IRUGO},
+	{"temp%d_max", S_IRUGO},
+	{"temp%d_notify_threshold_1", S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH},
+	{"temp%d_notify_threshold_2", S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH} };
 
 	for (i = 0; i < tdata->attr_size; i++) {
-		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
-			attr_no);
+		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
+			attr_info[i].name, attr_no);
 		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
 		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
-		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
+		tdata->sd_attrs[i].dev_attr.attr.mode = attr_info[i].mode;
 		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
+		tdata->sd_attrs[i].dev_attr.store = wr_ptr[i];
 		tdata->sd_attrs[i].index = attr_no;
 		err = device_create_file(dev, &tdata->sd_attrs[i].dev_attr);
 		if (err)
@@ -460,8 +554,9 @@ static int __cpuinit create_core_data(struct platform_device *pdev,
 	struct temp_data *tdata;
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-	u32 eax, edx;
+	u32 eax, ebx, ecx, edx;
 	int err, attr_no;
+	int thres_cnt;
 
 	/*
 	 * Find attr number for sysfs:
@@ -511,6 +606,19 @@ static int __cpuinit create_core_data(struct platform_device *pdev,
 		}
 	}
 
+	if (pkg_flag) {
+		cpuid(6, &eax, &ebx, &ecx, &edx);
+		thres_cnt = ebx & 0x7;
+		/*
+		 * Can't set more than 2 (MAX_NON_CORE_ATTRS) thresholds in
+		 * MSR so cap at MAX_NON_CORE_ATTRS
+		 */
+		thres_cnt = clamp_val(thres_cnt, 0, MAX_NON_CORE_ATTRS);
+		dev_dbg(&pdev->dev, "No of thresholds %d\n", thres_cnt);
+		if (thres_cnt)
+			tdata->attr_size += thres_cnt;
+	}
+
 	pdata->core_data[attr_no] = tdata;
 
 	/* Create sysfs interfaces */
-- 
1.7.11.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
