From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 26 Dec 2013 08:37:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] input: Add new sun4i-ts driver for Allwinner sunxi SoC's rtp controller
Message-Id: <20131226093751.3d133371@skate>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
	<1387923847-1294-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1387923847-1294-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Dear Hans de Goede,

On Tue, 24 Dec 2013 23:24:03 +0100, Hans de Goede wrote:

> +/* TP_INT_FIFOS irq and fifo status bits */
> +#define TEMP_DATA_PENDING	(1 << 18)
> +#define FIFO_OVERRUN_PENDING	(1 << 17)
> +#define FIFO_DATA_PENDING	(1 << 16)
> +#define TP_IDLE_FLG		(1 << 2)
> +#define TP_UP_PENDING		(1 << 1)
> +#define TP_DOWN_PENDING		(1 << 0)

You could use the BIT() macro for these definitions.


> +	ret = sun4i_ts_register_input(ts, pdev->name);
> +	if (ret)
> +		goto error;
> +
> +	/*
> +	 * Select HOSC clk, clkin = clk / 6, adc samplefreq = clkin / 8192,
> +	 * t_acq = clkin / (16 * 64)
> +	 */
> +	writel(ADC_CLK_SEL(0) | ADC_CLK_DIV(2) | FS_DIV(7) | T_ACQ(63),
> +	       ts->base + TP_CTRL0);
> +
> +	/*
> +	 * sensitive_adjust = 15 : max, which is not all that sensitive,
> +	 * tp_mode = 0 : only x and y coordinates, as we don't use dual touch
> +	 */
> +	writel(TP_SENSITIVE_ADJUST(15) | TP_MODE_SELECT(0),
> +	       ts->base + TP_CTRL2);
> +
> +	/* Enable median filter, type 1 : 5/3 */
> +	writel(FILTER_EN(1) | FILTER_TYPE(1), ts->base + TP_CTRL3);
> +
> +	/* Flush fifo, set trig level to 1, enable data and pen up irqs */
> +	writel(DATA_IRQ_EN(1) | FIFO_TRIG(1) | FIFO_FLUSH(1) | TP_UP_IRQ_EN(1),
> +	       ts->base + TP_INT_FIFOC);
> +
> +	/*
> +	 * Set stylus up debounce to aprox 10 ms, enable debounce, and
> +	 * finally enable tp mode.
> +	 */
> +	writel(STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1) | TP_MODE_EN(1),
> +	       ts->base + TP_CTRL1);

It seems weird to do all the hardware initialization *after* the input
device has been registered. We normally initialize all the hardware
*and* then register the device, so that we guarantee that userspace
cannot access the device before it is properly initialized.


> +static const struct of_device_id sun4i_ts_of_match[] = {
> +	{ .compatible = "allwinner,sun4i-ts", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_ts_of_match);

You're introducing a new DT binding, so the appropriate documentation
should be written for it.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
