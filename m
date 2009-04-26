From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Sun, 26 Apr 2009 16:07:09 +0000
Subject: [lm-sensors] Why internal sensor on atom cpu isn't yet supported?
Message-Id: <1240762029.10972.15.camel@maxim-laptop>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-4SCK0W76BrEpvumbXlqy"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--=-4SCK0W76BrEpvumbXlqy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I use an old patch, and it works fine, was it forgotten?

Best regards,
	Maxim Levitky

I attach the patch I use for reference, I didn't wrote it
(I did slight modifications to apply it on latest kernels)

Best regards,
	Maxim Levitsky

--=-4SCK0W76BrEpvumbXlqy
Content-Disposition: attachment;
	filename="0001-Add-intel-atom-support-to-coretemp.patch"
Content-Type: text/x-patch;
	name="0001-Add-intel-atom-support-to-coretemp.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 7415b9249a8fd03baea37f292da765aa77926208 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Fri, 14 Nov 2008 22:52:42 +0200
Subject: [PATCH] Add intel atom support to coretemp

---
 Documentation/hwmon/coretemp |   14 ++++++++------
 drivers/hwmon/coretemp.c     |   18 +++++++++++++-----
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index dbbe6c7..d85c8fa 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -4,7 +4,7 @@ Kernel driver coretemp
 Supported chips:
   * All Intel Core family
     Prefix: 'coretemp'
-    CPUID: family 0x6, models 0xe, 0xf, 0x16, 0x17
+    CPUID: family 0x6, models 0xe, 0xf, 0x16, 0x17, 0x1c
     Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
                Volume 3A: System Programming Guide
                http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
@@ -14,10 +14,11 @@ Author: Rudolf Marek
 Description
 -----------
 
-This driver permits reading temperature sensor embedded inside Intel Core CPU.
-Temperature is measured in degrees Celsius and measurement resolution is
-1 degree C. Valid temperatures are from 0 to TjMax degrees C, because
-the actual value of temperature register is in fact a delta from TjMax.
+This driver permits reading temperature sensor embedded inside Intel
+Core  and Intel Atom CPUs. Temperature is measured in degrees Celsius
+and measurement resolution is 1 degree C. Valid temperatures are from 0
+to TjMax degrees C, because the actual value of temperature register is
+in fact a delta from TjMax.
 
 Temperature known as TjMax is the maximum junction temperature of processor.
 Intel defines this temperature as 85C or 100C. At this temperature, protection
@@ -35,4 +36,5 @@ temp1_label	 - Contains string "Core X", where X is processor
 
 The TjMax temperature is set to 85 degrees C if undocumented model specific
 register (UMSR) 0xee has bit 30 set. If not the TjMax is 100 degrees C as
-(sometimes) documented in processor datasheet.
+(sometimes) documented in processor datasheet. The Intel Atom has TjMax 95C
+as per the specification.
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 93c1722..0f58eff 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -1,7 +1,7 @@
 /*
  * coretemp.c - Linux kernel module for hardware monitoring
  *
- * Copyright (C) 2007 Rudolf Marek <r.marek@assembler.cz>
+ * Copyright (C) 2007, 2008 Rudolf Marek <r.marek@assembler.cz>
  *
  * Inspired from many hwmon drivers
  *
@@ -244,8 +244,14 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
 		}
 	}
 
-	data->tjmax = adjust_tjmax(c, data->id, &pdev->dev);
-	platform_set_drvdata(pdev, data);
+	/* Intel Atom has only fixed TjMax at 95C */
+
+	if (c->x86_model == 0x1c) {
+		data->tjmax = 95000;
+	} else {
+		/* Adjust the TjMax for the rest of Core2 family */
+		data->tjmax = adjust_tjmax(c, data->id, &pdev->dev);
+	}
 
 	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists
 	   on older CPUs but not in this register */
@@ -265,6 +271,8 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
 		}
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
 		goto exit_dev;
 
@@ -413,11 +421,11 @@ static int __init coretemp_init(void)
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &cpu_data(i);
 
-		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A */
+		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A, 0x1C */
 		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
 		    !((c->x86_model == 0xe) || (c->x86_model == 0xf) ||
 			(c->x86_model == 0x16) || (c->x86_model == 0x17) ||
-			(c->x86_model == 0x1A))) {
+			(c->x86_model == 0x1A) || c->x86_model == 0x1C)) {
 
 			/* supported CPU not found, but report the unknown
 			   family 6 CPU */
-- 
1.5.6.3


--=-4SCK0W76BrEpvumbXlqy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-4SCK0W76BrEpvumbXlqy--

