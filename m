From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Feb 2013 10:12:20 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/7] hwmon: (pmbus/ltc2978) Fix temperature reporting
Message-Id: <20130227111220.3c6d281f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130226233606.GA17484@roeck-us.net>
In-Reply-To: <20130226233606.GA17484@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Feb 2013 15:36:06 -0800, Guenter Roeck wrote:
> On LTC2978, only READ_TEMPERATURE is supported. It reports
> the internal junction temperature. This register is unpaged.
> 
> On LTC3880, READ_TEMPERATURE and READ_TEMPERATURE2 are supported.
> READ_TEMPERATURE is paged and reports external temperatures.
> READ_TEMPERATURE2 is unpaged and reports the internal junction
> temperature.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Candidate for -stable.
> 
> v2: v1 converted temp2_max from an array to a scalar.
>     This is now done in an earlier patch. 
> 
>  drivers/hwmon/pmbus/ltc2978.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index a58de38..a729c1c 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -59,7 +59,7 @@ enum chips { ltc2978, ltc3880 };
>  struct ltc2978_data {
>  	enum chips id;
>  	int vin_min, vin_max;
> -	int temp_min, temp_max;
> +	int temp_min, temp_max[8];

I'm confused. LTC2978 only has 1 temperature, LTC3880 has 3, so why
have room for 8? I'm not even sure you need 2, as I suspect LTC3880's
TEMP2 doesn't actually support peak recording, so 2 should be enough?

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
> @@ -323,7 +324,6 @@ static int ltc2978_probe(struct i2c_client *client,
>  	data->vin_min = 0x7bff;
>  	data->vin_max = 0x7c00;
>  	data->temp_min = 0x7bff;
> -	data->temp_max = 0x7c00;
>  	data->temp2_max = 0x7c00;
>  
>  	switch (data->id) {
> @@ -357,8 +357,10 @@ static int ltc2978_probe(struct i2c_client *client,
>  	default:
>  		return -ENODEV;
>  	}
> -	for (i = 0; i < info->pages; i++)
> +	for (i = 0; i < info->pages; i++) {
> +		data->temp_max[i] = 0x7c00;

I would leave the initialization of data->temp_max[0] where it was
originally  and initialize data->temp_max[1] in the "case ltc3880"
section above.

I have yet to read the next patches in the series, but in general using
info->pages as the upper bound for this initialization loop seems a
little dangerous and inappropriate if you want to initialize several
unrelated arrays there. It might be less bother to initialize every
array using its ARRAY_SIZE upfront. Remember that probe() is only
called once, so we don't care about optimizing every bit of speed out
of it. We do care about correctness and lack of array overrun though ;)
and also about the code and data structure being as small as reasonably
possible.

>  		data->vout_min[i] = 0xffff;
> +	}
>  
>  	return pmbus_do_probe(client, id, info);
>  }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
