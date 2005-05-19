From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040404152809.4ed5dc48.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> > 1* Doesn't include our dmi_scan.
> > 2* Patches the kernel one.
> >
> > 1 is trivial, and 2 should not be too hard.
> 
> I'd like to reroll RHL & FC kernels (2.4.20 and 2.4.22 based), and fix
> also the dmi_scan issue. Has any of the above suggestions found its
> way into i2c CVS (I'd love a
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> patch :)?

No, I have to admit I had completely forgotten about this issue and
nothing was done.

I just took a look at the files and I think I missed a step in my first
plan. The problem is that our dmi_scan module exports the whole DMI
information and leaves it do i2c-piix4 to compare the strings, while the
kernel's dmi_scan, once patched, would preferably export a simple flag.

So step 1 is to make our own dmi_scan compute and export that flag
instead of the whole data, and change i2c-piix4 so that it always looks
for the flag and doesn't try to access the whole data. I just did that,
proposed patch to lm_sensors2 attached.

I do *not* want to apply it right now since we're about to release and
this is a sensible change. You can still apply it before building your
RPMs.

Step 2 is that lm_sensors2's mkpatch shouldn't include dmi_scan.c/.h.
Easy, patch attached.

Step 3 is that lm_sensors2's mkpatch should include a patch to
arch/i386/kernel/dmi_scan.c. This is the hardest part. Even before
changing mkpatch so that it is able to dynamically create the patch (it
must work with every kernel version), we have to make sure that we agree
on what has to be done exactly.

Attached is my proposal for a kernel 2.4.22. It looks like we have to
patch i386_ksyms.c as well.

Please note that these changes do not belong to the i2c package. For
this reason, I don't think it would be a good idea to include them to
the i2c patch, as you once suggested IIRC. This would make things even
more complex in the end.

> Or should I use one of the less favoured, but easier (for me) to
> implement solutions (renaming files)?

Well, I invite you to test the patches attached, and tell us how it is
working for you. Note that I didn't test anything myself (except that it
still compiles).

If it works OK and nobody objects, after 2.8.6 has been released, I'll
apply the changes our CVS repository and hack mkpatch.pl so that it
learns how to generate the kernel patch to dmi_scan regardless of the
kernel version.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: kernel/busses/dmi_scan.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/dmi_scan.c,v
retrieving revision 1.9
diff -u -r1.9 dmi_scan.c
--- kernel/busses/dmi_scan.c	31 Jul 2003 12:56:35 -0000	1.9
+++ kernel/busses/dmi_scan.c	4 Apr 2004 13:19:41 -0000
@@ -16,7 +16,9 @@
 #include <asm/keyboard.h>
 #include <asm/system.h>
 #include "version.h"
-#include "dmi_scan.h"
+
+int is_unsafe_smbus;
+EXPORT_SYMBOL(is_unsafe_smbus);
 
 struct dmi_header
 {
@@ -25,6 +27,20 @@
 	u16	handle;
 };
 
+enum
+{
+	DMI_BIOS_VENDOR,
+	DMI_BIOS_VERSION,
+	DMI_BIOS_DATE,
+	DMI_SYS_VENDOR,
+	DMI_PRODUCT_NAME,
+	DMI_PRODUCT_VERSION,
+	DMI_BOARD_VENDOR,
+	DMI_BOARD_NAME,
+	DMI_BOARD_VERSION,
+	DMI_STRING_MAX
+};
+
 #define dmi_printk(x)
 //#define dmi_printk(x) printk x
 
@@ -211,7 +227,7 @@
 	}
 }
 
-void __init dmi_scan_mach(void)
+int __init dmi_scan_mach(void)
 {
 	int err;
 	printk("dmi_scan.o version %s (%s)\n", LM_VERSION, LM_DATE);
@@ -220,9 +236,14 @@
 		printk("dmi_scan.o: SM BIOS not found\n");
 	else
 		printk("dmi_scan.o: SM BIOS found\n");
+
+	if(dmi_ident[DMI_SYS_VENDOR] != NULL
+	&& strncmp(dmi_ident[DMI_SYS_VENDOR], "IBM", 3) = 0)
+		is_unsafe_smbus = 1;
+	return 0;
 }
 
 MODULE_DESCRIPTION("SM BIOS DMI Scanner");
 MODULE_LICENSE("GPL");
