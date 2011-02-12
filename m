From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 12 Feb 2011 05:08:01 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (w83627ehf) Use 16 bit fan
Message-Id: <20110212050801.GA7057@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Feb 11, 2011 at 11:08:54PM -0500, Andrew Lutomirski wrote:
> On Fri, Feb 11, 2011 at 10:45 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Fri, Feb 11, 2011 at 10:09:23PM -0500, Andrew Lutomirski wrote:
> >> On Fri, Feb 11, 2011 at 12:20 PM, Guenter Roeck
> >> <guenter.roeck@ericsson.com> wrote:
> >> > Some of the chips supported by this driver have 13 bit or 16 bit fan=
 count
> >> > registers. This patch improves support for those registers, specific=
ally for
> >> > NCT6775F. With the changes in this patch, fan speed is reported corr=
ectly even
> >> > if the fan divider is set to a low value, which results in a fan spe=
ed reading
> >> > above 0xff.
> >>
> >> I'm not convinced this works. =A0I have an NCT6775F (or at least the
> >> driver says I do) and, with fan2_min =3D 0 or 100, I get fan2_div =3D =
128.
> >> =A0If I set fan2_min=1000, I get fan2_div =3D 8 but fan2_input reads 0.
> >> Presumably a low divider should have worked if I really had 16 bits to
> >> play with.
> >>
> > Yes, you are right. Can you dump the raw contents of the registers at 0=
x28..0x2a
> > as well as 0x630..0x637 ?
>=20
> [13561.120768] w83627ehf: Found NCT6775F chip at 0x290
> [13561.121084] Reg 0028 =3D 45
> [13561.121097] Reg 0029 =3D 4c
> [13561.121108] Reg 002a =3D 00
> [13561.121119] Reg 003f =3D 00
> [13561.121147] Reg 0630 =3D 0045
> [13561.121166] Reg 0631 =3D 4500
> [13561.121186] Reg 0632 =3D 004c
> [13561.121205] Reg 0633 =3D 4c00
> [13561.121225] Reg 0634 =3D 0000
> [13561.121244] Reg 0635 =3D 0000
> [13561.121263] Reg 0636 =3D 0000
> [13561.121283] Reg 0637 =3D 0000
>=20
> >
> > According to the datasheet, register 0x28 and 0x631 should match, 0x29 =
should
> > match 0x633, 0x2a should match 0x635, and 0x3f should match 0x637.
>=20
> Doesn't look like it.  You might be off by one, or maybe there's an
> endianness issue.
>=20
No, it is ok, since the registers are detected as 16 bit registers. Reading=
 from 0x630=20
really reads from 0x630 and 0x631, and the result is as expected (ie the re=
ad from 0x630
returns the same as the read from 0x28, and both is 0x45).

But then this should translate to a fan1 value of (1350000 / (0x45 * diviso=
r)),
ie be reported as a value somewhere between 19565 if the divisor is 1 to
153 if the divisor is 128. I must be missing something.

Odd is that if I simulate fan speed reading, ie just assign 0x45 to fan[i] =
when
reading the fan speeds, I do get the expected speeds for the various diviso=
r values.
So I don't really understand what is going on in your system.

Can you possibly dump the raw values of nr, data->fan[nr], data->fan_div[nr=
], and=20
data->fan_from_reg(data->fan[nr], data->fan_div[nr]) in show_fan() ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
