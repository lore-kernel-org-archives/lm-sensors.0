From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2007 09:30:06 +0000
Subject: Re: [lm-sensors] lm_sensors -->Temp too high
Message-Id: <20070616113006.5d6a3e9d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Shawn,

On Wed, 30 May 2007 14:19:21 -0400, Shawn Casler wrote:
> I'm having a problem fixing all of these elements. Mostly, I need the
> temperature to work correctly. Not to mention, the alarms aren't
> necessarily going off when they should be, only one of the fans is
> working and the BIOS has all 4 fans working, and a few other minor
> things..
>=20
> kernel - 2.6.9-55
>=20
> w83627hf-isa-0c00
> Adapter: ISA adapter
> VCore 1:   +1.55 V  (min =3D  +1.26 V, max =3D  +1.39 V)
> VCore 2:   +1.31 V  (min =3D  +1.26 V, max =3D  +1.39 V)
> +3.3V:     +3.33 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +5V:       +4.97 V  (min =3D  +4.76 V, max =3D  +5.24 V)
> +12V:      +4.99 V  (min =3D +10.82 V, max =3D +13.19 V)
> -12V:      -1.42 V  (min =3D -13.18 V, max =3D -10.80 V)
> -5V:       -3.94 V  (min =3D  -5.25 V, max =3D  -4.75 V)
> V5SB:      +5.54 V  (min =3D  +4.76 V, max =3D  +5.24 V)
> VBat:      +3.28 V  (min =3D  +2.40 V, max =3D  +3.60 V)
> fan1:        0 RPM  (min =3D 21093 RPM, div =3D 4)
> fan2:     2576 RPM  (min =3D 2986 RPM, div =3D 4)
> fan3:        0 RPM  (min =3D 21093 RPM, div =3D 4)
> temp1:      +127=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D diode
> temp2:    +127.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D diode
> ALARM
> temp3:    +127.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D diode
> ALARM
> vid:      +1.325 V  (VRM Version 8.5)
> alarms:
> beep_enable:
>           Sound alarm enabled

The W83627HF only had 3 fan inputs, so if you see 4 fan speed values in
your BIOS, this suggests that there's another hardware monitoring chip
on the board. This would also explain why the temperatures reported by
the W83627HF aren't valid, if temperatures are monitored by this second
chip. The second chip is likely to be connected to the SMBus.

It seems that you are running a relatively old system. You should give
a try to a more recent version of sensors-detect, it may be able to
find out the second chip. Try either the version from lm-sensors 2.10.3
or even from lm-sensors SVN. You can run the script in place, no need
to install it.

Keep in mind that the driver for this chip, if it exists, is however
unlikely to be included in your 2.6.9 kernel.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
