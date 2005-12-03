From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 03 Dec 2005 23:23:01 +0000
Subject: [lm-sensors] Re: hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <43921A82.5090509@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

Sorry for delay, I'm extra busy.
In attachment is patch that should compile.

Please apply it and see the system log for result. (and of course mail it back)

Thanks
Regards
Rudolf
-------------- next part --------------
diff -Naur a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
--- a/drivers/hwmon/hwmon-vid.c	2005-10-28 02:02:08.000000000 +0200
+++ b/drivers/hwmon/hwmon-vid.c	2005-11-22 21:41:51.327622000 +0100
@@ -49,20 +49,22 @@
         . . . .
        11110  =  0.800 V
        11111  =  0.000 V (off)
+
+    The 17 specification is in fact Intel Mobile Voltage Positioning -
+    (IMVP-II). You can find more information in the datasheet of Max1718
+    http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2452
+
 */
 
 /* vrm is the VRM/VRD document version multiplied by 10.
    val is the 4-, 5- or 6-bit VID code.
    Returned value is in mV to avoid floating point in the kernel. */
-int vid_from_reg(int val, int vrm)
+int vid_from_reg(int val, u8 vrm)
 {
 	int vid;
 
 	switch(vrm) {
 
-	case  0:
-		return 0;
-
 	case 100:               /* VRD 10.0 */
 		if((val & 0x1f) = 0x1f)
 			return 0;
@@ -91,10 +93,16 @@
 	case 84:		/* VRM 8.4 */
 		val &= 0x0f;
 				/* fall through */
-	default:		/* VRM 8.2 */
+	case 82:		/* VRM 8.2 */
 		return(val = 0x1f ? 0 :
 		       val & 0x10  ? 5100 - (val) * 100 :
 		                     2050 - (val) * 50);
+	case 17:		/* Intel IMVP-II */
+		return(val & 0x10 ? 975 - (val & 0xF) * 25 :
+				    1750 - val * 50);
+	default:		/* report 0 for unknown */
+		printk(KERN_INFO "hwmon-vid: requested unknown VRM version\n");
+		return 0;
 	}
 }
 
@@ -108,30 +116,36 @@
 	u8 vendor;
 	u8 eff_family;
 	u8 eff_model;
-	int vrm_type;
+	u8 eff_stepping;
+	u8 vrm_type;
 };
 
 #define ANY 0xFF
 
 #ifdef CONFIG_X86
 
+/* the stepping parameter is highest acceptable stepping for current line */
+
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
-	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
+	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
+	{X86_VENDOR_AMD, 0xF, ANY, ANY, 24},		/* Athlon 64, Opteron and above VRM 24 */
+	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 85},		/* 0.13um too */
+	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
+	{X86_VENDOR_INTEL, 0x6, ANY, ANY, 82},		/* any P6 */
+	{X86_VENDOR_INTEL, 0x7, ANY, ANY, 0},		/* Itanium */
+	{X86_VENDOR_INTEL, 0xF, 0x0, ANY, 90},		/* P4 */
+	{X86_VENDOR_INTEL, 0xF, 0x1, ANY, 90},		/* P4 Willamette */
+	{X86_VENDOR_INTEL, 0xF, 0x2, ANY, 90},		/* P4 Northwood */
+	{X86_VENDOR_INTEL, 0xF, ANY, ANY, 100},		/* Prescott and above assume VRD 10 */
+	{X86_VENDOR_INTEL, 0x10, ANY, ANY, 0},		/* Itanium 2 */
+	{X86_VENDOR_CENTAUR, 0x6, 0x7, ANY, 85},	/* Eden ESP/Ezra */
+	{X86_VENDOR_CENTAUR, 0x6, 0x8, 0x7, 85},	/* Ezra T */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},	/* Nemiah */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},	/* C3-M */
+	{X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}		/* stop here */
 };
 
-static int find_vrm(u8 eff_family, u8 eff_model, u8 vendor)
+static int find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8 vendor)
 {
 	int i = 0;
 
@@ -139,7 +153,8 @@
 		if (vrm_models[i].vendor=vendor)
 			if ((vrm_models[i].eff_family=eff_family)
 			 && ((vrm_models[i].eff_model=eff_model) ||
-			     (vrm_models[i].eff_model=ANY)))
+			     (vrm_models[i].eff_model=ANY)) &&
+			     (eff_stepping <= vrm_models[i].eff_stepping))
 				return vrm_models[i].vrm_type;
 		i++;
 	}
@@ -147,12 +162,11 @@
 	return 0;
 }
 
-int vid_which_vrm(void)
+u8 vid_which_vrm(void)
 {
 	struct cpuinfo_x86 *c = cpu_data;
 	u32 eax;
-	u8 eff_family, eff_model;
-	int vrm_ret;
+	u8 eff_family, eff_model, eff_stepping, vrm_ret;
 
 	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
 		return 0;	/* doesn't have VID and/or CPUID */
@@ -160,20 +174,23 @@
 	eax = cpuid_eax(1);
 	eff_family = ((eax & 0x00000F00)>>8);
 	eff_model  = ((eax & 0x000000F0)>>4);
+	eff_stepping = eax & 0xF;
 	if (eff_family = 0xF) {	/* use extended model & family */
 		eff_family += ((eax & 0x00F00000)>>20);
 		eff_model += ((eax & 0x000F0000)>>16)<<4;
 	}
-	vrm_ret = find_vrm(eff_family,eff_model,c->x86_vendor);
+	printk("CALLING WITH: %x %x %x %x\n", eff_family, eff_model, eff_stepping, c->x86_vendor);
+	vrm_ret = find_vrm(eff_family, eff_model, eff_stepping, c->x86_vendor);
+	printk("%d is back\n",vrm_ret);
 	if (vrm_ret = 0)
 		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your "
 		       "x86 CPU\n");
 	return vrm_ret;
 }
 
-/* and now something completely different for the non-x86 world */
+/* and now for something completely different for the non-x86 world */
 #else
-int vid_which_vrm(void)
+u8 vid_which_vrm(void)
 {
 	printk(KERN_INFO "hwmon-vid: Unknown VRM version of your CPU\n");
 	return 0;
diff -Naur a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
--- a/include/linux/hwmon-vid.h	2005-10-28 02:02:08.000000000 +0200
+++ b/include/linux/hwmon-vid.h	2005-12-03 23:16:27.186109750 +0100
@@ -23,14 +23,14 @@
 #ifndef _LINUX_HWMON_VID_H
 #define _LINUX_HWMON_VID_H
 
-int vid_from_reg(int val, int vrm);
-int vid_which_vrm(void);
+int vid_from_reg(int val, u8 vrm);
+u8 vid_which_vrm(void);
 
 /* vrm is the VRM/VRD document version multiplied by 10.
    val is in mV to avoid floating point in the kernel.
    Returned value is the 4-, 5- or 6-bit VID code.
    Note that only VRM 9.x is supported for now. */
-static inline int vid_to_reg(int val, int vrm)
+static inline int vid_to_reg(int val, u8 vrm)
 {
 	switch (vrm) {
 	case 91:		/* VRM 9.1 */
