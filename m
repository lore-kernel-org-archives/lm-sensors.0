From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 07 Feb 2013 02:49:10 +0000
Subject: [lm-sensors] [PATCH v4] hwmon: (coretemp) Report package power and energy consumption
Message-Id: <1360205350-15764-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Supported by SandyBridge and newer CPUs.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Replaced INIT_DELAYED_WORK with INIT_DEFERRABLE_WORK
v3: Added Cc:
v2: Fix missing symbol error on i386 builds
    Dropped leftover pr_info from debugging

I dropped this patch from my -next queue. The potential negative impact
due to scheduled work especially in suspend situations is too risky
without feedback and review by others.

 Documentation/hwmon/coretemp |    6 ++
 drivers/hwmon/coretemp.c     |  188 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index fec5a9b..a6b75b5 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -43,6 +43,12 @@ tempX_crit_alarm - Set when Out-of-spec bit is set, never clears.
 tempX_label	 - Contains string "Core X", where X is processor
 		   number. For Package temp, this will be "Physical id Y",
 		   where Y is the package number.
+energyX_input	 - Package energy consumption since driver was loaded
+powerX_cap	 - Package power limit
+powerX_cap_max	 - Maximum value for powerX_cap
+powerX_cap_min	 - Minimum value for powerX_cap
+powerX_input	 - Package power consumption
+powerX_max	 - Maximum package power
 
 On CPU models which support it, TjMax is read from a model-specific register.
 On other models, it is set to an arbitrary value based on weak heuristics.
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 02ac401..51f537b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
-#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
+#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 9)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
 #define TO_PHYS_ID(cpu)		(cpu_data(cpu).phys_proc_id)
@@ -79,6 +79,15 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
  * @is_pkg_data: If this is true, the core_data holds pkgtemp data.
  *		Otherwise, core_data holds coretemp data.
  * @valid: If this is true, the current temperature is valid.