-EXPORT_SYMBOL(dmi_ident);
-EXPORT_SYMBOL(dmi_scan_mach);
+
+module_init(dmi_scan_mach);
Index: kernel/busses/dmi_scan.h
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/dmi_scan.h,v
retrieving revision 1.1
diff -u -r1.1 dmi_scan.h
--- kernel/busses/dmi_scan.h	2 Aug 2002 01:56:56 -0000	1.1
+++ kernel/busses/dmi_scan.h	4 Apr 2004 13:19:41 -0000
@@ -1,15 +0,0 @@
-enum
-{
-	DMI_BIOS_VENDOR,
-	DMI_BIOS_VERSION,
-	DMI_BIOS_DATE,
-	DMI_SYS_VENDOR,
-	DMI_PRODUCT_NAME,
-	DMI_PRODUCT_VERSION,
-	DMI_BOARD_VENDOR,
-	DMI_BOARD_NAME,
-	DMI_BOARD_VERSION,
-	DMI_STRING_MAX
-};
-
-extern char *dmi_ident[DMI_STRING_MAX];
Index: kernel/busses/i2c-piix4.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-piix4.c,v
retrieving revision 1.62
diff -u -r1.62 i2c-piix4.c
--- kernel/busses/i2c-piix4.c	27 Jan 2004 02:47:35 -0000	1.62
+++ kernel/busses/i2c-piix4.c	4 Apr 2004 13:19:42 -0000
@@ -41,7 +41,6 @@
 #include <linux/apm_bios.h>
 #include <asm/io.h>
 #include "version.h"
-#include "dmi_scan.h"
 
 
 struct sd {
@@ -116,25 +115,11 @@
 /*
  * Get DMI information.
  */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,34)
-void dmi_scan_mach(void);
-#endif
 
 static int __devinit ibm_dmi_probe(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
 	extern int is_unsafe_smbus;
 	return is_unsafe_smbus;
-#else
-#define IBM_SIGNATURE		"IBM"
-	dmi_scan_mach();
-	if(dmi_ident[DMI_SYS_VENDOR] = NULL)
-		return 0;
-	if(strncmp(dmi_ident[DMI_SYS_VENDOR], IBM_SIGNATURE,
-	           strlen(IBM_SIGNATURE)) = 0)
-		return 1;
-	return 0;
-#endif
 }
 #endif
 
-------------- next part --------------
Index: mkpatch/FILES
=================================RCS file: /home/cvs/lm_sensors2/mkpatch/FILES,v
retrieving revision 1.26
diff -u -r1.26 FILES
--- mkpatch/FILES	23 Jan 2004 17:35:55 -0000	1.26
+++ mkpatch/FILES	4 Apr 2004 13:19:56 -0000
@@ -1,5 +1,3 @@
-kernel/busses/dmi_scan.c	drivers/i2c/dmi_scan.c
-kernel/busses/dmi_scan.h	include/linux/dmi_scan.h
 kernel/busses/i2c-ali1535.c	drivers/i2c/i2c-ali1535.c
 kernel/busses/i2c-ali15x3.c	drivers/i2c/i2c-ali15x3.c
 kernel/busses/i2c-amd756.c	drivers/i2c/i2c-amd756.c
-------------- next part --------------
--- linux-2.4.22/arch/i386/kernel/dmi_scan.c.orig	Sun Apr  4 15:04:20 2004
+++ linux-2.4.22/arch/i386/kernel/dmi_scan.c	Sun Apr  4 15:14:08 2004
@@ -15,6 +15,7 @@
 
 unsigned long dmi_broken;
 int is_sony_vaio_laptop;
+int is_unsafe_smbus;
 
 struct dmi_header
 {
@@ -406,6 +407,19 @@
 	return 0;
 }		
 
+/* 
+ * Don't access SMBus on IBM systems which get corrupted eeproms 
+ */
+
+static __init int disable_smbus(struct dmi_blacklist *d)
+{   
+	if (is_unsafe_smbus = 0) {
+		is_unsafe_smbus = 1;
+		printk(KERN_INFO "%s machine detected. Disabling SMBus accesses.\n", d->ident);
+	}
+	return 0;
+}
+
 /*
  * Check for a Sony Vaio system
  *
@@ -740,6 +754,10 @@
 			NO_MATCH, NO_MATCH,
 			} },
 
+	{ disable_smbus, "IBM", {
+			MATCH(DMI_SYS_VENDOR, "IBM"),
+			NO_MATCH, NO_MATCH, NO_MATCH
+			} },
 	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
 			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 			MATCH(DMI_PRODUCT_NAME, "PCG-"),
--- linux-2.4.22/arch/i386/kernel/i386_ksyms.c.orig	Sun Apr  4 15:16:55 2004
+++ linux-2.4.22/arch/i386/kernel/i386_ksyms.c	Sun Apr  4 15:15:49 2004
@@ -177,6 +177,9 @@
 extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
+extern int is_unsafe_smbus;
+EXPORT_SYMBOL(is_unsafe_smbus);
+
 #ifdef CONFIG_MULTIQUAD
 EXPORT_SYMBOL(xquad_portio);
 #endif
