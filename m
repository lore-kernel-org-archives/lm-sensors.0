From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Feb 2013 16:16:54 +0000
Subject: [lm-sensors] [PATCH (resend) 1/2] hwmon: (coretemp) Rename temp_data to core_data
Message-Id: <1361895415-18253-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We are going to use the data structure for power data as well.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 3f1e297..02ac401 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -76,11 +76,11 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
  * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
  *		from where the temperature values should be read.
  * @attr_size:  Total number of pre-core attrs displayed in the sysfs.
- * @is_pkg_data: If this is 1, the temp_data holds pkgtemp data.
- *		Otherwise, temp_data holds coretemp data.
- * @valid: If this is 1, the current temperature is valid.
+ * @is_pkg_data: If this is true, the core_data holds pkgtemp data.
+ *		Otherwise, core_data holds coretemp data.
+ * @valid: If this is true, the current temperature is valid.
  */
-struct temp_data {
+struct core_data {
 	int temp;
 	int ttarget;
 	int tjmax;
@@ -100,7 +100,7 @@ struct temp_data {
 struct platform_data {
 	struct device *hwmon_dev;
 	u16 phys_proc_id;
-	struct temp_data *core_data[MAX_CORE_DATA];
+	struct core_data *core_data[MAX_CORE_DATA];
 	struct device_attribute name_attr;
 };
 
@@ -124,7 +124,7 @@ static ssize_t show_label(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct core_data *tdata = pdata->core_data[attr->index];
 
 	if (tdata->is_pkg_data)
 		return sprintf(buf, "Physical id %u\n", pdata->phys_proc_id);
@@ -138,7 +138,7 @@ static ssize_t show_crit_alarm(struct device *dev,
 	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct core_data *tdata = pdata->core_data[attr->index];
 
 	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 
@@ -169,7 +169,7 @@ static ssize_t show_temp(struct device *dev,
 	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct core_data *tdata = pdata->core_data[attr->index];
 
 	mutex_lock(&tdata->update_lock);
 
@@ -367,7 +367,7 @@ static int create_name_attr(struct platform_data *pdata,
 	return device_create_file(dev, &pdata->name_attr);
 }
 
-static int __cpuinit create_core_attrs(struct temp_data *tdata,
+static int __cpuinit create_core_attrs(struct core_data *tdata,
 				       struct device *dev, int attr_no)
 {
 	int err, i;
@@ -435,12 +435,12 @@ static struct platform_device __cpuinit *coretemp_get_pdev(unsigned int cpu)
 	return NULL;
 }
 
-static struct temp_data __cpuinit *init_temp_data(unsigned int cpu,
-						  int pkg_flag)
+static struct core_data __cpuinit *init_core_data(unsigned int cpu,
+						  bool pkg_flag)
 {
-	struct temp_data *tdata;
+	struct core_data *tdata;
 
-	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
+	tdata = kzalloc(sizeof(struct core_data), GFP_KERNEL);
 	if (!tdata)
 		return NULL;
 
@@ -455,9 +455,9 @@ static struct temp_data __cpuinit *init_temp_data(unsigned int cpu,
 }
 
 static int __cpuinit create_core_data(struct platform_device *pdev,
-				unsigned int cpu, int pkg_flag)
+				unsigned int cpu, bool pkg_flag)
 {
-	struct temp_data *tdata;
+	struct core_data *tdata;
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
@@ -484,7 +484,7 @@ static int __cpuinit create_core_data(struct platform_device *pdev,
 	if (pdata->core_data[attr_no] != NULL)
 		return 0;
 
-	tdata = init_temp_data(cpu, pkg_flag);
+	tdata = init_core_data(cpu, pkg_flag);
 	if (!tdata)
 		return -ENOMEM;
 
@@ -525,7 +525,7 @@ exit_free:
 	return err;
 }
 
-static void __cpuinit coretemp_add_core(unsigned int cpu, int pkg_flag)
+static void __cpuinit coretemp_add_core(unsigned int cpu, bool pkg_flag)
 {
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
 	int err;
@@ -542,7 +542,7 @@ static void coretemp_remove_core(struct platform_data *pdata,
 				struct device *dev, int indx)
 {
 	int i;
-	struct temp_data *tdata = pdata->core_data[indx];
+	struct core_data *tdata = pdata->core_data[indx];
 
 	/* Remove the sysfs attributes */
 	for (i = 0; i < tdata->attr_size; i++)
@@ -717,13 +717,13 @@ static void __cpuinit get_core_online(unsigned int cpu)
 		 * If so, add interfaces for pkgtemp.
 		 */
 		if (cpu_has(c, X86_FEATURE_PTS))
-			coretemp_add_core(cpu, 1);
+			coretemp_add_core(cpu, true);
 	}
 	/*
 	 * Physical CPU device already exists.
 	 * So, just add interfaces for this core.
 	 */
-	coretemp_add_core(cpu, 0);
+	coretemp_add_core(cpu, false);
 }
 
 static void __cpuinit put_core_offline(unsigned int cpu)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
