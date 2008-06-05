From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Date: Thu, 05 Jun 2008 20:34:30 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <48484DD6.3050706@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost>	<4846EBF5.2030406@tremplin-utc.net>	<20080604225830.1dff64fc@hyperion.delvare>	<20080604230510.GB30475@elf.ucw.cz>	<484728B2.1000209@tremplin-utc.net> <20080605082950.6957f1a2@hyperion.delvare> <4847B415.2080708@cam.ac.uk>
In-Reply-To: <4847B415.2080708@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>, Torokhov <dmitry.torokhov@gmail.com>, Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Pavel Machek <pavel@suse.cz>, Yan@ATrpms.net, Dmitry@ATrpms.net, Arjan van de Ven <arjan@infradead.org>

05-06-08 11:38, Jonathan Cameron wrote/a =E9crit:
:
> For an initial bash I'm throwing in a couple of accelerometers, ADC's and
> probably one or two other sensors as well.  Haven't come up with a good
> name as yet, but the point is that accelerometers would be just part of
> the relevant subsystem.
>=20
> Based on one suggestion (and current layout in my source tree),=20
> drivers/industrialio/accelerometer
> drivers/industrialio/adc
> and crucially for all those weird and wonderful sensors,
> drivers/industrialio/misc
>=20
> The reason for making it an io system is that many chips combine ADCs and
> DACs.  Also suggestions for alternative names would be most welcome.
Great to hear that you have started the new subsystem!
It's also nice that you are still hesitant about the name because
"industrialio" sounds for me too... let's say... industrial ;-) For
accelerometers found in laptops and mobile phones, it will sound strange
(although a name is just a name). Maybe "physicsio" (physics as "the
observation of the matter and its motion")?

> Still, it may take some time to iron out the various kinks in this system
> and get it fully tested, so may be worth putting stuff elsewhere for now
> with the intention to move it as and when the more unified stuff has been
> written.
Yes, so I'll keep my plan of first submitting the driver with the
current interface, and latter updating the interface to the new
subsystem when you have stabilised its interface.

BTW, just by curiosity, is your tree available publicly somewhere?

> Also, the LI3L02DQ (very similar to the chip you are using) is one of my
> test chips, so combining the two drivers should be straight forward.
> Also the driver I have is SPI only, so this may give us an easy way to
> test a combined driver.
For now I'll go back to the drawing board (with Yan) in order to address
the comments received, all very insightful. I'll also go around the
other versions of the driver to pick up the nice parts. Looking at the
openmoko driver, I finally understood how to avoid polling. It will
likely be worthy :-)
In addition, I'll try to make the main functions as independent as
possible of the platform, hoping that we can then easily merge the SPI
and the ACPI versions together.

See you,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
