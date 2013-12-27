From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Dec 2013 16:34:19 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/5] input: sun4i-ts: Add support for temperature sensor
Message-Id: <20131227163419.GA20135@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
 <1388156399-29677-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1388156399-29677-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Fri, Dec 27, 2013 at 03:59:56PM +0100, Hans de Goede wrote:
> The sun4i resisitive touchscreen controller also comes with a built-in
> temperature sensor. This commit adds support for it.
>=20
> This commit also introduces a new "ts-attached" device-tree property,
> when this is not set, the input part of the driver won't register. This w=
ay
> the internal temperature sensor can be used to measure the SoC temperature
> independent of there actually being a touchscreen attached to the control=
ler.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Hi Hans,

Almost good, except for a couple of nitpicks and one moe question.
Assuming you fix the nitpicks and the question is not a concern,
feel free to add

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  .../bindings/input/touchscreen/sun4i.txt           |   6 +
>  drivers/input/touchscreen/sun4i-ts.c               | 129 +++++++++++++++=
+-----
>  2 files changed, 109 insertions(+), 26 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.tx=
t b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> index e45927e..1fffd11 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> @@ -6,10 +6,16 @@ Required properties:
>   - reg: mmio address range of the chip
>   - interrupts: interrupt to which the chip is connected
> =20
> +Optional properties:
> + - ts-attached: boolean set this to tell the driver that an actual touch=
screen
> +		is attached and that it should register an input device,
> +		without this it only registers the builtin temperate sensor
> +
>  Example:
> =20
>  	rtp: rtp@01c25000 {
>  		compatible =3D "allwinner,sun4i-ts";
>  		reg =3D <0x01c25000 0x100>;
>  		interrupts =3D <29>;
> +		ts-attached;
>  	};
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchsc=
reen/sun4i-ts.c
> index 10839d2..2d437f6 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (C) 2013 - 2014 Hans de Goede <hdegoede@redhat.com>
>   *
> + * The hwmon parts are based on work by Corentin LABBE which is:
> + * Copyright (C) 2013 Corentin LABBE <clabbe.montjoie@gmail.com>
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -30,6 +33,7 @@
>   */
> =20
>  #include <linux/err.h>
> +#include <linux/hwmon.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> @@ -106,6 +110,7 @@ struct sun4i_ts_data {
>  	void __iomem *base;
>  	unsigned int irq;
>  	bool ignore_fifo_data;
> +	int temp_data;
>  };
> =20
>  static irqreturn_t sun4i_ts_irq(int irq, void *dev_id)
> @@ -115,6 +120,12 @@ static irqreturn_t sun4i_ts_irq(int irq, void *dev_i=
d)
> =20
>  	reg_val  =3D readl(ts->base + TP_INT_FIFOS);
> =20
> +	if (reg_val & TEMP_DATA_PENDING)
> +		ts->temp_data =3D readl(ts->base + TEMP_DATA);

Is this read guaranteed to return 0 in the upper bit, or in other words is =
it
guaranteed to never return 0xffffffff ? Otherwise there might be a problem =
with
the implicit conversion to a negative integer.

