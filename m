From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 20 Sep 2011 05:22:02 +0000
Subject: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Fix threshold attribute
Message-Id: <1316496122-20796-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Starting with 3.1, meaning of some coretemp attributes was changed. tempX_max
no longer returns the value of the undocumented register
MSR_IA32_TEMPERATURE_TARGET, but instead returns the value of CPU threshold
register T1. tempX_max_hyst was added to reflect the value of temperature
threshold register T0.

As it turns out, T0 and T1 are used on some systems, presumably by the BIOS.
Also, T0 and T1 don't have a well defined meaning. The thresholds may be used
as upper or lower limits, and it is not guaranteed that T0 <= T1. Thus, the new
attribute mapping does not reflect the actual usage of the threshold registers.

To solve the problem, restore the old meaning of tempX_max to reflect the value
of MSR_IA32_TEMPERATURE_TARGET if it exists. Add new attributes tempX_threshold1
and tempX_threshold2 to reflect the values of T0 and T1. Also add new attributes
tempX_threshold1_triggered and tempX_threshold2_triggered to reflect that the
temperature is equal or higher than the threshold, as reflected by the
THERM_STATUS_THRESHOLD[01] bits in the CPU status register.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Tested on one system only so far. I'll do some more testing tomorrow, but it is
getting late and I really want to get some feedback.

Key question is if we want to submit this as-is for 3.1, or if I should split it
into two parts, one to restore tempX_max to reflect ttarget for 3.1, and the
other to introduce the thresholds for 3.2.

 drivers/hwmon/coretemp.c |  166 +++++++++++++++++++++++++++-------------------
 1 files changed, 99 insertions(+), 67 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5a41e9d..d4f261b 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -52,9 +52,9 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		16	/* Number of Real cores per cpu */
-#define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
-#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
-#define MAX_THRESH_ATTRS	3	/* Maximum no of Threshold attrs */
+#define CORETEMP_NAME_LENGTH	33	/* String Length of attrs */
+#define MAX_CORE_ATTRS		5	/* Maximum no of basic attrs */
+#define MAX_THRESH_ATTRS	4	/* Maximum no of Threshold attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + MAX_THRESH_ATTRS)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
@@ -88,7 +88,6 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 struct temp_data {
 	int temp;
 	int ttarget;
-	int tmin;
 	int tjmax;
 	unsigned long last_updated;
 	unsigned int cpu;
@@ -152,8 +151,9 @@ static ssize_t show_crit_alarm(struct device *dev,
 	return sprintf(buf, "%d\n", (eax >> 5) & 1);
 }
 
-static ssize_t show_max_alarm(struct device *dev,
-				struct device_attribute *devattr, char *buf)
+static ssize_t show_tx_triggered(struct device *dev,
+				 struct device_attribute *devattr, char *buf,
+				 u32 mask)
 {
 	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -162,7 +162,19 @@ static ssize_t show_max_alarm(struct device *dev,
 
 	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 
-	return sprintf(buf, "%d\n", !!(eax & THERM_STATUS_THRESHOLD1));
+	return sprintf(buf, "%d\n", !!(eax & mask));
+}
+
+static ssize_t show_t0_triggered(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	return show_tx_triggered(dev, devattr, buf, THERM_STATUS_THRESHOLD0);
+}
+
+static ssize_t show_t1_triggered(struct device *dev,
+				 struct device_attribute *devattr, char *buf)
+{
+	return show_tx_triggered(dev, devattr, buf, THERM_STATUS_THRESHOLD1);
 }
 
 static ssize_t show_tjmax(struct device *dev,
@@ -183,52 +195,25 @@ static ssize_t show_ttarget(struct device *dev,
 	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget);
 }
 
-static ssize_t store_ttarget(struct device *dev,
-				struct device_attribute *devattr,
-				const char *buf, size_t count)
+static ssize_t show_tx(struct device *dev,
+		       struct device_attribute *devattr, char *buf,
+		       u32 mask, int shift)
 {
 	struct platform_data *pdata = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct temp_data *tdata = pdata->core_data[attr->index];
 	u32 eax, edx;
-	unsigned long val;
-	int diff;
-
-	if (strict_strtoul(buf, 10, &val))
-		return -EINVAL;
-
-	/*
-	 * THERM_MASK_THRESHOLD1 is 7 bits wide. Values are entered in terms
-	 * of milli degree celsius. Hence don't accept val > (127 * 1000)
-	 */
-	if (val > tdata->tjmax || val > 127000)
-		return -EINVAL;
+	int t;
 
-	diff = (tdata->tjmax - val) / 1000;
-
-	mutex_lock(&tdata->update_lock);
 	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
-	eax = (eax & ~THERM_MASK_THRESHOLD1) |
-				(diff << THERM_SHIFT_THRESHOLD1);
-	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);
-	tdata->ttarget = val;
-	mutex_unlock(&tdata->update_lock);
-
-	return count;
-}
-
-static ssize_t show_tmin(struct device *dev,
-			struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct platform_data *pdata = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->tmin);
+	t = tdata->tjmax - ((eax & mask) >> shift) * 1000;
+	return sprintf(buf, "%d\n", t);
 }
 
