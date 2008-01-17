From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 17 Jan 2008 23:50:04 +0000
Subject: [lm-sensors] [PATCH] coretemp: Add Penryn CPU to coretemp
Message-Id: <478FE9AC.30804@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030407000000040800030906"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030407000000040800030906
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

This patch adds support for family 0x17, which has Penryn Core. It should also
cover the 8 cores Xeons.

Can someone test please? I think it should work.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHj+ms3J9wPJqZRNURAqKoAJwLGJSgU2k1ke0Gn3550qMaWfIyGQCgimyV
Fl8HRd1y4ecNQ7SqSMx3RL0=
=8BPU
-----END PGP SIGNATURE-----

--------------030407000000040800030906
Content-Type: text/x-patch;
 name="add-penryn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-penryn.patch"

Index: linux-2.6.24-rc7/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.24-rc7.orig/drivers/hwmon/coretemp.c	2008-01-18 00:32:26.147387823 +0100
+++ linux-2.6.24-rc7/drivers/hwmon/coretemp.c	2008-01-18 00:33:49.220121868 +0100
@@ -414,10 +414,10 @@
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &cpu_data(i);
 
-		/* check if family 6, models e, f, 16 */
+		/* check if family 6, models 0xe, 0xf, 0x16, 0x17 */
 		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
 		    !((c->x86_model == 0xe) || (c->x86_model == 0xf) ||
-			(c->x86_model == 0x16))) {
+			(c->x86_model == 0x16) || (c->x86_model == 0x17))) {
 
 			/* supported CPU not found, but report the unknown
 			   family 6 CPU */
Index: linux-2.6.24-rc7/Documentation/hwmon/coretemp
===================================================================
--- linux-2.6.24-rc7.orig/Documentation/hwmon/coretemp	2008-01-18 00:34:00.776780445 +0100
+++ linux-2.6.24-rc7/Documentation/hwmon/coretemp	2008-01-18 00:35:39.646414704 +0100
@@ -4,9 +4,10 @@
 Supported chips:
   * All Intel Core family
     Prefix: 'coretemp'
-    CPUID: family 0x6, models 0xe, 0xf, 0x16
+    CPUID: family 0x6, models 0xe, 0xf, 0x16, 0x17
     Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
                Volume 3A: System Programming Guide
+               http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
 
 Author: Rudolf Marek
 

--------------030407000000040800030906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030407000000040800030906--
