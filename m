From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jan 2012 12:43:33 +0000
Subject: [lm-sensors] [RFC PATCH 2/3] hwmon: (hwmon-vid) Fix checkpatch issues
Message-Id: <1327495414-6256-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: space required before the open parenthesis '('
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

Not fixed (url):
WARNING: line over 80 characters

Not fixed (false positive):
ERROR: Macros with complex values should be enclosed in parenthesis

Cc: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon-vid.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 5ec5e37..40b50b4 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -83,18 +83,18 @@ int vid_from_reg(int val, u8 vrm)
 {
 	int vid;
 
-	switch(vrm) {
+	switch (vrm) {
 
-	case 100:               /* VRD 10.0 */
+	case 100:		/* VRD 10.0 */
 		/* compute in uV, round to mV */
 		val &= 0x3f;
-		if((val & 0x1f) = 0x1f)
+		if ((val & 0x1f) = 0x1f)
 			return 0;
-		if((val & 0x1f) <= 0x09 || val = 0x0a)
+		if ((val & 0x1f) <= 0x09 || val = 0x0a)
 			vid = 1087500 - (val & 0x1f) * 25000;
 		else
 			vid = 1862500 - (val & 0x1f) * 25000;
-		if(val & 0x20)
+		if (val & 0x20)
 			vid -= 12500;
 		return (vid + 500) / 1000;
 
@@ -119,7 +119,7 @@ int vid_from_reg(int val, u8 vrm)
 	case 90:		/* VRM 9.0 */
 		val &= 0x1f;
 		return val = 0x1f ? 0 :
-		                       1850 - val * 25;
+				     1850 - val * 25;
 
 	case 85:		/* VRM 8.5 */
 		val &= 0x1f;
@@ -134,7 +134,7 @@ int vid_from_reg(int val, u8 vrm)
 		val &= 0x1f;
 		return val = 0x1f ? 0 :
 		       val & 0x10  ? 5100 - (val) * 100 :
-		                     2050 - (val) * 50;
+				     2050 - (val) * 50;
 	case 17:		/* Intel IMVP-II */
 		val &= 0x1f;
 		return val & 0x10 ? 975 - (val & 0xF) * 25 :
@@ -157,7 +157,7 @@ int vid_from_reg(int val, u8 vrm)
 		return 0;
 	}
 }
-
+EXPORT_SYMBOL(vid_from_reg);
 
 /*
  * After this point is the code to automatically determine which
@@ -299,8 +299,6 @@ u8 vid_which_vrm(void)
 	return 0;
 }
 #endif
-
-EXPORT_SYMBOL(vid_from_reg);
 EXPORT_SYMBOL(vid_which_vrm);
 
 MODULE_AUTHOR("Rudolf Marek <r.marek@assembler.cz>");
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
