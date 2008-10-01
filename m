From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 01 Oct 2008 22:09:09 +0000
Subject: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <48E3F505.40401@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040809060805030409050604"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040809060805030409050604
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Following patch adds warning about wrong CPU temperature readouts on all fam f
rev f revision of CPUs.

Used switch statement, more code changes follows.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

It should "fix" http://bugzilla.kernel.org/show_bug.cgi?id=8866

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFI4/UF3J9wPJqZRNURAmtlAJ9+mLtSfm0pm5mPYM64KAJlkqNJSACfeUd/
E/rMMMRv+fY550oVBxk3lF4=
=zqkq
-----END PGP SIGNATURE-----

--------------040809060805030409050604
Content-Type: text/x-diff;
 name="k8temp_add_warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k8temp_add_warning.patch"

Index: linux-2.6.27-rc7/drivers/hwmon/k8temp.c
===================================================================
--- linux-2.6.27-rc7.orig/drivers/hwmon/k8temp.c	2008-09-28 11:01:45.855284456 +0200
+++ linux-2.6.27-rc7/drivers/hwmon/k8temp.c	2008-09-28 11:13:42.396117790 +0200
@@ -34,6 +34,7 @@
 
 #define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
 #define REG_TEMP	0xe4
+#define REG_CPUID	0xfc
 #define SEL_PLACE	0x40
 #define SEL_CORE	0x04
 
@@ -47,6 +48,7 @@
 	/* registers values */
 	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
 	u32 temp[2][2];		/* core, place */
+	u8 fam;
 };
 
 static struct k8temp_data *k8temp_update_device(struct device *dev)
@@ -141,6 +143,7 @@
 	int err;
 	u8 scfg;
 	u32 temp;
+
 	struct k8temp_data *data;
 	u32 cpuid = cpuid_eax(1);
 
@@ -155,6 +158,18 @@
 		goto exit;
 	}
 
+	/* get real PCI based cpuid, prior revF of fam 0Fh, this reg is 0 */
+	pci_read_config_dword(pdev, REG_CPUID, &cpuid);
+
+	data->fam = (cpuid & 0x00000f00) >> 8;
+	data->fam += (cpuid & 0x00f00000) >> 20;
+
+	switch (data->fam) {
+		case 0xf:
+			dev_warn(&pdev->dev, "Temperature readouts might be wrong"
+						" - check errata #141\n");
+	}
+
 	pci_read_config_byte(pdev, REG_TEMP, &scfg);
 	scfg &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
 	pci_write_config_byte(pdev, REG_TEMP, scfg);

--------------040809060805030409050604
Content-Type: application/octet-stream;
 name="k8temp_add_warning.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="k8temp_add_warning.patch.sig"

iD8DBQBI4/UF3J9wPJqZRNURAvJuAKC7XAYZVr7tUOa5iiOP+v1Pzt9H/ACglUjnOytF04Kx
yOJvVz7s01idS8Q=
--------------040809060805030409050604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040809060805030409050604--
