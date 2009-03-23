From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 23 Mar 2009 00:07:39 +0000
Subject: Re: [lm-sensors] [RFC] SHT15 Sensiron humidity and temperature
Message-Id: <20090322170739.7f4078c4.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <497367C6.8010200@cam.ac.uk>
In-Reply-To: <497367C6.8010200@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Jan 2009 17:32:54 +0000 Jonathan Cameron <jic23@cam.ac.uk> wrote:

> From: Jonathan Cameron <jic23@cam.ac.uk>
> hwmon: SHT15 and similar Sensiron humidity sensors
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> ---
> Depends on:
> Regulator: Add voltage change event notification
> (to be posted to lkml shortly - it needs rebasing as that subsystem
> is changing rapidly at the mo!)
> 
> Data sheet at:
> http://www.sensirion.ch/en/pdf/product_information/Datasheet-humidity-sensor-SHT1x.pdf
> 
> These sensors communicate over a 2 wire bus running a device specific
> protocol.  The complexity of the driver is mainly due to handling the
> substantial delays between requesting a reading and the device pulling
> the data line low to indicate that the data is available.  This is
> handled by an interrupt that is disabled under all other conditions.
> 
> I wasn't terribly clear on the best way to handle this, so comments
> on that aspect would be particularly welcome!
> 
> Interpretation of the temperature depends on knowing the supply voltage.
> If configured in a board config as a regulator consumer this is obtained
> from the regulator subsystem. If not it should be provided in the
> platform data.
> 
> I've placed this driver in the hwmon subsystem as it is definitely a
> device that may be used for hardware monitoring and with it's relatively
> slow response times (up to 120 milisecs to get a reading) a caching
> strategy certainly seems to make sense!
> 

Building this in current kernels on x86_64 gives

drivers/hwmon/sht15.c: In function 'sht15_update_single_val':
drivers/hwmon/sht15.c:237: error: implicit declaration of function 'IRQ_GPIO'

>
> ...
>
> +static int __init sht15_init(void)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sht_drivers); i++) {
> +		ret = platform_driver_register(&sht_drivers[i]);
> +		if (ret)
> +			goto error_unreg;
> +	}
> +
> +	return 0;
> +
> +error_unreg:
> +	i--;
> +	for (; i >= 0; i--)
> +		platform_driver_unregister(&sht_drivers[i]);
> +
> +	return ret;
> +}

We could just do

	while (--i >= 0)
		platform_driver_unregister(...);

here.


Anyway, please take a look at those things and Cc: me on version 2 and
we'll try to push forward with this, thanks.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
