From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Fri, 05 Mar 2010 15:28:52 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (coretemp) Detect the thermal
Message-Id: <20100305152852.GA15945@owl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The thermal sensors of Intel CPUs can be detected by CPUID instruction,
indicated by CPUID.06H.EAX[0].

Signed-off-by: Huaxu Wan <huaxu.wan@intel.com>
---
 drivers/hwmon/coretemp.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 2d7bcee..55122d8 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -440,6 +440,7 @@ static int __init coretemp_init(void)
 {
 	int i, err = -ENODEV;
 	struct pdev_entry *p, *n;
+	u32 eax;
 
 	/* quick check if we run Intel */
 	if (cpu_data(0).x86_vendor != X86_VENDOR_INTEL)
@@ -450,23 +451,12 @@ static int __init coretemp_init(void)
 		goto exit;
 
 	for_each_online_cpu(i) {
-		struct cpuinfo_x86 *c = &cpu_data(i);
-
-		/* check if family 6, models 0xe (Pentium M DC),
-		  0xf (Core 2 DC 65nm), 0x16 (Core 2 SC 65nm),
-		  0x17 (Penryn 45nm), 0x1a (Nehalem), 0x1c (Atom),
-		  0x1e (Lynnfield) */
-		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
-		    !((c->x86_model = 0xe) || (c->x86_model = 0xf) ||
-			(c->x86_model = 0x16) || (c->x86_model = 0x17) ||
-			(c->x86_model = 0x1a) || (c->x86_model = 0x1c) ||
-			(c->x86_model = 0x1e))) {
-
-			/* supported CPU not found, but report the unknown
-			   family 6 CPU */
-			if ((c->x86 = 0x6) && (c->x86_model > 0xf))
-				printk(KERN_WARNING DRVNAME ": Unknown CPU "
-					"model %x\n", c->x86_model);
+		/* check if the CPU has thermal sensor */
+		eax = cpuid_eax(0x06);
+		if (!(eax & 0x01)) {
+			struct cpuinfo_x86 *c = &cpu_data(i);
+			printk_once(KERN_WARNING DRVNAME ": CPU (model=0x%x)"
+				" has no thermal sensor!\n", c->x86_model);
 			continue;
 		}
 
-- 
1.6.3.3.363.g725cf7

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
