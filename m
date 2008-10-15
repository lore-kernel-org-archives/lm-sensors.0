From: Eric Piel <eric.piel@tremplin-utc.net>
Date: Wed, 15 Oct 2008 07:50:32 +0000
Subject: Re: [lm-sensors] Accelerometer driver for HP laptops
Message-Id: <48F5A0C8.1080102@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C984F5.5000804@tudelft.nl> <200809120736.06594.trenn@suse.de> <48CAD89F.1050806@tremplin-utc.net> <20081015072511.GA20607@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20081015072511.GA20607@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pavel Machek <pavel@suse.cz>
Cc: lm-sensors@lm-sensors.org, kernel list <linux-kernel@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Tejun Heo <tj@kernel.org>, Yan Burman <burman.yan@gmail.com>

Pavel Machek schreef:
> Hi!
>=20
> I took a look at the driver, and it seems to work for me... I'd like
> to get it to the mainline...
>=20
>>>> Attached is our work-in-progress version of the driver for a fourth ta=
ke
>>>> on the LKML (it used to be mdps). It works really fine, with lots of
>>>> "goodies" (like automatically convert the axes to fit to a standard,
>>>> automatic power-off of the device when not in used) excepted the
>>>> interrupt support for free-fall detection.
>=20
> I wonder if mdps was really a better name? Driver is HP-specific
> (because of the ACPI usage), not really chip specific... and lis3lv02d
> looks like an alphabet soup to me...
>=20
> Ok, it is a bit chip-specific, too...
Yes, the point is that several people got interested in adding to the
driver SPI and I=B2C support last time I submitted the driver. I did my
best to concentrate the ACPI stuff only to some 3 or 4 small functions,
so that it can be be easily done.

>=20
> What are the next plans... lm_sensors is listed as orphan in
> MAINTAINERS, so I guess I'll clean it up a tiny bit then submit to akpm?
Yes I've hold things up because I can't get the free-fall detection
working correctly on my laptop. However here is the merge window (not
that it matters that much with new drivers), free-fall is "just" not
always detected, and there are lots of people who have showed interest
in the driver. Fixing the last small things can be done once in Linus'
tree as well!

I've got already a changelog ready. Give me a couple of days to clean
things up and I'll send it to akpm myself :-)

See you,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
