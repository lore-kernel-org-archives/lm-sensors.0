From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 30 Apr 2011 10:15:36 +0000
Subject: Re: [lm-sensors] [RFC 2/5] gpio: add support for Technologic
Message-Id: <20110430111536.5cb49d59@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1304115712-5299-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1304115712-5299-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, lm-sensors@lm-sensors.org

> + * The TS-5500 board has 38 GPIOs referred to as DIOs in the product's
> + * litterature.

literature

> +#define MODULE_NAME "ts5500-gpio"

see dev_dbg etc and the fmt support in them - they will do all this for
you nicely and the various printks can become dev_* which will tidy it up
and give more info

> +
> +#define PORT_BIT_SET(addr, bit)		\
> +	do {				\
> +		u8 var;			\
> +		var = inb(addr);	\
> +		var |= (1 << bit);	\
> +		outb(var, addr);	\
> +	} while (0)
> +
> +#define PORT_BIT_CLEAR(addr, bit)	\
> +	do {				\
> +		u8 var;			\
> +		var = inb(addr);	\
> +		var &= ~(1 << bit);	\
> +		outb(var, addr);	\
> +	} while (0)

These shouldn't be magic macros especially if creating variables and give
the multiple references to addr will break on things like ++ - use a
function so it is typechecked and variables behave as espected.


> +	/* Request DIO1 */
> +	if (!request_region(0x7A, 3, "ts5500-gpio-DIO1")) {
> +		dev_err(&pdev->dev, "Cannot request I/O port 0x7A-7C\n");
> +		goto err_req_dio1;
> +	}
> +
> +	/* Request DIO2 */
> +	if (!request_region(0x7D, 3, "ts5500-gpio-DIO2")) {
> +		dev_err(&pdev->dev, "Cannot request I/O port 0x7D-7F\n");
> +		goto err_req_dio2;
> +	}
> +
> +	/* Request LCDIO if wanted */
> +	if (use_lcdio && !request_region(0x72, 2, "ts5500-gpio-LCD")) {
> +		dev_err(&pdev->dev, "Cannot request I/O port 0x72-73\n");
> +		goto err_req_lcdio;
> +	}

I'd have expected these to be resources of the platform device but I
guess that if they are entirely fixed it doesn't really matter much.

> +	/* Enable IRQ generation */
> +	mutex_lock(&drvdata->gpio_lock);
> +	PORT_BIT_SET(0x7A, 7); /* DIO1_13 on IRQ7 */
> +	PORT_BIT_SET(0x7D, 7); /* DIO2_13 on IRQ6 */
> +	if (use_lcdio) {
> +		PORT_BIT_CLEAR(0x7D, 4); /* Enable LCD header usage as DIO */
> +		PORT_BIT_SET(0x7D, 6);   /* LCD_RS on IRQ1 */
> +	}

What happens if an IRQ occurs at this point, you have no handler for it ?

> +err_gpiochip_add:
> +	printk(KERN_ERR "gpio: Failed registering gpio chip.\n");
> +	kfree(drvdata);

pr_err/dev_err etc - in general


> +
> +static int __init ts5500_gpio_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&ts5500_gpio_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_device_register(&gpio_device);
> +	if (ret) {
> +		printk(MODULE_NAME ": Failed to register platform device\n");
> +		platform_driver_unregister(&ts5500_gpio_driver);
> +		return ret;
> +	}
> +
> +	printk(MODULE_NAME ": GPIO/DIO driver loaded.\n");

prinkt isn't needed

Also you've done no checks to see if it's being loaded on the right
board. I'd actually have expected a single chunk of code in
arch/x86/platform/ts5500 or similar to do the board check and create the
platform devices, and this code to just register them.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
