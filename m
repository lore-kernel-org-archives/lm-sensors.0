From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Feb 2011 17:49:17 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (lm85) Use macro to
Message-Id: <20110225184917.14d921aa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298654487-30232-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1298654487-30232-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 25 Feb 2011 09:21:24 -0800, Guenter Roeck wrote:
> ADT7463 and ADT7468 optionally support VID5 instead of the standard +12V
> measurement input. Use a macro to detect configuration instead of hardcoding it
> several times.

While avoiding repeating code is certainly a good idea, macros also
have the bad side effect of hiding the complexity (and binary code
side.) While I wouldn't mind too much if it only affected
initialization paths, I do mind when it affects run-time paths
(show_vid_reg and lm85_update_device even more so.)

I would suggest a more efficient strategy. Add an "has_vid5" member to
the data structure, set it at initialization time, and use it
everywhere it is needed. As the value isn't suppose to change over
time, it will preserve the current behavior, avoid the code duplication
as you desire, and will make the driver faster. What do you think?

> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm85.c |   19 ++++++++-----------
>  1 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index d2cc286..12edd5f 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -124,6 +124,9 @@ enum chips {
>  #define	EMC6D102_REG_EXTEND_ADC3	0x87
>  #define	EMC6D102_REG_EXTEND_ADC4	0x88
>  
> +#define	vid5_configured(data)		(((data)->type = adt7463 || \
> +					  (data)->type = adt7468) && \
> +					  ((data)->vid & 0x80))
>  
>  /* Conversions. Rounding and limit checking is only done on the TO_REG
>     variants. Note that you should be a bit careful with which arguments
> @@ -420,8 +423,7 @@ static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
>  	struct lm85_data *data = lm85_update_device(dev);
>  	int vid;
>  
> -	if ((data->type = adt7463 || data->type = adt7468) &&
> -	    (data->vid & 0x80)) {
> +	if (vid5_configured(data)) {
>  		/* 6-pin VID (VRM 10) */
>  		vid = vid_from_reg(data->vid & 0x3f, data->vrm);
>  	} else {
> @@ -1322,8 +1324,7 @@ static int lm85_probe(struct i2c_client *client,
>  	/* The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
>  	   as a sixth digital VID input rather than an analog input. */
>  	data->vid = lm85_read_value(client, LM85_REG_VID);
> -	if (!((data->type = adt7463 || data->type = adt7468) &&
> -	    (data->vid & 0x80)))
> +	if (!vid5_configured(data))

Ideally, the LM85_REG_VID register would only be read on the chips
which need the value. For the other ones, it's only slowing down the
driver loading with no benefit.

>  		if ((err = sysfs_create_group(&client->dev.kobj,
>  					&lm85_group_in4)))
>  			goto err_remove_files;
> @@ -1457,11 +1458,8 @@ static struct lm85_data *lm85_update_device(struct device *dev)
>  			    lm85_read_value(client, LM85_REG_FAN(i));
>  		}
>  
> -		if (!((data->type = adt7463 || data->type = adt7468) &&
> -		    (data->vid & 0x80))) {
> -			data->in[4] = lm85_read_value(client,
> -				      LM85_REG_IN(4));
> -		}
> +		if (!vid5_configured(data))
> +			data->in[4] = lm85_read_value(client, LM85_REG_IN(4));
>  
>  		if (data->type = adt7468)
>  			data->cfg5 = lm85_read_value(client, ADT7468_REG_CFG5);
> @@ -1528,8 +1526,7 @@ static struct lm85_data *lm85_update_device(struct device *dev)
>  			    lm85_read_value(client, LM85_REG_FAN_MIN(i));
>  		}
>  
> -		if (!((data->type = adt7463 || data->type = adt7468) &&
> -		    (data->vid & 0x80))) {
> +		if (!vid5_configured(data))  {
>  			data->in_min[4] = lm85_read_value(client,
>  					  LM85_REG_IN_MIN(4));
>  			data->in_max[4] = lm85_read_value(client,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
