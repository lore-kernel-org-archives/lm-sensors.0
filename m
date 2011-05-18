From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 18 May 2011 16:37:07 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] staging:iio:adc: as1531 driver initial
Message-Id: <20110518163707.GB11675@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305733172-18519-1-git-send-email-jic23@cam.ac.uk>
 <1305735420-23293-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305735420-23293-2-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "fabien.marteau@armadeus.com" <fabien.marteau@armadeus.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, May 18, 2011 at 12:16:59PM -0400, Jonathan Cameron wrote:
> From: Fabien Marteau <fabien.marteau@armadeus.com>
>=20
> V2: Fix double mutex unlock and whitespace (Guenter Roeck).

Should be below ---

> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

and nitpick below, otherwise=20

Revewed-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  drivers/staging/iio/adc/Kconfig  |   10 ++
>  drivers/staging/iio/adc/Makefile |    2 +
>  drivers/staging/iio/adc/as1531.c |  209 ++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 221 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kc=
onfig
> index 8c751c4..4af730a 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -168,6 +168,16 @@ config ADT7410
>  	  Say yes here to build support for Analog Devices ADT7410
>  	  temperature sensors.
> =20
> +config AS1531
> +tristate "Austria Microsystems AS1531 Analog to Digital Converter"
> +	depends on SPI_MASTER
> +	help
> +	  If you say yes here you get support for Austria Microsystems AS1531.
> +		AS1531 is a 12=A0bits Analog to digitals converter with 8 channels
> +		provided by Austria-Microsystems company.
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called as1531.
> +
>  config MAX1363
>  	tristate "Maxim max1363 ADC driver"
>  	depends on I2C
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/M=
akefile
> index 1d9b3f5..027b94e2 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -39,3 +39,5 @@ obj-$(CONFIG_AD7816) +=3D ad7816.o
>  obj-$(CONFIG_ADT75) +=3D adt75.o
>  obj-$(CONFIG_ADT7310) +=3D adt7310.o
>  obj-$(CONFIG_ADT7410) +=3D adt7410.o
> +
> +obj-$(CONFIG_AS1531) +=3D as1531.o
> \ No newline at end of file

What does this mean ? Is there a missing newline ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
