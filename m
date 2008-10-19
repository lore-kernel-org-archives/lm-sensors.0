From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sun, 19 Oct 2008 19:53:26 +0000
Subject: Re: [lm-sensors] abituguru3: Please send .. to the abituguru3 (see
Message-Id: <200810192053.26915.alistair@devzero.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_2A5+IzONxSO1y2r"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
In-Reply-To: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
To: lm-sensors@vger.kernel.org

--Boundary-00=_2A5+IzONxSO1y2r
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 19 October 2008 17:54:15 Justin Piszcz wrote:
> Kernel: 2.6.27.2:
> [   10.242065] abituguru3: found Abit uGuru3, motherboard ID: 0016
> [   10.242105] abituguru3: this motherboard was not detected using DMI.
> Please send the output of "dmidecode" to the abituguru3 maintainer(see
> MAINTAINERS)
>
> Motherboard: AW9D-MAX as shown below.
>
> DMI Decode:
[snip]
>  	Product Name: AW9D-MAX       (Intel i975-ICH7)

The spaces are a somewhat worrying (Abit haven't done this on other boards I 
have DMI information for), but assuming they're constant through all BIOS 
revisions the attached patch should be safe.

(In the longer term it might be safer to only match the board product name, 
and ignore the chipset information. I'll do this if the need arises.)

Please test the attached patch. I'll resubmit a cleaned up version if you can 
verify that the kernel message disappears and your sensors still work.

-- 
Cheers,
Alistair.

--Boundary-00=_2A5+IzONxSO1y2r
Content-Type: text/x-patch; charset="us-ascii";
	name="aw9d-max-dmi-detection.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aw9d-max-dmi-detection.diff"

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index d9e7a49..ff6aad8 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -402,7 +402,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0016, NULL /* AW9D-MAX, need DMI string */, {
+	{ 0x0016, "AW9D-MAX       (Intel i975-ICH7)", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },

--Boundary-00=_2A5+IzONxSO1y2r
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_2A5+IzONxSO1y2r--
