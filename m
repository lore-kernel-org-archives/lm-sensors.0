From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:44 +0000
Subject: [lm-sensors] [PATCH 18/44] [PATCH] HWMON: Trim VID values to
Message-Id: <11510009522432-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at sh.cvut.cz>

Following patch trims the VID value to correct number of bits
for each VRM.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/hwmon-vid.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index a74a44f..b0fd267 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -70,6 +70,7 @@ int vid_from_reg(int val, u8 vrm)
 	switch(vrm) {
 
 	case 100:               /* VRD 10.0 */
+		val &= 0x3f;
 		if((val & 0x1f) = 0x1f)
 			return 0;
 		if((val & 0x1f) <= 0x09 || val = 0x0a)
@@ -82,14 +83,17 @@ int vid_from_reg(int val, u8 vrm)
 		return vid;
 
 	case 24:                /* Opteron processor */
+		val &= 0x1f;
 		return(val = 0x1f ? 0 : 1550 - val * 25);
 
 	case 91:		/* VRM 9.1 */
 	case 90:		/* VRM 9.0 */
+		val &= 0x1f;
 		return(val = 0x1f ? 0 :
 		                       1850 - val * 25);
 
 	case 85:		/* VRM 8.5 */
+		val &= 0x1f;
 		return((val & 0x10  ? 25 : 0) +
 		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
 		       ((val & 0x0f) * 50));
@@ -98,14 +102,17 @@ int vid_from_reg(int val, u8 vrm)
 		val &= 0x0f;
 				/* fall through */
 	case 82:		/* VRM 8.2 */
+		val &= 0x1f;
 		return(val = 0x1f ? 0 :
 		       val & 0x10  ? 5100 - (val) * 100 :
 		                     2050 - (val) * 50);
 	case 17:		/* Intel IMVP-II */
+		val &= 0x1f;
 		return(val & 0x10 ? 975 - (val & 0xF) * 25 :
 				    1750 - val * 50);
 	case 13:
-		return(1708 - (val & 0x3f) * 16);
+		val &= 0x3f;
+		return(1708 - val * 16);
 	default:		/* report 0 for unknown */
 		printk(KERN_INFO "hwmon-vid: requested unknown VRM version\n");
 		return 0;
-- 
1.4.0


