From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:54 +0000
Subject: [lm-sensors] [PATCH] hwmon: hwmon vs i2c, second round (08/11)
Message-Id: <11259567694007@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567691080@kroah.com>
In-Reply-To: <11259567691080@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: hwmon vs i2c, second round (08/11)

Cleanup hwmon-vid a bit, fixing typos, rewording some comments and
reindenting properly at places.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit da97a5a3279340462e8be6612feabc4b28883f87
tree d4c40ea5d37cffc2316c0528a8d9807fe114abde
parent 303760b44a7a142cb9f4c9df4609fb63bbda98db
author Jean Delvare <khali@linux-fr.org> Sun, 31 Jul 2005 21:54:28 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:22 -0700

 drivers/hwmon/hwmon-vid.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -38,14 +38,14 @@ static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
 	{X86_VENDOR_AMD, 0xF, ANY, 24},		/* Athlon 64, Opteron */
 	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
-	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* 0xB Tualatin */
+	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* Tualatin */
 	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
 	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */
 	{X86_VENDOR_INTEL, 0xF, 0x3, 100},	/* P4 Prescott */
 	{X86_VENDOR_INTEL, 0xF, ANY, 90},	/* P4 before Prescott */
 	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */
 	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
-	};
+};
 
 static int find_vrm(u8 eff_family, u8 eff_model, u8 vendor)
 {
@@ -53,9 +53,9 @@ static int find_vrm(u8 eff_family, u8 ef
 
 	while (vrm_models[i].vendor!=X86_VENDOR_UNKNOWN) {
 		if (vrm_models[i].vendor=vendor)
-			if ((vrm_models[i].eff_family=eff_family)&& \
-			((vrm_models[i].eff_model=eff_model)|| \
-			(vrm_models[i].eff_model=ANY)))
+			if ((vrm_models[i].eff_family=eff_family)
+			 && ((vrm_models[i].eff_model=eff_model) ||
+			     (vrm_models[i].eff_model=ANY)))
 				return vrm_models[i].vrm_type;
 		i++;
 	}
@@ -70,8 +70,9 @@ int vid_which_vrm(void)
 	u8 eff_family, eff_model;
 	int vrm_ret;
 
-	if (c->x86 < 6) return 0;	/* any CPU with familly lower than 6
-				 	dont have VID and/or CPUID */
+	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
+		return 0;	/* doesn't have VID and/or CPUID */
+
 	eax = cpuid_eax(1);
 	eff_family = ((eax & 0x00000F00)>>8);
 	eff_model  = ((eax & 0x000000F0)>>4);
@@ -81,12 +82,12 @@ int vid_which_vrm(void)
 	}
 	vrm_ret = find_vrm(eff_family,eff_model,c->x86_vendor);
 	if (vrm_ret = 0)
-		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your"
-		" x86 CPU\n");
+		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your "
+		       "x86 CPU\n");
 	return vrm_ret;
 }
 
-/* and now for something completely different for Non-x86 world*/
+/* and now something completely different for the non-x86 world */
 #else
 int vid_which_vrm(void)
 {

