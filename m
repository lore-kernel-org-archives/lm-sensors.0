From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Oct 2008 12:57:10 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <20081023145710.72c3f9a1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Manuel,

On Wed, 22 Oct 2008 10:04:23 +0200, Manuel Lauss wrote:
> The Texas Instruments TMP121 is a SPI temperature sensor very similar
> to the LM70, with slightly higher resolution.  This patch extends the
> LM70 driver to support the TMP121.  Chip type is determined through
> SPI platform data.

Review:

> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  Documentation/hwmon/lm70 |    7 +++++-
>  drivers/hwmon/Kconfig    |    5 ++-
>  drivers/hwmon/lm70.c     |   56 ++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/spi/lm70.h |   15 ++++++++++++
>  4 files changed, 73 insertions(+), 10 deletions(-)
>  create mode 100644 include/linux/spi/lm70.h
> 
> diff --git a/Documentation/hwmon/lm70 b/Documentation/hwmon/lm70
> index 2bdd3fe..88f4322 100644
> --- a/Documentation/hwmon/lm70
> +++ b/Documentation/hwmon/lm70
> @@ -1,9 +1,11 @@
>  Kernel driver lm70
>  =========
>  
> -Supported chip:
> +Supported chips:
>    * National Semiconductor LM70
>      Datasheet: http://www.national.com/pf/LM/LM70.html
> +  * Texas Instruments TMP121/TMP123
> +    Datasheet: http://www.ti.com/lit/gpn/tmp121

I'd rather link to:
http://focus.ti.com/docs/prod/folders/print/tmp121.html
Where people can see a lot of useful information about the chip, and
then download the datasheet.

>  
>  Author:
>          Kaiwan N Billimoria <kaiwan@designergraphix.com>
> @@ -25,6 +27,9 @@ complement digital temperature (sent via the SIO line), is available in the
>  driver for interpretation. This driver makes use of the kernel's in-core
>  SPI support.
>  
> +The TMP121 is very similar; main differences are 4 wire SPI interface,
> +and 13bit temperature data (0.0625 celsius resolution).

13-bit, degree Celsius

> +
>  Thanks to
>  ---------
>  Jean Delvare <khali@linux-fr.org> for mentoring the hwmon-side driver
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 6de1e0f..f86923d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -407,11 +407,12 @@ config SENSORS_LM63
>  	  will be called lm63.
>  
>  config SENSORS_LM70
> -	tristate "National Semiconductor LM70"
> +	tristate "National Semiconductor LM70 / Texas Instruments TMP121"
>  	depends on SPI_MASTER && EXPERIMENTAL
>  	help
>  	  If you say yes here you get support for the National Semiconductor
> -	  LM70 digital temperature sensor chip.
> +	  LM70 and Texas Instruments TMP121/TMP123 digital temperature
> +	  sensor chips.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm70.
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index d435f00..9ab0479 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -33,13 +33,14 @@
>  #include <linux/hwmon.h>
>  #include <linux/mutex.h>
>  #include <linux/spi/spi.h>
> -
> +#include <linux/spi/lm70.h>
>  
>  #define DRVNAME		"lm70"
>  
>  struct lm70 {
>  	struct device *hwmon_dev;
>  	struct mutex lock;
> +	unsigned int chip;
>  };
>  
>  /* sysfs hook function */
> @@ -67,10 +68,8 @@ static ssize_t lm70_sense_temp(struct device *dev,
>  	}
>  	dev_dbg(dev, "rxbuf[1] : 0x%x rxbuf[0] : 0x%x\n", rxbuf[1], rxbuf[0]);
>  
> -	raw = (rxbuf[1] << 8) + rxbuf[0];
> -	dev_dbg(dev, "raw=0x%x\n", raw);
> -
>  	/*
> +	 * LM70:
>  	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
>  	 * complement value. Only the MSB 11 bits (1 sign + 10 temperature
>  	 * bits) are meaningful; the LSB 5 bits are to be discarded.
> @@ -80,8 +79,27 @@ static ssize_t lm70_sense_temp(struct device *dev,
>  	 * by 0.25. Also multiply by 1000 to represent in millidegrees
>  	 * Celsius.
>  	 * So it's equivalent to multiplying by 0.25 * 1000 = 250.
> +	 *
> +	 * TMP121:
> +	 * 13bits of 2's complement data, discard lower 3 bits.  Chip
> +	 * transmits high byte first.  Resolution 0.0625 celsius.
>  	 */
> -	val = ((int)raw/32) * 250;
> +	switch (p_lm70->chip) {
> +	case LM70_CHIP_LM70:
> +		raw = (rxbuf[1] << 8) + rxbuf[0];
> +		dev_dbg(dev, "raw=0x%x\n", raw);

This debug statement is common to all cases so it could be moved
outside of the switch block.

> +		val = ((int)raw/32) * 250;
> +		break;
> +
> +	case LM70_CHIP_TMP121:
> +		raw = (rxbuf[0] << 8) + rxbuf[1];
> +		dev_dbg(dev, "raw=0x%x\n", raw);
> +		val = (raw / 8) * 625 / 10;
> +		break;
> +
> +	default:
> +		raw = 0;

This default case is broken, it sets raw but not val, while what the
following code uses is val. Anyway, I don't think you really need a
default here, the chip type should have already been checked as you
reach this portion of the driver code.

> +	}
>  	status = sprintf(buf, "%d\n", val); /* millidegrees Celsius */
>  out:
>  	mutex_unlock(&p_lm70->lock);
> @@ -93,7 +111,21 @@ static DEVICE_ATTR(temp1_input, S_IRUGO, lm70_sense_temp, NULL);
>  static ssize_t lm70_show_name(struct device *dev, struct device_attribute
>  			      *devattr, char *buf)
>  {
> -	return sprintf(buf, "lm70\n");
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);

