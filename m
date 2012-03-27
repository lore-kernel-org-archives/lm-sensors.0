From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 27 Mar 2012 23:28:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for  IT8781F, IT8782F, IT8783E/F
Message-Id: <20120327232853.GA21100@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
In-Reply-To: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Mar 27, 2012 at 03:21:35PM -0400, Bj=F6rn Gerhart wrote:
> Hi Jean,
>=20
> Am 26.03.2012 um 19:01 schrieb Jean Delvare:
> > [..]
> >> If actually it is the job of the module to do such calculations, I wou=
ld offer to create an it87 patch for IT8783 fixing this - analog to an exis=
ting module with a similar behavior (if you know one).
> >=20
> > You assume that the PECI value always refers to the CPU. I do not think
> > this is true, other parts (e.g. north bridge) could report their
> > temperature through PECI as well.
> >=20
> > And if it is the CPU temperature, we already have the coretemp driver
> > providing the same information, so there's little point in implementing
> > the same in it87. The only benefit of handling PECI sensors in it87 and
> > the like would be so that they can be used as sources for automatic fan
> > speed control, but if the chip itself has no idea about the absolute
> > value of the temperature then I doubt it can use it for automatic fan
> > speed control.
> >=20
> Yes, with the coretemp driver even both core temperatures are displayed c=
orrectly. So I agree, it's nonsense to implement our special design into th=
e generic driver  ;-)

Depends. As Jean mentioned, it would make sense if the temperature can be u=
sed for
automatic fan control.

The PECI specification says (I qoute Wikipedia) "PECI reports a negative va=
lue expressing
the difference between the current temperature and the thermal throttle poi=
nt (at which
the CPU reduces speed or shuts down to prevent damage due to overheating) i=
nstead of the
absolute temperature". So the negative value and slope is to be expected.

Question is if there is a way to tell the chip the how to calculate the rea=
l temperature
from the raw value reported by PECI. The Nuvoton chips have a set of regist=
ers for that
purpose.

Since the raw PECI value is not very useful, it might well be that it is po=
ssible
to program the ITE chip to adust its readings. No idea how to do that, thou=
gh.
If your HW folks have a contact at ITE, maybe you could ask them to try to =
find out.
Or maybe there is some BIOS code available from ITE and/or from BIOS vendor=
s.

Alternatively, it might be possible to program fan control to take the nega=
tive slope
into account; at least Wikipedia suggests that as possibility (to have the =
fan run faster
as the reported temperature approaches zero from below). No idea how to do =
that either,
though.

There is also register 0x0a, bits 4-6. Is that set to PECI on your board ?

Either case, I think it would make sense for us to report the sensor type a=
s PECI
if so configured. Yet another patch ...

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
