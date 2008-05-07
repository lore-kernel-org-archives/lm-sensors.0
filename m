From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 May 2008 06:45:07 +0000
Subject: Re: [lm-sensors] Problem with sensors on linux 2.6.25
Message-Id: <20080507084507.77764325@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805042334.03574.tockar@o2.pl>
	<20080506231838.563c9dcd.akpm@linux-foundation.org>
In-Reply-To: <20080506231838.563c9dcd.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tockar <tockar@o2.pl>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 6 May 2008 23:18:38 -0700, Andrew Morton wrote:
> On Sun, 4 May 2008 23:34:03 +0200 tockar <tockar@o2.pl> wrote:
>=20
> > Hello,
> > I've strange problem with Linux 2.6.25 and later (I've compiled 2.6.26-=
rc1 and=20
> > I have same problem). In 'sensors' command result, I get ALARMs.=20
> > Here's 'sensors' result on Linux 2.6.24:
> >=20
> > it87-isa-0290
> > Adapter: ISA adapter
> > VCore 1:     +1,71 V  (min =3D  +3,97 V, max =3D  +1,95 V)
> > VCore 2:     +3,09 V  (min =3D  +3,82 V, max =3D  +1,01 V)
> > +3.3V:       +3,07 V  (min =3D  +3,82 V, max =3D  +3,06 V)
> > +5V:         +5,59 V  (min =3D  +4,27 V, max =3D  +5,11 V)
> > +12V:       +13,31 V  (min =3D +15,62 V, max =3D  +7,74 V)
> > -12V:        -2,69 V  (min =3D  -0,61 V, max =3D  +3,44 V)
> > -5V:         -9,14 V  (min =3D  +3,82 V, max =3D  -2,62 V)
> > Stdby:       +0,00 V  (min =3D  +6,37 V, max =3D  +5,03 V)
> > VBat:        +3,25 V
> > fan1:       5152 RPM  (min =3D    0 RPM, div =3D 2)
> > fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)
> > M/B Temp:    +34,0__C  (low  =3D  -7,0=B0C, high =3D -11,0=B0C)  sensor=
 =3D transistor
> > CPU Temp:    +33,0__C  (low  =3D -66,0=B0C, high =3D +127,0=B0C)  senso=
r =3D transistor
> > Temp3:       +31,0__C  (low  =3D -33,0=B0C, high =3D -101,0=B0C)  senso=
r =3D transistor
> >=20
> > Two minutes later, on Linux 2.6.25:
> >=20
> > it87-isa-0290
> > Adapter: ISA adapter
> > VCore 1:     +1,71 V  (min =3D  +3,97 V, max =3D  +1,95 V)   ALARM
> > VCore 2:     +3,09 V  (min =3D  +3,82 V, max =3D  +1,01 V)   ALARM
> > +3.3V:       +3,07 V  (min =3D  +3,82 V, max =3D  +3,06 V)   ALARM
> > +5V:         +5,59 V  (min =3D  +4,27 V, max =3D  +5,11 V)   ALARM
> > +12V:       +13,31 V  (min =3D +15,62 V, max =3D  +7,74 V)   ALARM
> > -12V:        -2,69 V  (min =3D  -0,61 V, max =3D  +3,44 V)   ALARM
> > -5V:         -9,14 V  (min =3D  +3,82 V, max =3D  -2,62 V)   ALARM
> > Stdby:       +0,00 V  (min =3D  +6,37 V, max =3D  +5,03 V)   ALARM
> > VBat:        +3,25 V
> > fan1:       5152 RPM  (min =3D    0 RPM, div =3D 2)
> > fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)
> > M/B Temp:    +35,0__C  (low  =3D  -7,0=B0C, high =3D -11,0=B0C)  sensor=
 =3D transistor
> > CPU Temp:    +33,0__C  (low  =3D -66,0=B0C, high =3D +127,0=B0C)  senso=
r =3D transistor
> > Temp3:       +32,0__C  (low  =3D -33,0=B0C, high =3D -101,0=B0C)  senso=
r =3D transistor
> >=20
> > Results are almost identical, but I get those ALARMs. I've Pentium4 1,4=
Ghz=20
> > processor, module for my mainboard is BLK_DEV_VIA82CXXX. Is that a bug?=
 Can I=20
> > safely use Linux 2.6.25 or later?

No, it's not a bug. Yes, 2.6.25 can be safely used, do not worry.

The it87 driver in kernel 2.6.24 did not implement the standard alarm
reporting, so sensors 3.x (which I guess you are using) couldn't report
the alarms. This was fixed in 2.6.25, so now you see the alarms, but in
fact they were already there before.

All these alarms really mean is that you didn't bother fine-tuning your
sensors3.conf file, or you did but you forgot to run "sensors -s"
afterwards, so the low and high limits for each sensor aren't set
properly. So, if you care about the alarms, you have to edit the
configuration file. If you are lucky, we might have one for your board
already, check at http://www.lm-sensors.org/wiki/Configurations and
http://khali.linux-fr.org/devel/lm-sensors/ . But more likely you'll
have to do the work by yourself.

Note: I see that you are using a locale where a comma is used to
display decimal numbers. There's a bug in libsensors which causes some
statements of the configuration file to be parsed improperly in this
case. This is fixed in SVN already, but until 3.0.2 is released and you
upgrade to it, you should force your locale to C when running "sensors"
or "sensors -s".

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
