From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 30 Jun 2011 12:34:32 +0000
Subject: [lm-sensors] [PATCH] hwmon-vid: Add support for VIA family 6 model
Message-Id: <20110630143432.12d32eb8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The VIA family 6 model D CPU (C7-D, Eden 90 nm) can use two different
VID tables, we have to check the value of a MSR to decide which one to
use.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/hwmon-vid.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

--- linux-3.0-rc5.orig/drivers/hwmon/hwmon-vid.c	2011-06-30 14:26:44.000000000 +0200
+++ linux-3.0-rc5/drivers/hwmon/hwmon-vid.c	2011-06-30 14:33:45.000000000 +0200
@@ -140,7 +140,11 @@ int vid_from_reg(int val, u8 vrm)
 		return(val & 0x10 ? 975 - (val & 0xF) * 25 :
 				    1750 - val * 50);
 	case 13:
+	case 131:
 		val &= 0x3f;
+		/* Exception for Eden ULV 500 MHz */
+		if (vrm = 131 && val = 0x3f)
+			val++;
 		return(1708 - val * 16);
 	case 14:		/* Intel Core */
 				/* compute in uV, round to mV */
@@ -205,11 +209,45 @@ static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},	/* Nehemiah */
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},	/* C3-M, Eden-N */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, 0x7, 0},		/* No information */
-	{X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},	/* C7, Esther */
+	{X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},	/* C7-M, C7, Eden (Esther) */
+	{X86_VENDOR_CENTAUR, 0x6, 0xD, ANY, 134},	/* C7-D, C7-M, C7, Eden (Esther) */
 
 	{X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}		/* stop here */
 };
 
+/*
+ * Special case for VIA model D: there are two different possible
+ * VID tables, so we have to figure out first, which one must be
+ * used. This resolves temporary drm value 134 to 14 (Intel Core
+ * 7-bit VID), 13 (Pentium M 6-bit VID) or 131 (Pentium M 6-bit VID
+ * + quirk for Eden ULV 500 MHz).
+ * Note: something similar might be needed for model A, I'm not sure.
+ */
+static u8 get_via_model_d_vrm(void)
+{
+	unsigned int vid, brand, dummy;
+	static const char *brands[4] = {
+		"C7-M", "C7" "Eden", "C7-D"
+	};
+
+	rdmsr(0x198, dummy, vid);
+	vid &= 0xff;
+
+	rdmsr(0x1154, brand, dummy);
+	brand = ((brand >> 4) ^ (brand >> 2)) & 0x03;
+
+	if (vid > 0x3f) {
+		pr_info("Using %d-bit VID table for VIA %s CPU\n",
+			7, brands[brand]);
+		return 14;
+	} else {
+		pr_info("Using %d-bit VID table for VIA %s CPU\n",
+			6, brands[brand]);
+		/* Enable quirk for Eden */
+		return brand = 2 ? 131 : 13;
+	}
+}
+
 static u8 find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8 vendor)
 {
 	int i = 0;
@@ -247,6 +285,8 @@ u8 vid_which_vrm(void)
 		eff_model += ((eax & 0x000F0000)>>16)<<4;
 	}
 	vrm_ret = find_vrm(eff_family, eff_model, eff_stepping, c->x86_vendor);
+	if (vrm_ret = 134)
+		vrm_ret = get_via_model_d_vrm();
 	if (vrm_ret = 0)
 		pr_info("Unknown VRM version of your x86 CPU\n");
 	return vrm_ret;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
