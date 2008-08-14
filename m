From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Aug 2008 18:33:19 +0000
Subject: [lm-sensors] [PATCH v2] hwmon-vid: Fix AMD K8 VID decoding
Message-Id: <20080814203319.3052d48f@hyperion.delvare>
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
Patch updated... First version was incorrect.

 drivers/hwmon/hwmon-vid.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- linux-2.6.27-rc3.orig/drivers/hwmon/hwmon-vid.c	2008-08-13 09:50:50.000000000 +0200
+++ linux-2.6.27-rc3/drivers/hwmon/hwmon-vid.c	2008-08-14 19:55:26.000000000 +0200
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
@@ -157,11 +160,16 @@ struct vrm_model {
 
 #ifdef CONFIG_X86
 
-/* the stepping parameter is highest acceptable stepping for current line */
+/*
+ * The stepping parameter is highest acceptable stepping for current line.
+ * The model match must be exact for 4-bit values. For model values 0x10
+ * and above (extended model), all models below the parameter will match.
+ */
 
 static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
-	{X86_VENDOR_AMD, 0xF, ANY, ANY, 24},		/* Athlon 64, Opteron and above VRM 24 */
+	{X86_VENDOR_AMD, 0xF, 0x2F, ANY, 24},		/* Athlon 64, Opteron */
+	{X86_VENDOR_AMD, 0xF, ANY, ANY, 25},		/* NPT family 0Fh */
 	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 13},		/* Pentium M (130 nm) */
 	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
 	{X86_VENDOR_INTEL, 0x6, 0xD, ANY, 13},		/* Pentium M (90 nm) */
@@ -189,6 +197,8 @@ static u8 find_vrm(u8 eff_family, u8 eff
 		if (vrm_models[i].vendor=vendor)
 			if ((vrm_models[i].eff_family=eff_family)
 			 && ((vrm_models[i].eff_model=eff_model) ||
+			     (vrm_models[i].eff_model >= 0x10 &&
+			      eff_model <= vrm_models[i].eff_model) ||
 			     (vrm_models[i].eff_model=ANY)) &&
 			     (eff_stepping <= vrm_models[i].eff_stepping))
 				return vrm_models[i].vrm_type;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
