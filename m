From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 21 Sep 2011 16:54:56 +0000
Subject: Re: [lm-sensors] [PATCH] Bugfix for ds620.c (sign error)
Message-Id: <1316624096.4630.31.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316622960-13167-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1316622960-13167-1-git-send-email-stigge@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roland,

On Wed, 2011-09-21 at 12:36 -0400, Roland Stigge wrote:
> Bugfix for ds620.c: Signed temperatures were not handled appropriately
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> 
> diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
> index 257957c..92e39fa 100644
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
>  /*
> @@ -169,7 +169,8 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  
> -	return sprintf(buf, "%d\n", ((data->temp[attr->index] / 8) * 625) / 10);
> +	return sprintf(buf, "%d\n",
> +			(((int)data->temp[attr->index] / 8) * 625) / 10);

since data->temp is now already signed, you do not need the typecast to
int here (conversion from s16 to int is automatic).

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
