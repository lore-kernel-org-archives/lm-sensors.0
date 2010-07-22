From: Fenghua Yu <fenghua.yu@intel.com>
Date: Thu, 22 Jul 2010 16:22:23 +0000
Subject: [lm-sensors] [PATCH 5/5] Package Level Thermal Control and Power
Message-Id: <20100722162222.GA22450@linux-os.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <94E56C79ECC49A4B87113985F1FEBA8D03F8AE2A4B@bgsmsx502.gar.corp.intel.com> <4C485DF1.5050407@linux.intel.com>
In-Reply-To: <4C485DF1.5050407@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Huaxu Wan <huaxu.wan@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org


Document for package level thermal hwmon driver.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---

 pkgtemp |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

diff --git a/Documentation/hwmon/pkgtemp b/Documentation/hwmon/pkgtemp
new file mode 100644
index 0000000..a60d286
--- /dev/null
+++ b/Documentation/hwmon/pkgtemp
@@ -0,0 +1,36 @@
+Kernel driver pkgtemp
+===========
+
+Supported chips:
+  * Intel family
+    Prefix: 'pkgtemp'
+    CPUID:
+    Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
+               Volume 3A: System Programming Guide
+
+Author: Fenghua Yu
+
+Description
+-----------
+
+This driver permits reading package level temperature sensor embedded inside
+Intel CPU package. The sensors can be in core, uncore, memroy controller, or
+other componenets in a package. The feature is first implemented in Intel Sandy
+Bridge platform.
+
+Temperature is measured in degrees Celsius and measurement resolution is
+1 degree C. Valid temperatures are from 0 to TjMax degrees C, because the actual
+value of temperature register is in fact a delta from TjMax.
+
+Temperature known as TjMax is the maximum junction temperature of package.
+Intel defines this temperature as 125C. At this temperature, protection
+mechanism will perform actions to forcibly cool down the processor. Alarm
+may be raised, if the temperature grows enough (more than TjMax) to trigger
+the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
+
+temp1_input	 - Package temperature (in millidegrees Celsius).
+temp1_crit	 - Maximum junction temperature (in millidegrees Celsius).
+temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
+		   Correct CPU operation is no longer guaranteed.
+temp1_label	 - Contains string "Pysical package id X", where X is physical
+		   package id.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
