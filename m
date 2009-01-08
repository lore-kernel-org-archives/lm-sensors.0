From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Thu, 08 Jan 2009 18:09:40 +0000
Subject: Re: [lm-sensors] abituguru3: no Abit uGuru3 found
Message-Id: <200901081809.40940.alistair@devzero.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_kFkZJWm3OwYNCse"
List-Id: <lm-sensors.vger.kernel.org>
References: <49657F3B.3060607@NickAndBarb.net>
In-Reply-To: <49657F3B.3060607@NickAndBarb.net>
To: lm-sensors@vger.kernel.org

--Boundary-00=_kFkZJWm3OwYNCse
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 08 January 2009 17:09:43 Jean Delvare wrote:
> On Thu, 08 Jan 2009 13:02:38 +0100, Hans de Goede wrote:
> > Nick Pasich wrote:
> > > No BIOS update....
> > >
> > > Here's the output from "dmidecode" Attached...
> >
> > Hmm, nasty. We've got "IP35 Pro(Intel P35-ICH9R)" as identifaction string
> > in the driver, and your DMI table has: "IP35 PRO(P35+ICH9R)"
> >
> > You should be able to work around your problem (for now) by doing this
> > (as root):
> >
> > modprobe abituguru3 force=1
> >
> > After that, please do "dmesg" and copy paste the relevant (abituguru
> > related) lines in your mail, that will help us diagnose this.
>
> Might be worth reading this discussion thread again:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024522.html
>
> We gave up on fixing it back then, but apparently there really is a
> need. Alistair, do you have a patch?

I think the consensus we came to at the time was to switch to strncmp'ing a 
subset of the DMI string, but in this case we'll need strncasecmp. This isn't 
too terrible as false positives are pretty unlikely (we already check the 
board manufacturer too, which does seem to be unchanging). Hans?

Of course, if Abit start putting arbitrary spaces and hyphens into the names 
too, all bets are off. But I read that their motherboard division was ceasing 
operation soon so (alas) this shouldn't be a problem. :-)

Find attached a patch that should fix it (Nick, please test this if you can).

Jean, there's another DMI patch tested by Paul Hartman I've been holding onto. 
I'll send you a proper version of the patch in this email and the other DMI 
patch ASAP.

-- 
Cheers,
Alistair.

--Boundary-00=_kFkZJWm3OwYNCse
Content-Type: text/x-patch; charset="us-ascii";
	name="abituguru3-use-strncasecmp-substring-dmi-match.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="abituguru3-use-strncasecmp-substring-dmi-match.diff"

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 70bb854..ae75def 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -279,7 +279,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "OTES1 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0011, "AT8 32X(ATI RD580-ULI M1575)", {
+	{ 0x0011a, "AT8 32X", {
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
@@ -1139,7 +1139,9 @@ static int __init abituguru3_dmi_detect(void)
 
 	for (i = 0; abituguru3_motherboards[i].id; i++) {
 		const char *dmi_name = abituguru3_motherboards[i].dmi_name;
-		if (dmi_name && !strcmp(dmi_name, board_name))
+		if (!dmi_name)
+			continue;
+		if (!strncasecmp(board_name, dmi_name, strlen(dmi_name)))
 			break;
 	}
 

--Boundary-00=_kFkZJWm3OwYNCse
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_kFkZJWm3OwYNCse--
