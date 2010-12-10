From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Dec 2010 15:23:13 +0000
Subject: Re: [lm-sensors] weird lectures
Message-Id: <20101210152313.GC11777@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP1575A83C98D31BBDBECD18ECE2F0@phx.gbl>
In-Reply-To: <BLU0-SMTP1575A83C98D31BBDBECD18ECE2F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Dec 10, 2010 at 09:32:47AM -0500, Jose M. Caballero wrote:
> El jue, 09-12-2010 a las 08:20 -0800, Guenter Roeck escribi=F3:
> > On Thu, Dec 09, 2010 at 11:09:34AM -0500, Jos=E9 M. Caballero wrote:
> > [ ... ]
> > >=20
> > > Thanks a lot. Finally it works.
> > > But it is very worrying lectures:
> > >=20
> > >=20
> > > w83667hg-isa-0290
> > > Adapter: ISA adapter
> > > in0:         +0.89 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
> > > in1:         +1.86 V  (min =3D  +0.73 V, max =3D  +1.97 V)  =20
> > > in2:         +3.42 V  (min =3D  +0.45 V, max =3D  +3.82 V)  =20
> > > in3:         +3.42 V  (min =3D  +1.18 V, max =3D  +0.27 V)   ALARM
> > > in4:         +0.05 V  (min =3D  +0.50 V, max =3D  +0.11 V)   ALARM
> > > in5:         +1.74 V  (min =3D  +1.39 V, max =3D  +0.91 V)   ALARM
> > > in7:         +3.44 V  (min =3D  +0.90 V, max =3D  +3.07 V)   ALARM
> > > in8:         +3.30 V  (min =3D  +1.31 V, max =3D  +1.76 V)   ALARM
> > > fan1:          0 RPM  (min =3D  340 RPM, div =3D 128)  ALARM
> > > fan2:       2008 RPM  (min =3D  448 RPM, div =3D 32)
> > > fan3:          0 RPM  (min =3D  405 RPM, div =3D 128)  ALARM
> > > temp1:       +30.0=B0C  (high =3D -10.0=B0C, hyst =3D  -5.0=B0C)  ALA=
RM  sensor > > > thermistor
> > > temp2:       +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sen=
sor > > > thermistor
> > > temp3:      +127.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALA=
RM  sensor > > > thermistor
> > > cpu0_vid:   +2.500 V
> > >=20
> > > I hope the sensor doesn't work properly...
> > >=20
> > temp3 is probably not connected, as is fan1 and fan3. The temp1 high li=
mit seems to be=20
> > unset. The voltage limits look odd, with max being lower than min in so=
me cases.
> > Since ALARM is set for those voltages, I suspect that the limits are no=
t set correctly.
> > You can test that by setting more reasonable limits for one of the volt=
ages (and temp1)
> > and verify if that resets the ALARM bit.
> >=20
> > Guenter
> >=20
>=20
> After installing (successfully) lm-sensors and the standalone patch for
> Nuvoton w83627hg-b (w83627ehf driver), I have not a /etc/sensors.conf
> file just a sensors3.conf file with next relevant data:
> =20
> chip "w83627ehf-*" "w83627dhg-*"
> =20
>     label in0 "Vcore"
>     label in2 "AVCC"
>     label in3 "VCC"
>     label in7 "3VSB"
>     label in8 "Vbat"
> =20
>     set in2_min  3.3 * 0.90
>     set in2_max  3.3 * 1.10
>     set in3_min  3.3 * 0.90
>     set in3_max  3.3 * 1.10
>     set in7_min  3.3 * 0.90
>     set in7_max  3.3 * 1.10
>     set in8_min  3.0 * 0.90
>     set in8_max  3.0 * 1.10
>    =20
> (The same data as the sensors.conf.default from the
> lm_sensors-3.2.0.tar.bz2)
> =20
> Could be due to that some of my amazing readings of 'sensors'? How to
> fix it?
>=20
Might well be. I would suggest to remove the set lines (or comment them out=
) and=20
restart your system.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
