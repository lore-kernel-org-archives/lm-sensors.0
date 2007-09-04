From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 04 Sep 2007 19:07:57 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0709041207x1056e29kcbc5890f7e8efc6a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juergen,


> > -----Urspr=FCngliche Nachricht-----
> > Von: "Juerg Haefliger" <juergh@gmail.com>
> > Gesendet: 28.08.07 17:07:38
> > An: "Juergen Bausa" <Juergen.Bausa@web.de>
> > CC: "Kushal Koolwal" <kushalkoolwal@hotmail.com>, lm-sensors@lm-sensors=
.org
> > Betreff: Re: [lm-sensors] dme1737 module
>
>
> >
> >
> > > So, which version is needed to run the dme1737 on the asus board (Whi=
ch I think doesnt have the
> > > SCH3114 Super I/O chip)?
> > >
> > > debian testing and unstable both have 2.10.4 at the moment, which is =
the same version as
> > > http://www.lm-sensors.org/wiki/Download. Will it be enough to install=
 this version?
> >
> > 2.10.4 and kernel 2.6.23 is sufficient if you don't have the sch311x.
> >
>
> Now it works with lm-sensors 2.10.4 which can easily backported drom debi=
an testing.
>
> However, I get strange temperatures for the cpu. With the fan at 3000 rpm=
 and idle cpu I get a temperature
> of 17 =B0C, while room temperature is 20=B0C. I think this is not possibl=
e.

That is strange indeed. Can you reproduce this and then unload the
dme1737 module and run 'i2cdump 0 0x2e' and post the output?


> I now use fancontrol which turns fan speed to 0 rpm. Here is the output o=
f sensors:
>
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 4c00
> V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
> Vccp:      +1.10 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:      +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> V5:        +4.94 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:      +11.80 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:  +3.29 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Int Temp:    +34=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> CPU Temp:    +29=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> CPU_Fan:     0 RPM  (min =3D    0 RPM)
> ERROR: Can't get fan3 data!
> ERROR: Can't get fan5 data!
> ERROR: Can't get fan6 data!
> CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
> ERROR: Can't get pwm5 data!
> ERROR: Can't get pwm6 data!
> cpu0_vid: +1.550 V  (VRM Version 2.4)
>
> I think 29 =B0C is also very low for idle and no fan, even for my AMD BE-=
2350
> (45 w maximum power consumption). Also, Int-Temperature (is this board te=
mperature?)
> is higher than cpu- temperature. This changes only for high load, where
> cpu-temperature increases more than int-temperature.

That's possible. The Int-temp is the dme1737 internal temperature, not
the 'board' temperature. Depending on how hot the chip itself is this
temperature can be rather high.


> At first I thought that temperature calculation is wrong in lm-sensors. H=
owever,
> BIOS shows nearly the same temperatures.

There's not much that can be done wrong here. All the driver does is
convert from unsigned to signed. Sensors itself doesn't do any
conversion.

...juerg


> So, is there anything wrong here?
>
> Juergen
> _________________________________________________________________________
> In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten!
> Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
