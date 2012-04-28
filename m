From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Apr 2012 14:43:24 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <20120428144324.GA23747@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Apr 28, 2012 at 04:55:09AM -0400, Jean Delvare wrote:
> On Sat, 28 Apr 2012 06:43:53 +0000, P.B. V wrote:
> > w83627ehf and nct6775 (Apr 27, 2012) driver modules both show a
> > seemingly incorrect value for PECI. I am running a Maximus IV Extreme
> > Revision 1.0 motherboard (NCT6776F), with an i5-2550K CPU, on kernel
> > 3.3.
> >=20
> > The coretemp module and my BIOS reports my idle temperatures at around
> > 33-35C, while PECI in Linux reports in at 23-25. It looks to be 10
> > degrees off. Under load it scales with coretemp, always staying 10
> > degrees under the average coretemp values.
> >=20
> > Unless I'm not understanding something correctly, PECI should not be
> > used and doing so may lead to hardware damage.
> >=20
> > coretemp:
> >  Physical id 0:  +36.0 C  (high =3D +80.0 C, crit =3D +101.0 C)
> >  Core 0:         +36.0 C  (high =3D +80.0 C, crit =3D +101.0 C)
> >  Core 1:         +32.0 C  (high =3D +80.0 C, crit =3D +101.0 C)
> >  Core 2:         +34.0 C  (high =3D +80.0 C, crit =3D +101.0 C)
> >  Core 3:         +30.0 C  (high =3D +80.0 C, crit =3D +101.0 C)
> >=20
> > w83627ehf: (nct6775 values are identical)
> >  PECI Agent 0:  +24.0 C
>=20
> PECI values are reported (at the hardware level) relative from an
> arbitrary maximum. The coretemp driver uses 101=B0C as the maximum, your
> results suggests that the w83627ehf and nct6775 drivers use 91=B0C (or
> maybe 90=B0C) instead. This isn't going to cause any hardware damage, and
> you can even fix the problem in user-space with a compute formula like:
>=20
The maximum should be set by the BIOS. On my system (ASUS mainboard) it
is correctly set to the critical CPU temperature (99 degrees C in my case).
Guess the Maximum board doesn't do that.

> chip "nct6776-*"
>=20
>    compute tempN @ + 10, @ - 10
>=20
> Guenter, is there a way to know what the NCT6776F thinks the maximum
> temperature is? Maybe we can read it from registers 0x709 or 0x70A? If
> we could present this value as tempN_crit, this would help understand
> the difference of absolute temperatures between coretemp and nct6776.
>=20

Good idea. I added that to the nct6775 driver (I don't really want to mess
with the w83627ehf driver - it is getting too complicated).
Output for NCT6776F on my board (i5-2400) is now:

PECI Agent 0:   +39.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
                         (crit =3D +99.0=B0C)

and for NCT6775F (i7-2600):

PECI Agent 0:   +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
                         (crit =3D +98.0=B0C)

The attribute is writable.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
