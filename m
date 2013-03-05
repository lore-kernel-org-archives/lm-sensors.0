From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Mar 2013 14:34:35 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (pmbus/ltc2978) Fix temperature reporting
Message-Id: <20130305143435.GA15897@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362069993-9530-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1362069993-9530-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 28, 2013 at 08:46:30AM -0800, Guenter Roeck wrote:
> On LTC2978, only READ_TEMPERATURE is supported. It reports
> the internal junction temperature. This register is unpaged.
> 
> On LTC3880, READ_TEMPERATURE and READ_TEMPERATURE2 are supported.
> READ_TEMPERATURE is paged and reports external temperatures.
> READ_TEMPERATURE2 is unpaged and reports the internal junction
> temperature.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Hi Jean,

I know I take way too much of your time, but do you have any
feedback on this one ? 

Thanks,
Guenter

> ---
> Candidate for -stable.
> 
> v3: Reduce to strictly fixes only
> 
> v2: v1 converted temp2_max from an array to a scalar.
>     This is now done in an earlier patch.
> 
>  drivers/hwmon/pmbus/ltc2978.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index a58de38..6d61307 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -59,7 +59,7 @@ enum chips { ltc2978, ltc3880 };
>  struct ltc2978_data {
>  	enum chips id;
>  	int vin_min, vin_max;
> -	int temp_min, temp_max;
> +	int temp_min, temp_max[2];
>  	int vout_min[8], vout_max[8];
>  	int iout_max[2];
>  	int temp2_max;
> @@ -113,9 +113,10 @@ static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
>  		ret = pmbus_read_word_data(client, page,
>  					   LTC2978_MFR_TEMPERATURE_PEAK);
>  		if (ret >= 0) {
> -			if (lin11_to_val(ret) > lin11_to_val(data->temp_max))
> -				data->temp_max = ret;
> -			ret = data->temp_max;
> +			if (lin11_to_val(ret)
> +			    > lin11_to_val(data->temp_max[page]))
> +				data->temp_max[page] = ret;
> +			ret = data->temp_max[page];
>  		}
>  		break;
>  	case PMBUS_VIRT_RESET_VOUT_HISTORY:
> @@ -266,7 +267,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
>  		break;
>  	case PMBUS_VIRT_RESET_TEMP_HISTORY:
>  		data->temp_min = 0x7bff;
> -		data->temp_max = 0x7c00;
> +		data->temp_max[page] = 0x7c00;
>  		ret = ltc2978_clear_peaks(client, page, data->id);
>  		break;
>  	default:
> @@ -323,7 +324,8 @@ static int ltc2978_probe(struct i2c_client *client,
>  	data->vin_min = 0x7bff;
>  	data->vin_max = 0x7c00;
>  	data->temp_min = 0x7bff;
> -	data->temp_max = 0x7c00;
> +	for (i = 0; i < ARRAY_SIZE(data->temp_max); i++)
> +		data->temp_max[i] = 0x7c00;
>  	data->temp2_max = 0x7c00;
>  
>  	switch (data->id) {
> -- 
> 1.7.9.7
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
