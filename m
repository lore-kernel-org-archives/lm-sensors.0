From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 10 Aug 2008 18:58:06 +0000
Subject: Re: [lm-sensors] CPU Model 1c (Intel Atom) not supported in coretemp
Message-Id: <489F3A3E.30908@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090705030200070302020608"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090705030200070302020608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I completed a patch for Atom support. Intel told me the TjMax. It is 95C. Here 
we go. Please test and report if it works for you.

The high temperature might be wrong. Please check that Critical temperature is 
95C. Or even better paste the output sensors to some mail.

The patch has been just compile tested! Test with care!

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Thanks
Rudolf

--------------090705030200070302020608
Content-Type: text/x-diff;
 name="add-coretemp-atom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-coretemp-atom.patch"

Index: linux-2.6.27-rc2/Documentation/hwmon/coretemp
===================================================================
--- linux-2.6.27-rc2.orig/Documentation/hwmon/coretemp	2008-08-10 20:33:20.355228221 +0200
+++ linux-2.6.27-rc2/Documentation/hwmon/coretemp	2008-08-09 20:09:42.000000000 +0200
@@ -4,7 +4,7 @@
 Supported chips:
   * All Intel Core family
     Prefix: 'coretemp'
-    CPUID: family 0x6, models 0xe, 0xf, 0x16, 0x17
+    CPUID: family 0x6, models 0xe, 0xf, 0x16, 0x17, 0x1c
     Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
                Volume 3A: System Programming Guide
                http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
@@ -14,10 +14,11 @@
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
@@ -35,4 +36,5 @@
 
 The TjMax temperature is set to 85 degrees C if undocumented model specific
 register (UMSR) 0xee has bit 30 set. If not the TjMax is 100 degrees C as
-(sometimes) documented in processor datasheet.
+(sometimes) documented in processor datasheet. The Intel Atom has TjMax 95C
+as per the specification.
Index: linux-2.6.27-rc2/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.27-rc2.orig/drivers/hwmon/coretemp.c	2008-08-10 20:33:55.357222871 +0200
+++ linux-2.6.27-rc2/drivers/hwmon/coretemp.c	2008-08-10 20:55:34.931281376 +0200
@@ -1,7 +1,7 @@
 /*
  * coretemp.c - Linux kernel module for hardware monitoring
  *
- * Copyright (C) 2007 Rudolf Marek <r.marek@assembler.cz>
+ * Copyright (C) 2007, 2008 Rudolf Marek <r.marek@assembler.cz>
  *
  * Inspired from many hwmon drivers
  *
@@ -244,8 +244,14 @@
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
@@ -265,6 +271,8 @@
 		}
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
 		goto exit_dev;
 
@@ -413,10 +421,11 @@
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &cpu_data(i);
 
-		/* check if family 6, models 0xe, 0xf, 0x16, 0x17 */
+		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1c */
 		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
 		    !((c->x86_model == 0xe) || (c->x86_model == 0xf) ||
-			(c->x86_model == 0x16) || (c->x86_model == 0x17))) {
+			(c->x86_model == 0x16) || (c->x86_model == 0x17) ||
+			(c->x86_model == 0x1c))) {
 
 			/* supported CPU not found, but report the unknown
 			   family 6 CPU */

--------------090705030200070302020608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090705030200070302020608--
