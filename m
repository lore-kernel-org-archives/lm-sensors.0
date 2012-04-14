From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 14 Apr 2012 00:46:02 +0000
Subject: Re: [lm-sensors] [PATCH v6 1/3] hwmon: Maxim MAX197 support
Message-Id: <20120414004602.GA5609@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1334276935-11258-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <1334276935-11258-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1334276935-11258-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>

On Thu, Apr 12, 2012 at 08:28:53PM -0400, Vivien Didelot wrote:
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
[ ... ]

> +
> +/**
> + * max197_show_input() - Show channel input
> + *
> + * Function called on read access on in{0,1,2,3,4,5,6,7}_input
> + */
> +static ssize_t max197_show_input(struct device *dev,
> +                                struct device_attribute *devattr,
> +                                char *buf)
> +{
> +       struct max197_chip *chip = dev_get_drvdata(dev);
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +       int channel = attr->index;
> +       u16 raw;
> +       s32 scaled;
> +       int ret;
> +
> +       if (mutex_lock_interruptible(&chip->lock))
> +               return -ERESTARTSYS;
> +
> +       ret = chip->pdata->convert(chip->ctrl_bytes[channel], &raw);
> +       if (ret) {
> +               dev_err(dev, "conversion failed\n");
> +               goto unlock;
> +       }

Hi Vivien,

thinking about this, you can simplify the API to

	ret = chip->pdata->convert(chip->ctrl_bytes[channel]);
	if (ret < 0) {
		dev_err(dev, "conversion failed\n");
		goto unlock;
	}
	scaled = ret;

This overloads the return value with both error code (< 0) and return value (unsigned, >= 0).
This would make the code a bit simpler and smaller.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
