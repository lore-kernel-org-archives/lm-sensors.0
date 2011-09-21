From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 21 Sep 2011 17:36:09 +0000
Subject: Re: [lm-sensors] [PATCH] Bugfix for ds620.c (sign error)
Message-Id: <1316626569.4630.32.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316622960-13167-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1316622960-13167-1-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-09-21 at 13:06 -0400, Roland Stigge wrote:
> Bugfix for ds620.c: Signed temperatures were not handled appropriately
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> 
> diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
> index 257957c..4f7c3fc 100644
> --- a/drivers/hwmon/ds620.c
> +++ b/drivers/hwmon/ds620.c
> @@ -72,7 +72,7 @@ struct ds620_data {
>  	char valid;		/* !=0 if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
> -	u16 temp[3];		/* Register values, word */
> +	s16 temp[3];		/* Register values, word */
>  };
>  
Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
