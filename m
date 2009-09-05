From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sat, 05 Sep 2009 17:13:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: (abituguru3) Support multiple DMI
Message-Id: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Most known Abit motherboards have unique uguru chip IDs. However,
some "refresh" boards keep the same chip ID but have a different
DMI string. As our DMI board string matching is (necessarily)
strict, some boards were failing DMI detection, and as the old
probe method was also failing, the driver would not load.

The only known boards affected by this problem are the IP35 Pro XE
(vs IP35 Pro) and the AB9 Pro (vs AB9). Is it not sufficient to
relax the match criteria, as some boards (e.g. the AB9 Quad GT)
have different uguru chip IDs.

This patch replaces the dmi_name string with a NULL terminated
array of strings to be matched per uguru chip ID. It has been
compile and runtime tested (thanks Rune).

References: https://bugs.launchpad.net/bugs/298798

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Tested-by: Rune Svendsen <runesvend@gmail.com>
Cc: Rune Svendsen <runesvend@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: lm-sensors@lm-sensors.org

---
 drivers/hwmon/abituguru3.c |   63 +++++++++++++++++++++++--------------------
 1 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 7d3f15d..5203ec2 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -117,9 +117,12 @@ struct abituguru3_sensor_info {
 	int offset;
 };
 
+/* Avoid use of flexible array members */
+#define ABIT_UGURU3_MAX_DMI_NAMES 2
+
 struct abituguru3_motherboard_info {
 	u16 id;
-	const char *dmi_name;
+	const char *dmi_name[ABIT_UGURU3_MAX_DMI_NAMES + 1];
 	/* + 1 -> end of sensors indicated by a sensor with name = NULL */
 	struct abituguru3_sensor_info sensors[ABIT_UGURU3_MAX_NO_SENSORS + 1];
 };
@@ -164,7 +167,7 @@ struct abituguru3_data {
 
 /* Constants */
 static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
-	{ 0x000C, NULL /* Unknown, need DMI string */, {
+	{ 0x000C, { NULL } /* Unknown, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -186,7 +189,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX1 Fan",		35, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x000D, NULL /* Abit AW8, need DMI string */, {
+	{ 0x000D, { NULL } /* Abit AW8, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -215,7 +218,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX5 Fan",		39, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x000E, NULL /* AL-8, need DMI string */, {
+	{ 0x000E, { NULL } /* AL-8, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -236,7 +239,8 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "SYS Fan",		34, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x000F, NULL /* Unknown, need DMI string */, {
+	{ 0x000F, { NULL } /* Unknown, need DMI string */, {
+
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -257,7 +261,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "SYS Fan",		34, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0010, NULL /* Abit NI8 SLI GR, need DMI string */, {
+	{ 0x0010, { NULL } /* Abit NI8 SLI GR, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -279,7 +283,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "OTES1 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0011, "AT8 32X", {
+	{ 0x0011, { "AT8 32X", NULL }, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 20, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -306,7 +310,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		37, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0012, NULL /* Abit AN8 32X, need DMI string */, {
+	{ 0x0012, { NULL } /* Abit AN8 32X, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 20, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -328,7 +332,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX1 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0013, NULL /* Abit AW8D, need DMI string */, {
+	{ 0x0013, { NULL } /* Abit AW8D, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -357,7 +361,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX5 Fan",		39, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0014, "AB9", /* + AB9 Pro */ {
+	{ 0x0014, { "AB9", "AB9 Pro", NULL }, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -378,7 +382,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "SYS Fan",		34, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0015, NULL /* Unknown, need DMI string */, {
+	{ 0x0015, { NULL } /* Unknown, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 20, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -402,7 +406,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0016, "AW9D-MAX", {
+	{ 0x0016, { "AW9D-MAX", NULL }, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
@@ -430,7 +434,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "OTES1 Fan",		38, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0017, NULL /* Unknown, need DMI string */, {
+	{ 0x0017, { NULL } /* Unknown, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
@@ -455,7 +459,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 FAN",		37, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0018, "AB9 QuadGT", {
+	{ 0x0018, { "AB9 QuadGT", NULL }, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
@@ -482,7 +486,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0019, "IN9 32X MAX", {
+	{ 0x0019, { "IN9 32X MAX", NULL }, {
 		{ "CPU Core",		 7, 0, 10, 1, 0 },
 		{ "DDR2",		13, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		14, 0, 10, 1, 0 },
@@ -509,7 +513,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 FAN",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x001A, "IP35 Pro", {
+	{ 0x001A, { "IP35 Pro", "IP35 Pro XE", NULL }, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
@@ -537,7 +541,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX4 Fan",		37, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x001B, NULL /* Unknown, need DMI string */, {
+	{ 0x001B, { NULL } /* Unknown, need DMI string */, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR3",		 1, 0, 20, 1, 0 },
 		{ "DDR3 VTT",		 2, 0, 10, 1, 0 },
@@ -564,7 +568,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x001C, "IX38 QuadGT", {
+	{ 0x001C, { "IX38 QuadGT", NULL }, {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
@@ -591,7 +595,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0000, NULL, { { NULL, 0, 0, 0, 0, 0 } } }
+	{ 0x0000, { NULL }, { { NULL, 0, 0, 0, 0, 0 } } }
 };
 
 
@@ -947,7 +951,7 @@ static int __devinit abituguru3_probe(struct platform_device *pdev)
 		"ID: %04X\n", (unsigned int)id);
 
 #ifdef CONFIG_DMI
-	if (!abituguru3_motherboards[i].dmi_name) {
+	if (!*abituguru3_motherboards[i].dmi_name) {
 		printk(KERN_WARNING ABIT_UGURU3_NAME ": this motherboard was "
 			"not detected using DMI. Please send the output of "
 			"\"dmidecode\" to the abituguru3 maintainer "
@@ -1131,6 +1135,7 @@ static int __init abituguru3_dmi_detect(void)
 {
 	const char *board_vendor, *board_name;
 	int i, err = (force) ? 1 : -ENODEV;
+	const char *const *dmi_name;
 	size_t sublen;
 
 	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
@@ -1151,17 +1156,17 @@ static int __init abituguru3_dmi_detect(void)
 		sublen--;
 
 	for (i = 0; abituguru3_motherboards[i].id; i++) {
-		const char *dmi_name = abituguru3_motherboards[i].dmi_name;
-		if (!dmi_name || strlen(dmi_name) != sublen)
-			continue;
-		if (!strncasecmp(board_name, dmi_name, sublen))
-			break;
+		dmi_name = abituguru3_motherboards[i].dmi_name;
+		for ( ; *dmi_name; dmi_name++) {
+			if (strlen(*dmi_name) != sublen)
+				continue;
+			if (!strncasecmp(board_name, *dmi_name, sublen))
+				return 0;
+		}
 	}
 
-	if (!abituguru3_motherboards[i].id)
-		return 1;
-
-	return 0;
+	/* No match found */
+	return 1;
 }
 
 #else /* !CONFIG_DMI */

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
