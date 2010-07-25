From: "Fenghua Yu" <fenghua.yu@intel.com>
Date: Sun, 25 Jul 2010 05:13:47 +0000
Subject: [lm-sensors] [PATH V2 5/5] Package Level Thermal Control and Power
Message-Id: <1280034827-5759-6-git-send-email-fenghua.yu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Document for package level thermal hwmon driver.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/pkgtemp |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/pkgtemp

diff --git a/Documentation/hwmon/pkgtemp b/Documentation/hwmon/pkgtemp
new file mode 100644
index 0000000..c8e1fb0
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
+Intel CPU package. The sensors can be in core, uncore, memory controller, or
+other components in a package. The feature is first implemented in Intel Sandy
+Bridge platform.
+
+Temperature is measured in degrees Celsius and measurement resolution is
+1 degree C. Valid temperatures are from 0 to TjMax degrees C, because the actual
+value of temperature register is in fact a delta from TjMax.
+
+Temperature known as TjMax is the maximum junction temperature of package.
+We get this from MSR_IA32_TEMPERATURE_TARGET. If the MSR is not accessible,
+we define TjMax as 100 degrees Celsius. At this temperature, protection
+mechanism will perform actions to forcibly cool down the package. Alarm
+may be raised, if the temperature grows enough (more than TjMax) to trigger
+the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
+
+temp1_input	  - Package temperature (in millidegrees Celsius).
+temp1_max        - All cooling devices should be turned on.
+temp1_crit	  - Maximum junction temperature (in millidegrees Celsius).
+temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
+		    Correct CPU operation is no longer guaranteed.
-- 
1.7.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
