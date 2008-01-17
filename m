From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 17 Jan 2008 23:47:36 +0000
Subject: [lm-sensors] [PATCH] coretemp: Add TjMax detection for mobile CPUs
Message-Id: <478FE918.9030804@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070904080604070807050409"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904080604070807050409
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Following patch will finally solve the detection of Intel Mobile CPUs which
share same CPUID with Desktop/Server CPUs. We need this information to test
some bit so we know if TjMax is 100C or 85C. Intel claims this works for mobiles
only, respect that and set for desktops the TjMax to 100C. Intel provided some
table on their wiki based on my chat with them at:
http://softwarecommunity.intel.com/isn/Community/en-US/forums/30247249/ShowThread.aspx#30247249

The patch is totally untested, please check the patch, test and report ;)

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHj+kY3J9wPJqZRNURAuh0AKCrT48ujm2J9kYomYRpUedNX4XmAgCfchGX
GHQPF83yNL8r4BcPcRPhv1s=
=p+1S
-----END PGP SIGNATURE-----

--------------070904080604070807050409
Content-Type: text/x-patch;
 name="fix_mobile_core2_detection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_mobile_core2_detection.patch"

Index: linux-2.6.24-rc7/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.24-rc7.orig/drivers/hwmon/coretemp.c	2008-01-18 00:19:34.899436907 +0100
+++ linux-2.6.24-rc7/drivers/hwmon/coretemp.c	2008-01-18 00:32:26.147387823 +0100
@@ -152,6 +152,57 @@
 	return data;
 }
 
+static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev) {
+
+	/* The 100C is default for both mobile and non mobile CPUs */
+
+	int tjmax = 100000;
+	int ismobile = 1;
+	int err;
+	u32 eax, edx;
+
+	/* Early chips have no MSR for TjMax */
+
+	if (((c->x86_model == 0xf) && (c->x86_mask < 4)) ||
+	      (c->x86_model < 0xe)) {
+		ismobile = 0;
+	}
+
+	if ((c->x86_model > 0xe) && (ismobile)) {
+
+		/* Now we can detect the mobile CPU using Intel provided table
+		   http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
+		   For Core2 cores, check MSR 0x17, bit 28 1 = Mobile CPU
+		*/
+
+		err = rdmsr_safe_on_cpu(id, 0x17, &eax, &edx);
+		if (err) {
+			dev_warn(dev,
+				 "Unable to access MSR 0x17, assuming desktop"
+				 " CPU\n");
+			ismobile = 0;
+		} else if (!(eax & 0x10000000)) {
+				ismobile = 0;
+		}
+	}
+
+	if (ismobile) {
+
+		err = rdmsr_safe_on_cpu(id, 0xee, &eax, &edx);
+		if (err) {
+			dev_warn(dev,
+				 "Unable to access MSR 0xEE, for Tjmax, left"
+				 " at default");
+		} else if (eax & 0x40000000) {
+			tjmax = 85000;
+		}
+	} else  {
+		dev_warn(dev, "Using relative temperature scale!\n");
+	}
+
+	return tjmax;
+}
+
 static int __devinit coretemp_probe(struct platform_device *pdev)
 {
 	struct coretemp_data *data;
@@ -168,8 +219,6 @@
 	data->id = pdev->id;
 	data->name = "coretemp";
 	mutex_init(&data->update_lock);
-	/* Tjmax default is 100 degrees C */
-	data->tjmax = 100000;
 
 	/* test if we can access the THERM_STATUS MSR */
 	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
@@ -196,36 +245,7 @@
 		}
 	}
 
-	/* Some processors have Tjmax 85 following magic should detect it
-	   Intel won't disclose the information without signed NDA, but
-	   individuals cannot sign it. Catch(ed) 22.
-	*/
-
-	if (((c->x86_model == 0xf) && (c->x86_mask > 3)) ||
-		(c->x86_model == 0xe))  {
-		err = rdmsr_safe_on_cpu(data->id, 0xee, &eax, &edx);
-		if (err) {
-			dev_warn(&pdev->dev,
-				 "Unable to access MSR 0xEE, Tjmax left at %d "
-				 "degrees C\n", data->tjmax/1000);
-		} else if (eax & 0x40000000) {
-			data->tjmax = 85000;
-		}
-	}
-
-	/* Intel says that above should not work for desktop Core2 processors,
-	   but it seems to work. There is no other way how get the absolute
-	   readings. Warn the user about this. First check if are desktop,
-	   bit 50 of MSR_IA32_PLATFORM_ID should be 0.
-	*/
-
-	rdmsr_safe_on_cpu(data->id, MSR_IA32_PLATFORM_ID, &eax, &edx);
-
-	if ((c->x86_model == 0xf) && (!(edx & 0x00040000))) {
-		dev_warn(&pdev->dev, "Using undocumented features, absolute "
-			 "temperature might be wrong!\n");
-	}
-
+	data->tjmax = adjust_tjmax(c, data->id, &pdev->dev);
 	platform_set_drvdata(pdev, data);
 
 	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists

--------------070904080604070807050409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070904080604070807050409--
