From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Date: Wed, 04 Jun 2008 23:43:46 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <484728B2.1000209@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net> <20080604225830.1dff64fc@hyperion.delvare> <20080604230510.GB30475@elf.ucw.cz>
In-Reply-To: <20080604230510.GB30475@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pavel Machek <pavel@suse.cz>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

05-06-08 01:05, Pavel Machek wrote/a =E9crit:
> Hi!
>=20
>> So my advice is that you don't wait for a review from the hwmon people,
>> because apparently we don't have much interest in this type of device,
>> so you'll be waiting forever. You're much better adding the mdps driver
>> to drivers/misc through Andrew Morton, at least until someone takes
>> care of creating a subsystem for this type of devices and move all
>> existing drivers there.
>=20
> Just create drivers/accel ... accelerometers are quite common these
> days. Going to drivers/misc is okay, too, I guess -- moves are easy
> with git ;-).
Yes, why not do one little step to the correct direction now and create
drivers/accel, it will likely be the chosen name anyway! That will not
yet be a "real" subsystem, just a place to put all the related drivers
already present together.
Anyone against this idea?

Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
