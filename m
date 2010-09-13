From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:30:08 +0000
Subject: [lm-sensors] [PATCH] x86/hwmon: {core, pkg,
Message-Id: <4C8E19500200007800015B15@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

... as they're being called only from a __cpuinit function.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/hwmon/coretemp.c    |    2 +-
 drivers/hwmon/pkgtemp.c     |    2 +-
 drivers/hwmon/via-cputemp.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.36-rc4/drivers/hwmon/coretemp.c	2010-09-13 08:45:02.000000000 +0200
+++ 2.6.36-rc4-x86-hwmon-sections/drivers/hwmon/coretemp.c	2010-09-03 17:54:14.000000000 +0200
@@ -480,7 +480,7 @@ exit:
 	return err;
 }
 
-static void coretemp_device_remove(unsigned int cpu)
+static void __cpuinit coretemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
 	mutex_lock(&pdev_list_mutex);
--- linux-2.6.36-rc4/drivers/hwmon/pkgtemp.c	2010-09-13 08:45:03.000000000 +0200
+++ 2.6.36-rc4-x86-hwmon-sections/drivers/hwmon/pkgtemp.c	2010-09-01 09:00:45.000000000 +0200
@@ -337,7 +337,7 @@ exit:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void pkgtemp_device_remove(unsigned int cpu)
+static void __cpuinit pkgtemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
 	unsigned int i;
--- linux-2.6.36-rc4/drivers/hwmon/via-cputemp.c	2010-09-13 08:45:03.000000000 +0200
+++ 2.6.36-rc4-x86-hwmon-sections/drivers/hwmon/via-cputemp.c	2010-09-13 00:00:00.000000000 +0200
@@ -238,7 +238,7 @@ exit:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void via_cputemp_device_remove(unsigned int cpu)
+static void __cpuinit via_cputemp_device_remove(unsigned int cpu)
 {
 	struct pdev_entry *p, *n;
 	mutex_lock(&pdev_list_mutex);




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
