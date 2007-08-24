From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 Aug 2007 09:21:17 +0000
Subject: Re: [lm-sensors] coretemp and sensors.conf
Message-Id: <20070824112117.21e0edbc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C81AB3.90306@wanadoo.fr>
In-Reply-To: <46C81AB3.90306@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 19 Aug 2007 12:25:55 +0200, S=E9bastien CRAMATTE wrote:
> I've just build a 2.6.22.1 kernel and latest lm-sensors with coretemp
> driver
> coretemp.ko is driver loaded properly ....
> (...)
> Unfortunately when I exectute
> #/usr/local/bin/sensors
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> ERROR: Can't get temperature data!
>=20
> w83793-i2c-0-2f
> Can't get adapter name for bus 0
> VCoreA:    +1.32 V  (min =3D  +0.92 V, max =3D  +1.49 V) =20
> VCoreB:    +1.53 V  (min =3D  +0.92 V, max =3D  +1.49 V)   ALARM
> Vtt:       +1.21 V  (min =3D  +1.08 V, max =3D  +1.33 V) =20
> in3:       +0.51 V  (min =3D  +0.38 V, max =3D  +0.69 V) =20
> in4:       +1.82 V  (min =3D  +1.62 V, max =3D  +1.98 V) =20
> +3.3V:     +3.38 V  (min =3D  +2.96 V, max =3D  +3.63 V) =20
> +12V:     +11.81 V  (min =3D +10.75 V, max =3D +13.25 V) =20
> +5V:       +5.00 V  (min =3D  +4.64 V, max =3D  +5.65 V) =20
> 5VSB:      +5.07 V  (min =3D  +4.64 V, max =3D  +5.65 V) =20
> VBAT:      +3.23 V  (min =3D  +2.99 V, max =3D  +3.66 V) =20
> fan1:     11637 RPM  (min =3D  712 RPM)                 =20
> fan2:     11440 RPM  (min =3D  712 RPM)                 =20
> CPU1 Temp: +37.2 C  (high =3D +60.0 C, hyst =3D +55.0 C) =20
> CPU2 Temp:-110.5 C  (high =3D +60.0 C, hyst =3D +55.0 C) =20
> temp3:    -128.0 C  (high =3D +60.0 C, hyst =3D +55.0 C) =20
> temp4:    -128.0 C  (high =3D +60.0 C, hyst =3D +55.0 C) =20
> temp5:       +39 C  (high =3D   +80 C, hyst =3D   +75 C) =20
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> ERROR: Can't get temperature data!

Odd. What does "/usr/local/bin/sensors -v" return? Please unload the
w83793 driver and provide the output of "strace /usr/local/bin/sensors".

Please also look in /sys/bus/platform/devices, you should find two
entries for the coretemp driver, please list the files (ls -l) in these
directories.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
