From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 04 Jun 2012 23:32:29 +0000
Subject: [lm-sensors] [RFC PATCH v2 2/2] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <1338852749-5564-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Atom CPUs don't have a register to retrieve TjMax. Detection so far was
incomplete. Use the X86 model ID to improve it.

This patch also removes the dependency on PCI code, since the PCI host bridge
type is no longer used to detect TjMax.

Cc: Durgadoss R <durgadoss.r@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Dropped PCI dependencies
    Fixed 330 and 230 detection (2 spaces between CPU and 330/230)
    Added support for Cedar Creek CPUs
    Declared atom_tjmax as __cpuinitconst

Questions:

Would it make sense to keep the PCI detection in addition to the new detection code ?

Would it make sense to include the CPU model number in struct tjmax, to make
detection more generic ?

 drivers/hwmon/Kconfig    |    2 +-
 drivers/hwmon/coretemp.c |   52 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6f1d167..3a7c248 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -435,7 +435,7 @@ config SENSORS_GPIO_FAN
 
 config SENSORS_CORETEMP
 	tristate "Intel Core/Core2/Atom temperature sensor"
-	depends on X86 && PCI && EXPERIMENTAL
+	depends on X86 && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the temperature
 	  sensor inside your CPU. Most of the family 6 CPUs
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 07160126..d61489f 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -34,7 +34,6 @@
 #include <linux/list.h>
 #include <linux/platform_device.h>
 #include <linux/cpu.h>
-#include <linux/pci.h>
 #include <linux/smp.h>
 #include <linux/moduleparam.h>
 #include <asm/msr.h>
@@ -191,6 +190,36 @@ static ssize_t show_temp(struct device *dev,
 	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
 }
 
+struct tjmax {
+	char const *id;
+	int tjmax;
+};
+
+static struct tjmax __cpuinitconst atom_tjmax[] = {
+	{ "CPU D410", 100000 },		/* model 0x1c */
+	{ "CPU D425", 100000 },
+	{ "CPU D510", 100000 },
+	{ "CPU D525", 100000 },
+	{ "CPU N450", 100000 },
+	{ "CPU N455", 100000 },
+	{ "CPU N470", 100000 },
+	{ "CPU N475", 100000 },
+	{ "CPU  230", 100000 },
+	{ "CPU  330", 125000 },
+	{ "CPU E620T", 110000 },	/* model 0x26, 0x27 */
+	{ "CPU E640T", 110000 },
+	{ "CPU E660T", 110000 },
+	{ "CPU E680T", 110000 },
+	{ "CPU D2500", 100000 },	/* model 0x36 */
+	{ "CPU D2550", 100000 },
+	{ "CPU D2700", 100000 },
+	{ "CPU N2600", 100000 },
+	{ "CPU N2650", 100000 },
+	{ "CPU N2800", 100000 },
+	{ "CPU N2850", 100000 },
+	{ },
+};
+
 static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 				  struct device *dev)
 {
@@ -201,7 +230,6 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 	int usemsr_ee = 1;
 	int err;
 	u32 eax, edx;
-	struct pci_dev *host_bridge;
 
 	/* Early chips have no MSR for TjMax */
 
@@ -212,18 +240,16 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 
 	if (c->x86_model = 0x1c || c->x86_model = 0x26
 	    || c->x86_model = 0x27 || c->x86_model = 0x36) {
-		usemsr_ee = 0;
+		struct tjmax *tj;
 
-		host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
-
-		if (host_bridge && host_bridge->vendor = PCI_VENDOR_ID_INTEL
-		    && (host_bridge->device = 0xa000	/* NM10 based nettop */
-		    || host_bridge->device = 0xa010))	/* NM10 based netbook */
-			tjmax = 100000;
-		else
-			tjmax = 90000;
-
-		pci_dev_put(host_bridge);
+		usemsr_ee = 0;
+		tjmax = 90000;
+		for (tj = atom_tjmax; tj->tjmax; tj++) {
+			if (strstr(c->x86_model_id, tj->id)) {
+				tjmax = tj->tjmax;
+				break;
+			}
+		}
 	}
 
 	if (c->x86_model > 0xe && usemsr_ee) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
