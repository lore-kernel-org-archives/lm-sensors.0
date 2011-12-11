From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 11 Dec 2011 13:17:40 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Add missing section
Message-Id: <20111211141740.4edc53f0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Many functions in the coretemp driver lack a proper section
annotation. Add them to let the kernel free the memory after
initialization when possible.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Durgadoss R <durgadoss.r@intel.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/hwmon/coretemp.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- linux-3.2-rc4.orig/drivers/hwmon/coretemp.c	2011-12-01 10:30:28.000000000 +0100
+++ linux-3.2-rc4/drivers/hwmon/coretemp.c	2011-12-05 18:14:34.000000000 +0100
@@ -191,7 +191,8 @@ static ssize_t show_temp(struct device *
 	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
 }
 
-static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
+static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
+				  struct device *dev)
 {
 	/* The 100C is default for both mobile and non mobile CPUs */
 
@@ -285,7 +286,8 @@ static int adjust_tjmax(struct cpuinfo_x
 	return tjmax;
 }
 
-static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
+static int __cpuinit get_tjmax(struct cpuinfo_x86 *c, u32 id,
+			       struct device *dev)
 {
 	int err;
 	u32 eax, edx;
@@ -324,7 +326,8 @@ static int get_tjmax(struct cpuinfo_x86
 	return adjust_tjmax(c, id, dev);
 }
 
-static int create_name_attr(struct platform_data *pdata, struct device *dev)
+static int __devinit create_name_attr(struct platform_data *pdata,
+				      struct device *dev)
 {
 	sysfs_attr_init(&pdata->name_attr.attr);
 	pdata->name_attr.attr.name = "name";
@@ -333,8 +336,8 @@ static int create_name_attr(struct platf
 	return device_create_file(dev, &pdata->name_attr);
 }
 
-static int create_core_attrs(struct temp_data *tdata, struct device *dev,
-				int attr_no)
+static int __cpuinit create_core_attrs(struct temp_data *tdata,
+				       struct device *dev, int attr_no)
 {
 	int err, i;
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
@@ -384,7 +387,7 @@ static int __cpuinit chk_ucode_version(u
 	return 0;
 }
 
-static struct platform_device *coretemp_get_pdev(unsigned int cpu)
+static struct platform_device __cpuinit *coretemp_get_pdev(unsigned int cpu)
 {
 	u16 phys_proc_id = TO_PHYS_ID(cpu);
 	struct pdev_entry *p;
@@ -401,7 +404,8 @@ static struct platform_device *coretemp_
 	return NULL;
 }
 
-static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
+static struct temp_data __cpuinit *init_temp_data(unsigned int cpu,
+						  int pkg_flag)
 {
 	struct temp_data *tdata;
 
@@ -419,7 +423,7 @@ static struct temp_data *init_temp_data(
 	return tdata;
 }
 
-static int create_core_data(struct platform_device *pdev,
+static int __cpuinit create_core_data(struct platform_device *pdev,
 				unsigned int cpu, int pkg_flag)
 {
 	struct temp_data *tdata;
@@ -490,7 +494,7 @@ exit_free:
 	return err;
 }
 
-static void coretemp_add_core(unsigned int cpu, int pkg_flag)
+static void __cpuinit coretemp_add_core(unsigned int cpu, int pkg_flag)
 {
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
 	int err;
@@ -619,7 +623,7 @@ exit:
 	return err;
 }
 
-static void coretemp_device_remove(unsigned int cpu)
+static void __cpuinit coretemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
 	u16 phys_proc_id = TO_PHYS_ID(cpu);
@@ -635,7 +639,7 @@ static void coretemp_device_remove(unsig
 	mutex_unlock(&pdev_list_mutex);
 }
 
-static bool is_any_core_online(struct platform_data *pdata)
+static bool __cpuinit is_any_core_online(struct platform_data *pdata)
 {
 	int i;
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