Err, what about just:
	struct lm70 *p_lm70 = dev_get_drvdata(dev);
? You don't use spi anywhere else.

> +	int ret;
> +
> +	switch (p_lm70->chip) {
> +	case LM70_CHIP_LM70:
> +		ret = sprintf(buf, "lm70\n");
> +		break;
> +	case LM70_CHIP_TMP121:
> +		ret = sprintf(buf, "tmp121\n");
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	return ret;
>  }
>  
>  static DEVICE_ATTR(name, S_IRUGO, lm70_show_name, NULL);
> @@ -102,11 +134,20 @@ static DEVICE_ATTR(name, S_IRUGO, lm70_show_name, NULL);
>  
>  static int __devinit lm70_probe(struct spi_device *spi)
>  {
> +	struct lm70_platform_data *pdata;
>  	struct lm70 *p_lm70;
>  	int status;
> +	unsigned int chip;
> +
> +	pdata = spi->dev.platform_data;
> +	if (pdata)
> +		chip = pdata->chip;
> +	else
> +		chip = LM70_CHIP_LM70;
>  
>  	/* signaling is SPI_MODE_0 on a 3-wire link (shared SI/SO) */
> -	if ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !(spi->mode & SPI_3WIRE))
> +	if ((chip = LM70_CHIP_LM70) &&
> +	    ((spi->mode & (SPI_CPOL|SPI_CPHA)) || !(spi->mode & SPI_3WIRE)))
>  		return -EINVAL;
>  
>  	p_lm70 = kzalloc(sizeof *p_lm70, GFP_KERNEL);
> @@ -114,6 +155,7 @@ static int __devinit lm70_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	mutex_init(&p_lm70->lock);
> +	p_lm70->chip = chip;
>  
>  	/* sysfs hook */
>  	p_lm70->hwmon_dev = hwmon_device_register(&spi->dev);
> diff --git a/include/linux/spi/lm70.h b/include/linux/spi/lm70.h
> new file mode 100644
> index 0000000..986c35a
> --- /dev/null
> +++ b/include/linux/spi/lm70.h
> @@ -0,0 +1,15 @@
> +/*
> + * LM70 platform data
> + */
> +
> +#ifndef _LM70_H_
> +#define _LM70_H_
> +
> +#define LM70_CHIP_LM70		0
> +#define LM70_CHIP_TMP121	1
> +
> +struct lm70_platform_data {
> +	unsigned int chip;
> +};
> +
> +#endif

I don't know much about the SPI side of things so I would like someone
else to comment on that aspect of the patch (in particular the way
different device types are supported by the same driver.) David, can
you please take a look and let us know if you have any objection?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
