From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 09 Oct 2012 21:08:59 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: (coretemp) Drop dependency on PCI for TjMax detection on Atom CPUs
Message-Id: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So far, we use the NM10 Express Chipset PCI chip ID to detect TjMax for
Atom CPUs with model 0x1c. As it turns out, we can use the CPU stepping
(x86_mask) for the same purpose; stepping is 10 for all model 0x1c CPUs
with TjMax of 100 degrees C. This was verified by checking the output of
/proc/cpuinfo for the respective CPUs (D4xx, D5xx, N4xx, N5xx).

Other CPUs currently covered by the same code (Exx, Z6xx, Z2460) are not
supported by the NM10 Express Chipset. Most of those CPUs have TjMax of 90
degrees C, except for E6xxT models which have a TjMax of 110 degrees C.
E6xxT CPUs can however not be detected by software.

Calculate TjMax for Atom CPUs as follows:

ID	Stepping	TjMax		Models
0x1c	10		100		D4xx, N4xx, D5xx, N5xx
0x1c	not 10		90		Z5xx, N2xx, 230, 330, others
0x26	-		90		Atom Tunnel Creek (Exx),
					Lincroft (Z6xx)
0x27	-		90		Atom Medfield (Z2460)
0x36	-		100000		Atom Cedar Trail (N2xxx, D2xxx)

and drop the module dependency on PCI.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Stepping information for model 0x1c CPUs was found in FreeBSD,
Open Hardware Monitor, and HWSensors.

 drivers/hwmon/Kconfig    |    2 +-
 drivers/hwmon/coretemp.c |   37 +++++++++++++++----------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c74e73b..0a4c790 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -465,7 +465,7 @@ config SENSORS_HIH6130
 
 config SENSORS_CORETEMP
 	tristate "Intel Core/Core2/Atom temperature sensor"
-	depends on X86 && PCI
+	depends on X86
 	help
 	  If you say yes here you get support for the temperature
 	  sensor inside your CPU. Most of the family 6 CPUs
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 984a3f1..1937cd4 100644
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
@@ -219,7 +218,6 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 	int usemsr_ee = 1;
 	int err;
 	u32 eax, edx;
-	struct pci_dev *host_bridge;
 	int i;
 
 	/* explicit tjmax table entries override heuristics */
@@ -228,31 +226,26 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 			return tjmax_table[i].tjmax;
 	}
 
-	/* Early chips have no MSR for TjMax */
-
-	if (c->x86_model = 0xf && c->x86_mask < 4)
-		usemsr_ee = 0;
-
 	/* Atom CPUs */
 
-	if (c->x86_model = 0x1c || c->x86_model = 0x26
-	    || c->x86_model = 0x27) {
-		usemsr_ee = 0;
-
-		host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
+	if (c->x86_model = 0x1c) {
+		/*
+		 * TjMax for stepping 10 CPUs (N4xx, N5xx, D4xx, D5xx)
+		 * is 100 degrees C, for all others it is 90 degrees C.
+		 */
+		if (c->x86_mask = 10)
+			return 100000;
+		return 90000;
+	} else if (c->x86_model = 0x26 || c->x86_model = 0x27) {
+		return 90000;
+	} else if (c->x86_model = 0x36) {
+		return 100000;
+	}
 
-		if (host_bridge && host_bridge->vendor = PCI_VENDOR_ID_INTEL
-		    && (host_bridge->device = 0xa000	/* NM10 based nettop */
-		    || host_bridge->device = 0xa010))	/* NM10 based netbook */
-			tjmax = 100000;
-		else
-			tjmax = 90000;
+	/* Early chips have no MSR for TjMax */
 
-		pci_dev_put(host_bridge);
-	} else if (c->x86_model = 0x36) {
+	if (c->x86_model = 0xf && c->x86_mask < 4)
 		usemsr_ee = 0;
-		tjmax = 100000;
-	}
 
 	if (c->x86_model > 0xe && usemsr_ee) {
 		u8 platform_id;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
