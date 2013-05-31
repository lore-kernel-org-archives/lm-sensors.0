From: Simon Guinot <simon.guinot@sequanux.org>
Date: Fri, 31 May 2013 22:16:16 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130531221616.GG7626@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3394511119470145730=="
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
 <b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
In-Reply-To: <b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>


--===============3394511119470145730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 12:03:14AM +0200, Arnaud Ebalard wrote:
>=20
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  drivers/hwmon/Kconfig              |   10 +
>  drivers/hwmon/Makefile             |    1 +
>  drivers/hwmon/g762.c               | 1012 ++++++++++++++++++++++++++++++=
++++++
>  include/linux/platform_data/g762.h |   54 ++
>  4 files changed, 1077 insertions(+)
>  create mode 100644 drivers/hwmon/g762.c
>  create mode 100644 include/linux/platform_data/g762.h

Hi Arnaud,

After more tests on my 2Big Network v2 board, it appears that the fan
doesn't rotate when PWM mode (the preferred operating mode for this
board) is selected. Nevertheless, DC mode is usable (even if not ideal
given the hardware). After some investigations I noticed that an extra
initialization is needed to enable PWM mode on my board: the set_cnt
register must be set to 0 while the default value is 0xff. Is that
specific to my hardware ? Is PWM mode working on your ReadyNAS with
the default set_cnt value ?

I haven't noticed this issue while testing your v1 patch series because
at the time I was using a board with an U-Boot modified by LaCie. This
last sets the set_cnt register to 0 while U-Boot mainline don't.
Actually, the 2Big fan is not configured nor even started by U-Boot
mainline. I have to fix this but maybe that something can be done in
the g762 Linux driver too ?

>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 0428e8a..142bdf8 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig

Snip

> diff --git a/include/linux/platform_data/g762.h b/include/linux/platform_=
data/g762.h
> new file mode 100644
> index 0000000..29e3934
> --- /dev/null
> +++ b/include/linux/platform_data/g762.h
> @@ -0,0 +1,54 @@
> +/*
> + * Platform data structure for g762 fan controller driver
> + *
> + * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
> + */
> +#ifndef __LINUX_PLATFORM_DATA_G762_H__
> +#define __LINUX_PLATFORM_DATA_G762_H__
> +
> +#define G762_DEFAULT_NO_OVERLOAD 0xffffffff
> +
> +struct g762_platform_data {
> +	u32 fan_startv;
> +	u32 fan_gear_mode;
> +	u32 fan_div;
> +	u32 fan_pulses;
> +	u32 fan_target;
> +	u32 pwm_polarity;
> +	u32 pwm_enable;
> +	u32 pwm_freq;
> +	u32 pwm_mode;
> +};
> +
> +/* When filling a g762_platform_data structure to be passed during platf=
orm
> + * init to the driver, it needs to be initialized to the following defau=
lt
> + * value before changing specific fields. This is needed to avoid a spar=
se
> + * initialization to have current values replaced by 0 */

In other places, you use this multi-line comment format:

/*
 * ...
 * ...
 */

> +
> +static const struct g762_platform_data G762_DEFAULT_PDATA =3D {
> +	.fan_startv =3D G762_DEFAULT_NO_OVERLOAD,
> +	.fan_gear_mode =3D G762_DEFAULT_NO_OVERLOAD,
> +	.fan_div =3D G762_DEFAULT_NO_OVERLOAD,
> +	.fan_pulses =3D G762_DEFAULT_NO_OVERLOAD,
> +	.fan_target =3D G762_DEFAULT_NO_OVERLOAD,
> +	.pwm_polarity =3D G762_DEFAULT_NO_OVERLOAD,
> +	.pwm_enable =3D G762_DEFAULT_NO_OVERLOAD,
> +	.pwm_freq =3D G762_DEFAULT_NO_OVERLOAD,
> +	.pwm_mode =3D G762_DEFAULT_NO_OVERLOAD,
> +};

Are you sure that all this settings are needed ? IMHO the g762 platform
data should only holds the platform specific configuration: fan_startv,
fan_gear_mode, fan_div and fan_pulses. The other settings are not really
related with the platform but more with the operating fan configuration.
For my part, I am happy enough with the sysfs hwmon interface.

The same comment applies to the g762 DT binding properties.

Regards,

Simon

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGpITAACgkQgtp0PDeOcDp53wCfa1quBnLps+Vc5RF0cIdR8bQj
SJ0An1IU/RmEIGWDkAaGj+0Xs5CrcXdN
=ABZ1
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--


--===============3394511119470145730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3394511119470145730==--
