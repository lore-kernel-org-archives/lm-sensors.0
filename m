From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jun 2008 08:22:26 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080612102226.7532f580@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bruno,

On Wed, 11 Jun 2008 23:09:49 +0200, Bruno Pr=E9mont wrote:
> On Wed, 11 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > 55 Hz would be 1650 RPM. If the IT8712F reports 4600 RPM then it's
> > indeed certainly wrong. Can you check what speed is reported in the
> > BIOS? Please also test with another fan if you can. I'd like to know
> > if that's a problem with this specific fan (in which case there's
> > probably not much we can do) or not. I suspect not (see below.)
>=20
> I've not checked the BIOS yet but increasing divider helps - see also
> below

Your chip doesn't actually have these dividers. Changing them appears
to work because the driver _thinks_ the dividers exist and it somehow
compensates with the missing support for 16-bit counter registers. But
the value you get is still wrong!

> I have a second FAN of the same brand, same model which produces
> equivalent values. I didn't check a quicker fixed-speed fan yet on that
> connector.
> The CPU fan is fixed-speed and regulated by IT8712F (speed
> reported as 3200 with pwm=3D2 RPM, about 4400 RPM with pwm=3D4 - same val=
ues
> for divider =3D 2..8)
>
> By the way, how does this behave with S3 (suspend to RAM), are all
> values reprogrammed by the kernel or is it userspace's job (can't test
> because of the graphics chips... no resume support yet in kernel for
> ATI/AMD graphics)
> I know that on older nforce-based PC did forget pwm settings on resume
> (never cared about the divider so would have to verify for that one)

I've never thought about S3 support, so I'd say it is unsupported and
you are lucky if it works at all.

> > Please remember that the divisor value does _not_ divide the speed
> > value. It only affects the range of measurable values. For a fan that
> > could run as slow as 1000 RPM, you want to set the divider to 8.
>=20
> Changing the divider to 8 makes the IT8712F report a likely speed around
> 1500 RPM, so the divider was the cause of the bad value.

No, it wasn't (not directly at least). That's two errors roughly
compensating themselves, so the end result looks acceptable, but it's
still wrong. I can explain it to you when you provide a dump of your
chip.

> (wondering why it defaults to such a small divider as is 2)

That's a problem on recent systems, indeed. I think the reason is
historical. When the first hardware monitoring chips made it into PCs,
in the late 90's, CPU fans had fixed speeds, in the 3000 to 4500 RPM
range. For this speed range, div=3D2 was the correct value. On recent
systems, we have fan spinning at variable speeds, and large case fans
that spin at low speeds too, so the default would rather be div=3D8 but
the chips were not updated for this. Some BIOSes switch the dividers to
8, though.

Note that chip manufacturers are switching to 12-bit or 16-bit fan
speed registers. That's the best way to address the problem of fans
with variable speed. Using a fixed, high divider value with an 8-bit
register would result in bad measurement resolution at higher speeds.

> > Can you tell us what revision of the IT8712F you have? The it87 driver
> > will write it to the kernel log when you load it. I would also like a
> > dump of the chip (using isadump).
>=20
> According to dmesg it's revision 8:
> [   26.954326] i2c /dev entries driver
> [   26.954524] it87: Found IT8712F chip at 0xe80, revision 8
> [   26.954572] it87: in3 is VCC (+5V)
> [   26.954611] it87: in7 is VCCH (+5V Stand-By)

OK, revision 8 chips only support 16-bit fan speed registers, and the
driver doesn't support that. This is exactly what I suspected.

> Not sure how to call isadump to get the right data, its man-page
> is reasonably vague regarding the addrreg and datareg args...
> sould it be the following?:
>   isadump 0xe85 0xe86

Yes, that's exactly the right command to run in your case. See, the man
page wasn't that bad ;)

Please also tell me which of fan1, fan2 and fan3 is the case fan and
which is the CPU fan. Seeing the output of "sensors" on this machine
would help.

> > Recent IT8712F chips have 16-bit tachometer registers, but the it87
> > driver doesn't support this mode for that chip yet. We received a
> > patch adding support for that 4 months ago:
> >   http://lists.lm-sensors.org/pipermail/lm-sensors/2008-February/022460=
.html
> > I reviewed it, it needed some more work, but the author never followed
> > up. If you need this, I guess we'll have to revive it.
>=20
> I could help testing that patch though test-responsiveness may not be
> optimal knowing that this host is actively used and freeing a timeslot
> for testing is not that easy (usually only possible at night during
> weekend)

I've asked the original author for an update, let's see if he sends
something.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