-static ssize_t store_tmin(struct device *dev,
-				struct device_attribute *devattr,
-				const char *buf, size_t count)
+static ssize_t store_tx(struct device *dev,
+			struct device_attribute *devattr,
+			const char *buf, size_t count,
+			u32 mask, int shift)
 {
 	struct platform_data *pdata = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -241,7 +226,7 @@ static ssize_t store_tmin(struct device *dev,
 		return -EINVAL;
 
 	/*
-	 * THERM_MASK_THRESHOLD0 is 7 bits wide. Values are entered in terms
+	 * Thermal threshold mask is 7 bits wide. Values are entered in terms
 	 * of milli degree celsius. Hence don't accept val > (127 * 1000)
 	 */
 	if (val > tdata->tjmax || val > 127000)
@@ -251,15 +236,43 @@ static ssize_t store_tmin(struct device *dev,
 
 	mutex_lock(&tdata->update_lock);
 	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
-	eax = (eax & ~THERM_MASK_THRESHOLD0) |
-				(diff << THERM_SHIFT_THRESHOLD0);
+	eax = (eax & ~mask) | (diff << shift);
 	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);
-	tdata->tmin = val;
 	mutex_unlock(&tdata->update_lock);
 
 	return count;
 }
 
+static ssize_t show_t0(struct device *dev,
+		       struct device_attribute *devattr, char *buf)
+{
+	return show_tx(dev, devattr, buf, THERM_MASK_THRESHOLD0,
+		       THERM_SHIFT_THRESHOLD0);
+}
+
+static ssize_t store_t0(struct device *dev,
+			struct device_attribute *devattr,
+			const char *buf, size_t count)
+{
+	return store_tx(dev, devattr, buf, count, THERM_MASK_THRESHOLD0,
+			THERM_SHIFT_THRESHOLD0);
+}
+
+static ssize_t show_t1(struct device *dev,
+		       struct device_attribute *devattr, char *buf)
+{
+	return show_tx(dev, devattr, buf, THERM_MASK_THRESHOLD1,
+		       THERM_SHIFT_THRESHOLD1);
+}
+
+static ssize_t store_t1(struct device *dev,
+			struct device_attribute *devattr,
+			const char *buf, size_t count)
+{
+	return store_tx(dev, devattr, buf, count, THERM_MASK_THRESHOLD1,
+			THERM_SHIFT_THRESHOLD1);
+}
+
 static ssize_t show_temp(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
@@ -439,24 +452,30 @@ static int create_name_attr(struct platform_data *pdata, struct device *dev)
 }
 
 static int create_core_attrs(struct temp_data *tdata, struct device *dev,
-				int attr_no)
+				int attr_no, bool have_ttarget)
 {
 	int err, i;
 	static ssize_t (*rd_ptr[TOTAL_ATTRS]) (struct device *dev,
 			struct device_attribute *devattr, char *buf) = {
 			show_label, show_crit_alarm, show_temp, show_tjmax,
-			show_max_alarm, show_ttarget, show_tmin };
+			show_ttarget, show_t0, show_t0_triggered,
+			show_t1, show_t1_triggered };
 	static ssize_t (*rw_ptr[TOTAL_ATTRS]) (struct device *dev,
 			struct device_attribute *devattr, const char *buf,
 			size_t count) = { NULL, NULL, NULL, NULL, NULL,
-					store_ttarget, store_tmin };
+					store_t0, NULL, store_t1, NULL };
 	static const char *names[TOTAL_ATTRS] = {
 					"temp%d_label", "temp%d_crit_alarm",
 					"temp%d_input", "temp%d_crit",
-					"temp%d_max_alarm", "temp%d_max",
-					"temp%d_max_hyst" };
+					"temp%d_max",
+					"temp%d_threshold1",
+					"temp%d_threshold1_triggered",
+					"temp%d_threshold2",
+					"temp%d_threshold2_triggered" };
 
 	for (i = 0; i < tdata->attr_size; i++) {
+		if (rd_ptr[i] = show_ttarget && !!have_ttarget)
+			continue;
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
 			attr_no);
 		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
