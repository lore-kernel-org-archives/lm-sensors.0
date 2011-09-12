From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Sep 2011 18:47:15 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon/f71882fg: Make the decision
Message-Id: <1315853235.2455.206.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315563155-15774-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315563155-15774-3-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-09 at 06:12 -0400, Hans de Goede wrote:
> Before this patch the f71882fg driver completely fails to initialize
> on systems which have reserved settings in the pwm enable register, and
> it disables all auto pwm sysfs attributes if any fan is controlled by
> a digital sensor reading.
> 
> This patch changes the fail to initialize into don't register any attributes
> for the fan for which there are reserved settings in the pwm enable register
> and also makes the not registering of auto pwm sysfs attributes a per fan
> thing.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Nice cleanup. One minor comment:

[ ... ]
>  
>  static int __devinit f71882fg_create_fan_sysfs_files(
> -	struct platform_device *pdev, int idx, bool pwm_auto_point)
> +	struct platform_device *pdev, int idx)
>  {
>  	struct f71882fg_data *data = platform_get_drvdata(pdev);
>  	int err;
>  
> +	/* Sanity check the pwm setting */
> +	err = 0;
> +	switch (data->type) {
> +	case f71858fg:
> +		if (((data->pwm_enable >> (idx * 2)) & 3) = 3)
> +			err = 1;
> +		break;
> +	case f71862fg:
> +		if (((data->pwm_enable >> (idx * 2)) & 1) != 1)
> +			err = 1;
> +		break;
> +	case f8000:
> +		if (idx = 2)
> +			err = data->pwm_enable & 0x20;
> +		break;
> +	default:
> +		break;
> +	}
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Invalid (reserved) pwm settings: 0x%02x, "
> +			"skipping fan %d\n",
> +			(data->pwm_enable >> (idx * 2)) & 3, idx + 1);
> +		return 0; /* This is a non fatal condition */
> +	}

Since this is no longer a fatal condition, it might make sense to use
dev_warn instead.

Otherwise

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Jean, do you want to take the series (and maybe have another look), or
do you want me to take it ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
