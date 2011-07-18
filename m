From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jul 2011 11:02:35 +0000
Subject: Re: [lm-sensors] add ASRock motherboard to sensors3.conf
Message-Id: <20110718130235.12e91466@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACfFi_TLviaXNuFqHLD3E9bJKux+OaHJMM6Prx80fcaPd-FWJg@mail.gmail.com>
In-Reply-To: <CACfFi_TLviaXNuFqHLD3E9bJKux+OaHJMM6Prx80fcaPd-FWJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Please keep the list in Cc.

On Sun, 17 Jul 2011 15:45:15 +0300, vagelis xxx wrote:
> 2011/7/16 Jean Delvare <khali@linux-fr.org>
>=20
> > On Wed, 13 Jul 2011 00:42:06 +0300, vagelis xxx wrote:> *:~$ sensors*
> > > w83627ehf-isa-0290
> > > Adapter: ISA adapter
> > > VCore:                     +1.13 V  (min =3D  +0.00 V, max =3D  +1.74=
 V)
> > > VCore2:                    +1.14 V  (min =3D  +0.56 V, max =3D  +0.19=
 V)  ALARM
> >
> > You failed to set the limits, hence the ALARM. Recent CPUs tend to have
> > a single Vcore, BTW, So I doubt this is actually Vcore2.
>=20
> For this maybe you have right! Just i add to the results VCore2, to see i=
t.
> Maybe is good to ignore VCore2.

Maybe not ignoring. It might actually be monitoring something, just not
the CPU Vcore.

> > > AVCC:                      +3.36 V  (min =3D  +3.14 V, max =3D  +3.47=
 V)
> > > 3VCC:                      +3.38 V  (min =3D  +3.14 V, max =3D  +3.47=
 V)
> > > Vram:                      +1.71 V  (min =3D  +1.89 V, max =3D  +1.71=
 V)  ALARM
> >
> > This is pretty low for DDR2 memory.
>=20
> +1.71V is the only hardware where maybe have this value.
> I have 2 Kingston KVR800D2N5 and from Kingston say must have +1.8V (+/-
> .1V) see more info from *pdf*
> http://www.valueram.com/datasheets/KVR800D2N5_1G.pdf
> Maybe i should change the "compute Vram" but I do not know the exact resu=
lt
> if this is wrong.

No, compute statements shouldn't be needed for Vram, as it is below the
ADC limit (2.04 V.) My point was that maybe Vram isn't in4 but another
input. For example, the unscaled values of in5 and in6 are closer to
the nominal +1.8V than in4. in6 (+1.87) in particular would be a good
bet, as overvolting is a more frequent operation than undervolting, and
one would normally not scale +5V or +12V to a value so close to the ADC
max.

> > > +12V:                     +12.33 V  (min =3D +10.79 V, max =3D +13.18=
 V)
> > > +5V:                       +4.99 V  (min =3D  +4.76 V, max =3D  +5.25=
 V)
> > > VSB3V:                     +3.36 V  (min =3D  +3.14 V, max =3D  +3.47=
 V)
> > > VBAT:                      +3.31 V  (min =3D  +3.14 V, max =3D  +3.47=
 V)
> > > +3.3V:                     +3.34 V  (min =3D  +3.14 V, max =3D  +3.47=
 V)
> >
> > This would be surprising. +3.3V is already monitored twice internally
> > (see AVCC and 3VCC above). It would make very little sense to monitor
> > it again externally.
>=20
> Yes,  you have right. Just i add to the results, to see it. Maybe is good=
 to
> ignore it.

Again maybe you don't have to ignore it. It may be monitoring something
else. And if you don't know what it is, it is fine to leave it enabled
without labels. One of the purposes of monitoring is to detect unusual
conditions, and that can be achieved even if you don't know which input
corresponds to what voltage.

> > More generally, how did you figure out the mappings and scaling factors?
>=20
> I found the exact parameters, measuring the computer time operating with a
> voltmeter
>=20
> This about +12V /  +5V / AVCC

The voltmeter won't tell you the mappings, only the scaling factors.
But you have to find out the mappings first. Secondly, what is the
accuracy of your voltmeter? Low-end models do often no better than 5%,
which makes them useless for this kind of exercise.

I am curious how you measured +3.3V, BTW. While +12V and +5V are easy
to measure on a molex connector, I wouldn't know where to measure +3.3V.

The usual way is to start from what the BIOS is displaying. Did you
check that? Without that, or detailed documentation from the vendor, it
is pretty hard to come up with a correct voltage sensor configuration.

> > > Case Fan:                 1339 RPM  (min =3D 5273 RPM, div =3D 8)  AL=
ARM
> > > CPU Fan:                  2410 RPM  (min =3D 1288 RPM, div =3D 8)
> >
> > You should set proper fan min values.
>=20
> This would be somewhat difficult, because the case fan and cpu fan is not
> all the same.

I don't quite get you here. Sure, other users may use other fans, but
you should at least set proper limits for your personal case: this
can't be worse than the broken default values.

> > > Chipset ATI=99 SB600 Temp: +37.0=B0C  (high =3D +50.0=B0C, hyst =3D +=
45.0=B0C)
> >
> > I would avoid non-ASCII characters in labels.
>=20
> Ok, this in not problem.Maybe is good these names
>=20
> Chipset ATI=99 SB600 Temp =3D> Southbridge Chipset Temp
> Chipset AMD 480X Temp =3D> Northbridge Chipset Temp

I like short labels and would go for "SBr Temp" and "NBr Temp", but up
to you.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
