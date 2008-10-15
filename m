From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Oct 2008 14:41:11 +0000
Subject: [lm-sensors] [PATCH] hwmon-vid: Add support for AMD family 10h CPUs
Message-Id: <20081015164111.39112422@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The AMD family 10h CPUs use the same VID decoding table as the family
0Fh CPUs.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
Testers welcome, thanks.

 drivers/hwmon/hwmon-vid.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.28-rc0.orig/drivers/hwmon/hwmon-vid.c	2008-10-14 19:07:40.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/hwmon-vid.c	2008-10-14 19:09:54.000000000 +0200
@@ -182,6 +182,7 @@ static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
 	{X86_VENDOR_AMD, 0xF, 0x3F, ANY, 24},		/* Athlon 64, Opteron */
 	{X86_VENDOR_AMD, 0xF, ANY, ANY, 25},		/* NPT family 0Fh */
+	{X86_VENDOR_AMD, 0x10, ANY, ANY, 25},		/* NPT family 10h */
 	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 13},		/* Pentium M (130 nm) */
 	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
 	{X86_VENDOR_INTEL, 0x6, 0xD, ANY, 13},		/* Pentium M (90 nm) */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
