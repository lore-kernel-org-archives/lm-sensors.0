From: Lukasz Odzioba <lukasz.odzioba@intel.com>
Date: Wed, 15 Jul 2015 16:04:13 +0000
Subject: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1335971436-13903-1-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1335971436-13903-1-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fenghua.yu@intel.com
Cc: jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Lukasz Odzioba <lukasz.odzioba@intel.com>

Removes the limits of supported CPU cores and max core ID.


Patch is based on Kirill A. Shutemov's work from 2012.

Signed-off-by: Lukasz Odzioba <lukasz.odzioba@intel.com>
---
 drivers/hwmon/coretemp.c |  120 ++++++++++++++++++++++++++++-----------------
 1 files changed, 75 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 3e03379..c39ce14 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -52,11 +52,10 @@ module_param_named(tjmax, force_tjmax, int, 0444);
 MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	19	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
-#define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
+#define PACKAGE_ID		1	/* Magic number of physical cpu */
 
 #define TO_PHYS_ID(cpu)		(cpu_data(cpu).phys_proc_id)
 #define TO_CORE_ID(cpu)		(cpu_data(cpu).cpu_core_id)
@@ -71,18 +70,20 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 /*
  * Per-Core Temperature Data
+ * @id: If this is equal PACKAGE_ID, structure contains package temperature
+		data, otherwise it is just TO_ATTR_NO(cpu)
  * @last_updated: The time when the current temperature value was updated
  *		earlier (in jiffies).
  * @cpu_core_id: The CPU Core from which temperature values should be read
  *		This value is passed as "id" field to rdmsr/wrmsr functions.
  * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
  *		from where the temperature values should be read.
- * @attr_size:  Total number of pre-core attrs displayed in the sysfs.
- * @is_pkg_data: If this is 1, the temp_data holds pkgtemp data.
- *		Otherwise, temp_data holds coretemp data.
+ * @attr_size:  Total number of per-core attrs displayed in the sysfs.
  * @valid: If this is 1, the current temperature is valid.
  */
 struct temp_data {
+	struct list_head list;
+	int id;
 	int temp;
 	int ttarget;
 	int tjmax;
@@ -104,7 +105,8 @@ struct temp_data {
 struct platform_data {
 	struct device *hwmon_dev;
 	u16 phys_proc_id;
-	struct temp_data *core_data[MAX_CORE_DATA];
+	struct list_head temp_data_list;
+	struct mutex temp_data_lock;
 	struct device_attribute name_attr;
 };
 
@@ -117,12 +119,26 @@ struct pdev_entry {
 static LIST_HEAD(pdev_list);
 static DEFINE_MUTEX(pdev_list_mutex);
 
+static struct temp_data *get_temp_data(struct platform_data *pdata, int id)
+{
+	struct temp_data *tdata;
+
+	mutex_lock(&pdata->temp_data_lock);
+	list_for_each_entry(tdata, &pdata->temp_data_list, list)
+		if (tdata->id = id) {
+			mutex_unlock(&pdata->temp_data_lock);
+			return tdata;
+		}
+	mutex_unlock(&pdata->temp_data_lock);
+	return NULL;
+}
+
 static ssize_t show_label(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct temp_data *tdata = get_temp_data(pdata, attr->index);
 
 	if (tdata->is_pkg_data)
 		return sprintf(buf, "Physical id %u\n", pdata->phys_proc_id);
@@ -136,7 +152,7 @@ static ssize_t show_crit_alarm(struct device *dev,
 	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct temp_data *tdata = get_temp_data(pdata, attr->index);
 
 	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 
@@ -148,8 +164,9 @@ static ssize_t show_tjmax(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct temp_data *tdata = get_temp_data(pdata, attr->index);
 
-	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->tjmax);
+	return sprintf(buf, "%d\n", tdata->tjmax);
 }
 
 static ssize_t show_ttarget(struct device *dev,
@@ -157,8 +174,9 @@ static ssize_t show_ttarget(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct temp_data *tdata = get_temp_data(pdata, attr->index);
 
-	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget);
+	return sprintf(buf, "%d\n", tdata->ttarget);
 }
 
 static ssize_t show_temp(struct device *dev,
@@ -167,7 +185,7 @@ static ssize_t show_temp(struct device *dev,
 	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct temp_data *tdata = get_temp_data(pdata, attr->index);
 
 	mutex_lock(&tdata->update_lock);
 
@@ -468,7 +486,7 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
 	return tdata;
 }
 
-static int create_core_data(struct platform_device *pdev, unsigned int cpu,
+static int create_temp_data(struct platform_device *pdev, unsigned int cpu,
 			    int pkg_flag)
 {
 	struct temp_data *tdata;
@@ -483,10 +501,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	 * The attr number is always core id + 2
 	 * The Pkgtemp will always show up as temp1_*, if available
 	 */
-	attr_no = pkg_flag ? 1 : TO_ATTR_NO(cpu);
-
-	if (attr_no > MAX_CORE_DATA - 1)
-		return -ERANGE;
+	attr_no = pkg_flag ? PACKAGE_ID : TO_ATTR_NO(cpu);
 
 	/*
 	 * Provide a single set of attributes for all HT siblings of a core
@@ -495,7 +510,8 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	 * Skip if a HT sibling of this core is already registered.
 	 * This is not an error.
 	 */
-	if (pdata->core_data[attr_no] != NULL)
+	tdata = get_temp_data(pdata, attr_no);
+	if (tdata)
 		return 0;
 
 	tdata = init_temp_data(cpu, pkg_flag);
@@ -525,16 +541,28 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		}
 	}
 
-	pdata->core_data[attr_no] = tdata;
+	tdata->id = attr_no;
+
+	get_online_cpus();
+	mutex_lock(&pdata->temp_data_lock);
+	list_add(&tdata->list, &pdata->temp_data_list);
+	mutex_unlock(&pdata->temp_data_lock);
+	put_online_cpus();
 
 	/* Create sysfs interfaces */
 	err = create_core_attrs(tdata, pdata->hwmon_dev, attr_no);
 	if (err)
-		goto exit_free;
+		goto exit_del;
 
 	return 0;
+
+exit_del:
+	get_online_cpus();
+	mutex_lock(&pdata->temp_data_lock);
+	list_del(&tdata->list);
+	mutex_unlock(&pdata->temp_data_lock);
+	put_online_cpus();
 exit_free:
-	pdata->core_data[attr_no] = NULL;
 	kfree(tdata);
 	return err;
 }
@@ -547,21 +575,21 @@ static void coretemp_add_core(unsigned int cpu, int pkg_flag)
 	if (!pdev)
 		return;
 
-	err = create_core_data(pdev, cpu, pkg_flag);
+	err = create_temp_data(pdev, cpu, pkg_flag);
 	if (err)
 		dev_err(&pdev->dev, "Adding Core %u failed\n", cpu);
 }
 
 static void coretemp_remove_core(struct platform_data *pdata,
-				 int indx)
+					struct temp_data *tdata)
 {
-	struct temp_data *tdata = pdata->core_data[indx];
-
 	/* Remove the sysfs attributes */
 	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
 
-	kfree(pdata->core_data[indx]);
-	pdata->core_data[indx] = NULL;
+	mutex_lock(&pdata->temp_data_lock);
+	list_del(&tdata->list);
+	kfree(tdata);
+	mutex_unlock(&pdata->temp_data_lock);
 }
 
 static int coretemp_probe(struct platform_device *pdev)
@@ -575,6 +603,8 @@ static int coretemp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pdata->phys_proc_id = pdev->id;
+	INIT_LIST_HEAD(&pdata->temp_data_list);
+	mutex_init(&pdata->temp_data_lock);
 	platform_set_drvdata(pdev, pdata);
 
 	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
@@ -585,11 +615,12 @@ static int coretemp_probe(struct platform_device *pdev)
 static int coretemp_remove(struct platform_device *pdev)
 {
 	struct platform_data *pdata = platform_get_drvdata(pdev);
-	int i;
+	struct temp_data *cur, *tmp;
 
-	for (i = MAX_CORE_DATA - 1; i >= 0; --i)
-		if (pdata->core_data[i])
-			coretemp_remove_core(pdata, i);
+	get_online_cpus();
+	list_for_each_entry_safe(cur, tmp, &pdata->temp_data_list, list)
+		coretemp_remove_core(pdata, cur);
+	put_online_cpus();
 
 	return 0;
 }
@@ -664,15 +695,15 @@ static void coretemp_device_remove(unsigned int cpu)
 
 static bool is_any_core_online(struct platform_data *pdata)
 {
-	int i;
+	struct temp_data *tdata;
 
-	/* Find online cores, except pkgtemp data */
-	for (i = MAX_CORE_DATA - 1; i >= 0; --i) {
-		if (pdata->core_data[i] &&
-			!pdata->core_data[i]->is_pkg_data) {
+	mutex_lock(&pdata->temp_data_lock);
+	list_for_each_entry(tdata, &pdata->temp_data_list, list)
+		if (tdata->id != PACKAGE_ID) {
+			mutex_unlock(&pdata->temp_data_lock);
 			return true;
 		}
-	}
+	mutex_unlock(&pdata->temp_data_lock);
 	return false;
 }
 
@@ -720,9 +751,10 @@ static void get_core_online(unsigned int cpu)
 
 static void put_core_offline(unsigned int cpu)
 {
-	int i, indx;
+	int i, attr_no;
 	struct platform_data *pdata;
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
+	struct temp_data *tdata;
 
 	/* If the physical CPU device does not exist, just return */
 	if (!pdev)
@@ -730,15 +762,13 @@ static void put_core_offline(unsigned int cpu)
 
 	pdata = platform_get_drvdata(pdev);
 
-	indx = TO_ATTR_NO(cpu);
-
-	/* The core id is too big, just return */
-	if (indx > MAX_CORE_DATA - 1)
-		return;
-
-	if (pdata->core_data[indx] && pdata->core_data[indx]->cpu = cpu)
-		coretemp_remove_core(pdata, indx);
+	attr_no = TO_ATTR_NO(cpu);
 
+	get_online_cpus();
+	tdata = get_temp_data(pdata, attr_no);
+	if (tdata && tdata->cpu = cpu)
+		coretemp_remove_core(pdata, tdata);
+	put_online_cpus();
 	/*
 	 * If a HT sibling of a core is taken offline, but another HT sibling
 	 * of the same core is still online, register the alternate sibling.
-- 
1.7.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
