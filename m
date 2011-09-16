From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Sep 2011 19:21:43 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (coretemp) Drop duplicate function
Message-Id: <20110916212143.557f8495@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Function get_pkg_tjmax is a simplified copy of get_tjmax. Drop it and
always use get_tjmax, result is the same and this avoids code
duplication.

Also make get_tjmax less verbose: don't warn about MSR read failure
when failure was expected, and don't report TjMax in the logs unless
debugging is enabled.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/hwmon/coretemp.c |   26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

--- linux-3.1-rc4.orig/drivers/hwmon/coretemp.c	2011-09-15 14:27:41.000000000 +0200
+++ linux-3.1-rc4/drivers/hwmon/coretemp.c	2011-09-15 14:50:46.000000000 +0200
@@ -374,7 +374,6 @@ static int adjust_tjmax(struct cpuinfo_x
 
 static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 {
-	/* The 100C is default for both mobile and non mobile CPUs */
 	int err;
 	u32 eax, edx;
 	u32 val;
@@ -385,7 +384,8 @@ static int get_tjmax(struct cpuinfo_x86
 	 */
 	err = rdmsr_safe_on_cpu(id, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
 	if (err) {
-		dev_warn(dev, "Unable to read TjMax from CPU.\n");
+		if (c->x86_model > 0xe && c->x86_model != 0x1c)
+			dev_warn(dev, "Unable to read TjMax from CPU %u\n", id);
 	} else {
 		val = (eax >> 16) & 0xff;
 		/*
@@ -393,7 +393,7 @@ static int get_tjmax(struct cpuinfo_x86
 		 * will be used
 		 */
 		if (val) {
-			dev_info(dev, "TjMax is %d C.\n", val);
+			dev_dbg(dev, "TjMax is %d degrees C\n", val);
 			return val * 1000;
 		}
 	}
@@ -414,21 +414,6 @@ static void __devinit get_ucode_rev_on_c
 	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
 }
 
-static int get_pkg_tjmax(unsigned int cpu, struct device *dev)
-{
-	int err;
-	u32 eax, edx, val;
-
-	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
-	if (!err) {
-		val = (eax >> 16) & 0xff;
-		if (val)
-			return val * 1000;
-	}
-	dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%u\n", cpu);
-	return 100000; /* Default TjMax: 100 degree celsius */
-}
-
 static int create_name_attr(struct platform_data *pdata, struct device *dev)
 {
 	sysfs_attr_init(&pdata->name_attr.attr);
@@ -588,10 +573,7 @@ static int create_core_data(struct platf
 		goto exit_free;
 
 	/* We can access status register. Get Critical Temperature */
-	if (pkg_flag)
-		tdata->tjmax = get_pkg_tjmax(pdev->id, &pdev->dev);
-	else
-		tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
+	tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
 
 	/*
 	 * Test if we can access the intrpt register. If so, increase the


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
