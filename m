From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:04 +0000
Subject: [lm-sensors] [PATCH] hwmon: hwmon vs i2c, second round (10/11)
Message-Id: <1125956769605@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567691080@kroah.com>
In-Reply-To: <11259567691080@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: hwmon vs i2c, second round (10/11)

I see very little reason why vid_from_reg is inlined. It is not
exactly short, its parameters are seldom known in advance, and it is
never called in speed critical areas. Uninlining it should cause
little performance loss if any, and saves a signficant space as well
as compilation time.

As suggested by Alexey Dobriyan, I am leaving vid_to_reg inline for now,
as it is short and has a single user so far.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d0f282706df877f8fd8869419e308d24eedb523b
tree a0305b5bcb691fa7bc7005b56b4dc45263fb3cbb
parent ee70d3a33368038d41985474d9e70ac07f19651c
author Jean Delvare <khali@linux-fr.org> Mon, 01 Aug 2005 22:50:08 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:23 -0700

 drivers/hwmon/hwmon-vid.c |   82 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwmon-vid.h |   83 +++++----------------------------------------
 2 files changed, 91 insertions(+), 74 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -3,6 +3,10 @@
 
     Copyright (c) 2004 Rudolf Marek <r.marek@sh.cvut.cz>
 
+    Partly imported from i2c-vid.h of the lm_sensors project
+    Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+    With assistance from Trent Piepho <xyzzy@speakeasy.org>
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -23,6 +27,83 @@
 #include <linux/kernel.h>
 #include <linux/hwmon-vid.h>
 
+/*
+    Common code for decoding VID pins.
+
+    References:
+
+    For VRM 8.4 to 9.1, "VRM x.y DC-DC Converter Design Guidelines",
+    available at http://developer.intel.com/.
+
+    For VRD 10.0 and up, "VRD x.y Design Guide",
+    available at http://developer.intel.com/.
+
+    AMD Opteron processors don't follow the Intel specifications.
+    I'm going to "make up" 2.4 as the spec number for the Opterons.
+    No good reason just a mnemonic for the 24x Opteron processor
+    series.
+
+    Opteron VID encoding is:
+       00000  =  1.550 V
+       00001  =  1.525 V
+        . . . .
+       11110  =  0.800 V
+       11111  =  0.000 V (off)
+*/
+
+/* vrm is the VRM/VRD document version multiplied by 10.
+   val is the 4-, 5- or 6-bit VID code.
+   Returned value is in mV to avoid floating point in the kernel. */
+int vid_from_reg(int val, int vrm)
+{
+	int vid;
+
+	switch(vrm) {
+
+	case  0:
+		return 0;
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
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return(val = 0x1f ? 0 :
+		                       1850 - val * 25);
+
+	case 85:		/* VRM 8.5 */
+		return((val & 0x10  ? 25 : 0) +
+		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
+		       ((val & 0x0f) * 50));
+
+	case 84:		/* VRM 8.4 */
+		val &= 0x0f;
+				/* fall through */
+	default:		/* VRM 8.2 */
+		return(val = 0x1f ? 0 :
+		       val & 0x10  ? 5100 - (val) * 100 :
+		                     2050 - (val) * 50);
+	}
+}
+
+
+/*
+    After this point is the code to automatically determine which
+    VRM/VRD specification should be used depending on the CPU.
+*/
+
 struct vrm_model {
 	u8 vendor;
 	u8 eff_family;
@@ -96,6 +177,7 @@ int vid_which_vrm(void)
 }
 #endif
 
+EXPORT_SYMBOL(vid_from_reg);
 EXPORT_SYMBOL(vid_which_vrm);
 
 MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
diff --git a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
--- a/include/linux/hwmon-vid.h
+++ b/include/linux/hwmon-vid.h
@@ -20,83 +20,16 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/*
-    This file contains common code for decoding VID pins.
-    This file is #included in various chip drivers in this directory.
-    As the user is unlikely to load more than one driver which
-    includes this code we don't worry about the wasted space.
-    Reference: VRM x.y DC-DC Converter Design Guidelines,
-    available at http://developer.intel.com
-*/
-
-/*
-    AMD Opteron processors don't follow the Intel VRM spec.
-    I'm going to "make up" 2.4 as the VRM spec for the Opterons.
-    No good reason just a mnemonic for the 24x Opteron processor
-    series
-
-    Opteron VID encoding is:
-
-       00000  =  1.550 V
-       00001  =  1.525 V
-        . . . .
-       11110  =  0.800 V
-       11111  =  0.000 V (off)
- */
-
-/*
-    Legal val values 0x00 - 0x1f; except for VRD 10.0, 0x00 - 0x3f.
-    vrm is the Intel VRM document version.
-    Note: vrm version is scaled by 10 and the return value is scaled by 1000
-    to avoid floating point in the kernel.
-*/
+#ifndef _LINUX_HWMON_VID_H
+#define _LINUX_HWMON_VID_H
 
+int vid_from_reg(int val, int vrm);
 int vid_which_vrm(void);
 
-static inline int vid_from_reg(int val, int vrm)
-{
-	int vid;
-
-	switch(vrm) {
-
-	case  0:
-		return 0;
-
-	case 100:               /* VRD 10.0 */
-		if((val & 0x1f) = 0x1f)
-			return 0;
-		if((val & 0x1f) <= 0x09 || val = 0x0a)
-			vid = 10875 - (val & 0x1f) * 250;
-		else
-			vid = 18625 - (val & 0x1f) * 250;
-		if(val & 0x20)
-			vid -= 125;
-		vid /= 10;      /* only return 3 dec. places for now */
-		return vid;
-
-	case 24:                /* Opteron processor */
-		return(val = 0x1f ? 0 : 1550 - val * 25);
-
-	case 91:		/* VRM 9.1 */
-	case 90:		/* VRM 9.0 */
-		return(val = 0x1f ? 0 :
-		                       1850 - val * 25);
-
-	case 85:		/* VRM 8.5 */
-		return((val & 0x10  ? 25 : 0) +
-		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
-		       ((val & 0x0f) * 50));
-
-	case 84:		/* VRM 8.4 */
-		val &= 0x0f;
-				/* fall through */
-	default:		/* VRM 8.2 */
-		return(val = 0x1f ? 0 :
-		       val & 0x10  ? 5100 - (val) * 100 :
-		                     2050 - (val) * 50);
-	}
-}
-
+/* vrm is the VRM/VRD document version multiplied by 10.
+   val is in mV to avoid floating point in the kernel.
+   Returned value is the 4-, 5- or 6-bit VID code.
+   Note that only VRM 9.x is supported for now. */
 static inline int vid_to_reg(int val, int vrm)
 {
 	switch (vrm) {
@@ -108,3 +41,5 @@ static inline int vid_to_reg(int val, in
 		return -1;
 	}
 }
+
+#endif /* _LINUX_HWMON_VID_H */

