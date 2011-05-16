From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Mon, 16 May 2011 15:01:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for as1531,
Message-Id: <20110516080119.e13284b6.randy.dunlap@oracle.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <fabien.marteau@armadeus.com>
	<1305553154-18195-2-git-send-email-fabien.marteau@armadeus.com>
In-Reply-To: <1305553154-18195-2-git-send-email-fabien.marteau@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: fabien.marteau@armadeus.com
Cc: khali@linux-fr.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 16 May 2011 15:39:14 +0200 fabien.marteau@armadeus.com wrote:

> From: Fabien Marteau <fabien.marteau@armadeus.com>
>=20
>=20
> Signed-off-by: Fabien Marteau <fabien.marteau@armadeus.com>
> ---
>  drivers/hwmon/Kconfig  |   10 ++
>  drivers/hwmon/Makefile |    1 +
>  drivers/hwmon/as1531.c |  297 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 308 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/as1531.c
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 50e40db..d2ba655 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -104,6 +104,16 @@ config SENSORS_ADCXX
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adcxx.
> =20
> +config SENSORS_AS1531
> +	tristate "Austria Microsystems AS1531 Analog to Digital Converter"
> +	depends on SPI_MASTER
> +	help
> +	  If you say yes here you get support for Austria Microsystems AS1531.
> +		AS1531 is a 12=C2=A0bits Analog to digitals converter with 8 channels

is a 12? bits

what is the character after the "12", please?

Analog to digital converter

> +		provided by Austria-Microsystems company.
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called as1531.
> +
>  config SENSORS_ADM1021
>  	tristate "Analog Devices ADM1021 and compatibles"
>  	depends on I2C


> +/*----------------------------------------------------------------------=
*/
> +
> +static int __devinit as1531_probe(struct spi_device *spi)
> +{
> +	struct as1531 *adc;
> +	int status;
> +	int i;
> +
> +	adc =3D kzalloc(sizeof(struct as1531), GFP_KERNEL);
> +	if (adc =3D NULL)
> +		return -ENOMEM;
> +
> +	mutex_init(&adc->lock);
> +	mutex_lock(&adc->lock);
> +
> +	dev_set_drvdata(&spi->dev, adc);
> +
> +	for (i =3D 0; i < 11; i++) {

s/11/ARRAY_SIZE(as1531_input)/

> +		status =3D device_create_file(&spi->dev,
> +						&as1531_input[i].dev_attr);
> +		if (status < 0) {
> +			dev_err(&spi->dev, "device_create_file failed.\n");
> +			goto out_err;
> +		}
> +	}



---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
