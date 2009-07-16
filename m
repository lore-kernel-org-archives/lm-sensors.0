From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 16 Jul 2009 11:18:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add WM835x PMIC hardware monitoring
Message-Id: <4A5F0C6A.1090801@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1247671762-19506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1247671762-19506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Few queries below (all nit picky)

> --- /dev/null
> +++ b/drivers/hwmon/wm8350-hwmon.c
> @@ -0,0 +1,154 @@
...
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>

Why input-polldev? or for that matter delay.h, mutex.h, dmi.h
Can't immediately see any use of things from them, but I
haven't build tested without to check.

> +#include <linux/input-polldev.h>
...
> +
> +static ssize_t show_voltage(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct wm8350 *wm8350 = dev_get_drvdata(dev);
> +	int channel = to_sensor_dev_attr(attr)->index;
> +	int val;
> +
> +	val = wm8350_read_auxadc(wm8350, channel, 0, 0)
> +		* WM8350_AUX_COEFF / 1000;

I'd normally be a bit dubious about the lack of error handling here,
but having taken a look in at the wm8350-core it doesn't look like any
errors that occur can get through anyway (now whether they would
ideally be passed up to here is a different question!)

> +
> +	return sprintf(buf, "%d\n", val);
> +}

The rest looks fine to me.  Get rid of (or justify) the headers
and you have my ack.

--
Jonathan Cameron

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
