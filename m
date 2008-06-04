From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Date: Wed, 04 Jun 2008 23:29:21 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <48472551.9020202@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net> <20080604230326.GA30475@elf.ucw.cz>
In-Reply-To: <20080604230326.GA30475@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arjan van de Ven <arjan@infradead.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>

05-06-08 01:03, Pavel Machek wrote/a =E9crit:
> Hi!
>>> 3) Makes it possible to power the device off.
>=20
> But this part is what I don't understand. powering off does not seem
> to belong there. Why can't you just use acpi to power down?
Not sure what you mean. Are you saying acpi has already a user interface
to power up/down a device? If so, I'm not aware of it, is it in /sys ?
Or did you mean that there is already a kernel api to turn on/off a
device via acpi, no need to access the device directly?

That said, this special /sys interface to power the device off is
probably going to be used rarely. It was put there because it is costly
to wake the device up each time we want to read it. What I could do is
put a timer to turn the device off after 10s of non-usage, and power it
on automatically again as soon as the user wants to read some info. That
would permit to remove this interface.

Eric


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
