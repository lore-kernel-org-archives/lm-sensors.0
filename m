From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 22:21:05 +0000
Subject: [lm-sensors] [PATCH 04/11] hwmon: Support the Pentium M VID code
Message-Id: <20060205232105.41cbfcac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-vid-pentium-m.patch

Add support for the Intel Pentium M series to the hwmon-vid driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Rudolf Marek <r.marek at sh.cvut.cz>
---
 drivers/hwmon/hwmon-vid.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc1.orig/drivers/hwmon/hwmon-vid.c	2006-01-18 18:28:57.000000000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/hwmon-vid.c	2006-02-02 22:41:54.000000000 +0100
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
@@ -129,8 +135,9 @@
 static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
 	{X86_VENDOR_AMD, 0xF, ANY, ANY, 24},		/* Athlon 64, Opteron and above VRM 24 */
-	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 85},		/* 0.13um too */
+	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 13},		/* Pentium M (130 nm) */
 	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
+	{X86_VENDOR_INTEL, 0x6, 0xD, ANY, 13},		/* Pentium M (90 nm) */
 	{X86_VENDOR_INTEL, 0x6, ANY, ANY, 82},		/* any P6 */
 	{X86_VENDOR_INTEL, 0x7, ANY, ANY, 0},		/* Itanium */
 	{X86_VENDOR_INTEL, 0xF, 0x0, ANY, 90},		/* P4 */

-- 
Jean Delvare

