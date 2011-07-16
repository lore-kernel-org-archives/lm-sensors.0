From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jul 2011 19:51:41 +0000
Subject: Re: [lm-sensors] add ASRock motherboard to sensors3.conf
Message-Id: <20110716215141.4b18047f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACfFi_TLviaXNuFqHLD3E9bJKux+OaHJMM6Prx80fcaPd-FWJg@mail.gmail.com>
In-Reply-To: <CACfFi_TLviaXNuFqHLD3E9bJKux+OaHJMM6Prx80fcaPd-FWJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 13 Jul 2011 00:42:06 +0300, vagelis xxx wrote:
> Hi!
> I add to *sensors3.conf* file info about motherboard ASRock -
> ALiveXFire-eSATA2
> R3.0<http://www.asrock.com/MB/overview.asp?Model=3DALiveXFire-eSATA2%20R3=
.0>
>=20
> Here is the result of sensors command:
>=20
> *:~$ sensors*
> w83627ehf-isa-0290
> Adapter: ISA adapter
> VCore:                     +1.13 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> VCore2:                    +1.14 V  (min =3D  +0.56 V, max =3D  +0.19 V) =
  ALARM

You failed to set the limits, hence the ALARM. Recent CPUs tend to have
a single Vcore, BTW, So I doubt this is actually Vcore2.

> AVCC:                      +3.36 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> 3VCC:                      +3.38 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> Vram:                      +1.71 V  (min =3D  +1.89 V, max =3D  +1.71 V) =
  ALARM

This is pretty low for DDR2 memory.

> +12V:                     +12.33 V  (min =3D +10.79 V, max =3D +13.18 V)
> +5V:                       +4.99 V  (min =3D  +4.76 V, max =3D  +5.25 V)
> VSB3V:                     +3.36 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> VBAT:                      +3.31 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +3.3V:                     +3.34 V  (min =3D  +3.14 V, max =3D  +3.47 V)

This would be surprising. +3.3V is already monitored twice internally
(see AVCC and 3VCC above). It would make very little sense to monitor
it again externally.

More generally, how did you figure out the mappings and scaling factors?

> Case Fan:                 1339 RPM  (min =3D 5273 RPM, div =3D 8)  ALARM
> CPU Fan:                  2410 RPM  (min =3D 1288 RPM, div =3D 8)

You should set proper fan min values.

> Chipset ATI=99 SB600 Temp: +37.0=B0C  (high =3D +50.0=B0C, hyst =3D +45.0=
=B0C)  sensor =3D thermistor

I would avoid non-ASCII characters in labels.

> CPU Temp:                  +34.0=B0C  (high =3D +50.0=B0C, hyst =3D +45.0=
=B0C)  sensor =3D thermistor
> Chipset AMD 480X Temp:     +34.0=B0C  (high =3D +50.0=B0C, hyst =3D +45.0=
=B0C)  sensor =3D thermistor

How did you find out where each sensor is located?

> cpu0_vid:

You stripped the end of this last line.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
