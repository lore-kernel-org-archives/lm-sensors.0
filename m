From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sat, 04 Oct 2008 11:54:52 +0000
Subject: Re: [lm-sensors] abitguru3 doesnt detect fan6 on Abit AT8-32X
Message-Id: <200810041254.52289.alistair@devzero.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_Mm15IVPWzfUrEMX"
List-Id: <lm-sensors.vger.kernel.org>
References: <20081004105600.62a2b75c@hyperion.delvare>
In-Reply-To: <20081004105600.62a2b75c@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--Boundary-00=_Mm15IVPWzfUrEMX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Re ticket 2339, could you try the attached patch?

My understanding is that the sensor tables are derived from an ini shipping 
with the Windows driver. I don't have that driver handy right now, but I'm 
guessing the config is missing this final fan. At a guess, it's placed 
immediately after the other fans in the table. The attached patch implements 
this for your board.

If you don't have anything connected to the sixth fan port, please let me 
know. I'd rather not apply an untested patch. If the fan appears but does not 
produce a valid reading, try incrementing the valid 27 introduced in the patch 
in the range 37-47 until the fan appears. I've also guessed a name for the fan 
"AUX3", for which there might be something more suitable.

(Unrelated, but it would also be useful if you could run "dmidecode" as root 
and send me a copy of the output, then I can implement DMI detection for your 
board.)

-- 
Cheers,
Alistair.

--Boundary-00=_Mm15IVPWzfUrEMX
Content-Type: text/x-patch; charset="us-ascii";
	name="at8-32x-add-aux3-fan.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="at8-32x-add-aux3-fan.diff"

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index d568c65..4545194 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -303,6 +303,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "SYS Fan",		34, 2, 60, 1, 0 },
 		{ "AUX1 Fan",		35, 2, 60, 1, 0 },
 		{ "AUX2 Fan",		36, 2, 60, 1, 0 },
+		{ "AUX3 Fan",		37, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
 	{ 0x0012, NULL /* Abit AN8 32X, need DMI string */, {

--Boundary-00=_Mm15IVPWzfUrEMX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_Mm15IVPWzfUrEMX--
