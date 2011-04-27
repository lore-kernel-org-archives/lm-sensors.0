From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Apr 2011 13:23:11 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/f71882fg: Split has_beep in
Message-Id: <20110427152311.613d64ca@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1303393458-4001-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1303393458-4001-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 21 Apr 2011 15:44:17 +0200, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hwmon/f71882fg.c |   28 +++++++++++++++++++++-------
>  1 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index ca07a32..16330db 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -149,7 +149,7 @@ static const char f71882fg_has_in1_alarm[] = {
>  	[f81865f]	= 1,
>  };
>  
> -static const char f71882fg_has_beep[] = {
> +static const char f71882fg_fan_has_beep[] = {
>  	[f71808e]	= 0,
>  	[f71858fg]	= 0,
>  	[f71862fg]	= 1,
> @@ -175,6 +175,19 @@ static const char f71882fg_nr_fans[] = {
>  	[f81865f]	= 2,
>  };
>  
> +static const char f71882fg_temp_has_beep[] = {
> +	[f71808e]	= 0,
> +	[f71858fg]	= 0,
> +	[f71862fg]	= 1,
> +	[f71869]	= 1,
> +	[f71882fg]	= 1,
> +	[f71889fg]	= 1,
> +	[f71889ed]	= 1,
> +	[f71889a]	= 1,
> +	[f8000]		= 0,
> +	[f81865f]	= 1,
> +};
> +

This looks good. At first I was a little worried about the memory space
taken by these definitions, as most of it is unused, but on second
thought it's probably not worth optimizing, as this is a marginal
amount of memory compared to the rest of the driver.

So, patch applied.

>  static const char f71882fg_nr_temps[] = {
>  	[f71808e]	= 2,
>  	[f71858fg]	= 3,
> @@ -1146,12 +1159,13 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
>  			data->temp_type[3] = (reg & 0x08) ? 2 : 4;
>  		}
>  
> -		if (f71882fg_has_beep[data->type]) {
> +		if (f71882fg_fan_has_beep[data->type])
>  			data->fan_beep = f71882fg_read8(data,
>  						F71882FG_REG_FAN_BEEP);
> +
> +		if (f71882fg_temp_has_beep[data->type])
>  			data->temp_beep = f71882fg_read8(data,
>  						F71882FG_REG_TEMP_BEEP);
> -		}
>  
>  		data->pwm_enable = f71882fg_read8(data,
>  						  F71882FG_REG_PWM_ENABLE);
> @@ -2140,7 +2154,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
>  		if (err)
>  			goto exit_unregister_sysfs;
>  
> -		if (f71882fg_has_beep[data->type]) {
> +		if (f71882fg_temp_has_beep[data->type]) {
>  			err = f71882fg_create_sysfs_files(pdev,
>  					&fxxxx_temp_beep_attr[0][0],
>  					ARRAY_SIZE(fxxxx_temp_beep_attr[0])
> @@ -2221,7 +2235,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
>  		if (err)
>  			goto exit_unregister_sysfs;
>  
> -		if (f71882fg_has_beep[data->type]) {
> +		if (f71882fg_fan_has_beep[data->type]) {
>  			err = f71882fg_create_sysfs_files(pdev,
>  					fxxxx_fan_beep_attr, nr_fans);
>  			if (err)
> @@ -2343,7 +2357,7 @@ static int f71882fg_remove(struct platform_device *pdev)
>  				&fxxxx_temp_attr[0][0],
>  				ARRAY_SIZE(fxxxx_temp_attr[0]) * nr_temps);
>  		}
> -		if (f71882fg_has_beep[data->type]) {
> +		if (f71882fg_temp_has_beep[data->type]) {
>  			f71882fg_remove_sysfs_files(pdev,
>  			       &fxxxx_temp_beep_attr[0][0],
>  			       ARRAY_SIZE(fxxxx_temp_beep_attr[0]) * nr_temps);
> @@ -2366,7 +2380,7 @@ static int f71882fg_remove(struct platform_device *pdev)
>  		f71882fg_remove_sysfs_files(pdev, &fxxxx_fan_attr[0][0],
>  				ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);
>  
> -		if (f71882fg_has_beep[data->type]) {
> +		if (f71882fg_fan_has_beep[data->type]) {
>  			f71882fg_remove_sysfs_files(pdev,
>  					fxxxx_fan_beep_attr, nr_fans);
>  		}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
