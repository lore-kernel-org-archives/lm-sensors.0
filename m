From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Feb 2011 17:57:54 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/4] hwmon: (lm85) Do not update
Message-Id: <20110225185754.6cd6069f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298654487-30232-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1298654487-30232-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 25 Feb 2011 09:21:26 -0800, Guenter Roeck wrote:
> So far, the driver updates temp_auto_hyst and temp_auto_off if temp_auto_min changes.
> This may cause problems if temp_auto_off was not configured before configuring
> temp_auto_min, because one of the variables used (off_desired) is not initialized
> in this case.
> 
> To simplify the code, and for consistency with other drivers, no longer update the delta
> between "min" and "off" until the user sets the "off" value again.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm85.c |   12 ------------
>  1 files changed, 0 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index 1a9540a..a2fcf67 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -936,18 +936,6 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
>  		((data->zone[nr].range & 0x0f) << 4)
>  		| (data->pwm_freq[nr] & 0x07));
>  
> -/* Update temp_auto_hyst and temp_auto_off */
> -	data->zone[nr].hyst = HYST_TO_REG(TEMP_FROM_REG(
> -		data->zone[nr].limit) - TEMP_FROM_REG(
> -		data->zone[nr].off_desired));
> -	if (nr = 0 || nr = 1) {
> -		lm85_write_value(client, LM85_REG_AFAN_HYST1,
> -			(data->zone[0].hyst << 4)
> -			| data->zone[1].hyst);
> -	} else {
> -		lm85_write_value(client, LM85_REG_AFAN_HYST2,
> -			(data->zone[2].hyst << 4));
> -	}
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }

Your patch is incomplete: you can now get rid of lm85_zone.off_desired
altogether.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
