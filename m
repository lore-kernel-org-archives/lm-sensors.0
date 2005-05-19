From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: [PATCH 2.6] Add Intel VRD 10.0 and AMD Opteron VID support
Message-Id: <20040916040048.GC25840@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch adds support for Intel VRD 10.0 and AMD Opteron VID calculations.
It is based on the lm_sensors project CVS, r1.6.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.9-rc2/include/linux/i2c-vid.h
=================================--- linux-2.6.9-rc2.orig/include/linux/i2c-vid.h	2004-09-15 22:45:16.094005498 -0400
+++ linux-2.6.9-rc2/include/linux/i2c-vid.h	2004-09-15 22:50:25.870720679 -0400
@@ -29,7 +29,22 @@
 */
 
 /*
-    Legal val values 00 - 1F.
+    AMD Opteron processors don't follow the Intel VRM spec.
+    I'm going to "make up" 2.4 as the VRM spec for the Opterons.
+    No good reason just a mnemonic for the 24x Opteron processor
+    series
+
+    Opteron VID encoding is:
+
+       00000  =  1.550 V
+       00001  =  1.525 V
+        . . . .
+       11110  =  0.800 V
+       11111  =  0.000 V (off)
+ */
+
+/*
+    Legal val values 0x00 - 0x1f; except for VRD 10.0, 0x00 - 0x3f.
     vrm is the Intel VRM document version.
     Note: vrm version is scaled by 10 and the return value is scaled by 1000
     to avoid floating point in the kernel.
@@ -41,9 +56,28 @@ int i2c_which_vrm(void);
 
 static inline int vid_from_reg(int val, int vrm)
 {
+	int vid;
+
 	switch(vrm) {
+
 	case  0:
 		return 0;
+
+	case 100:               /* VRD 10.0 */
+		if((val & 0x1f) = 0x1f)
+			return 0;
+		if((val & 0x1f) <= 0x09 || val = 0x0a)
+			vid = 10875 - (val & 0x1f) * 250;
+		else
+			vid = 18625 - (val & 0x1f) * 250;
+		if(val & 0x20)
+			vid -= 125;
+		vid /= 10;      /* only return 3 dec. places for now */
+		return vid;
+
+	case 24:                /* Opteron processor */
+		return(val = 0x1f ? 0 : 1550 - val * 25);
+
 	case 91:		/* VRM 9.1 */
 	case 90:		/* VRM 9.0 */
 		return(val = 0x1f ? 0 :
-- 
Mark M. Hoffman
mhoffman@lightlink.com
