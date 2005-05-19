From: robs@multiplayer.it (Roberto Sebastiano)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: as99127f bug?
Message-Id: <1070199878.28235.2.camel@newdeal>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130134504.142f7cde.khali@linux-fr.org>
In-Reply-To: <20031130134504.142f7cde.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Il dom, 2003-11-30 alle 13:45, Jean Delvare ha scritto:
> > as99127f-i2c-1-2d
> > Adapter: SMBus nForce2 adapter at 5500
> > Algorithm: Unavailable from sysfs
> > VCore 1:   +1.70 V  (min =3D  +1.49 V, max =3D  +1.81 V)             =20
> > VCore 2:   +1.70 V  (min =3D  +1.49 V, max =3D  +1.81 V)             =20
> > +3.3V:     +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)             =20
> > +5V:       +4.95 V  (min =3D  +4.52 V, max =3D  +5.48 V)             =20
> > +12V:     +11.55 V  (min =3D +10.82 V, max =3D +13.13 V)             =20
> > -12V:     -12.14 V  (min =3D  -0.00 V, max =3D  -0.00 V)             =20
> > -5V:       -4.60 V  (min =3D  -0.00 V, max =3D  -0.00 V)             =20
> > fan1:     4927 RPM  (min =3D 3000 RPM, div =3D 2)              ALARM =20
> > fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)              ALARM =20
> > fan3:        0 RPM  (min =3D 3000 RPM, div =3D 2)              ALARM =20
> > M/B Temp:    +39?C  (high =3D  +127?C, hyst =3D   +60?C)         =20
> > CPU Temp:  +28.0?C  (high =3D  +120?C, hyst =3D  +100?C)         =20
> > temp3:    +255.4?C  (high =3D  +100?C, hyst =3D  +100?C)         =20
> > vid:      +1.650 V
> > alarms:  =20
> > beep_enable:
> >           Sound alarm enabled
> >=20
> > M/B and CPU temp are swapped. CPU is 39 and MB 28
>=20
> I doubt it. It would be physically difficult to do this, unless the
> monitoring chip is hardly tied to the CPU. This was never seen. temp1
> (here displayed as "M/B Temp") is the monitoring chipset internal
> temperature. 39 degrees is exactly what I have for a similar chip here.
>=20
No, the BIOS shows the temperatures *exactly* swapped
Also, fan1 is wrong. I use a thermaltake silent boost, it never reaches
3000 RPM


> CPU Temp (temp2) is probably wrong. Take a look at the configuration
> file, there are three different formulae for temp2. Maybe you're using
> one that doesn't work for your motherboard. Try the other two.

I'm not using a configuration file (2.6 kernel if that matters)



--=20
Roberto Sebastiano <robs@multiplayer.it>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Questa parte del messaggio =3D?ISO-8859-1?Q?=E8?=3D firmata
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031130=
/37230c9b/attachment.bin
