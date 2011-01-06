From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 06 Jan 2011 12:04:34 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030	madc
Message-Id: <20110106120433.GC17184@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294286200-16446-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1294286200-16446-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, linux-omap@vger.kernel.org, amit.kucheria@canonical.com, balajitk@ti.com

On Thu, Jan 06, 2011 at 09:26:40AM +0530, Keerthy wrote:

> ---
>  drivers/hwmon/Kconfig            |   11 +
>  drivers/hwmon/Makefile           |    1 +
>  drivers/hwmon/twl4030-madc.c     |  794 ++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/twl4030-madc.h |  118 ++++++
>  4 files changed, 924 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/twl4030-madc.c
>  create mode 100644 include/linux/i2c/twl4030-madc.h

hwmon drivers are also expected to have a file under Documentation.

> +struct twl4030_madc_data {
> +	struct device *hwmon_dev;
> +	struct mutex lock;/* mutex protecting this data structire */
> +	struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
> +	int imr;
> +	int isr;
> +};

> +static struct twl4030_madc_data *twl4030_madc;

I'd expect this to be per driver instance rather than global (I know
it's vanishingly unlikely that you'll get multiple twl4030s in a single
system but it's nicer).

> +/*
> + * sysfs hook function
> + */
> +static ssize_t madc_read(struct device *dev,
> +			 struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct twl4030_madc_request req;
> +	long val;
> +
> +	req.channels = (1 << attr->index);
> +	req.method = TWL4030_MADC_SW2;
> +	req.func_cb = NULL;
> +	val = twl4030_madc_conversion(&req);
> +	if (val >= 0)
> +		val = req.rbuf[attr->index];
> +	else
> +		return val;
> +	return sprintf(buf, "%ld\n", val);

Does this return data in the appropriate units - milivolts for voltages?

> +/*
> + * Enables irq.
> + * @madc - pointer to twl4030_madc_data struct
> + * @id - irq number to be enabled
> + * can take one of TWL4030_MADC_RT, TWL4030_MADC_SW1, TWL4030_MADC_SW2
> + * corresponding to RT, SW1, SW2 conversion requests.
> + * If the i2c read fails it returns an error else returns 0.
> + */
> +static int twl4030_madc_enable_irq(struct twl4030_madc_data *madc, int id)

It'd be good to clarify that this is interrupt sources within this
module rather than Linux interrupt numbers.

> +			dev_dbg(madc->hwmon_dev,
> +			"Disable interrupt failed%d\n", i);
> +		}
> +
> +		madc->requests[i].result_pending = 1;
> +	}
> +	mutex_lock(&madc->lock);
> +	for (i = 0; i < TWL4030_MADC_NUM_METHODS; i++) {
> +
> +		r = &madc->requests[i];

In general through the driver your use of blank lines is really odd
which doesn't help readability.

> +	switch (conv_method) {
> +	case TWL4030_MADC_SW1:
> +	case TWL4030_MADC_SW2:
> +		ret = twl_i2c_write_u8(TWL4030_MODULE_MADC,
> +			TWL4030_MADC_SW_START, method->ctrl);
> +		if (ret) {
> +			dev_err(madc->hwmon_dev,
> +			"unable to write ctrl register 0x%X\n", method->ctrl);
> +			return ret;
> +		}
> +		break;
> +	case TWL4030_MADC_RT:
> +	default:
> +		break;

This looks odd - the function won't actually do anything for non-SW
conversions but won't return an error?

> +/* sysfs nodes to read individual channels from user side */
> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, madc_read, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, madc_read, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, madc_read, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, madc_read, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, madc_read, NULL, 4);
> +static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, madc_read, NULL, 5);
> +static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, madc_read, NULL, 6);
> +static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, madc_read, NULL, 7);
> +static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, madc_read, NULL, 8);
> +static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, madc_read, NULL, 9);
> +static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, madc_read, NULL, 10);
> +static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, madc_read, NULL, 11);
> +static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, madc_read, NULL, 12);
> +static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, madc_read, NULL, 13);
> +static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, madc_read, NULL, 14);
> +static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);

I suspect some of these are temperatures, some are voltages and that
some are fixed to particular inputs?  The temperatures should be temp_
and if the inputs are from known sources it'd be good to label them.

> +	madc->imr = (pdata->irq_line = 1) ?
> +	    TWL4030_MADC_IMR1 : TWL4030_MADC_IMR2;
> +	madc->isr = (pdata->irq_line = 1) ?
> +	    TWL4030_MADC_ISR1 : TWL4030_MADC_ISR2;

This looks really odd - what's going on here?  Comments might help.

> +
> +MODULE_DESCRIPTION("TWL4030 ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("J Keerthy");

A MODULE_ALIAS to enable automatic loading of teh driver would also be
good.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
