From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 13:47:58 +0000
Subject: Re: [lm-sensors] ASUS M2N-LR sensors reports incorrect values
Message-Id: <20070812154758.2354a8e0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 28 Jul 2007 16:59:53 -0700, James Satterfield wrote:
> Motherboard: ASUS M2N-LR
> Chip:  W83627THG-A
> Sensors Version: 2.10.1
> Kernel: 2.6.20
>=20
> sensors output:
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>               +38=B0C
> Core1 Temp:
>               +43=B0C
>=20
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.94 V  (min =3D  +0.70 V, max =3D  +1.87 V)       ALARM
> +12V:      +6.51 V  (min =3D  +9.67 V, max =3D  +1.52 V)       ALARM
> +3.3V:     +1.44 V  (min =3D  +1.17 V, max =3D  +1.31 V)       ALARM
> +5V:       +4.85 V  (min =3D  +2.51 V, max =3D  +0.45 V)       ALARM
> -12V:      +0.22 V  (min =3D  -4.47 V, max =3D  +4.25 V)
> V5SB:      +5.00 V  (min =3D  +2.53 V, max =3D  +3.14 V)       ALARM
> VBat:      +0.82 V  (min =3D  +1.52 V, max =3D  +1.26 V)       ALARM
> fan1:        0 RPM  (min =3D 3552 RPM, div =3D 2)              ALARM
> CPU Fan:     0 RPM  (min =3D 337500 RPM, div =3D 2)              ALARM
> fan3:        0 RPM  (min =3D 3590 RPM, div =3D 2)              ALARM
> M/B Temp:    -48=B0C  (high =3D  +125=B0C, hyst =3D  -128=B0C)   sensor =
=3D =20
> thermistor
> CPU Temp:  -48.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D =20
> thermistor
> temp3:     -48.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D =20
> thermistor
> alarms:
> beep_enable:
>            Sound alarm enabled

I guess that the W83627THG is not used for monitoring and you have
another dedicated hardware monitoring chip one the SMBus. A more recent
version of sensors-detect should find it.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
