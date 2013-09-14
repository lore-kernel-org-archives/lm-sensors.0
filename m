From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Sep 2013 11:03:55 +0000
Subject: Re: [lm-sensors] [PATCH 10/12] hwmon: (atxp1) Set and use error code from vid_to_reg()
Message-Id: <20130914130355.36181c53@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379147615-7703-11-git-send-email-linux@roeck-us.net>
In-Reply-To: <1379147615-7703-11-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 14 Sep 2013 01:33:33 -0700, Guenter Roeck wrote:
> vid_to_reg() returns -1 if it encounters an error. Return -EINVAL instead.
> Its only caller, atxp1_storevcore(), doesn't use the return code but
> returns -1 instead, which is wrong anyway as it means -EPERM.
> Use the return value from vid_to_reg() instead to report the error.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/atxp1.c     |    3 +--
>  include/linux/hwmon-vid.h |    2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
> index aecb9ea..ddff02e 100644
> --- a/drivers/hwmon/atxp1.c
> +++ b/drivers/hwmon/atxp1.c
> @@ -147,10 +147,9 @@ static ssize_t atxp1_storevcore(struct device *dev,
>  
>  	/* Calculate VID */
>  	vid = vid_to_reg(vcore, data->vrm);
> -
>  	if (vid < 0) {
>  		dev_err(dev, "VID calculation failed.\n");
> -		return -1;
> +		return vid;
>  	}
>  
>  	/*
> diff --git a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
> index f346e4d..da0a680 100644
> --- a/include/linux/hwmon-vid.h
> +++ b/include/linux/hwmon-vid.h
> @@ -38,7 +38,7 @@ static inline int vid_to_reg(int val, u8 vrm)
>  		return ((val >= 1100) && (val <= 1850) ?
>  			((18499 - val * 10) / 25 + 5) / 10 : -1);
>  	default:
> -		return -1;
> +		return -EINVAL;
>  	}
>  }
>  

Good catch.

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
