From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 May 2011 14:48:00 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Fix checkpatch errors
Message-Id: <1305902880-11414-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix remaining checkpatch errors in the coretemp driver.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/hwmon/coretemp.c |   66 +++++++++++++++++++++++++--------------------
 1 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ece3b7d..649d87d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -37,7 +37,7 @@
 #include <linux/pci.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
-#include <asm/smp.h>
+#include <linux/smp.h>
 
 #define DRVNAME	"coretemp"
 
@@ -170,7 +170,7 @@ static ssize_t show_temp(struct device *dev,
 		/* Check whether the data is valid */
 		if (eax & 0x80000000) {
 			tdata->temp = tdata->tjmax -
-					(((eax >> 16) & 0x7f) * 1000);
+					((eax >> 16) & 0x7f) * 1000;
 			tdata->valid = 1;
 		}
 		tdata->last_updated = jiffies;
@@ -193,9 +193,8 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 
 	/* Early chips have no MSR for TjMax */
 
-	if ((c->x86_model = 0xf) && (c->x86_mask < 4)) {
+	if (c->x86_model = 0xf && c->x86_mask < 4)
 		usemsr_ee = 0;
-	}
 
 	/* Atom CPUs */
 
@@ -214,14 +213,14 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 		pci_dev_put(host_bridge);
 	}
 
-	if ((c->x86_model > 0xe) && (usemsr_ee)) {
+	if (c->x86_model > 0xe && usemsr_ee) {
 		u8 platform_id;
 
-		/* Now we can detect the mobile CPU using Intel provided table
-		   http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
-		   For Core2 cores, check MSR 0x17, bit 28 1 = Mobile CPU
-		*/
-
+		/*
+		 * Now we can detect the mobile CPU using Intel provided table
+		 * http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
+		 * For Core2 cores, check MSR 0x17, bit 28 1 = Mobile CPU
+		 */
 		err = rdmsr_safe_on_cpu(id, 0x17, &eax, &edx);
 		if (err) {
 			dev_warn(dev,
@@ -229,20 +228,26 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 				 " CPU\n");
 			usemsr_ee = 0;
 		} else if (c->x86_model < 0x17 && !(eax & 0x10000000)) {
-			/* Trust bit 28 up to Penryn, I could not find any
-			   documentation on that; if you happen to know
-			   someone at Intel please ask */
+			/*
+			 * Trust bit 28 up to Penryn, I could not find any
+			 * documentation on that; if you happen to know
+			 * someone at Intel please ask
+			 */
 			usemsr_ee = 0;
 		} else {
 			/* Platform ID bits 52:50 (EDX starts at bit 32) */
 			platform_id = (edx >> 18) & 0x7;
 
-			/* Mobile Penryn CPU seems to be platform ID 7 or 5
-			  (guesswork) */
-			if ((c->x86_model = 0x17) &&
-			    ((platform_id = 5) || (platform_id = 7))) {
-				/* If MSR EE bit is set, set it to 90 degrees C,
-				   otherwise 105 degrees C */
+			/*
+			 * Mobile Penryn CPU seems to be platform ID 7 or 5
+			 * (guesswork)
+			 */
+			if (c->x86_model = 0x17 &&
+			    (platform_id = 5 || platform_id = 7)) {
+				/*
+				 * If MSR EE bit is set, set it to 90 degrees C,
+				 * otherwise 105 degrees C
+				 */
 				tjmax_ee = 90000;
 				tjmax = 105000;
 			}
@@ -259,8 +264,10 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 		} else if (eax & 0x40000000) {
 			tjmax = tjmax_ee;
 		}
-	/* if we dont use msr EE it means we are desktop CPU (with exeception
-	   of Atom) */
+	/*
+	 * if we dont use msr EE it means we are desktop CPU (with exeception
+	 * of Atom)
+	 */
 	} else if (tjmax = 100000) {
 		dev_warn(dev, "Using relative temperature scale!\n");
 	}
@@ -275,8 +282,10 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	u32 eax, edx;
 	u32 val;
 
-	/* A new feature of current Intel(R) processors, the
-	   IA32_TEMPERATURE_TARGET contains the TjMax value */
+	/*
+	 * A new feature of current Intel(R) processors, the
+	 * IA32_TEMPERATURE_TARGET contains the TjMax value
+	 */
 	err = rdmsr_safe_on_cpu(id, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
 	if (err) {
 		dev_warn(dev, "Unable to read TjMax from CPU.\n");
@@ -286,7 +295,7 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 		 * If the TjMax is not plausible, an assumption
 		 * will be used
 		 */
-		if ((val > 80) && (val < 120)) {
+		if (val > 80 && val < 120) {
 			dev_info(dev, "TjMax is %d C.\n", val);
 			return val * 1000;
 		}
@@ -331,7 +340,7 @@ static int get_pkg_tjmax(unsigned int cpu, struct device *dev)
 	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
 	if (!err) {
 		val = (eax >> 16) & 0xff;
-		if ((val > 80) && (val < 120))
+		if (val > 80 && val < 120)
 			return val * 1000;
 	}
 	dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%u\n", cpu);
@@ -399,7 +408,7 @@ static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
 	 * on older CPUs but not in this register,
 	 * Atoms don't have it either.
 	 */
-	if ((cpu_model > 0xe) && (cpu_model != 0x1c)) {
+	if (cpu_model > 0xe && cpu_model != 0x1c) {
 		err = rdmsr_safe_on_cpu(tdata->cpu,
 				MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
 		if (err) {
@@ -407,7 +416,7 @@ static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
 			"Unable to read IA32_TEMPERATURE_TARGET MSR\n");
 		} else {
 			tdata->ttarget = tdata->tjmax -
-					(((eax >> 8) & 0xff) * 1000);
+					((eax >> 8) & 0xff) * 1000;
 		}
 	}
 }
@@ -423,7 +432,7 @@ static int chk_ucode_version(struct platform_device *pdev)
 	 * Readings might stop update when processor visited too deep sleep,
 	 * fixed for stepping D0 (6EC).
 	 */
-	if ((c->x86_model = 0xe) && (c->x86_mask < 0xc)) {
+	if (c->x86_model = 0xe && c->x86_mask < 0xc) {
 		/* check for microcode update */
 		err = smp_call_function_single(pdev->id, get_ucode_rev_on_cpu,
 					       &edx, 1);
@@ -791,7 +800,6 @@ static struct notifier_block coretemp_cpu_notifier __refdata = {
 	.notifier_call = coretemp_cpu_callback,
 };
 
-
 static int __init coretemp_init(void)
 {
 	int i, err = -ENODEV;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
