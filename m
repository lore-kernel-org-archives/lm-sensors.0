From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Mon, 06 Jun 2005 22:28:44 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] pca9539: new i2c drvier
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C907FD67D@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

Thanks for taking the time to review.
I made the changes you suggested and will repost as retry 5.
For the description, I went with the wording in the datasheet: "16-bit
I/O port" 

Ben

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Monday, June 06, 2005 2:37 PM
To: Gardner, Ben
Cc: Greg KH; LM Sensors
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc5-mm2] pca9539: new i2c drvier
(retry 4 - attachment)

Hi Ben,

> Attached (due to email line-wrapping problems) is an updated patch for

> the PCA9539.
> I think this one is now ready for inclusion.

I'm very sorry but it looks like I still have a few objections ;)

> --- linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/Kconfig
2005-06-01 14:29:17.000000000 -0500
> +++ linux-2.6.12-rc5-mm2-pca9539/drivers/i2c/chips/Kconfig
2005-06-06 09:22:05.904153486 -0500
> @@ -440,6 +440,16 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called pcf8574.
>  
> +config SENSORS_PCA9539
> +	tristate "PCA9539 16-bit digital IO"

"Philips PCA9539 16-bit digital I/O"

(BTW, is there something like analog bits?)

> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the PCA9539

Philips PCA9539

> +	  low power digital I/O with 16 bit.

"with 16 bit" sounds really weird. "16-bit digital I/O" here again
maybe?

> --- linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/pca9539.c
1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.12-rc5-mm2-pca9539/drivers/i2c/chips/pca9539.c
2005-06-06 09:21:15.000000000 -0500
> @@ -0,0 +1,192 @@
> +/*
> +    pca9539.c - 16 port digital I/O with interrupt and reset

s/ port/-bit/ for consistency.

> +#include <linux/i2c-sysfs.h>

It has become linux/hwmon-sysfs.h a few hours ago ;)

http://lkml.org/lkml/2005/6/6/108

> +enum pca9539_cmd
> +{
> +	PCA9539_INPUT_0 = 0,
> +	PCA9539_INPUT_1 = 1,
> +	PCA9539_OUTPUT_0 = 2,
> +	PCA9539_OUTPUT_1 = 3,
> +	PCA9539_INVERT_0 = 4,
> +	PCA9539_INVERT_1 = 5,
> +	PCA9539_DIRECTION_0 = 6,
> +	PCA9539_DIRECTION_1 = 7
> +};

I think tab-aligned equal signs would improve readability. Also, it's
considered good practice to leave a comma on the last line, so as to
minimize possible further patches.

> +	return sprintf(buf, "%d\n", i2c_smbus_read_byte_data(client, 
> +
(u8)psa->index));
> (...)
> +	i2c_smbus_write_byte_data(client, (u8)psa->index, (u8)val);

These (u8) casts do not seem to be needed.

> +	/* Detection: the pcs9539 only has 8 registers (0-7).
> +	   A read of 7 should succeed, but a read of 8 should fail. */

s/pcs/pca/

> +	if ((i2c_smbus_read_byte_data(new_client, 7) < 0) &&
> +	    (i2c_smbus_read_byte_data(new_client, 8) >= 0))
> +		goto exit_kfree;

Shouldn't this be || rather than &&? Either condition is sufficient to
discard the chip.

> --- linux-2.6.12-rc5-mm2-clean/Documentation/i2c/chips/pca9539
1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.12-rc5-mm2/Documentation/i2c/chips/pca9539
2005-06-06 09:36:49.167804115 -0500
> @@ -0,0 +1,54 @@
> +Kernel driver pca9539
> +==========> +
> +Supported chips:
> +  * Maxim pca9539

Isn't it really Philips? Also, we tend to use caps when designating the
chips themselves.

> +    Prefixes: 'pca9539'

No s, there's a single prefix.

> +    Addresses scanned: 0x74 - 0x77
> +    Datasheets:

No s, there's a single datasheet.

> +Module Parameters
> +-----------------
> +
> +None
> +
> +

You can skip that section altogether.

> +Description
> +-----------
> +
> +The Phillips PCA9539 is a 16 bit low power I/O device.

Single 'l' to Philips.

> +name          - reads 'pca9539'

This is a standard entry, do not bother documenting it here.

> +The direction defaults to input only for all channels.

s/only//?

OK, I think that's all, and it should be alright next time :)

Thanks for your collaboration, I know how much work it is to go through
these review & update cycles, but this is how we manage to get the best
code and documentation into the kernel tree.

--
Jean Delvare


