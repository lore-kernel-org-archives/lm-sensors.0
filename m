From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Date: Thu, 02 Jul 2009 08:04:56 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <4A4C6A28.9010102@tudelft.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000307090007070702080400"
List-Id: <lm-sensors.vger.kernel.org>
References: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>	<4A4BB4AB.7010003@cam.ac.uk>	<68FBE0F3CE97264395875AC1C468F22C152BFA@mail03.cyberswitching.local> <20090701221310.1d6aa587@hyperion.delvare>
In-Reply-To: <20090701221310.1d6aa587@hyperion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Chris Verges <chrisv@cyberswitching.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

This is a multi-part message in MIME format.
--------------000307090007070702080400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Op 01-07-09 22:13, Jean Delvare schreef:
> A few accelerometer drivers were originally added to drivers/hwmon
> because the chips also included some hwmon features (e.g. temperature
> sensor.) Now every new accelerometer driver gets dropped in
> drivers/hwmon "because there are other accelerometer drivers there".
> The LIS3LV02D driver is a perfect example of this... the device is not
> even registered as a hwmon driver! This driver definitely doesn't
> belong there.
> 
> Probably it's about time to put an end to this and kick all
> accelerometer drivers out of drivers/hwmon.
(I'm the maintainer of LIS3LV02D)
I completely agree with you, accelerometer drivers do not belong to
hwmon. Unfortunately, so far there has not been any landing place which
looked really more relevant. As soon as such a thing is available (maybe
an "accelerometer" subsystem) I'll be happy to move the driver :-)

Eric



--------------000307090007070702080400
Content-Type: text/x-vcard; charset=utf-8;
 name="E_A_B_Piel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="E_A_B_Piel.vcf"

begin:vcard
fn;quoted-printable:=C3=89ric Piel
n;quoted-printable:Piel;=C3=89ric
org:Technical University of Delft;Software Engineering Research Group
adr:HB 08.080;;Mekelweg 4;Delft;;2628 CD;The Netherlands
email;internet:E.A.B.Piel@tudelft.nl
tel;work:+31 15 278 6338
tel;cell:+31 6 2437 9135
x-mozilla-html:FALSE
url:http://pieleric.free.fr
version:2.1
end:vcard


--------------000307090007070702080400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000307090007070702080400--

