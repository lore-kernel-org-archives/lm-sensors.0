From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jan 2012 12:43:32 +0000
Subject: [lm-sensors] [RFC PATCH 1/3] hwmon: (hwmon-vid) Add new entries to VRM model table
Message-Id: <1327495414-6256-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The VRM model table was missing several Intel CPUs, resulting in wrong VRM table
entries to be used for many recent CPUs. Update it. Also, use values from
struct cpuinfo_x86 to retrieve CPU model information instead of re-calculating
it locally.

Cc: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon-vid.c |  103 ++++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 4029ac6..5ec5e37 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -166,9 +166,10 @@ int vid_from_reg(int val, u8 vrm)
 
 struct vrm_model {
 	u8 vendor;
-	u8 eff_family;
-	u8 eff_model;
-	u8 eff_stepping;
+	u8 family;
+	u8 model_from;
+	u8 model_to;
+	u8 stepping;
 	u8 vrm_type;
 };
 
@@ -183,38 +184,46 @@ struct vrm_model {
  */
 
 static struct vrm_model vrm_models[] = {
-	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
-	{X86_VENDOR_AMD, 0xF, 0x3F, ANY, 24},		/* Athlon 64, Opteron */
+	{X86_VENDOR_AMD, 0x6, 0x0, ANY, ANY, 90},	/* Athlon Duron etc */
+	{X86_VENDOR_AMD, 0xF, 0x0, 0x3F, ANY, 24},	/* Athlon 64, Opteron */
 	/*
 	 * In theory, all NPT family 0Fh processors have 6 VID pins and should
 	 * thus use vrm 25, however in practice not all mainboards route the
 	 * 6th VID pin because it is never needed. So we use the 5 VID pin
 	 * variant (vrm 24) for the models which exist today.
 	 */
-	{X86_VENDOR_AMD, 0xF, 0x7F, ANY, 24},		/* NPT family 0Fh */
-	{X86_VENDOR_AMD, 0xF, ANY, ANY, 25},		/* future fam. 0Fh */
-	{X86_VENDOR_AMD, 0x10, ANY, ANY, 25},		/* NPT family 10h */
-
-	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 13},		/* Pentium M (130 nm) */
-	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
-	{X86_VENDOR_INTEL, 0x6, 0xD, ANY, 13},		/* Pentium M (90 nm) */
-	{X86_VENDOR_INTEL, 0x6, 0xE, ANY, 14},		/* Intel Core (65 nm) */
-	{X86_VENDOR_INTEL, 0x6, 0xF, ANY, 110},		/* Intel Conroe */
-	{X86_VENDOR_INTEL, 0x6, ANY, ANY, 82},		/* any P6 */
-	{X86_VENDOR_INTEL, 0xF, 0x0, ANY, 90},		/* P4 */
-	{X86_VENDOR_INTEL, 0xF, 0x1, ANY, 90},		/* P4 Willamette */
-	{X86_VENDOR_INTEL, 0xF, 0x2, ANY, 90},		/* P4 Northwood */
-	{X86_VENDOR_INTEL, 0xF, ANY, ANY, 100},		/* Prescott and above assume VRD 10 */
-
-	{X86_VENDOR_CENTAUR, 0x6, 0x7, ANY, 85},	/* Eden ESP/Ezra */
-	{X86_VENDOR_CENTAUR, 0x6, 0x8, 0x7, 85},	/* Ezra T */
-	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},	/* Nehemiah */
-	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},	/* C3-M, Eden-N */
-	{X86_VENDOR_CENTAUR, 0x6, 0xA, 0x7, 0},		/* No information */
-	{X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},	/* C7-M, C7, Eden (Esther) */
-	{X86_VENDOR_CENTAUR, 0x6, 0xD, ANY, 134},	/* C7-D, C7-M, C7, Eden (Esther) */
-
-	{X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}		/* stop here */
+	{X86_VENDOR_AMD, 0xF, 0x40, 0x7F, ANY, 24},	/* NPT family 0Fh */
+	{X86_VENDOR_AMD, 0xF, 0x80, ANY, ANY, 25},	/* future fam. 0Fh */
+	{X86_VENDOR_AMD, 0x10, 0x0, ANY, ANY, 25},	/* NPT family 10h */
+
+	{X86_VENDOR_INTEL, 0x6, 0x0, 0x6, ANY, 82},	/* Pentium Pro,
+							 * Pentium II, Xeon,
+							 * Mobile Pentium,
+							 * Celeron */
+	{X86_VENDOR_INTEL, 0x6, 0x7, 0x7, ANY, 84},	/* Pentium III, Xeon */
+	{X86_VENDOR_INTEL, 0x6, 0x8, 0x8, ANY, 82},	/* Pentium III, Xeon */
+	{X86_VENDOR_INTEL, 0x6, 0x9, 0x9, ANY, 13},	/* Pentium M (130 nm) */
+	{X86_VENDOR_INTEL, 0x6, 0xA, 0xA, ANY, 82},	/* Pentium III Xeon */
+	{X86_VENDOR_INTEL, 0x6, 0xB, 0xB, ANY, 85},	/* Tualatin */
+	{X86_VENDOR_INTEL, 0x6, 0xD, 0xD, ANY, 13},	/* Pentium M (90 nm) */
+	{X86_VENDOR_INTEL, 0x6, 0xE, 0xE, ANY, 14},	/* Intel Core (65 nm) */
+	{X86_VENDOR_INTEL, 0x6, 0xF, ANY, ANY, 110},	/* Intel Conroe and
+							 * later */
+	{X86_VENDOR_INTEL, 0xF, 0x0, 0x0, ANY, 90},	/* P4 */
+	{X86_VENDOR_INTEL, 0xF, 0x1, 0x1, ANY, 90},	/* P4 Willamette */
+	{X86_VENDOR_INTEL, 0xF, 0x2, 0x2, ANY, 90},	/* P4 Northwood */
+	{X86_VENDOR_INTEL, 0xF, 0x3, ANY, ANY, 100},	/* Prescott and above
+							 * assume VRD 10 */
+
+	{X86_VENDOR_CENTAUR, 0x6, 0x7, 0x7, ANY, 85},	/* Eden ESP/Ezra */
+	{X86_VENDOR_CENTAUR, 0x6, 0x8, 0x8, 0x7, 85},	/* Ezra T */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x9, 0x7, 85},	/* Nehemiah */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x9, ANY, 17},	/* C3-M, Eden-N */
+	{X86_VENDOR_CENTAUR, 0x6, 0xA, 0xA, 0x7, 0},	/* No information */
+	{X86_VENDOR_CENTAUR, 0x6, 0xA, 0xA, ANY, 13},	/* C7-M, C7,
+							 * Eden (Esther) */
+	{X86_VENDOR_CENTAUR, 0x6, 0xD, 0xD, ANY, 134},	/* C7-D, C7-M, C7,
+							 * Eden (Esther) */
 };
 
 /*
@@ -250,20 +259,17 @@ static u8 get_via_model_d_vrm(void)
 	}
 }
 
-static u8 find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8 vendor)
+static u8 find_vrm(u8 family, u8 model, u8 stepping, u8 vendor)
 {
-	int i = 0;
-
-	while (vrm_models[i].vendor!=X86_VENDOR_UNKNOWN) {
-		if (vrm_models[i].vendor=vendor)
-			if ((vrm_models[i].eff_family=eff_family)
-			 && ((vrm_models[i].eff_model=eff_model) ||
-			     (vrm_models[i].eff_model >= 0x10 &&
-			      eff_model <= vrm_models[i].eff_model) ||
-			     (vrm_models[i].eff_model=ANY)) &&
-			     (eff_stepping <= vrm_models[i].eff_stepping))
-				return vrm_models[i].vrm_type;
-		i++;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vrm_models); i++) {
+		if (vendor = vrm_models[i].vendor &&
+		    family = vrm_models[i].family &&
+		    model >= vrm_models[i].model_from &&
+		    model <= vrm_models[i].model_to &&
+		    stepping <= vrm_models[i].stepping)
+			return vrm_models[i].vrm_type;
 	}
 
 	return 0;
@@ -272,21 +278,12 @@ static u8 find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8 vendor)
 u8 vid_which_vrm(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
-	u32 eax;
-	u8 eff_family, eff_model, eff_stepping, vrm_ret;
+	u8 vrm_ret;
 
 	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
 		return 0;	/* doesn't have VID and/or CPUID */
 
-	eax = cpuid_eax(1);
-	eff_family = ((eax & 0x00000F00)>>8);
-	eff_model  = ((eax & 0x000000F0)>>4);
-	eff_stepping = eax & 0xF;
-	if (eff_family = 0xF) {	/* use extended model & family */
-		eff_family += ((eax & 0x00F00000)>>20);
-		eff_model += ((eax & 0x000F0000)>>16)<<4;
-	}
-	vrm_ret = find_vrm(eff_family, eff_model, eff_stepping, c->x86_vendor);
+	vrm_ret = find_vrm(c->x86, c->x86_model, c->x86_mask, c->x86_vendor);
 	if (vrm_ret = 134)
 		vrm_ret = get_via_model_d_vrm();
 	if (vrm_ret = 0)
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
