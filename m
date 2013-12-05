From: roger <roger@hiddenengine.co.uk>
Date: Thu, 05 Dec 2013 11:07:51 +0000
Subject: Re: [lm-sensors] =?utf-8?q?=5Bpatch=5D_hwmon=3A_prevent_some_divide_b?=
Message-Id: <db3f06d585a4dea3efe200f9e2f5fca6@mailserver.hiddenengine.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On , Dan Carpenter wrote:
> It's not enough to just test if "rpm" is zero, the "rpm * div" 
> operation
> could overflow and that could also lead to a divide by zero.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
> index 0e7017841f7d..923c18034a5f 100644
> --- a/drivers/hwmon/vt8231.c
> +++ b/drivers/hwmon/vt8231.c
> @@ -145,7 +145,7 @@ static const u8 regtempmin[] = { 0x3a, 0x3e, 0x2c,
> 0x2e, 0x30, 0x32 };
>   */
>  static inline u8 FAN_TO_REG(long rpm, int div)
>  {
> -	if (rpm = 0)
> +	if (rpm * div = 0)
>  		return 0;
>  	return clamp_val(1310720 / (rpm * div), 1, 255);
>  }

Seems a reasonable improvement to me, so ACK'd.

> diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
> index 6cf6bff79003..fc4578195674 100644
SNIP
>  		return 255;
>  	return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
>  }


- Roger

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
