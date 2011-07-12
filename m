From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jul 2011 07:00:16 +0000
Subject: Re: [lm-sensors] [PATCH] pmbus: Use long variables for register to
Message-Id: <20110712090016.6f17ab6c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310411064-16337-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310411064-16337-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 11 Jul 2011 12:04:24 -0700, Guenter Roeck wrote:
> Using integer variable types for register to data conversions can cause
> overflows especially for power calculations, which are in microwatt.
> Use long variables instead.

I have no objection, using longs for calculations certainly makes
sense, however does it really help in practice? I thought that
sizeof(int) = sizeof(long) for all architectures on Linux?

> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Either way:

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
>  drivers/hwmon/pmbus_core.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
> index 744672c..8e31a8e 100644
> --- a/drivers/hwmon/pmbus_core.c
> +++ b/drivers/hwmon/pmbus_core.c
> @@ -362,8 +362,8 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
>   * Convert linear sensor values to milli- or micro-units
>   * depending on sensor type.
>   */
> -static int pmbus_reg2data_linear(struct pmbus_data *data,
> -				 struct pmbus_sensor *sensor)
> +static long pmbus_reg2data_linear(struct pmbus_data *data,
> +				  struct pmbus_sensor *sensor)
>  {
>  	s16 exponent;
>  	s32 mantissa;
> @@ -397,15 +397,15 @@ static int pmbus_reg2data_linear(struct pmbus_data *data,
>  	else
>  		val >>= -exponent;
>  
> -	return (int)val;
> +	return val;
>  }
>  
>  /*
>   * Convert direct sensor values to milli- or micro-units
>   * depending on sensor type.
>   */
> -static int pmbus_reg2data_direct(struct pmbus_data *data,
> -				 struct pmbus_sensor *sensor)
> +static long pmbus_reg2data_direct(struct pmbus_data *data,
> +				  struct pmbus_sensor *sensor)
>  {
>  	long val = (s16) sensor->data;
>  	long m, b, R;
> @@ -440,12 +440,12 @@ static int pmbus_reg2data_direct(struct pmbus_data *data,
>  		R++;
>  	}
>  
> -	return (int)((val - b) / m);
> +	return (val - b) / m;
>  }
>  
> -static int pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
> +static long pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
>  {
> -	int val;
> +	long val;
>  
>  	if (data->info->direct[sensor->class])
>  		val = pmbus_reg2data_direct(data, sensor);
> @@ -619,7 +619,7 @@ static int pmbus_get_boolean(struct pmbus_data *data, int index, int *val)
>  	if (!s1 && !s2)
>  		*val = !!regval;
>  	else {
> -		int v1, v2;
> +		long v1, v2;
>  		struct pmbus_sensor *sensor1, *sensor2;
>  
>  		sensor1 = &data->sensors[s1];
> @@ -661,7 +661,7 @@ static ssize_t pmbus_show_sensor(struct device *dev,
>  	if (sensor->data < 0)
>  		return sensor->data;
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", pmbus_reg2data(data, sensor));
> +	return snprintf(buf, PAGE_SIZE, "%ld\n", pmbus_reg2data(data, sensor));
>  }
>  
>  static ssize_t pmbus_set_sensor(struct device *dev,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
