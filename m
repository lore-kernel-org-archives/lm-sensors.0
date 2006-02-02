From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 02 Feb 2006 21:19:15 +0000
Subject: [lm-sensors] [PATCH] hwmon: Support for Pentium M VRM
Message-Id: <20060202221915.72ac77e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

The following patch adds support for the Intel Pentium M series to the
hwmon-vid driver.

Rudolf, does it look OK to you?

Thanks.

Add support for the Intel Pentium M series to the hwmon-vid driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/hwmon-vid.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.16-rc1.orig/drivers/hwmon/hwmon-vid.c	2006-01-18 18:28:57.000000000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/hwmon-vid.c	2006-02-02 22:16:44.000000000 +0100
@@ -54,6 +54,10 @@
     (IMVP-II). You can find more information in the datasheet of Max1718
     http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2452
 
+    The 13 specification corresponds to the Intel Pentium M series. There
+    doesn't seem to be any named specification for these. The conversion
+    tables are detailed directly in the various Pentium M datasheets:
+    http://www.intel.com/design/intarch/pentiumm/docs_pentiumm.htm
 */
 
 /* vrm is the VRM/VRD document version multiplied by 10.
@@ -100,6 +104,8 @@
 	case 17:		/* Intel IMVP-II */
 		return(val & 0x10 ? 975 - (val & 0xF) * 25 :
 				    1750 - val * 50);
+	case 13:
+		return(1708 - (val & 0x3f) * 16);
 	default:		/* report 0 for unknown */
 		printk(KERN_INFO "hwmon-vid: requested unknown VRM version\n");
 		return 0;
@@ -131,6 +137,7 @@
 	{X86_VENDOR_AMD, 0xF, ANY, ANY, 24},		/* Athlon 64, Opteron and above VRM 24 */
 	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 85},		/* 0.13um too */
 	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
+	{X86_VENDOR_INTEL, 0x6, 0xD, ANY, 13},		/* Pentium M */
 	{X86_VENDOR_INTEL, 0x6, ANY, ANY, 82},		/* any P6 */
 	{X86_VENDOR_INTEL, 0x7, ANY, ANY, 0},		/* Itanium */
 	{X86_VENDOR_INTEL, 0xF, 0x0, ANY, 90},		/* P4 */


-- 
Jean Delvare

