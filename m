From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Sep 2008 21:50:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: TI TMP121 SPI temperature sensor
Message-Id: <200809152350.51919.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080915200636.GA11608@roarinelk.homelinux.net>
In-Reply-To: <20080915200636.GA11608@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Manuel,

Le lundi 15 septembre 2008, Manuel Lauss a =E9crit=A0:
> Driver for the Texas Instruments TMP121/TMP123 SPI temperature sensors.
> The code is 99% identical to the LM70 driver;  only the formula to
> calculate the temperature (in 1/1000 deg celsius) has been adjusted.
>=20
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/hwmon/Kconfig  |   10 +++
>  drivers/hwmon/Makefile |    1 +
>  drivers/hwmon/tmp121.c |  168 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 179 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/tmp121.c

Wouldn't it make more sense to just add support for the TMP121/TMP123
chips to the lm70 driver? Duplicating code is better avoided when
possible. Thankfully these drivers are relatively small, but still...

> --- /dev/null
> +++ b/drivers/hwmon/tmp121.c
> (...)
> +	/*
> +	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
> +	 * complement value. Only the MSB 13 bits (1 sign + 12 temperature
> +	 * bits) are meaningful; the LSB 3 bits are to be discarded.
> +	 * Each bit represents 0.0625 degrees Celsius.
> +	 */
> +	val =3D (raw * 625) / 80;

This does not actually discard the 3 LSB. In order to do that, you
would need to write the following:

	val =3D (raw / 8) * 625 / 10;

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
