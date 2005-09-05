From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:41 +0000
Subject: [lm-sensors] [PATCH] hwmon: VID table update
Message-Id: <11259567693419@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: VID table update

This patch updates the VID entries, so any future
Intel CPU will be detected as unknown rather than 9.0

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3b6c0634cc989f0735a1541ccf9288947685cab5
tree 55c4697ce3835e35148d18572ceb7a30253b315e
parent 19f673eddb5a406be72989fb57b7f286772b8cf4
author R.Marek@sh.cvut.cz <R.Marek@sh.cvut.cz> Fri, 05 Aug 2005 15:40:11 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:24 -0700

 drivers/hwmon/hwmon-vid.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -122,8 +122,11 @@ static struct vrm_model vrm_models[] = {
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

