From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Apr 2011 18:21:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/f71882fg: Actually read registers
Message-Id: <20110427202150.50d0c858@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1303925538-3661-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1303925538-3661-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 27 Apr 2011 19:32:18 +0200, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hwmon/f71882fg.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 61ffab5..a4a94a0 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -1266,7 +1266,13 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
>  			data->pwm[nr] >  			    f71882fg_read8(data, F71882FG_REG_PWM(nr));
>  		}
> -		/* The f8000 can monitor 1 more fan, but has no pwm for it */
> +		/* Some models have 1 more fan with limited capabilities */
> +		if (data->type = f71808a) {
> +			data->fan[2] = f71882fg_read16(data,
> +						F71882FG_REG_FAN(2));
> +			data->pwm[2] = f71882fg_read8(data,
> +							F71882FG_REG_PWM(2));
> +		}
>  		if (data->type = f8000)
>  			data->fan[3] = f71882fg_read16(data,
>  						F71882FG_REG_FAN(3));

Merged, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
