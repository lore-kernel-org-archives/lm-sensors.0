From: Reimundo Heluani <rheluani@gmail.com>
Date: Sat, 08 Aug 2009 22:13:52 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <1249769632.10843.9.camel@campari.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


On Wed, 24 Jun 2009 14:32:45 +0200, Konstantin Kletschke wrote:

>=20
> Exactly I am running 2.6.30-rc7, the guy reporting this in the ubuntu
> forum did this februrary 28th, so on another kernel.

I think that was probably me :)=20


>> Would you be able and willing to apply a patch to your kernel and
>> rebuild it, if I come up with something?

I know this is a (not so) old thread, but where can I find the Kernel patch=
es from=20
2.6.29.5 to 2.6.30.4 for support with the 283667hg-A chipset in an asus=20
P5q3-Deluxe? I can't really run 2.6.30.4 as it kills audio which I can't
 solve apparently, so I'd like to patch my 2.6.29 kernel directly.

By the way, my readings on the p5q3 when running 2.6.30.4 also can't be
correct:

w83667hg-isa-0290
Adapter: ISA adapter
in0:         +1.11 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
in1:         +1.75 V  (min =3D  +0.79 V, max =3D  +0.05 V)   ALARM
in2:         +3.36 V  (min =3D  +0.53 V, max =3D  +0.51 V)   ALARM
in3:         +3.33 V  (min =3D  +2.14 V, max =3D  +0.51 V)   ALARM
in4:         +1.70 V  (min =3D  +0.82 V, max =3D  +0.51 V)   ALARM
in5:         +2.04 V  (min =3D  +0.27 V, max =3D  +0.51 V)   ALARM
in7:         +3.41 V  (min =3D  +2.05 V, max =3D  +0.22 V)   ALARM
in8:         +3.30 V  (min =3D  +0.64 V, max =3D  +0.02 V)   ALARM
fan1:        760 RPM  (min =3D 2410 RPM, div =3D 8)  ALARM
fan2:       1298 RPM  (min =3D 2636 RPM, div =3D 16)  ALARM
fan3:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan4:        753 RPM  (min =3D 12980 RPM, div =3D 8)  ALARM
fan5:        756 RPM  (min =3D  981 RPM, div =3D 8)  ALARM
temp1:       +37.0=B0C  (high =3D +102.0=B0C, hyst =3D +19.0=B0C)  sensor t=
hermistor
temp2:       +25.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
temp3:       +21.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor th=
ermistor
cpu0_vid:   +1.163 V

I'm also more than willing to try whatever you want on this machine :)

Thanks

R.

> > time understanding how this can happen at all. Does writing to pwm3
> > change the value of pwm2, too?
>=20
> echo into pwm1 changes nothing:
>=20
> > cat pwm1 pwm2 pwm3
> 77
> 55
> 78
> > echo "99" >> pwm1
> > cat pwm1 pwm2 pwm3
> 77
> 55
> 78
>=20
> echo into pwm2 changes pwm1:
>=20
> > cat pwm1 pwm2 pwm3
> 77
> 55
> 78
> > echo "99" >> pwm2
> > cat pwm1 pwm2 pwm3
> 99
> 55
> 78
>=20
> echo into pwm3 changes pwm3:
>=20
> > cat pwm1 pwm2 pwm3
> 99
> 55
> 78
> > echo "100" >> pwm3
> > cat pwm1 pwm2 pwm3
> 99
> 55
> 100

This is all very confusing, I admit. I would like you to unload the
w83627ehf driver and try to read from / write to the chip directly. For
this you'll need the isadump and isaset tools (part of lm-sensors.)

Registers pwm1, pwm2 and pwm3 are at 0x01, 0x03 and 0x11, respectively.
You can see their raw value using the following command (as root):

isaset 0x295 0x296 0x4e 0 # set bank to 0
isadump 0x295 0x296

Then I would like you to write to each register, then check the result.
The value written doesn't matter as long as it is different from the
current value of all 3 registers in question:

isaset 0x295 0x296 0x01 0xaa
isadump 0x295 0x296

isaset 0x295 0x296 0x03 0xbb
isadump 0x295 0x296

isaset 0x295 0x296 0x11 0xcc
isadump 0x295 0x296

If this works fine then that would be a bug in the driver. If it
doesn't, that would be a hardware bug.

--=20
Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
