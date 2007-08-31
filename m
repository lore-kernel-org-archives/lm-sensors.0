From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 31 Aug 2007 15:16:37 +0000
Subject: Re: [lm-sensors] [PATCH lm_sensors-2.10.4][RESEND] sensors-detect:
Message-Id: <20070831171637.2c343762@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jason,

For next time: patches to lm-sensors should be sent to the lm-sensors
list, not the i2c list.

On Thu, 30 Aug 2007 17:47:51 -0700, Jason Gaston wrote:
> Resend without wordwrap.
>=20
> This patch adds the Intel Tolapai SMBus Controller DID to the sensors-det=
ect=20
> script.
>=20
> Signed-off-by: =A0Jason Gaston <jason.d.gaston@intel.com>
>=20
> --- lm_sensors-2.10.4/prog/detect/sensors-detect.orig	2007-08-30 15:51:39=
.000000000 -0700
> +++ lm_sensors-2.10.4/prog/detect/sensors-detect	2007-08-30 15:53:06.0000=
00000 -0700
> @@ -166,7 +166,14 @@
>         procid =3D> "Intel ICH9",
>         driver =3D> "i2c-i801",
>         match =3D> qr/^SMBus I801 adapter at [0-9a-f]{4}/,
> -     },=20
> +     },
> +     {=20
> +       vendid =3D> 0x8086,
> +       devid  =3D> 0x5032,
> +       procid =3D> "Intel Tolapai",
> +       driver =3D> "i2c-i801",
> +       match =3D> qr/^SMBus I801 adapter at [0-9a-f]{4}/,
> +     }, =20
>       {=20
>         vendid =3D> 0x1106,
>         devid  =3D> 0x3040,

Applied, thanks.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
