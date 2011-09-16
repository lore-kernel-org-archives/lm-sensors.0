From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Sep 2011 19:24:02 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Let the user force TjMax
Message-Id: <20110916212402.41fc972c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On old CPUs (and even some recent Atom CPUs) TjMax can't be read from
the CPU registers, so it is guessed by the driver using a complex
heuristic which isn't reliable. So let users who know their CPU's
TjMax pass it as a module parameter.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>
---
 Documentation/hwmon/coretemp |    7 ++++---
 drivers/hwmon/coretemp.c     |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

--- linux-3.1-rc4.orig/drivers/hwmon/coretemp.c	2011-09-15 14:50:46.000000000 +0200
+++ linux-3.1-rc4/drivers/hwmon/coretemp.c	2011-09-16 18:35:18.000000000 +0200
@@ -36,11 +36,20 @@
 #include <linux/cpu.h>
 #include <linux/pci.h>
 #include <linux/smp.h>
+#include <linux/moduleparam.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
 
 #define DRVNAME	"coretemp"
 
+/*
+ * force_tjmax only matters when TjMax can't be read from the CPU itself.
+ * When set, it replaces the driver's suboptimal heuristic.
+ */
+static int force_tjmax;
+module_param_named(tjmax, force_tjmax, int, 0444);
+MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
+
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		16	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
@@ -398,6 +407,12 @@ static int get_tjmax(struct cpuinfo_x86
 		}
 	}
 
+	if (force_tjmax) {
+		dev_notice(dev, "TjMax forced to %d degrees C by user\n",
+			   force_tjmax);
+		return force_tjmax * 1000;
+	}
+
 	/*
 	 * An assumption is made for early CPUs and unreadable MSR.
 	 * NOTE: the calculated value may not be correct.
--- linux-3.1-rc4.orig/Documentation/hwmon/coretemp	2011-08-16 11:49:35.000000000 +0200
+++ linux-3.1-rc4/Documentation/hwmon/coretemp	2011-09-16 18:26:19.000000000 +0200
@@ -49,9 +49,10 @@ tempX_label	 - Contains string "Core X",
 		   number. For Package temp, this will be "Physical id Y",
 		   where Y is the package number.
 
-The TjMax temperature is set to 85 degrees C if undocumented model specific
-register (UMSR) 0xee has bit 30 set. If not the TjMax is 100 degrees C as
-(sometimes) documented in processor datasheet.
+On CPU models which support it, TjMax is read from a model-specific register.
+On other models, it is set to an arbitrary value based on weak heuristics.
+If these heuristics don't work for you, you can pass the correct TjMax value
+as a module parameter (tjmax).
 
 Appendix A. Known TjMax lists (TBD):
 Some information comes from ark.intel.com


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
