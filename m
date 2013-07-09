From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 09 Jul 2013 18:01:04 +0000
Subject: Re: [lm-sensors] humidity sensors
Message-Id: <51DC4FE0.1080402@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1UwWkL-0000pI-8V@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1UwWkL-0000pI-8V@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Geyer <harald@ccbib.org>
Cc: linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, LM Sensors <lm-sensors@lm-sensors.org>

On 07/09/2013 01:10 PM, Harald Geyer wrote:
> Hi,
> 
> I'm working on a iio driver for the DHT11 (and DHT22)
> humidity and temperature sensor. I believe this is the
> first humidity sensor to be supported by the iio framework.
Sure, previously these have been considered acceptable to hwmon
(just about ;).  That has always  been controversial and with
iio-hwmon in place, I doubt anyone will mind having it new
ones in IIO.  I've cc'd a few people just in case they have
strong views on this.

> 
> This poses the question how the iio API regarding humidity
> values should be extended.
> 
> 1) Which string to use to construct filenames in sysfs, etc.:
> My suggestion: "relhum"
I wonder if humidtyrelative would be better (just in case someone
produces a sensor to measure specific or absolute humidity as then
they will be close together in names.  Also it's rarely worth
abreviating these terms as it can only cause confusion at a later
date and only costs a few characters here and there.
> 
> 2) What unit to use for values:
> My suggestion: permil (0.1%)
hmm.. Interesting question for a ratio quantity.  Perhaps a
decimal ratio might work?  so 0.1% = 0.0001?
Don't really have strong feelings but permil whilst common
in some fields is a little unusual.

> That's what the DHT11 is using and I believe humidity is
> difficult to measure to more precision.
> 
> 3) Probably I'm missing something as I'm not that familiar
> with iio yet.
> 
> I'll submit a formal patch for the DHT11 driver when the
> iio framework is ready, but if you want to have a look at
> the work in progress, you find it at
> http://www.unet.univie.ac.at/~a0300802/files/dht11-gpio.c
> and at the bottom of this mail.
> 
> Related newbie question: On which branch should I base
> the patch?
Typically the staging-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git

Whilst IIO isn't still in staging, Greg kindly routes our
patches upstream and enough of the drivers are still in staging
that it makes sense to still do it through his staging tree.

> 
> Also from reading the archives of this list and
> sysfs-bus-iio it's not clear to me whether using
> IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT in my driver is ok.
The way that is handled has changed so take a look at the
current status of Greg's tree.  In short I split the
info_mask in two as step one of some other reworking
with a side effect of simplifying that code.

As for whether it is appropriate, in cases where there is only
one channel of a given type it really doesn't matter whether the
info mask elements are defined as shared or separate. Any userspace
library will handle them both the same.

