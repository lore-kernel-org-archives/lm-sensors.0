From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 26 Feb 2015 10:11:59 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/5] hwmon: (it87) Don't configure 16 bit fan counters it not necessary
Message-Id: <20150226111159.482d22c4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424884581-2348-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1424884581-2348-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Feb 2015 09:16:17 -0800, Guenter Roeck wrote:
> On IT8728F, IT8771E, and IT8772E, fans counters are always 16 bit
> and don't need to be configured for it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Separated changed functionality from 'Add feature flags' patch.
> 
>  drivers/hwmon/it87.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index ed25e4b..e8cbefb 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -2463,9 +2463,12 @@ static void it87_init_device(struct platform_device *pdev)
>  	}
>  	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
>  
> -	/* Set tachometers to 16-bit mode if needed, IT8603E (and IT8728F?)
> -	 * has it by default */
> -	if (has_16bit_fans(data) && data->type != it8603) {
> +	/*
> +	 * Set tachometers to 16-bit mode if needed. IT8603E, IT8728F,
> +	 * IT8771E (guesswork), and IT8772E have it by default.
> +	 */
> +	if (has_16bit_fans(data) && data->type != it8603 && data->type != it8728
> +	    && data->type != it8771 && data->type != it8772) {
>  		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
>  		if (~tmp & 0x07 & data->has_fan) {
>  			dev_dbg(&pdev->dev,

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
