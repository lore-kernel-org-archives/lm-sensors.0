From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 10 May 2007 22:39:10 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp add more safety checks
Message-Id: <46439F0E.2080709@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020109090504030300020704"
List-Id: <lm-sensors.vger.kernel.org>
References: <4634A411.4030703@assembler.cz>
In-Reply-To: <4634A411.4030703@assembler.cz>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020109090504030300020704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello

here comes updated patch, I  added a check if certain Core2 are desktop or 
mobile processors (using yet another not officially documented register - but it 
should be ok ). They have same CPUID as desktop but are in fact mobile ;)

Everyone, please try the patch with core2 and core notebooks/desktops, I do not 
have any chance to test it.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

This patch adds detection of AE18 Errata of Core processor and warns
users that the absolute readings might be wrong for Core2 users.

Thanks,

Rudolf



--------------020109090504030300020704
Content-Type: text/x-patch;
 name="disable-coretemp-on-buggy-cpus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disable-coretemp-on-buggy-cpus.patch"

Index: linux-2.6.21/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.21.orig/drivers/hwmon/coretemp.c	2007-05-09 10:39:04.672435313 +0200
+++ linux-2.6.21/drivers/hwmon/coretemp.c	2007-05-11 00:35:07.082920759 +0200
@@ -176,6 +176,22 @@
 		goto exit_free;
 	}
 
+	/* Check if we have problem with errata AE18 of Core processors:
+	   Readings might stop update when processor visited too deep sleep,
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
@@ -193,6 +209,19 @@
 		}
 	}
 
+	/* Intel says that above should not work for desktop Core2 processors,
+	   but it seems to work. There is no other way how get the absolute
+	   readings. Warn the user about this. First check if are desktop,
+	   bit 50 of MSR_IA32_PLATFORM_ID should be 0.
+	*/
+
+	rdmsr_safe_on_cpu(data->id, MSR_IA32_PLATFORM_ID, &eax, &edx);
+
+	if ((c->x86_model == 0xf) && (!(edx & 0x00040000))) {
+		dev_warn(&pdev->dev, "Using undocumented features, absolute "
+			 "temperature might be wrong!\n");
+	}
+
 	platform_set_drvdata(pdev, data);
 
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
@@ -328,9 +357,6 @@
 	int i, err = -ENODEV;
 	struct pdev_entry *p, *n;
 
-	printk(KERN_NOTICE DRVNAME ": This driver uses undocumented features "
-		"of Core CPU. Temperature might be wrong!\n");
-
 	/* quick check if we run Intel */
 	if (cpu_data[0].x86_vendor != X86_VENDOR_INTEL)
 		goto exit;

--------------020109090504030300020704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020109090504030300020704--