Have had a very quick look at the driver and looks fine in general.
Will do a full review once it is complete.
> 
> TIA,
> Harald
> 
> 
> /*
>  * DHT11/DHT22 bit banging GPIO driver
>  *
>  * Copyright (c) Harald Geyer <harald@ccbib.org>
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation; either version 2 of the License, or
>  * (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>  * GNU General Public License for more details.
>  */
> 
> #include <linux/err.h>
> #include <linux/interrupt.h>
> #include <linux/device.h>
> #include <linux/kernel.h>
> #include <linux/printk.h>
> #include <linux/slab.h>
> #include <linux/of.h>
> #include <linux/of_device.h>
> #include <linux/sysfs.h>
> #include <linux/io.h>
> #include <linux/module.h>
> #include <linux/platform_device.h>
> #include <linux/wait.h>
> #include <linux/bitops.h>
> #include <linux/completion.h>
> #include <linux/delay.h>
> #include <linux/gpio.h>
> #include <linux/of_gpio.h>
> 
> #include <linux/iio/iio.h>
> 
> #define DRIVER_NAME	"dht11-gpio"
> 
> #define DATA_VALID_TIME	2000000000 /* 2s in ns */
> 
> #define EDGES_PREAMBLE	4
> #define BITS_PER_READ	40
> #define EDGES_PER_READ	(2*BITS_PER_READ + EDGES_PREAMBLE + 1)
> 
> /* Data transmission timing (nano seconds) */
> #define STARTUP		18    /* ms */
> #define SENSOR_RESPONSE	80000
> #define START_BIT	50000
> #define DATA_BIT_LOW	27000
> #define DATA_BIT_HIGH	70000
> 
> /* TODO?: Support systems without DT? */
> 
> struct dht11_gpio {
> 	int				gpio;
> 	int				irq;
> 
> 	struct completion		completion;
> 
> 	s64				timestamp;
> 	s16				temperature_raw;
> 	s16				humidity_raw;
> 
> 	/* num_edges: -1 means "no transmission in progress" */
> 	int				num_edges;
> 	struct {s64 ts; int value; }	edges[EDGES_PER_READ];
> };
> 
> /*
>  * dht11_edges_print: show the data as actually received by the
>  *                    driver.
>  * This is dead code, keeping it for now just in case somebody needs
>  * it for porting the driver to new sensor HW, etc.
>  *
> static void dht11_edges_print(struct dht11_gpio *dht11)
> {
> 	int i;
> 
> 	pr_err("dht11: transfer timed out:\n");
> 	for (i = 1; i < dht11->num_edges; ++i) {
> 		pr_err("dht11: %d: %lld ns %s\n", i,
> 			dht11->edges[i].ts - dht11->edges[i-1].ts,
> 			dht11->edges[i-1].value ? "high" : "low");
> 	}
> }
> */
> 
> static unsigned char dht11_gpio_decode_byte(int *timing, int threshold)
> {
> 	unsigned char ret = 0;
> 	int i;
> 
> 	for (i = 0; i < 8; ++i) {
> 		ret <<= 1;
> 		if (timing[i] >= threshold)
> 			++ret;
> 	}
> 
> 	return ret;
> }
> 
> static int dht11_gpio_decode(struct dht11_gpio *dht11)
> {
> 	int i, t, timing[BITS_PER_READ], threshold, timeres = SENSOR_RESPONSE;
> 	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
> 
> 	/* Calculate timestamp resolution */
> 	for (i = 0; i < dht11->num_edges; ++i) {
> 		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
> 		if (t > 0 && t < timeres)
> 			timeres = t;
> 	}
> 	if (2*timeres > DATA_BIT_HIGH) {
> 		pr_err("dht11-gpio: timeresolution %d too bad for decoding\n",
> 			timeres);
> 		return -EIO;
> 	}
> 	threshold = DATA_BIT_HIGH/timeres;
> 	if (DATA_BIT_LOW/timeres + 1 >= threshold)
> 		pr_err("dht11-gpio: WARNING: decoding ambiguous\n");
> 
> 	/* scale down with timeres and check validity */
> 	for (i = 0; i < BITS_PER_READ; ++i) {
> 		t = dht11->edges[EDGES_PREAMBLE + 2*i + 2].ts -
> 			dht11->edges[EDGES_PREAMBLE + 2*i + 1].ts;
> 		if (!dht11->edges[EDGES_PREAMBLE + 2*i + 1].value)
> 			return -EIO; /* lost synchronisation */
> 		timing[i] = t / timeres;
> 	}
> 
> 	hum_int = dht11_gpio_decode_byte(timing, threshold);
> 	hum_dec = dht11_gpio_decode_byte(&timing[8], threshold);
> 	temp_int = dht11_gpio_decode_byte(&timing[16], threshold);
> 	temp_dec = dht11_gpio_decode_byte(&timing[24], threshold);
> 	checksum = dht11_gpio_decode_byte(&timing[32], threshold);
> 
> 	if (((hum_int + hum_dec + temp_int + temp_dec) & 0x00ff) != checksum)
> 		return -EIO;
> 
> 	dht11->timestamp = iio_get_time_ns();
> 	dht11->temperature_raw = (temp_int << 8) + temp_dec;
> 	dht11->humidity_raw = (hum_int << 8) + hum_dec;
> 
> 	return 0;
> }
> 
> static int dht11_gpio_read_raw(struct iio_dev *iio_dev,
> 			const struct iio_chan_spec *chan,
> 			int *val, int *val2, long m)
> {
> 	struct dht11_gpio *dht11 = iio_priv(iio_dev);
> 	int ret = 0;
> 
> 	if (dht11->timestamp + DATA_VALID_TIME < iio_get_time_ns()) {
> 		INIT_COMPLETION(dht11->completion);
> 
> 		dht11->num_edges = 0;
> 		ret = gpio_direction_output(dht11->gpio, 0);
> 		if (ret)
> 			goto err;
> 		msleep(STARTUP);
> 		ret = gpio_direction_input(dht11->gpio);
> 		if (ret)
> 			goto err;
> 
> 		ret = wait_for_completion_killable_timeout(&dht11->completion,
> 								 HZ);
> 		if (ret = 0) {
> 			dev_err(&iio_dev->dev,
> 					"Only %d signal edges detected\n",
> 					dht11->num_edges);
> 			ret = -ETIMEDOUT;
> 		}
> 		if (ret < 0)
> 			goto err;
> 
> 		ret = dht11_gpio_decode(dht11);
> 		if (ret)
> 			goto err;
> 	}
> 
> 	ret = IIO_VAL_INT;
> 	if (chan->channel = 0)
> 		*val = dht11->temperature_raw * 100;
> 	else if (chan->channel = 1)
> 		*val = dht11->humidity_raw;
> 	else
> 		ret = -EINVAL;
> err:
> 	dht11->num_edges = -1;
> 	return ret;
> }
> 
> static const struct iio_info dht11_gpio_iio_info = {
> 	.driver_module		= THIS_MODULE,
> 	.read_raw		= dht11_gpio_read_raw,
> };
> 
> /*
>  * IRQ handler called on GPIO edges
> */
> static irqreturn_t dht11_gpio_handle_irq(int irq, void *data)
> {
> 	struct iio_dev *iio = data;
> 	struct dht11_gpio *dht11 = iio_priv(iio);
> 
> 	/* TODO: Consider making the handler safe for IRQ sharing */
> 	if (dht11->num_edges < EDGES_PER_READ && dht11->num_edges >= 0) {
> 		dht11->edges[dht11->num_edges].ts = iio_get_time_ns();
> 		dht11->edges[dht11->num_edges++].value > 						gpio_get_value(dht11->gpio);
> 	}
> 
> 	if (dht11->num_edges >= EDGES_PER_READ)
> 		complete(&dht11->completion);
> 
> 	return IRQ_HANDLED;
> }
> 
> static const struct iio_chan_spec dht11_gpio_chan_spec[] = {
> 	{ .type = IIO_TEMP, .channel = 0,
> 		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT, },
> 	{ .type = IIO_VOLTAGE, .channel = 1,
> 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
> } /* TODO: humidity */
> };
> 
> static const struct of_device_id dht11_gpio_dt_ids[] = {
> 	{ .compatible = "dht11-gpio", },
> 	{ }
> };
> MODULE_DEVICE_TABLE(of, dht11_gpio_dt_ids);
> 
> static int dht11_gpio_probe(struct platform_device *pdev)
> {
> 	struct device *dev = &pdev->dev;
> 	struct device_node *node = dev->of_node;
> 	struct dht11_gpio *dht11;
> 	struct iio_dev *iio;
> 	int ret = 0;
> 
> 	/* Allocate the IIO device. */
> 	iio = iio_device_alloc(sizeof(*dht11));
> 	if (!iio) {
> 		dev_err(dev, "Failed to allocate IIO device\n");
> 		return -ENOMEM;
> 	}
> 
> 	dht11 = iio_priv(iio);
> 	dht11->gpio = ret = of_get_gpio(node, 0);
> 	if (ret < 0)
> 		goto err;
> 	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
> 	if (ret)
> 		goto err;
> 
> 	dht11->irq = gpio_to_irq(dht11->gpio);
> 	if (dht11->irq < 0) {
> 		dev_err(dev, "GPIO %d has no interrupt\n", dht11->gpio);
> 		ret = -EINVAL;
> 		goto err;
> 	}
> 	ret = devm_request_irq(dev, dht11->irq, dht11_gpio_handle_irq,
> 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> 				pdev->name, iio);
> 	if (ret)
> 		goto err;
> 
> 	dht11->timestamp = iio_get_time_ns() - DATA_VALID_TIME - 1;
> 	dht11->num_edges = -1;
> 
> 	platform_set_drvdata(pdev, iio);
> 
> 	init_completion(&dht11->completion);
> 	iio->name = pdev->name;
> 	iio->dev.parent = &pdev->dev;
> 	iio->info = &dht11_gpio_iio_info;
> 	iio->modes = INDIO_DIRECT_MODE;
> 	iio->channels = dht11_gpio_chan_spec;
> 	iio->num_channels = ARRAY_SIZE(dht11_gpio_chan_spec);
> 
> 	/* Register IIO device. */
> 	ret = iio_device_register(iio);
> 	if (ret) {
> 		dev_err(dev, "Failed to register IIO device\n");
> 		goto err;
> 	}
> 
> 	return 0;
> 
> err:
> 	iio_device_free(iio);
> 	return ret;
> }
> 
> static int dht11_gpio_remove(struct platform_device *pdev)
> {
> 	struct iio_dev *iio = platform_get_drvdata(pdev);
> 
> 	iio_device_unregister(iio);
> 	iio_device_free(iio);
> 
> 	return 0;
> }
> 
> static struct platform_driver dht11_gpio_driver = {
> 	.driver = {
> 		.name	= DRIVER_NAME,
> 		.owner	= THIS_MODULE,
> 		.of_match_table = dht11_gpio_dt_ids,
> 	},
> 	.probe  = dht11_gpio_probe,
> 	.remove = dht11_gpio_remove,
> };
> 
> module_platform_driver(dht11_gpio_driver);
> 
> MODULE_AUTHOR("Harald Geyer <harald@ccbib.org>");
> MODULE_DESCRIPTION("DHT11 humidity/temperature sensor driver");
> MODULE_LICENSE("GPL v2");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
