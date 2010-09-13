From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:24:47 +0000
Subject: [lm-sensors] [PATCH] x86/hwmon: pkgtemp has no dependency on PCI
Message-Id: <4C8E180F0200007800015AF4@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: fenghua.yu@intel.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Other than coretemp, from which this code was apparently derived, there
is no PCI specific code in this driver.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>

---
 drivers/hwmon/Kconfig   |    2 +-
 drivers/hwmon/pkgtemp.c |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.36-rc4/drivers/hwmon/Kconfig	2010-09-13 08:45:02.000000000 +0200
+++ 2.6.36-rc4-x86-pkgtemp-no-pci/drivers/hwmon/Kconfig	2010-09-10 16:24:16.000000000 +0200
@@ -409,7 +409,7 @@ config SENSORS_CORETEMP
 
 config SENSORS_PKGTEMP
 	tristate "Intel processor package temperature sensor"
-	depends on X86 && PCI && EXPERIMENTAL
+	depends on X86 && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the package level temperature
 	  sensor inside your CPU. Check documentation/driver for details.
--- linux-2.6.36-rc4/drivers/hwmon/pkgtemp.c	2010-09-13 08:45:03.000000000 +0200
+++ 2.6.36-rc4-x86-pkgtemp-no-pci/drivers/hwmon/pkgtemp.c	2010-09-03 17:54:30.000000000 +0200
@@ -33,7 +33,6 @@
 #include <linux/list.h>
 #include <linux/platform_device.h>
 #include <linux/cpu.h>
-#include <linux/pci.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
 




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
