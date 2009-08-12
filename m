From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 12 Aug 2009 16:42:53 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] [hwmon] add Freescale MC13783
Message-Id: <20090812164252.GE11227@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1250089531-10399-1-git-send-email-s.hauer@pengutronix.de> <1250089531-10399-2-git-send-email-s.hauer@pengutronix.de> <1250089531-10399-3-git-send-email-s.hauer@pengutronix.de> <1250089531-10399-4-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1250089531-10399-4-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>, Luotao Fu <l.fu@pengutronix.de>, lm-sensors@lm-sensors.org, Hans de Goede <hdegoede@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, Aug 12, 2009 at 05:05:29PM +0200, Sascha Hauer wrote:

> ---
>  drivers/hwmon/Kconfig       |    6 ++
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/mc13783-adc.c |  181 +++++++++++++++++++++++++++++++++++++++++++

Ideally there should be a Documentation/hwmon describing the chip and
the hwmon features it has.

> +	for (i = 0; i < entries; i++) {
> +		ret = device_create_file(&pdev->dev,
> +				&mc13783_adc_ctl[i].dev_attr);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"device_create_file failed with %d.\n", ret);
> +			goto out_err;
> +		}
> +	}

Could use sysfs_create_group() here.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
