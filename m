From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 06 Jul 2009 20:38:10 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for Atom CPUs
Message-Id: <4A5260B2.4010405@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010400050502060306030401"
List-Id: <lm-sensors.vger.kernel.org>
References: <4A522794.1020507@assembler.cz>
In-Reply-To: <4A522794.1020507@assembler.cz>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010400050502060306030401
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

Thanks Martin for a test. It seems that TAGET MSR is not implemented, also
driver incorrectly reports that it uses relative temperature scale. Fix it with
updated patch.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpSYLEACgkQ3J9wPJqZRNX2qwCfeF0+WAidbXs/cterief56qV/
i4EAn1zchUyNP54Qas3KEqV5RGGi40Kj
=ye/T
-----END PGP SIGNATURE-----

--------------010400050502060306030401
Content-Type: text/x-diff;
 name="add_atoms.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_atoms.patch"

Index: linux-2.6.30.1/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.30.1.orig/drivers/hwmon/coretemp.c	2009-07-06 17:07:16.458757525 +0200
+++ linux-2.6.30.1/drivers/hwmon/coretemp.c	2009-07-06 22:34:59.417758968 +0200
@@ -157,17 +157,24 @@
 	/* The 100C is default for both mobile and non mobile CPUs */
 
 	int tjmax = 100000;
-	int ismobile = 1;
+	int usemsr_ee = 1;
 	int err;
 	u32 eax, edx;
 
 	/* Early chips have no MSR for TjMax */
 
 	if ((c->x86_model == 0xf) && (c->x86_mask < 4)) {
-		ismobile = 0;
+		usemsr_ee = 0;
 	}
 
-	if ((c->x86_model > 0xe) && (ismobile)) {
+	/* Atoms seems to have TjMax at 90C */
+
+	if (c->x86_model == 0x1c) {
+		usemsr_ee = 0;
+		tjmax = 90000;
+	}
+
+	if ((c->x86_model > 0xe) && (usemsr_ee)) {
 
 		/* Now we can detect the mobile CPU using Intel provided table
 		   http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
@@ -179,13 +186,13 @@
 			dev_warn(dev,
 				 "Unable to access MSR 0x17, assuming desktop"
 				 " CPU\n");
-			ismobile = 0;
+			usemsr_ee = 0;
 		} else if (!(eax & 0x10000000)) {
-			ismobile = 0;
+			usemsr_ee = 0;
 		}
 	}
 
-	if (ismobile) {
+	if (usemsr_ee) {
 
 		err = rdmsr_safe_on_cpu(id, 0xee, &eax, &edx);
 		if (err) {
@@ -195,7 +202,8 @@
 		} else if (eax & 0x40000000) {
 			tjmax = 85000;
 		}
-	} else {
+	/* if we dont use msr EE it means we are desktop CPU (with exeception of Atom) */
+	} else if (tjmax == 100000) {
 		dev_warn(dev, "Using relative temperature scale!\n");
 	}
 
@@ -248,9 +256,9 @@
 	platform_set_drvdata(pdev, data);
 
 	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists
-	   on older CPUs but not in this register */
+	   on older CPUs but not in this register, Atoms don't have it too */
 
-	if (c->x86_model > 0xe) {
+	if ((c->x86_model > 0xe) && (c->x86_model != 0x1c)) {
 		err = rdmsr_safe_on_cpu(data->id, 0x1a2, &eax, &edx);
 		if (err) {
 			dev_warn(&pdev->dev, "Unable to read"
@@ -413,11 +421,11 @@
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &cpu_data(i);
 
-		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A */
+		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A, 0x1c */
 		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
 		    !((c->x86_model == 0xe) || (c->x86_model == 0xf) ||
 			(c->x86_model == 0x16) || (c->x86_model == 0x17) ||
-			(c->x86_model == 0x1A))) {
+			(c->x86_model == 0x1A) || (c->x86_model == 0x1c))) {
 
 			/* supported CPU not found, but report the unknown
 			   family 6 CPU */
Index: linux-2.6.30.1/Documentation/hwmon/coretemp
===================================================================
--- linux-2.6.30.1.orig/Documentation/hwmon/coretemp	2009-07-06 18:31:56.262759644 +0200
+++ linux-2.6.30.1/Documentation/hwmon/coretemp	2009-07-06 22:31:01.905898848 +0200
@@ -4,7 +4,7 @@
 Supported chips:
   * All Intel Core family
     Prefix: 'coretemp'
-    CPUID: family 0x6, models 0xe, 0xf, 0x16, 0x17
+    CPUID: family 0x6, models 0xe, 0xf, 0x16, 0x17, 0x1c (Atom)
     Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
                Volume 3A: System Programming Guide
                http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
Index: linux-2.6.30.1/drivers/hwmon/Kconfig
===================================================================
--- linux-2.6.30.1.orig/drivers/hwmon/Kconfig	2009-07-06 18:32:31.974757310 +0200
+++ linux-2.6.30.1/drivers/hwmon/Kconfig	2009-07-06 18:33:48.566759515 +0200
@@ -402,12 +402,12 @@
 	  will be called gl520sm.
 
 config SENSORS_CORETEMP
-	tristate "Intel Core (2) Duo/Solo temperature sensor"
+	tristate "Intel Core/Core2/Atom temperature sensor"
 	depends on X86 && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the temperature
-	  sensor inside your CPU. Supported all are all known variants
-	  of Intel Core family.
+	  sensor inside your CPU. Most of the family 6 CPUs
+	  are supported. Check documentation/driver for details.
 
 config SENSORS_IBMAEM
 	tristate "IBM Active Energy Manager temperature/power sensors and control"

--------------010400050502060306030401
Content-Type: application/octet-stream;
 name="add_atoms.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="add_atoms.patch.sig"

iEYEABECAAYFAkpSYLEACgkQ3J9wPJqZRNUjGgCbB1QpDZeadXxZ1bdcv7oO+rzYjaoAoNGI
vn8uONq/ma138elRd1A766iw
--------------010400050502060306030401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010400050502060306030401--
