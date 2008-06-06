From: Eric Piel <E.A.B.Piel@tudelft.nl>
Date: Fri, 06 Jun 2008 14:56:23 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <48495017.8040003@tudelft.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040408070907010401070004"
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost>	<4846EBF5.2030406@tremplin-utc.net>	<20080604225830.1dff64fc@hyperion.delvare>	<20080604230510.GB30475@elf.ucw.cz>	<484728B2.1000209@tremplin-utc.net> <20080605082950.6957f1a2@hyperion.delvare> <4847B415.2080708@cam.ac.uk> <48484DD6.3050706@tremplin-utc.net> <4848683E.4070709@eslack.org>
In-Reply-To: <4848683E.4070709@eslack.org>
To: Pau Oliva Fora <pau@eslack.org>
Cc: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>, Jonathan Cameron <jic23@cam.ac.uk>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>, Torokhov <dmitry.torokhov@gmail.com>, Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Pavel Machek <pavel@suse.cz>, Yan@ATrpms.net, Dmitry@ATrpms.net, Arjan van de Ven <arjan@infradead.org>

This is a multi-part message in MIME format.
--------------040408070907010401070004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pau Oliva Fora wrote:
> Here's an i2c version of the driver for the LIS3LV02DL accelerometer,
> please try to combine it too, so we'll end up having ACPI, SPI and I2C.
Whaoo, you went fast!
As there is a dmi_match, that shouldn't be too hard to incorporate it 
nicely :-)

BTW, do you really need the invert_x and invert_y and swap_xy 
parameters? Don't all the HTC shift laptops have the sensors soldered 
the same way? We've worked hard to remove those parameters in mdps ;-)

See you,
Eric


--------------040408070907010401070004
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


--------------040408070907010401070004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040408070907010401070004--
