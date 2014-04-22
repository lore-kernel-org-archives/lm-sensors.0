From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 22 Apr 2014 08:01:28 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/3] hwmon: (lm77) Drop function macros
Message-Id: <20140422100128.32778da6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 20 Apr 2014 18:28:11 -0700, Guenter Roeck wrote:
> Function macros make the code harder to read and increase code size,
> so drop them.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4: Really provide temp_regs array size this time
>     Add space before temp_index comment
>     Rebase to patch 1/3 (fixes regression introduced in v3)
>=20
> v3: No comma after t_num_entries.
>     Make temp_regs const and provide array size.
>     Fix show_temp_hyst, specifically display of low limit hysteresis.
>     Simplify set_temp and handling of hysteresis.
>=20
>     Output with new libsensors:
>=20
>     lm77-i2c-9-49
>     Adapter: i2c-diolan-u2c at bus 003 device 013
>     temp1:        +22.5=B0C  (low  =3D +10.0=B0C, hyst =3D +12.0=B0C)
>                            (high =3D +64.0=B0C, hyst =3D +62.0=B0C)
> 			   (crit =3D +80.0=B0C, hyst =3D +78.0=B0C)
>=20
>  drivers/hwmon/lm77.c |  183 +++++++++++++++++++++-----------------------=
------
>  1 file changed, 75 insertions(+), 108 deletions(-)
> (...)

Looks good to me, except for the "preserve hysteresis when setting
T_crit" comment which you removed here while it should be removed by
the previous patch. But it's only a detail.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
