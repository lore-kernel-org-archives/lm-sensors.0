From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 23 Feb 2014 16:21:21 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (max6639) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140223172121.0d1b15ae@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393031014-26259-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393031014-26259-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 21 Feb 2014 17:03:34 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach sysfs attricutes to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/max6639.c |   81 +++++++++++++++--------------------------------
>  1 file changed, 26 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 52646bb..e4852bb 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> (...)
> @@ -424,9 +417,9 @@ static int rpm_range_to_reg(int range)
>  	return 1; /* default: 4000 RPM */
>  }
>  
> -static int max6639_init_client(struct i2c_client *client)
> +static int max6639_init_client(struct max6639_data *data,
> +			       struct i2c_client *client)

As in a previous review, I'd suggest keeping client as the first
parameter of this function.

All other changes look good, nice cleanup.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
