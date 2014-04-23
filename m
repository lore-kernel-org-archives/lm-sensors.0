From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 23 Apr 2014 07:48:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc2945) Don't crash the kernel unnecessarily
Message-Id: <20140423094812.37a33d54@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1398102121-24822-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1398102121-24822-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 21 Apr 2014 10:42:01 -0700, Guenter Roeck wrote:
> An implementation error should not crash the kernel if it is avoidable.
> Replace BUG() with WARN_ONCE().
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/ltc2945.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> index c104cc3..c9cddf5 100644
> --- a/drivers/hwmon/ltc2945.c
> +++ b/drivers/hwmon/ltc2945.c
> @@ -1,4 +1,4 @@
> -/*
> +    /*
>   * Driver for Linear Technology LTC2945 I2C Power Monitor
>   *
>   * Copyright (c) 2014 Guenter Roeck
> @@ -314,8 +314,8 @@ static ssize_t ltc2945_reset_history(struct device *dev,
>  		reg = LTC2945_MAX_ADIN_H;
>  		break;
>  	default:
> -		BUG();
> -		break;
> +		WARN_ONCE(1, "Bad register: 0x%x\n", reg);
> +		return -EINVAL;
>  	}
>  	/* Reset maximum */
>  	ret = regmap_bulk_write(regmap, reg, buf_max, num_regs);

Agreed. -EINVAL may be confusing though, as this normally means the
user input was invalid (which isn't the case here.) Maybe we can come
up with a better error code. Maybe -EFAULT? Or be original and use
-EBADSLT? ;)

It's purely theoretical anyway, as we both know that this piece of code
is never going to be executed. TBH if it was me I would just drop this
test altogether. But anyway:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