@@ -475,8 +494,11 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 	return 0;
 
 exit_free:
-	while (--i >= 0)
+	while (--i >= 0) {
+		if (!tdata->sd_attrs[i].dev_attr.attr.name)
+			continue;
 		device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
+	}
 	return err;
 }
 
@@ -556,6 +578,7 @@ static int create_core_data(struct platform_data *pdata,
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
 	int err, attr_no;
+	bool have_ttarget = false;
 
 	/*
 	 * Find attr number for sysfs:
@@ -591,25 +614,31 @@ static int create_core_data(struct platform_data *pdata,
 	tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
 
 	/*
-	 * Test if we can access the intrpt register. If so, increase the
-	 * 'size' enough to have ttarget/tmin/max_alarm interfaces.
-	 * Initialize ttarget with bits 16:22 of MSR_IA32_THERM_INTERRUPT
+	 * Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
+	 * on older CPUs but not in this register. Atoms don't have it either.
+	 */
+	if (c->x86_model > 0xe && c->x86_model != 0x1c) {
+		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
+					&eax, &edx);
+		if (!err) {
+			tdata->ttarget
+			  = tdata->tjmax - (((eax >> 8) & 0xff) * 1000);
+			have_ttarget = true;
+		}
+	}
+
+	/*
+	 * Test if we can access the intrpt register. If so, increase
+	 * 'size' enough to support t0 and t1 attributes.
 	 */
 	err = rdmsr_safe_on_cpu(cpu, tdata->intrpt_reg, &eax, &edx);
-	if (!err) {
+	if (!err)
 		tdata->attr_size += MAX_THRESH_ATTRS;
-		tdata->tmin = tdata->tjmax -
-			      ((eax & THERM_MASK_THRESHOLD0) >>
-			       THERM_SHIFT_THRESHOLD0) * 1000;
-		tdata->ttarget = tdata->tjmax -
-				 ((eax & THERM_MASK_THRESHOLD1) >>
-				  THERM_SHIFT_THRESHOLD1) * 1000;
-	}
 
 	pdata->core_data[attr_no] = tdata;
 
 	/* Create sysfs interfaces */
-	err = create_core_attrs(tdata, &pdev->dev, attr_no);
+	err = create_core_attrs(tdata, &pdev->dev, attr_no, have_ttarget);
 	if (err)
 		goto exit_free;
 
@@ -642,8 +671,11 @@ static void coretemp_remove_core(struct platform_data *pdata,
 	struct temp_data *tdata = pdata->core_data[indx];
 
 	/* Remove the sysfs attributes */
-	for (i = 0; i < tdata->attr_size; i++)
+	for (i = 0; i < tdata->attr_size; i++) {
+		if (!tdata->sd_attrs[i].dev_attr.attr.name)
+			continue;
 		device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
+	}
 
 	kfree(pdata->core_data[indx]);
 	pdata->core_data[indx] = NULL;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
