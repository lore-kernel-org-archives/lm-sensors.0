From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: Patch: Asus ASB100 Bach support
Message-Id: <20020804011630.A9065@mercury.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

Here is a patchset which provides support for the Asus
ASB100 "Bach" sensor chip, found on A7V333 among others.

The patch treats Bach just like an AS99127F; with no
datasheet this seems reasonable until we find otherwise.

Note that I also fixed a comment at the top of w83781d.c
where the wchipid for as99127f was different from what
the code actually does (there and in sensors-detect);
assumed code was/is correct.

Regards,

Mark

-- 
Mark M. Hoffman
mhoffman@lightlink.com


Index: CHANGES
=================================RCS file: /home/cvs/lm_sensors2/CHANGES,v
retrieving revision 1.216
diff -u -2 -r1.216 CHANGES
--- CHANGES	2002/08/03 22:43:53	1.216
+++ CHANGES	2002/08/04 07:58:06
@@ -19,4 +19,6 @@
 
 2.6.5 (2002????)
+  Program sensors-detect: recognize Asus "ASB100 Bach" as AS99127F
+  Module w83781: recognize Asus "ASB100 Bach" as AS99127F
   Library: Fix fan3_div writes for w8378* and it87
   Module dmi_scan: new
Index: doc/chips/w83781d
=================================RCS file: /home/cvs/lm_sensors2/doc/chips/w83781d,v
retrieving revision 1.23
diff -u -2 -r1.23 w83781d
--- doc/chips/w83781d	2002/06/29 02:46:50	1.23
+++ doc/chips/w83781d	2002/08/04 07:58:08
@@ -9,4 +9,6 @@
         AS99127F support is BETA and has known problems due to lack of a
 		 chip datasheet. SEE BELOW.
+	ASB100 Bach support is BETA; presently this chip is treated
+		exactly like AS99127F.
 
 Supported chips:
@@ -35,4 +37,9 @@
     Addresses scanned: I2C 0x20 - 0x2f (inclusive)
     Datasheet: Unavailable from Asus
+  * Asus ASB100 Bach
+    Prefix 'as99127f'
+    Addresses scanned: I2C 0x20 - 0x2f (inclusive)
+    Datasheet: Unavailable from Asus
+
 
 
@@ -82,5 +89,5 @@
 
 This driver implements support for the Winbond W83781D, W83782D,
-W8783S, and W83627HF chips, and the Asus AS99127F.
+W8783S, and W83627HF chips, and the Asus AS99127F/ASB100 chips.
 We will refer to them collectively as W8378* chips.
 
@@ -88,5 +95,5 @@
 enough that it was sensible to put them together in one driver. 
 The W83627HF chip is assumed to be identical to the ISA W83782D.
-The AS99127F chip is similar to an I2C-only W83782D.
+The Asus chips are similar to an I2C-only W83782D.
 
 Detection of these chips can sometimes be foiled because they can be in
@@ -178,7 +185,7 @@
 
 
-AS99127F PROBLEMS
+AS99127F/ASB100 PROBLEMS
 -----------------
-The as99127f support was developed without the benefit of a datasheet.
+The as99127f/asb100 support was developed without the benefit of a datasheet.
 In most cases it is treated as a w83781d.
 This support will be BETA until a datasheet is released.
Index: kernel/chips/w83781d.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/w83781d.c,v
retrieving revision 1.93
diff -u -2 -r1.93 w83781d.c
--- kernel/chips/w83781d.c	2002/07/30 03:00:22	1.93
+++ kernel/chips/w83781d.c	2002/08/04 07:58:13
@@ -25,5 +25,6 @@
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    as99127f	7	3	1?	3	0x20	0x12c3	yes	no
+    as99127f	7	3	1?	3	0x30	0x12c3	yes	no
+    asb100 "bach" (type_name = as99127f)	0x30	0x0694	yes	no
     w83781d	7	3	0	3	0x10	0x5ca3	yes	yes
     w83627hf	9	3	2	3	0x20	0x5ca3	yes	yes(LPC)
@@ -841,7 +842,8 @@
 		/* Check for Winbond or Asus ID if in bank 0 */
 		if ((!(val1 & 0x07)) &&
-		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
-		     || ((val1 & 0x80) && (val2 != 0x5c)
-			 && (val2 != 0x12)))) goto ERROR1;
+		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3) 
+			 && (val2 != 0x94))
+		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)
+			 && (val2 != 0x06)))) goto ERROR1;
 		/* If Winbond SMBus, check address at 0x48. Asus doesn't support */
 		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 = 0xa3)) ||
@@ -866,5 +868,5 @@
 		if (val2 = 0x5c)
 			vendid = winbond;
-		else if (val2 = 0x12)
+		else if ((val2 = 0x12) || (val2 = 0x06))
 			vendid = asus;
 		else
Index: prog/detect/sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.171
diff -u -2 -r1.171 sensors-detect
--- prog/detect/sensors-detect	2002/07/10 01:34:32	1.171
+++ prog/detect/sensors-detect	2002/08/04 07:58:19
@@ -2024,6 +2024,8 @@
   }
   if ($chip = 4) {
-    return unless (($reg1 & 0x80) = 0x00 and $reg2 = 0xc3) or 
-                  (($reg1 & 0x80) = 0x80 and $reg2 = 0x12);
+    return unless (($reg1 & 0x80) = 0x00 and
+			($reg2 = 0xc3 or $reg2 = 0x94)) or 
+                  (($reg1 & 0x80) = 0x80 and
+			($reg2 = 0x12 or $reg2 = 0x06));
   }
   return unless ($reg1 & 0x07) = 0x00;
