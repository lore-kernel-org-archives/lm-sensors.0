From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Mar 2012 12:45:17 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (adm1031) Fix compiler warning
Message-Id: <20120328144517.2261c0cf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332856040-30071-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1332856040-30071-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Mar 2012 06:47:20 -0700, Guenter Roeck wrote:
> Some configurations produce the following compile warning:
> 
> drivers/hwmon/adm1031.c: In function 'set_fan_auto_channel':
> drivers/hwmon/adm1031.c:292: warning: 'reg' may be used uninitialized in this function
> 
> While this is a false positive, it can easily be fixed by overloading the return
> value from get_fan_auto_nearest with both register value and error return code
> (the register value is never negative). Coincidentially, that also reduces
> module size by a few bytes.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Don't assign a negative value to an u8 variable.
>     [ And I have no idea why the compiler did not complain about that one :( ]
> 
>  drivers/hwmon/adm1031.c |   20 ++++++++------------
>  1 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index ff37363..44e1fd7 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -233,18 +233,15 @@ static const auto_chan_table_t auto_channel_select_table_adm1030 = {
>   * nearest match if no exact match where found.
>   */
>  static int
> -get_fan_auto_nearest(struct adm1031_data *data,
> -		     int chan, u8 val, u8 reg, u8 *new_reg)
> +get_fan_auto_nearest(struct adm1031_data *data, int chan, u8 val, u8 reg)
>  {
>  	int i;
>  	int first_match = -1, exact_match = -1;
>  	u8 other_reg_val >  	    (*data->chan_select_table)[FAN_CHAN_FROM_REG(reg)][chan ? 0 : 1];
>  
> -	if (val = 0) {
> -		*new_reg = 0;
> +	if (val = 0)
>  		return 0;
> -	}
>  
>  	for (i = 0; i < 8; i++) {
>  		if ((val = (*data->chan_select_table)[i][chan]) &&
> @@ -264,13 +261,11 @@ get_fan_auto_nearest(struct adm1031_data *data,
>  	}
>  
>  	if (exact_match >= 0)
> -		*new_reg = exact_match;
> +		return exact_match;
>  	else if (first_match >= 0)
> -		*new_reg = first_match;
> -	else
> -		return -EINVAL;
> +		return first_match;
>  
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  static ssize_t show_fan_auto_channel(struct device *dev,
> @@ -301,11 +296,12 @@ set_fan_auto_channel(struct device *dev, struct device_attribute *attr,
>  
>  	mutex_lock(&data->update_lock);
>  
> -	ret = get_fan_auto_nearest(data, nr, val, data->conf1, &reg);
> -	if (ret) {
> +	ret = get_fan_auto_nearest(data, nr, val, data->conf1);
> +	if (ret < 0) {
>  		mutex_unlock(&data->update_lock);
>  		return ret;
>  	}
> +	reg = ret;
>  	data->conf1 = FAN_CHAN_TO_REG(reg, data->conf1);
>  	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) ^
>  	    (old_fan_mode & ADM1031_CONF1_AUTO_MODE)) {

Looks good this time.

Acked-by: Jean Delvare <khali@linux-fr.org>


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
