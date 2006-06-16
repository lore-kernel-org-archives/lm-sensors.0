From: gregkh@suse.de (gregkh at suse.de)
Date: Fri, 16 Jun 2006 22:48:04 +0000
Subject: [lm-sensors] patch hwmon-vid-add-core-and-conroe-support.patch
Message-Id: <20060616225058.33395754C01@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 14/14] hwmon-vid: Add support for Intel Core and Conroe

to my gregkh-2.6 tree.  Its filename is

     hwmon-vid-add-core-and-conroe-support.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Mon Jun 12 13:00:57 2006
Date: Mon, 12 Jun 2006 22:00:53 +0200
From: Rudolf Marek <r.marek at sh.cvut.cz>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Rudolf Marek <r.marek at sh.cvut.cz>
Subject: [PATCH 14/14] hwmon-vid: Add support for Intel Core and Conroe
Message-Id: <20060612220053.622e56c6.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-vid-add-core-and-conroe-support.patch

From: Rudolf Marek <r.marek at sh.cvut.cz>

This patch adds support for two new VID codes, supporting Intel mobile Core
processors and new Conroe based platforms.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

--- linux-2.6.17-rc6.orig/drivers/hwmon/hwmon-vid.c	2006-06-11 13:49:25.000000000 +0200
+++ linux-2.6.17-rc6/drivers/hwmon/hwmon-vid.c	2006-06-11 16:20:34.000000000 +0200
@@ -58,11 +58,20 @@
     doesn't seem to be any named specification for these. The conversion
     tables are detailed directly in the various Pentium M datasheets:
     http://www.intel.com/design/intarch/pentiumm/docs_pentiumm.htm
+
+    The 14 specification corresponds to Intel Core series. There
+    doesn't seem to be any named specification for these. The conversion
+    tables are detailed directly in the various Pentium Core datasheets:
+    http://www.intel.com/design/mobile/datashts/309221.htm
+
+    The 110 (VRM 11) specification corresponds to Intel Conroe based series.
+    http://www.intel.com/design/processor/applnots/313214.htm
 */
 
 /* vrm is the VRM/VRD document version multiplied by 10.
-   val is the 4-, 5- or 6-bit VID code.
-   Returned value is in mV to avoid floating point in the kernel. */
+   val is the 4-bit or more VID code.
+   Returned value is in mV to avoid floating point in the kernel.
+   Some VID have some bits in uV scale, this is rounded to mV */
 int vid_from_reg(int val, u8 vrm)
 {
 	int vid;
@@ -70,18 +79,24 @@
 	switch(vrm) {
 
 	case 100:               /* VRD 10.0 */
+		/* compute in uV, round to mV */
 		val &= 0x3f;
 		if((val & 0x1f) = 0x1f)
 			return 0;
 		if((val & 0x1f) <= 0x09 || val = 0x0a)
-			vid = 10875 - (val & 0x1f) * 250;
+			vid = 1087500 - (val & 0x1f) * 25000;
 		else
-			vid = 18625 - (val & 0x1f) * 250;
+			vid = 1862500 - (val & 0x1f) * 25000;
 		if(val & 0x20)
-			vid -= 125;
-		vid /= 10;      /* only return 3 dec. places for now */
-		return vid;
+			vid -= 12500;
+		return((vid + 500) / 1000);
 
+	case 110:		/* Intel Conroe */
+				/* compute in uV, round to mV */
+		val &= 0xff;
+		if(((val & 0x7e) = 0xfe) || (!(val & 0x7e)))
+			return 0;
+		return((1600000 - (val - 2) * 6250 + 500) / 1000);
 	case 24:                /* Opteron processor */
 		val &= 0x1f;
 		return(val = 0x1f ? 0 : 1550 - val * 25);
@@ -113,6 +128,10 @@
 	case 13:
 		val &= 0x3f;
 		return(1708 - val * 16);
+	case 14:		/* Intel Core */
+				/* compute in uV, round to mV */
+		val &= 0x7f;
+		return(val > 0x77 ? 0 : (1500000 - (val * 12500) + 500) / 1000);
 	default:		/* report 0 for unknown */
 		printk(KERN_INFO "hwmon-vid: requested unknown VRM version\n");
 		return 0;
@@ -145,6 +164,8 @@
 	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 13},		/* Pentium M (130 nm) */
 	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
 	{X86_VENDOR_INTEL, 0x6, 0xD, ANY, 13},		/* Pentium M (90 nm) */
+	{X86_VENDOR_INTEL, 0x6, 0xE, ANY, 14},		/* Intel Core (65 nm) */
+	{X86_VENDOR_INTEL, 0x6, 0xF, ANY, 110},		/* Intel Conroe */
 	{X86_VENDOR_INTEL, 0x6, ANY, ANY, 82},		/* any P6 */
 	{X86_VENDOR_INTEL, 0x7, ANY, ANY, 0},		/* Itanium */
 	{X86_VENDOR_INTEL, 0xF, 0x0, ANY, 90},		/* P4 */

-- 
Jean Delvare



Patches currently in gregkh-2.6 which might be from r.marek at sh.cvut.cz are

i2c/hwmon-w83627ehf-add-alarms.patch
i2c/hwmon-w83627ehf-add-voltages.patch
i2c/i2c-piix4-add-ati-smbus-support.patch
i2c/i2c-piix4-remove-fix_hstcfg-parameter.patch
i2c/hwmon-vid-mask-per-vrm.patch
i2c/hwmon-w83791d-new-driver.patch
i2c/hwmon-sysfs-interface-update-1.patch
i2c/hwmon-vid-add-core-and-conroe-support.patch

