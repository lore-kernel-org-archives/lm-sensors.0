From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Feb 2012 12:46:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Remove duplicate code
Message-Id: <20120207134615.300951a1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328611129-6385-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1328611129-6385-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 7 Feb 2012 02:38:49 -0800, Guenter Roeck wrote:
> Commit ec3e5a16446fef1891611fe3bdfa5954d1ddf5e4 slipped in some duplicate code.
> Remove it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/w83627ehf.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index 4d383e7..5276d19 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -2354,11 +2354,6 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  	for (i = 0; i < data->pwm_num; i++)
>  		data->pwm_enable_orig[i] = data->pwm_enable[i];
>  
> -	/* Read pwm data to save original values */
> -	w83627ehf_update_pwm_common(dev, data);
> -	for (i = 0; i < data->pwm_num; i++)
> -		data->pwm_enable_orig[i] = data->pwm_enable[i];
> -
>  	/* Register sysfs hooks */
>  	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++) {
>  		err = device_create_file(dev, &sda_sf3_arrays[i].dev_attr);

Good catch.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
