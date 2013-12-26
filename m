From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 26 Dec 2013 22:33:06 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] input: Add new sun4i-ts driver for Allwinner sunxi SoC's rtp controller
Message-Id: <52BCAEA2.6040607@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com> <1387923847-1294-2-git-send-email-hdegoede@redhat.com> <20131226221558.GA18562@core.coreip.homeip.net>
In-Reply-To: <20131226221558.GA18562-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org

Hi Dimitri,

Thanks for the review. I've one or two small questions / remarks.
I'll do a v2 addressing your and others comments tomorrow.

On 12/26/2013 11:15 PM, Dmitry Torokhov wrote:
>> +static int sun4i_ts_register_input(struct sun4i_ts_data *ts,
>> +					     const char *name)
>> +{
>> +	int ret;
>> +	struct input_dev *input;
>> +
>> +	input = devm_input_allocate_device(ts->dev);
>> +	if (!input)
>> +		return -ENOMEM;
>> +
>> +	input->name = name;
>> +	input->phys = "sun4i_ts/input0";
>> +	input->id.bustype = BUS_HOST;
>> +	input->id.vendor = 0x0001;
>> +	input->id.product = 0x0001;
>> +	input->id.version = 0x0100;
>> +	input->dev.parent = ts->dev;
>> +	input->evbit[0] =  BIT(EV_SYN) | BIT(EV_KEY) | BIT(EV_ABS);
>> +	set_bit(BTN_TOUCH, input->keybit);
>> +	input_set_abs_params(input, ABS_X, 0, 4095, 0, 0);
>> +	input_set_abs_params(input, ABS_Y, 0, 4095, 0, 0);
>> +
>> +	ret = input_register_device(input);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ts->input = input;
>> +	return 0;
>> +}
>> +
>> +static int sun4i_ts_remove(struct platform_device *pdev)
>> +{
>> +	struct sun4i_ts_data *ts = platform_get_drvdata(pdev);
>> +
>> +	/* Deactivate all IRQs */
>> +	writel(0, ts->base + TP_INT_FIFOC);
>
> Should this be moved into close() method of input device?

Yes and no, given patch 2/5 we should leave the temp_data irq enabled in the
close method. But disabling the other irqs on close is a good idea.


>
>> +	msleep(20);
>
> Why do you need msleep here? Are you trying to ensure that interrupts
> are not happening?

Yes.

> In that case synchronize_irq() is better option I think.

I did not know about synchronize_irq(), that definitely is a better
option.


>
>> +
>> +	if (ts->input)
>> +		input_unregister_device(ts->input);
>
> Since you are using managed input device you do not need to call
> input_unregister_device() explicitly.

Yes I was already wondering about that and wanted to check this for v2,
now I can skip the checking and simply remove this :)

>
>> +
>> +	kfree(ts);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sun4i_ts_probe(struct platform_device *pdev)
>> +{
>> +	struct sun4i_ts_data *ts;
>> +	int ret = -ENOMEM;
>> +
>> +	ts = kzalloc(sizeof(struct sun4i_ts_data), GFP_KERNEL);
>> +	if (!ts)
>> +		return -ENOMEM;
>
> I believe someone already mentioned devm_kzalloc()...

Yep, already fixed locally.

>
>> +
>> +	platform_set_drvdata(pdev, ts);
>> +
>> +	ts->dev = &pdev->dev;
>> +	ts->base = devm_ioremap_resource(&pdev->dev,
>> +			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
>> +	if (IS_ERR(ts->base)) {
>> +		ret = PTR_ERR(ts->base);
>> +		goto error;
>> +	}
>> +
>> +	ret = devm_request_irq(&pdev->dev, platform_get_irq(pdev, 0),
>> +			       sun4i_ts_irq, 0, "sun4i-ts", ts);
>> +	if (ret)
>> +		goto error;
>> +
>
> Are we 1000% sure that the device is quiesced here and we will not get a
> stray interrupt? Even if we are sure I'd still rather allocate input
> device earlier, together with ts structure.

I will change things to allocate the input device earlier. What about
registering it, when is the best time to do that?

>
>> +	ret = sun4i_ts_register_input(ts, pdev->name);
>> +	if (ret)
>> +		goto error;
>> +
>> +	/*
>> +	 * Select HOSC clk, clkin = clk / 6, adc samplefreq = clkin / 8192,
>> +	 * t_acq = clkin / (16 * 64)
>> +	 */
>> +	writel(ADC_CLK_SEL(0) | ADC_CLK_DIV(2) | FS_DIV(7) | T_ACQ(63),
>> +	       ts->base + TP_CTRL0);
>> +
>> +	/*
>> +	 * sensitive_adjust = 15 : max, which is not all that sensitive,
>> +	 * tp_mode = 0 : only x and y coordinates, as we don't use dual touch
>> +	 */
>> +	writel(TP_SENSITIVE_ADJUST(15) | TP_MODE_SELECT(0),
>> +	       ts->base + TP_CTRL2);
>> +
>> +	/* Enable median filter, type 1 : 5/3 */
>> +	writel(FILTER_EN(1) | FILTER_TYPE(1), ts->base + TP_CTRL3);
>> +
>> +	/* Flush fifo, set trig level to 1, enable data and pen up irqs */
>> +	writel(DATA_IRQ_EN(1) | FIFO_TRIG(1) | FIFO_FLUSH(1) | TP_UP_IRQ_EN(1),
>> +	       ts->base + TP_INT_FIFOC);
>> +
>> +	/*
>> +	 * Set stylus up debounce to aprox 10 ms, enable debounce, and
>> +	 * finally enable tp mode.
>> +	 */
>> +	writel(STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1) | TP_MODE_EN(1),
>> +	       ts->base + TP_CTRL1);
>
> Should all of some of this be moved into open() method for your input
> device?

The flushing of the fifo, and enabling of the input related irqs is probably
best done in the open method, the rest is also needed for the temp sensor
parts. I'll move the fifo-flush + irq enabling to the open method.

<snip>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
