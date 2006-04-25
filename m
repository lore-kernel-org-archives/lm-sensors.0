From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Apr 2006 12:24:46 +0000
Subject: [lm-sensors] [PATCH 10/10] hwmon: Trim VID values to correct number
Message-Id: <20060425142446.4efec6a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at sh.cvut.cz>
Content-Disposition: inline; filename=hwmon-vid-mask-per-vrm.patch

Following patch trims the VID value to correct number of bits
for each VRM.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/hwmon-vid.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc1.orig/drivers/hwmon/hwmon-vid.c	2006-04-03 20:12:39.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/hwmon-vid.c	2006-04-16 10:18:13.000000000 +0200
@@ -70,6 +70,7 @@
 	switch(vrm) {
 
 	case 100:               /* VRD 10.0 */
+		val &= 0x3f;
 		if((val & 0x1f) = 0x1f)
 			return 0;
 		if((val & 0x1f) <= 0x09 || val = 0x0a)
@@ -82,14 +83,17 @@
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
@@ -98,14 +102,17 @@
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
Jean Delvare

