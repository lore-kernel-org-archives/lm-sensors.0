From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: kernel dmi_scan.c patch
Message-Id: <3D5EFF1F.17DEDFE8@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Albert,
here is a patch for you to submit.
It creates a new global variable, is_broken_smbus,
which we can use in i2c-piix4 to not load.
The variable gets set to 1 if an IBM system ID is detected
in the DMI information.

mds
-------------- next part --------------
--- dmi_scan.c.orig	Wed Jul 24 21:07:39 2002
+++ dmi_scan.c	Wed Aug 14 22:13:09 2002
@@ -13,6 +13,7 @@
 
 unsigned long dmi_broken;
 int is_sony_vaio_laptop;
+int is_broken_smbus;
 
 struct dmi_header
 {
@@ -468,6 +469,20 @@
 	return 0;
 }
 
+/* 
+ * Don't access SMBus on IBM systems which get corrupted eeproms 
+ */
+
+static __init int disable_smbus(struct dmi_blacklist *d)
+{
+	if (is_broken_smbus = 0)
+	{
+		is_broken_smbus = 1;
+		printk(KERN_INFO "%s machine detected. Disabling SMBus accesses.\n", d->ident);
+	}
+	return 0;
+}
+
 /*
  *	Simple "print if true" callback
  */
@@ -737,6 +752,15 @@
 	 */
 	 
 	{ set_apm_ints, "IBM", {	/* Allow interrupts during suspend on IBM laptops */
+			MATCH(DMI_SYS_VENDOR, "IBM"),
+			NO_MATCH, NO_MATCH, NO_MATCH
+			} },
+
+	/*
+	 *	SMBus / sensors settings
+	 */
+	 
+	{ disable_smbus, "IBM", {
 			MATCH(DMI_SYS_VENDOR, "IBM"),
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
