From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Tue, 04 Sep 2007 12:16:11 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <1570769001@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ok, board-temperature might be higher then cpu-temperature.

But the question remains, who cpu-temperature can be below room temperature=
. In addition,=20
your cpu-temperatures are significant higher than mine. Even at full load I=
 dont get 60 =B0C.

Juergen


> -----Urspr=FCngliche Nachricht-----
> Von: Krzysztof Helt <krzysztof.h1@wp.pl>
> Gesendet: 02.09.07 15:26:42
> An: Juergen Bausa <Juergen.Bausa@web.de>
> Betreff: Re: [lm-sensors] dme1737 module


>=20
> On Sun, 02 Sep 2007 14:57:32 +0200
> Juergen Bausa <Juergen.Bausa@web.de> wrote:
>=20
> > I think 29 =B0C is also very low for idle and no fan, even for my AMD B=
E-2350=20
> > (45 w maximum power consumption). Also, Int-Temperature (is this board =
temperature?)
> > is higher than cpu- temperature. This changes only for high load, where
> > cpu-temperature increases more than int-temperature.
> >=20
> > At first I thought that temperature calculation is wrong in lm-sensors.=
 However,
> > BIOS shows nearly the same temperatures.
>=20
> It is ok. I have something similar with the Compaq AP550 (Pentium3 CPUs -=
 not mobile version), which has no fans on CPU and only case fan.=20
> Even with minimal speed of fan I got around 30 to 35 degrees for CPUs whi=
le
> motherboard temperature is 36 and even 41 degrees (but I don't know where=
 - could be close to memory or chipset).
>=20
> Room temperature is 24 degrees now. The read values (no load):
>=20
> adm1022-i2c-0-2d
> Adapter: SMBus I801 adapter at fc00
> M/B Temp: +36.0=B0C (low =3D -128.0=B0C, high =3D +127.0=B0C)=20
> AUX Temp: +41.0=B0C (low =3D -128.0=B0C, high =3D +127.0=B0C)=20
>=20
> adm1022-i2c-0-2e
> Adapter: SMBus I801 adapter at fc00
> M/B Temp (near CPUs): +37.0=B0C (low =3D -128.0=B0C, high =3D +127.0=B0C)=
=20
> CPU1 Temp: +34.0=B0C (low =3D +0.0=B0C, high =3D +127.0=B0C)=20
> CPU2 Temp: +36.0=B0C (low =3D +0.0=B0C, high =3D +127.0=B0C)=20
>=20
> The CPUs temperature goes up to 60 degrees under load then return to the =
30 degree range when CPUs are idle.
>=20
> Regards,
> Krzysztof
>=20

=20
=20
=20

> -----Urspr=FCngliche Nachricht-----
> Von: Jean Delvare <khali@linux-fr.org>
> Gesendet: 02.09.07 19:46:00
> An: Juerg Haefliger <juergh@gmail.com>
> CC: lm-sensors@lm-sensors.org
> Betreff: Re: [lm-sensors] dme1737 module


>=20
> On Sun, 02 Sep 2007 14:57:32 +0200, Juergen Bausa wrote:
> > dme1737-i2c-0-2e
> > Adapter: SMBus nForce2 adapter at 4c00
> > V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
> > Vccp:      +1.10 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > V3.3:      +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > V5:        +4.94 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > V12:      +11.80 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > V3.3stby:  +3.29 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > Int Temp:    +34=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > CPU Temp:    +29=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > CPU_Fan:     0 RPM  (min =3D    0 RPM)
> > ERROR: Can't get fan3 data!
> > ERROR: Can't get fan5 data!
> > ERROR: Can't get fan6 data!
> > CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
> > ERROR: Can't get pwm5 data!
> > ERROR: Can't get pwm6 data!
> > cpu0_vid: +1.550 V  (VRM Version 2.4)
>=20
> Juerg, sensors shouldn't be displaying these errors for optional fans
> and pwms. Can you please provide a patch fixing this? It should be
> pretty easy.
>=20
> Thanks,
> --=20
> Jean Delvare
>=20


__________________________________________________________________________
Erweitern Sie FreeMail zu einem noch leistungsst=E4rkeren E-Mail-Postfach!	=
=09
Mehr Infos unter http://produkte.web.de/club/?mc=021131


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
