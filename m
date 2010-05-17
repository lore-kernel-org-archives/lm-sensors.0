From: Carsten Emde <C.Emde@osadl.org>
Date: Mon, 17 May 2010 09:41:37 +0000
Subject: [lm-sensors] [PATCH 1/2] Detect the thermal sensors by CPUID
Message-Id: <20100517094340.019100599@osadl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100510035031.GD9181@owl> <20100514065808.GA11598@owl>
 <20100517094136.094800562@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, Huaxu Wan <huaxu.wan@intel.com>, Carsten Emde <C.Emde@osadl.org>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Huaxu Wan <huaxu.wan@linux.intel.com>

The thermal sensors of Intel(R) CPUs can be detected by CPUID instruction,
indicated by CPUID.06H.EAX[0].

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Jean Delvare <khali@linux-fr.org>
CC: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Huaxu Wan <huaxu.wan@linux.intel.com>
Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Reviewed-By: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
 drivers/hwmon/coretemp.c |   34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

Index: head/drivers/hwmon/coretemp.c
=================================--- head.orig/drivers/hwmon/coretemp.c
+++ head/drivers/hwmon/coretemp.c
@@ -451,28 +451,20 @@ static int __init coretemp_init(void)
 
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &cpu_data(i);
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
-					"model 0x%x\n", c->x86_model);
-			continue;
+		/*
+		 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
+		 * sensors. We check this bit only, all the early CPUs
+		 * without thermal sensors will be filtered out.
+		 */
+		if (c->cpuid_level >= 6 && (cpuid_eax(0x06) & 0x01)) {
+			err = coretemp_device_add(i);
+			if (err)
+				goto exit_devices_unreg;
+
+		} else {
+			printk(KERN_INFO DRVNAME ": CPU (model=0x%x)"
+				" has no thermal sensor.\n", c->x86_model);
 		}
-
-		err = coretemp_device_add(i);
-		if (err)
-			goto exit_devices_unreg;
 	}
 	if (list_empty(&pdev_list)) {
 		err = -ENODEV;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
