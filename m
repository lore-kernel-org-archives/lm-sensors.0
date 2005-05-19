From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: vid version detection fix
Message-Id: <Pine.LNX.4.58.0412231501400.18510@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

AMD 64 uses same VID table as Opteron.
Please apply.

Regards

Rudolf

Source:
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/25112.PDF

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>


diff -Naur b/drivers/i2c/i2c-sensor-vid.c a/drivers/i2c/i2c-sensor-vid.c
--- b/drivers/i2c/i2c-sensor-vid.c	2004-10-18 23:55:06.000000000 +0200
+++ a/drivers/i2c/i2c-sensor-vid.c	2004-12-23 14:51:13.000000000 +0100
@@ -36,8 +36,7 @@

 static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
-	{X86_VENDOR_AMD, 0xF, 0x4, 90},		/* Athlon 64 */
-	{X86_VENDOR_AMD, 0xF, 0x5, 24},		/* Opteron */
+	{X86_VENDOR_AMD, 0xF, ANY, 24},		/* Athlon 64, Opteron */
 	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
 	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* 0xB Tualatin */
 	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
@@ -87,7 +86,7 @@
 	return vrm_ret;
 }

-/* and now something completely different for Non-x86 world*/
+/* and now for something completely different for Non-x86 world*/
 #else
 int i2c_which_vrm(void)
 {
