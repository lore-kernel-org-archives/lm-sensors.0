From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Fri, 05 Aug 2005 17:40:30 +0000
Subject: [lm-sensors] [PATCH] VID table update
Message-Id: <20050805154011.23290.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch updates the VID entries, so any future
Intel CPU will be detected as unknown rather than 9.0

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

Please apply on the top of Jean's "hwmon vs i2c, second round" patches.

Thanks

Regards
Rudolf

diff -Naur b/drivers/hwmon/hwmon-vid.c c/drivers/hwmon/hwmon-vid.c
--- b/drivers/hwmon/hwmon-vid.c	2005-08-05 17:25:11.000000000 +0200
+++ c/drivers/hwmon/hwmon-vid.c	2005-08-05 17:23:19.000000000 +0200
@@ -138,8 +138,11 @@
 	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* Tualatin */
 	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
 	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */
+	{X86_VENDOR_INTEL, 0xF, 0x0, 90},	/* P4 */
+	{X86_VENDOR_INTEL, 0xF, 0x1, 90},	/* P4 Willamette */
+	{X86_VENDOR_INTEL, 0xF, 0x2, 90},	/* P4 Northwood */
 	{X86_VENDOR_INTEL, 0xF, 0x3, 100},	/* P4 Prescott */
-	{X86_VENDOR_INTEL, 0xF, ANY, 90},	/* P4 before Prescott */
+	{X86_VENDOR_INTEL, 0xF, 0x4, 100},	/* P4 Prescott */
 	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */
 	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
 };
