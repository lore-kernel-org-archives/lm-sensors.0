From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Aug 2008 16:52:10 +0000
Subject: [lm-sensors] [PATCH] hwmon-vid: Fix AMD K8 VID decoding
Message-Id: <20080814185210.24002986@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Not all AMD K8 / family 0Fh have 6 VID pins. Older models have only 5
VID pins, so we need two entries in the hwmon-vid table.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Frank Myhr <fmyhr@fhmtech.com>
Cc: Jean-Luc Coulon <jean.luc.coulon@gmail.com>
---
Frank, this is my suggested fix for kernel bug #11329:
http://bugzilla.kernel.org/show_bug.cgi?id329

Can you please review and test it? Thanks.

 drivers/hwmon/hwmon-vid.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.27-rc3.orig/drivers/hwmon/hwmon-vid.c	2008-08-13 09:50:50.000000000 +0200
+++ linux-2.6.27-rc3/drivers/hwmon/hwmon-vid.c	2008-08-14 18:39:50.000000000 +0200
@@ -95,7 +95,10 @@ int vid_from_reg(int val, u8 vrm)
 			return 0;
 		return((1600000 - (val - 2) * 6250 + 500) / 1000);
 
-	case 24:		/* AMD NPT 0Fh (Athlon64 & Opteron) */
+	case 24:		/* Athlon64 & Opteron */
+		val &= 0x1f;
+				/* fall through */
+	case 25:		/* AMD NPT 0Fh */
 		val &= 0x3f;
 		return (val < 32) ? 1550 - 25 * val
 			: 775 - (25 * (val - 31)) / 2;
@@ -161,7 +164,8 @@ struct vrm_model {
 
 static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
-	{X86_VENDOR_AMD, 0xF, ANY, ANY, 24},		/* Athlon 64, Opteron and above VRM 24 */
+	{X86_VENDOR_AMD, 0xF, 0x2F, ANY, 24},		/* Athlon 64, Opteron */
+	{X86_VENDOR_AMD, 0xF, ANY, ANY, 25},		/* NPT family 0Fh */
 	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 13},		/* Pentium M (130 nm) */
 	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
 	{X86_VENDOR_INTEL, 0x6, 0xD, ANY, 13},		/* Pentium M (90 nm) */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
