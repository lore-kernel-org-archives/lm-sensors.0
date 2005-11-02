From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 02 Nov 2005 23:09:23 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <43693914.8090605@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Here is the first shot. I wrote it in the evening after two beers so dont expect to be bug free ;).
On the other hand comments wellcomed. (yes I know it can be written using ternary operator)

Roger, can you give a try if it detects your CPU and you will get back 1.2V?

TYPE  FAMILY  MODEL  STEPPING
0       6       7       0+   this should be 85? -  EDEN ESP samuel 2
0       6       7       8+   VRM85 C3 EZRA
0       6       8       0-7  VRM85 C3 EZRA T
0       6       9       0+   VRM85 NEMIAH
0       6       9       8+  max 1718 C3-M

Thanks,

Regards
Rudolf
-------------- next part --------------
diff -Naur a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
--- a/drivers/hwmon/hwmon-vid.c	2005-10-28 02:02:08.000000000 +0200
+++ b/drivers/hwmon/hwmon-vid.c	2005-11-02 22:59:19.577711744 +0100
@@ -60,9 +60,6 @@
 
 	switch(vrm) {
 
-	case  0:
-		return 0;
-
 	case 100:               /* VRD 10.0 */
 		if((val & 0x1f) = 0x1f)
 			return 0;
@@ -91,10 +88,16 @@
 	case 84:		/* VRM 8.4 */
 		val &= 0x0f;
 				/* fall through */
-	default:		/* VRM 8.2 */
+	case 82:		/* VRM 8.2 */
 		return(val = 0x1f ? 0 :
 		       val & 0x10  ? 5100 - (val) * 100 :
-		                     2050 - (val) * 50);
+			2050 - (val) * 50);
+	case 1718:		/* Intel IMVP-II */
+		if (val & 0x10) 
+			return 0975 - ((val & 0xF) * 25);
+		return 1750 - (val * 50);
+	default:		/* report 0 for unknown */
+		return 0;
 	}
 }
 
@@ -108,6 +111,7 @@
 	u8 vendor;
 	u8 eff_family;
 	u8 eff_model;
+	u8 eff_stepping;
 	int vrm_type;
 };
 
@@ -116,18 +120,22 @@
 #ifdef CONFIG_X86
 
 static struct vrm_model vrm_models[] = {
-	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
-	{X86_VENDOR_AMD, 0xF, ANY, 24},		/* Athlon 64, Opteron */
-	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
-	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* Tualatin */
-	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
-	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */
-	{X86_VENDOR_INTEL, 0xF, 0x0, 90},	/* P4 */
-	{X86_VENDOR_INTEL, 0xF, 0x1, 90},	/* P4 Willamette */
-	{X86_VENDOR_INTEL, 0xF, 0x2, 90},	/* P4 Northwood */
-	{X86_VENDOR_INTEL, 0xF, 0x3, 100},	/* P4 Prescott */
-	{X86_VENDOR_INTEL, 0xF, 0x4, 100},	/* P4 Prescott */
-	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */
+	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},	/* Athlon Duron etc */
+	{X86_VENDOR_AMD, 0xF, ANY, ANY, 24},	/* Athlon 64, Opteron */
+	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 85},	/* 0.13um too */
+	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},	/* Tualatin */
+	{X86_VENDOR_INTEL, 0x6, ANY, ANY, 82},	/* any P6 */
+	{X86_VENDOR_INTEL, 0x7, ANY, ANY, 0},	/* Itanium */
+	{X86_VENDOR_INTEL, 0xF, 0x0, ANY, 90},	/* P4 */
+	{X86_VENDOR_INTEL, 0xF, 0x1, ANY, 90},	/* P4 Willamette */
+	{X86_VENDOR_INTEL, 0xF, 0x2, ANY, 90},	/* P4 Northwood */
+	{X86_VENDOR_INTEL, 0xF, 0x3, ANY, 100},	/* P4 Prescott */
+	{X86_VENDOR_INTEL, 0xF, 0x4, ANY, 100},	/* P4 Prescott */
+	{X86_VENDOR_INTEL, 0x10, ANY, ANY, 0},	/* Itanium 2 */
+	{X86_VENDOR_CENTAUR, 0x6, 0x7, ANY, 85},/* Eden ESP/Ezra */
+	{X86_VENDOR_CENTAUR, 0x6, 0x8, 0x7, 85},/* Ezra T */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},/* Nemiah */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 1718},/* C3-M */
 	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
 };
 
@@ -139,7 +147,8 @@
 		if (vrm_models[i].vendor=vendor)
 			if ((vrm_models[i].eff_family=eff_family)
 			 && ((vrm_models[i].eff_model=eff_model) ||
-			     (vrm_models[i].eff_model=ANY)))
+			     (vrm_models[i].eff_model=ANY)) &&
+			     (eff_stepping =< vrm_models[i].eff_stepping))
 				return vrm_models[i].vrm_type;
 		i++;
 	}
@@ -151,7 +160,7 @@
 {
 	struct cpuinfo_x86 *c = cpu_data;
 	u32 eax;
-	u8 eff_family, eff_model;
+	u8 eff_family, eff_model, eff_stepping;
 	int vrm_ret;
 
 	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
@@ -160,6 +169,7 @@
 	eax = cpuid_eax(1);
 	eff_family = ((eax & 0x00000F00)>>8);
 	eff_model  = ((eax & 0x000000F0)>>4);
+	eff_stepping = eax & 0xF;
 	if (eff_family = 0xF) {	/* use extended model & family */
 		eff_family += ((eax & 0x00F00000)>>20);
 		eff_model += ((eax & 0x000F0000)>>16)<<4;
