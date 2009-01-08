From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Thu, 08 Jan 2009 19:53:04 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <200901081953.05204.alistair@devzero.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_hmlZJAJAmX7nmdF"
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
To: lm-sensors@vger.kernel.org

--Boundary-00=_hmlZJAJAmX7nmdF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 08 January 2009 18:09:40 Alistair John Strachan wrote:
> On Thursday 08 January 2009 17:09:43 Jean Delvare wrote:
[snip]
> > Might be worth reading this discussion thread again:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024522.html
> >
> > We gave up on fixing it back then, but apparently there really is a
> > need. Alistair, do you have a patch?

Find attached an alternative method which solves (I believe only potential) 
problems Jean pointed out at the time of the last thread. I think it's safe.

I've compromised by finding the first open bracket (it's fine if there are no 
brackets) and trimming any space from the sub-string. For example, here are 
the existing transformations:

"AW9D-MAX       (Intel i975-ICH7)" -> "AW9D-MAX"
"AT8 32X(ATI RD580-ULI M1575)" -> "AT8 32X"
"IP35 Pro(Intel P35-ICH9R)" -> "IP35 Pro"
"IN9 32X MAX(680i-MCP55PXE)" -> "IN9 32X MAX" (adding RSN)

And here are some hypothetical ones:

"AW9D      (Blah)" -> "AW9D"
"Abit Magic" -> "Abit Magic"

In the AW9D case, "AW9D" and "AW9D-MAX" are not considered to be the same 
motherboard, because the sub-string's length must exactly match that of the 
string in the motherboard entry. This is different to regular "strncasecmp" 
where they would be considered the same.

Find the patch attached. I'll probably go for this version if nobody finds any 
issues with it, otherwise the original patch I sent out is sufficient (since 
at the moment there are no boards falling into this hypothetical trap).

-- 
Cheers,
Alistair.

--Boundary-00=_hmlZJAJAmX7nmdF
Content-Type: text/x-patch; charset="us-ascii";
	name="abituguru3-use-strncasecmp-substring-dmi-match-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="abituguru3-use-strncasecmp-substring-dmi-match-2.diff"

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 70bb854..16d3142 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -279,7 +279,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "OTES1 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0011, "AT8 32X(ATI RD580-ULI M1575)", {
+	{ 0x0011, "AT8 32X", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 20, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -402,7 +402,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0016, "AW9D-MAX       (Intel i975-ICH7)", {
+	{ 0x0016, "AW9D-MAX", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
@@ -509,7 +509,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 FAN",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x001A, "IP35 Pro(Intel P35-ICH9R)", {
+	{ 0x001A, "IP35 Pro", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
@@ -1128,6 +1128,7 @@ static int __init abituguru3_dmi_detect(void)
 {
 	const char *board_vendor, *board_name;
 	int i, err = (force) ? 1 : -ENODEV;
+	size_t sublen;
 
 	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
 	if (!board_vendor || strcmp(board_vendor, "http://www.abit.com.tw/"))
@@ -1137,9 +1138,20 @@ static int __init abituguru3_dmi_detect(void)
 	if (!board_name)
 		return err;
 
+	/* At the moment, we don't care about the part of the vendor
+	 * DMI string contained in brackets. Truncate the string at
+	 * the first occurance of a bracket. Trim any trailing space
+	 * from the substring.
+	 */
+	sublen = strcspn(board_name, "(");
+	while(sublen > 0 && board_name[sublen - 1] == ' ')
+		sublen--;
+
 	for (i = 0; abituguru3_motherboards[i].id; i++) {
 		const char *dmi_name = abituguru3_motherboards[i].dmi_name;
-		if (dmi_name && !strcmp(dmi_name, board_name))
+		if (!dmi_name || strlen(dmi_name) != sublen)
+			continue;
+		if (!strncasecmp(board_name, dmi_name, sublen))
 			break;
 	}
 

--Boundary-00=_hmlZJAJAmX7nmdF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_hmlZJAJAmX7nmdF--
