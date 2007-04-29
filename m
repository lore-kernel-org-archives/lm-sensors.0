From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 29 Apr 2007 13:56:33 +0000
Subject: [lm-sensors] [PATCH] coretemp add more safety checks
Message-Id: <4634A411.4030703@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060906040908050400000707"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060906040908050400000707
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Hello all,

I hope I will have more time from now, here my patch. It adds check for Errata
AE18 of core processors, which causes values not to update after the CPU deep
sleeps. Intel claims that the TjMax detection might not work for the Core2, warn
the users about this.

I would like to ask anyone using coretemp on notebook to test this patch!

In case it is ok (haha) here is the kernel stuff:

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

This patch adds detection of AE18 Errata of Core processor and warns
users that the absolute readings might be wrong for Core2 users.

Rudolf

--------------060906040908050400000707
Content-Type: text/x-diff;
 name="disable-coretemp-on-some-cpus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disable-coretemp-on-some-cpus.patch"

Index: linux-2.6.21-rc3/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.21-rc3.orig/drivers/hwmon/coretemp.c	2007-04-29 14:38:49.440113304 +0200
+++ linux-2.6.21-rc3/drivers/hwmon/coretemp.c	2007-04-29 15:32:34.263885537 +0200
@@ -176,6 +176,22 @@
 		goto exit_free;
 	}
 
+	/* Check if we have problem with errata AE18 of Core processors:
+	   Readings might stop update when precessor visited too deep sleep,
+	   fixed for stepping D0 (6EC).
+	*/
+
+	if ((c->x86_model == 0xe) && (c->x86_mask < 0xc)) {
+		/* check for microcode update */
+		rdmsr_on_cpu(data->id, MSR_IA32_UCODE_REV, &eax, &edx);
+		if (edx < 0x39) {
+			dev_err(&pdev->dev,
+				"Errata AE18 not fixed, update BIOS or "
+				"microcode of the CPU!\n");
+			goto exit_free;
+		}
+	}
+
 	/* Some processors have Tjmax 85 following magic should detect it
 	   Intel won't disclose the information without signed NDA, but
 	   individuals cannot sign it. Catch(ed) 22.
@@ -193,6 +209,16 @@
 		}
 	}
 
+	/* Intel says that above should not work for Core2 processors,
+	   but it seems to work. There is no other way how get the absolute
+	   readings. Warn the user about this.
+	*/
+
+	if (((c->x86_model == 0xf) {
+		dev_warn(&pdev->dev, "Using undocumented features, absolute "
+			 "temperature might be wrong!\n");
+	}
+
 	platform_set_drvdata(pdev, data);
 
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
@@ -328,9 +354,6 @@
 	int i, err = -ENODEV;
 	struct pdev_entry *p, *n;
 
-	printk(KERN_NOTICE DRVNAME ": This driver uses undocumented features"
-		" of Core CPU. Temperature might be wrong!\n");
-
 	/* quick check if we run Intel */
 	if (cpu_data[0].x86_vendor != X86_VENDOR_INTEL)
 		goto exit;

--------------060906040908050400000707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060906040908050400000707--