> +
> +	if (!ts->input)
> +		goto leave;
> +
>  	if (reg_val & FIFO_DATA_PENDING) {
>  		x =3D readl(ts->base + TP_DATA);
>  		y =3D readl(ts->base + TP_DATA);
> @@ -140,6 +151,7 @@ static irqreturn_t sun4i_ts_irq(int irq, void *dev_id)
>  		input_sync(ts->input);
>  	}
> =20
> +leave:
>  	writel(reg_val, ts->base + TP_INT_FIFOS);
> =20
>  	return IRQ_HANDLED;
> @@ -149,9 +161,9 @@ static int sun4i_ts_open(struct input_dev *dev)
>  {
>  	struct sun4i_ts_data *ts =3D input_get_drvdata(dev);
> =20
> -	/* Flush, set trig level to 1, enable data and up irqs */
> -	writel(DATA_IRQ_EN(1) | FIFO_TRIG(1) |FIFO_FLUSH(1) | TP_UP_IRQ_EN(1),
> -	       ts->base + TP_INT_FIFOC);
> +	/* Flush, set trig level to 1, enable temp, data and up irqs */
> +	writel(TEMP_IRQ_EN(1) | DATA_IRQ_EN(1) | FIFO_TRIG(1) | FIFO_FLUSH(1) |
> +		TP_UP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
> =20
>  	return 0;
>  }
> @@ -160,40 +172,76 @@ static void sun4i_ts_close(struct input_dev *dev)
>  {
>  	struct sun4i_ts_data *ts =3D input_get_drvdata(dev);
> =20
> -	/* Deactivate all IRQs */
> -	writel(0, ts->base + TP_INT_FIFOC);
> +	/* Deactivate all input IRQs */
> +	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
>  	synchronize_irq(ts->irq);
>  }
> =20
> +static ssize_t show_temp(struct device *dev, struct device_attribute *de=
vattr,
> +			 char *buf)
> +{
> +	struct sun4i_ts_data *ts =3D dev_get_drvdata(dev);
> +
> +	/* No temp_data until the first irq */
> +	if (ts->temp_data =3D -1)
> +		return -EAGAIN;
> +
> +	return sprintf(buf, "%d\n", (ts->temp_data - 1447) * 100);
> +}
> +
> +static ssize_t show_temp_label(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	return sprintf(buf, "SoC temperature\n");
> +}
> +
> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
> +static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);
> +
> +static struct attribute *sun4i_ts_attrs[] =3D {
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp1_label.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(sun4i_ts);
> +
>  static int sun4i_ts_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_ts_data *ts;
>  	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =DEv->of_node;

Missing space after '=3D' (checkpatch error).

> +	struct device *hwmon;
>  	int ret;
> +	bool ts_attached;
> +
> +	ts_attached =3D of_property_read_bool(np, "ts-attached");
> =20
>  	ts =3D devm_kzalloc(dev, sizeof(struct sun4i_ts_data), GFP_KERNEL);
>  	if (!ts)
>  		return -ENOMEM;
> =20
>  	ts->dev =3D dev;
> -
> -	ts->input =3D devm_input_allocate_device(dev);
> -	if (!ts->input)
> -		return -ENOMEM;
> -
> -	ts->input->name =3D pdev->name;
> -	ts->input->phys =3D "sun4i_ts/input0";
> -	ts->input->open =3D sun4i_ts_open;
> -	ts->input->close =3D sun4i_ts_close;
> -	ts->input->id.bustype =3D BUS_HOST;
> -	ts->input->id.vendor =3D 0x0001;
> -	ts->input->id.product =3D 0x0001;
> -	ts->input->id.version =3D 0x0100;
> -	ts->input->evbit[0] =3D  BIT(EV_SYN) | BIT(EV_KEY) | BIT(EV_ABS);
> -	set_bit(BTN_TOUCH, ts->input->keybit);
> -	input_set_abs_params(ts->input, ABS_X, 0, 4095, 0, 0);
> -	input_set_abs_params(ts->input, ABS_Y, 0, 4095, 0, 0);
> -	input_set_drvdata(ts->input, ts);
> +	ts->temp_data =3D -1;
> +
> +	if (ts_attached) {
> +		ts->input =3D devm_input_allocate_device(dev);
> +		if (!ts->input)
> +			return -ENOMEM;
> +
> +		ts->input->name =3D pdev->name;
> +		ts->input->phys =3D "sun4i_ts/input0";
> +		ts->input->open =3D sun4i_ts_open;
> +		ts->input->close =3D sun4i_ts_close;
> +		ts->input->id.bustype =3D BUS_HOST;
> +		ts->input->id.vendor =3D 0x0001;
> +		ts->input->id.product =3D 0x0001;
> +		ts->input->id.version =3D 0x0100;
> +		ts->input->evbit[0] =3D  BIT(EV_SYN) | BIT(EV_KEY) | BIT(EV_ABS);
> +		set_bit(BTN_TOUCH, ts->input->keybit);
> +		input_set_abs_params(ts->input, ABS_X, 0, 4095, 0, 0);
> +		input_set_abs_params(ts->input, ABS_Y, 0, 4095, 0, 0);
> +		input_set_drvdata(ts->input, ts);
> +	}
> =20
>  	ts->base =3D devm_ioremap_resource(dev,
>  			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> @@ -232,14 +280,42 @@ static int sun4i_ts_probe(struct platform_device *p=
dev)
>  	writel(STYLUS_UP_DEBOUN(5) | STYLUS_UP_DEBOUN_EN(1) | TP_MODE_EN(1),
>  	       ts->base + TP_CTRL1);
> =20
> -	ret =3D input_register_device(ts->input);
> -	if (ret)
> -		return ret;
> +	hwmon =3D devm_hwmon_device_register_with_groups(ts->dev, "sun4i_ts",
> +						       ts, sun4i_ts_groups);
> +	if (IS_ERR(hwmon)) {
> +		return PTR_ERR(hwmon);
> +	}

{ } are not needed here (checkpatch warning).

> +
> +	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
> +
> +	if (ts_attached) {
> +		ret =3D input_register_device(ts->input);
> +		if (ret) {
> +			writel(0, ts->base + TP_INT_FIFOC);
> +			synchronize_irq(ts->irq);
> +			return ret;
> +		}
> +	}
> =20
>  	platform_set_drvdata(pdev, ts);
>  	return 0;
>  }
> =20
> +static int sun4i_ts_remove(struct platform_device *pdev)
> +{
> +	struct sun4i_ts_data *ts =3D platform_get_drvdata(pdev);
> +
> +	/* Explicit unregister to avoid open/close changing the imask later */
> +	if (ts->input)
> +		input_unregister_device(ts->input);
> +
> +	/* Deactivate all IRQs */
> +	writel(0, ts->base + TP_INT_FIFOC);
> +	synchronize_irq(ts->irq);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id sun4i_ts_of_match[] =3D {
>  	{ .compatible =3D "allwinner,sun4i-ts", },
>  	{ /* sentinel */ }
> @@ -253,6 +329,7 @@ static struct platform_driver sun4i_ts_driver =3D {
>  		.of_match_table =3D of_match_ptr(sun4i_ts_of_match),
>  	},
>  	.probe	=3D sun4i_ts_probe,
> +	.remove	=3D sun4i_ts_remove,
>  };
> =20
>  module_platform_driver(sun4i_ts_driver);
> --=20
> 1.8.4.2
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
