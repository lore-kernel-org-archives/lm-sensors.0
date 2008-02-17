From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 17 Feb 2008 21:59:39 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: Add TjMax detection for mobile
Message-Id: <47B8AE4B.1080702@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040003090403090501090702"
List-Id: <lm-sensors.vger.kernel.org>
References: <478FE918.9030804@assembler.cz>
In-Reply-To: <478FE918.9030804@assembler.cz>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003090403090501090702
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jean,

Thanks for the review. Here it comes updated. I managed to get to test this=
 on
core2 system:

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +50.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +51.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

Seems to work ;)

Hello,

Following patch will finally solve the detection of Intel Mobile CPUs which
share same CPUID with Desktop/Server CPUs. We need this information to test
some bit so we know if TjMax is 100C or 85C. Intel claims this works for mo=
biles
only, respect that and set for desktops the TjMax to 100C. Intel provided s=
ome
table on their wiki based on my chat with them at:
http://softwarecommunity.intel.com/isn/Community/en-US/forums/30247249/Show=
Thread.aspx#30247249

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHuK5J3J9wPJqZRNURAtb0AKCGD6F0QgcPLUOqyCFV9EwS4p7A1wCfVCyg
y3ar/7wdXX8OUBKRUQ3Wim0=3D
=3DeBKN
-----END PGP SIGNATURE-----

--------------040003090403090501090702
Content-Type: text/x-patch;
 name="fix_mobile_core2_detection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_mobile_core2_detection.patch"

Index: linux-2.6.24-rc7/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.24-rc7.orig/drivers/hwmon/coretemp.c	2008-01-18 00:19:34.000000000 +0100
+++ linux-2.6.24-rc7/drivers/hwmon/coretemp.c	2008-02-17 22:27:27.236965517 +0100
@@ -152,6 +152,56 @@
 	return data;
 }
 
+static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
+{
+	/* The 100C is default for both mobile and non mobile CPUs */
+
+	int tjmax = 100000;
+	int ismobile = 1;
+	int err;
+	u32 eax, edx;
+
+	/* Early chips have no MSR for TjMax */
+
+	if ((c->x86_model == 0xf) && (c->x86_mask < 4)) {
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
+			ismobile = 0;
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
+	} else {
+		dev_warn(dev, "Using relative temperature scale!\n");
+	}
+
+	return tjmax;
+}
+
 static int __devinit coretemp_probe(struct platform_device *pdev)
 {
 	struct coretemp_data *data;
@@ -168,8 +218,6 @@
 	data->id = pdev->id;
 	data->name = "coretemp";
 	mutex_init(&data->update_lock);
-	/* Tjmax default is 100 degrees C */
-	data->tjmax = 100000;
 
 	/* test if we can access the THERM_STATUS MSR */
 	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
@@ -196,36 +244,7 @@
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

--------------040003090403090501090702
Content-Type: application/octet-stream;
	name="fix_mobile_core2_detection.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="fix_mobile_core2_detection.patch.sig"

iD8DBQBHuK5K3J9wPJqZRNURAkGqAJ9ml009Pvnoyk6qSi6ZC83BhEcOyQCgnTjC8+y1064A
sZdjzCXHaK4Lc/s=
--------------040003090403090501090702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040003090403090501090702--