+ * @has_rapl:		true if the CPU supports RAPL (power measurement)
+ * @rapl_power_units:	Units of power as reported by the chip
+ * @rapl_energy_units:	Units of energy as reported by the chip
+ * @rapl_energy_raw:	Most recent energy measurement (raw)
+ * @rapl_energy:	cumulative energy (mJ)
+ * @rapl_power:		current power usage (mW)
+ * @rapl_power_max:	maximum power (mW) as reported by the chip
+ * @rapl_power_cap_min:	minimum power limit (mW) as reported by the chip
+ * @rapl_power_cap_max:	maximum power limit (mW) as reported by the chip
  */
 struct core_data {
 	int temp;
@@ -94,6 +103,17 @@ struct core_data {
 	struct sensor_device_attribute sd_attrs[TOTAL_ATTRS];
 	char attr_name[TOTAL_ATTRS][CORETEMP_NAME_LENGTH];
 	struct mutex update_lock;
+	/* power values */
+	bool has_rapl;
+	u32 rapl_power_units;
+	u32 rapl_energy_units;
+	u32 rapl_energy_raw;
+	u64 rapl_energy;
+	u32 rapl_power;
+	u32 rapl_power_max;
+	u32 rapl_power_cap_min;
+	u32 rapl_power_cap_max;
+	struct delayed_work rapl_wq;
 };
 
 /* Platform Data per Physical CPU */
@@ -132,6 +152,26 @@ static ssize_t show_label(struct device *dev,
 	return sprintf(buf, "Core %u\n", tdata->cpu_core_id);
 }
 
+static ssize_t show_power_label(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct core_data *tdata = pdata->core_data[attr->index];
+
+	return sprintf(buf, "Pkg %u power\n", tdata->cpu_core_id);
+}
+
+static ssize_t show_energy_label(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct core_data *tdata = pdata->core_data[attr->index];
+
+	return sprintf(buf, "Pkg %u energy\n", tdata->cpu_core_id);
+}
+
 static ssize_t show_crit_alarm(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
@@ -190,6 +230,73 @@ static ssize_t show_temp(struct device *dev,
 	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
 }
 
+static ssize_t show_power(struct device *dev,
+			  struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n",
+		       pdata->core_data[attr->index]->rapl_power * 1000);
+}
+
+static ssize_t show_power_max(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct core_data *tdata = pdata->core_data[attr->index];
+
+	return sprintf(buf, "%u\n", tdata->rapl_power_max * 1000);
+}
+
+static ssize_t show_power_cap(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct core_data *tdata = pdata->core_data[attr->index];
+	u32 cap1, cap2, eax, edx;
+	u64 cap;
+
+	rdmsr_on_cpu(tdata->cpu, MSR_PKG_POWER_LIMIT, &eax, &edx);
+	cap1 = (eax & 0x8000) ? (eax & 0x7fff) : 0;
+	cap2 = (edx & 0x8000) ? (edx & 0x7fff) : 0;
+	cap = (max(cap1, cap2) * 1000000LL) >> tdata->rapl_power_units;
+
+	return sprintf(buf, "%llu\n", cap);
+}
+
+static ssize_t show_power_cap_min(struct device *dev,
+				  struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct core_data *tdata = pdata->core_data[attr->index];
+
+	return sprintf(buf, "%u\n", tdata->rapl_power_cap_min * 1000);
+}
+
+static ssize_t show_power_cap_max(struct device *dev,
+				  struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct core_data *tdata = pdata->core_data[attr->index];
+
+	return sprintf(buf, "%u\n", tdata->rapl_power_cap_max * 1000);
+}
+
+static ssize_t show_energy(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct core_data *tdata = pdata->core_data[attr->index];
+
+	return sprintf(buf, "%llu\n", tdata->rapl_energy * 1000ULL);
+}
+
 struct tjmax {
 	char const *id;
 	int tjmax;
@@ -374,11 +481,17 @@ static int __cpuinit create_core_attrs(struct core_data *tdata,
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
 			struct device_attribute *devattr, char *buf) = {
 			show_label, show_crit_alarm, show_temp, show_tjmax,
-			show_ttarget };
+			show_ttarget, show_power_label, show_power,
+			show_power_max, show_power_cap, show_power_cap_min,
+			show_power_cap_max, show_energy_label, show_energy };
 	static const char *const names[TOTAL_ATTRS] = {
 					"temp%d_label", "temp%d_crit_alarm",
 					"temp%d_input", "temp%d_crit",
-					"temp%d_max" };
+					"temp%d_max", "power%d_label",
+					"power%d_input", "power%d_max",
+					"power%d_cap", "power%d_cap_min",
+					"power%d_cap_max", "energy%d_label",
+					"energy%d_input" };
 
 	for (i = 0; i < tdata->attr_size; i++) {
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
@@ -454,6 +567,66 @@ static struct core_data __cpuinit *init_core_data(unsigned int cpu,
 	return tdata;
 }
 
+static u32 coretemp_delta_wrap(u32 new, u32 old)
+{
+	if (new > old)
+		return new - old;
+	return 0x100000000LL + new - old;
+}
+
+static void coretemp_rapl_work(struct work_struct *work)
+{
+	struct core_data *tdata = container_of(work, struct core_data,
+					       rapl_wq.work);
+	u32 eax, edx;
+	u32 delta;
+	u32 power;
+
+	rdmsr_on_cpu(tdata->cpu, MSR_PKG_ENERGY_STATUS, &eax, &edx);
+	delta = coretemp_delta_wrap(eax, tdata->rapl_energy_raw);
+	tdata->rapl_energy_raw = eax;
+
+	power = (delta * 1000LL) >> tdata->rapl_energy_units;
+	tdata->rapl_power = power;
+	tdata->rapl_energy += power;
+
+	schedule_delayed_work(&tdata->rapl_wq, HZ);
+}
+
+static void coretemp_init_rapl(struct platform_device *pdev,
+			       int cpu, struct core_data *tdata)
+{
+	u32 eax, edx;
+	int err;
+
+	/* Test if we can access rapl registers */
+	err = rdmsr_safe_on_cpu(cpu, MSR_RAPL_POWER_UNIT, &eax, &edx);
+	if (err)
+		return;
+
+	tdata->rapl_power_units = eax & 0x000f;
+	tdata->rapl_energy_units = (eax >> 8) & 0x001f;
+
+	err = rdmsr_safe_on_cpu(cpu, MSR_PKG_POWER_INFO, &eax, &edx);
+	if (err)
+		return;
+
+	tdata->rapl_power_cap_min +	  (((eax >> 16) & 0x7fff) * 1000) >> tdata->rapl_power_units;
+
+	tdata->rapl_power_cap_max = tdata->rapl_power_max +	  ((edx & 0x7fff) * 1000) >> tdata->rapl_power_units;
+
+	rdmsr_on_cpu(tdata->cpu, MSR_PKG_ENERGY_STATUS, &eax, &edx);
+	tdata->rapl_energy_raw = eax;
+	tdata->rapl_energy = (eax * 1000LL) >> tdata->rapl_energy_units;
+
+	INIT_DEFERRABLE_WORK(&tdata->rapl_wq, coretemp_rapl_work);
+
+	tdata->has_rapl = true;
+	tdata->attr_size += 8;
+}
+
 static int __cpuinit create_core_data(struct platform_device *pdev,
 				unsigned int cpu, bool pkg_flag)
 {
@@ -511,6 +684,9 @@ static int __cpuinit create_core_data(struct platform_device *pdev,
 		}
 	}
 
+	if (pkg_flag)
+		coretemp_init_rapl(pdev, cpu, tdata);
+
 	pdata->core_data[attr_no] = tdata;
 
 	/* Create sysfs interfaces */
@@ -518,6 +694,9 @@ static int __cpuinit create_core_data(struct platform_device *pdev,
 	if (err)
 		goto exit_free;
 
+	if (tdata->has_rapl)
+		schedule_delayed_work(&tdata->rapl_wq, HZ);
+
 	return 0;
 exit_free:
 	pdata->core_data[attr_no] = NULL;
@@ -544,6 +723,9 @@ static void coretemp_remove_core(struct platform_data *pdata,
 	int i;
 	struct core_data *tdata = pdata->core_data[indx];
 
+	if (tdata->has_rapl)
+		cancel_delayed_work(&tdata->rapl_wq);
+
 	/* Remove the sysfs attributes */
 	for (i = 0; i < tdata->attr_size; i++)
 		device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
