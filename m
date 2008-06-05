From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 05 Jun 2008 09:38:29 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <4847B415.2080708@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost>	<4846EBF5.2030406@tremplin-utc.net>	<20080604225830.1dff64fc@hyperion.delvare>	<20080604230510.GB30475@elf.ucw.cz>	<484728B2.1000209@tremplin-utc.net> <20080605082950.6957f1a2@hyperion.delvare>
In-Reply-To: <20080605082950.6957f1a2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@osdl.org>, Torokhov <dmitry.torokhov@gmail.com>, Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Pavel Machek <pavel@suse.cz>, Yan@ATrpms.net, Dmitry@ATrpms.net, Arjan van de Ven <arjan@infradead.org>

Jean Delvare wrote:
> On Thu, 05 Jun 2008 01:43:46 +0200, =C9ric Piel wrote:
>> 05-06-08 01:05, Pavel Machek wrote/a =E9crit:
>>>> So my advice is that you don't wait for a review from the hwmon people,
>>>> because apparently we don't have much interest in this type of device,
>>>> so you'll be waiting forever. You're much better adding the mdps driver
>>>> to drivers/misc through Andrew Morton, at least until someone takes
>>>> care of creating a subsystem for this type of devices and move all
>>>> existing drivers there.
>>> Just create drivers/accel ... accelerometers are quite common these
>>> days. Going to drivers/misc is okay, too, I guess -- moves are easy
>>> with git ;-).
>> Yes, why not do one little step to the correct direction now and create
>> drivers/accel, it will likely be the chosen name anyway! That will not
>> yet be a "real" subsystem, just a place to put all the related drivers
>> already present together.
>=20
> Well, I would expect all these accelerometer drivers to have a common,
> standardized interface, so this should most probably become a real
> subsystem in the long run.
>=20
>> Anyone against this idea?
>=20
> I am in favor of it.
The upshot of the discussion Jean referenced was that the there were a=20
number of other devices / sensors that will form part of the same system.

For an initial bash I'm throwing in a couple of accelerometers, ADC's and
probably one or two other sensors as well.  Haven't come up with a good
name as yet, but the point is that accelerometers would be just part of
the relevant subsystem.

Based on one suggestion (and current layout in my source tree),=20
drivers/industrialio/accelerometer
drivers/industrialio/adc
and crucially for all those weird and wonderful sensors,
drivers/industrialio/misc

The reason for making it an io system is that many chips combine ADCs and
DACs.  Also suggestions for alternative names would be most welcome.

Still, it may take some time to iron out the various kinks in this system
and get it fully tested, so may be worth putting stuff elsewhere for now
with the intention to move it as and when the more unified stuff has been
written.

Also, the LI3L02DQ (very similar to the chip you are using) is one of my
test chips, so combining the two drivers should be straight forward.
Also the driver I have is SPI only, so this may give us an easy way to
test a combined driver.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
