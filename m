From: Mark Brown <broonie@sirena.org.uk>
Date: Mon, 22 Sep 2008 14:25:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] [i2c] support for MAX8821 led charge
Message-Id: <20080922142516.GB15783@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1222090951-20567-2-git-send-email-giometti@enneenne.com>
In-Reply-To: <1222090951-20567-2-git-send-email-giometti@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 22, 2008 at 03:42:31PM +0200, Rodolfo Giometti wrote:

> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/leds.h>
> +

The LDOs should be exposed via the regulator framework which was merged
in 2.6.27 - see include/linux/regulator and drivers/regulator.  This
provides an API for use by client drivers and standard sysfs interfaces
for user space.

> +static ssize_t store_audio_power(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	int ret = write_audio_power(to_i2c_client(dev),
> +					strict_strtol(buf, NULL, 10));
> +	return ret ? ret : count;
> +}

...

> +static DEVICE_ATTR(audio_gain, S_IWUSR | S_IRUGO,
> +		   show_audio_gain, store_audio_gain);

It'd be much nicer to expose these as an in-kernel API, allowing ASoC
machine or other ALSA drivers to integrate control for the audio part.
With a direct sysfs interface rather an in-kernel one user space would
need to do the power management for the amplifier and it won't be
possible to expose the gain via standard ALSA interfaces.

Ideally ASoC would support multiple analogue devices so this could just
be an ASoC driver directly but we're not there yet.  There's an example
of how such chips are currently handled in the OpenMoko GTA01 driver in
sound/soc/s3c24xx/neo1973_wm8753.c - essentially, all the controls for
the extra chip are glued in by the machine driver.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
