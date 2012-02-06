From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 06 Feb 2012 15:16:14 +0000
Subject: Re: [lm-sensors] [PATCH v5 2/5] x86/platform: (TS-5500) add GPIO support
Message-Id: <20120206151614.GD10173@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328130344-18836-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <1328130344-18836-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1328130344-18836-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: x86@kernel.org, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>

On Wed, Feb 01, 2012 at 04:05:41PM -0500, Vivien Didelot wrote:

>  arch/x86/platform/ts5500/Kconfig       |    7 +
>  arch/x86/platform/ts5500/Makefile      |    1 +
>  arch/x86/platform/ts5500/ts5500_gpio.c |  478 ++++++++++++++++++++++++++++++++
>  arch/x86/platform/ts5500/ts5500_gpio.h |   60 ++++

As previously pointed out rather than hiding these drivers in arch/
directories there's a push to ship them in drivers/ where they benefit
from better subsystem review.

> +static int ts5500_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct ts5500_drvdata *drvdata;
> +
> +	drvdata = container_of(chip, struct ts5500_drvdata, gpio_chip);
> +
> +	mutex_lock(&drvdata->gpio_lock);
> +	if (requested_gpios[offset]) {
> +		mutex_unlock(&drvdata->gpio_lock);
> +		return -EBUSY;
> +	}
> +	requested_gpios[offset] = 1;
> +	mutex_unlock(&drvdata->gpio_lock);

This is all redundant, gpiolib will check this for you.

> +static void ts5500_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
> +{

This (and get()) should be a _cansleep() operation because...

> +	mutex_lock(&drvdata->gpio_lock);
> +	if (val = 0)
> +		port_bit_clear(ioaddr, bitno);
> +	else
> +		port_bit_set(ioaddr, bitno);
> +	mutex_unlock(&drvdata->gpio_lock);

...you take a mutex which needs process context.

> +static int ts5500_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +	/* Only a few lines are IRQ-Capable */
> +	switch (offset) {
> +	case TS5500_DIO1_13:
> +		return TS5500_DIO1_13_IRQ;
> +	case TS5500_DIO2_13:
> +		return TS5500_DIO2_13_IRQ;
> +	case TS5500_LCD_RS:
> +		return TS5500_LCD_RS_IRQ;

Why are these numbers compile time constants?

> +	/* Setup the gpio_chip structure */
> +	drvdata = kzalloc(sizeof(struct ts5500_drvdata), GFP_KERNEL);
> +	if (drvdata = NULL)
> +		goto err_alloc_dev;

Looks like you'd benefit from using devm_ functions for most if not all
of the allocation.

> +/* Callback for releasing resources */
> +static void ts5500_gpio_device_release(struct device *dev)
> +{
> +	/* noop */
> +}
> +
> +static struct platform_device ts5500_gpio_device = {
> +	.name = "ts5500_gpio",
> +	.id = -1,
> +	.dev = {
> +		.release = ts5500_gpio_device_release,
> +	}
> +};

I'm not sure what this is all about but it looks fairly obviously wrong.

> +static int __devexit ts5500_gpio_remove(struct platform_device *pdev)
> +{
> +	struct ts5500_drvdata *drvdata;
> +	int ret, i;
> +
> +	drvdata = platform_get_drvdata(pdev);
> +
> +	/* Release GPIO lines */
> +	for (i = 0; i < ARRAY_SIZE(requested_gpios); i++) {
> +		if (requested_gpios[i])
> +			gpio_free(i);
> +	}

You shouldn't be doing this, if it was sensible then gpiolib ought to be
doing it for you.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
