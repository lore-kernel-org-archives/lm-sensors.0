From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 Mar 2011 20:47:52 +0000
Subject: Re: [lm-sensors] [PATCH] sensors: Skip limit slots to align
Message-Id: <1300308472.20292.103.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110316212102.2ef183f0@endymion.delvare>
In-Reply-To: <20110316212102.2ef183f0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-03-16 at 16:21 -0400, Jean Delvare wrote:
> Ensure that hysteresis and the limit it relates to are always
> printed on the same line.
> ---
> Guenter, this is what I had in mind. Makes the code slightly more
> complex, but the result seems worth it. What do you think?
> 
Looks a bit kludgy to me, but it works, and at least right now I have no
idea how to make it better. So go ahead.

Guenter

>  prog/sensors/chips.c |   31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> --- lm-sensors.orig/prog/sensors/chips.c	2011-03-16 21:06:28.000000000 +0100
> +++ lm-sensors/prog/sensors/chips.c	2011-03-16 21:07:49.000000000 +0100
> @@ -67,6 +67,8 @@ void print_chip_raw(const sensors_chip_n
>  	}
>  }
>  
> +static const char hyst_str[] = "hyst";
> +
>  static inline double deg_ctof(double cel)
>  {
>  	return cel * (9.0F / 5.0F) + 32.0F;
> @@ -154,12 +156,17 @@ static void print_limits(struct sensor_s
>  			 int alarm_count, int label_size,
>  			 const char *fmt)
>  {
> -	int i;
> +	int i, slot, skip;
>  	int alarms_printed = 0;
>  
> -	for (i = 0; i < limit_count; i++) {
> -		if (!(i & 1)) {
> -			if (i)
> +	/*
> +	 * We print limits on two columns, filling lines first, except for
> +	 * hysteresis which must always go on the right column, with the
> +	 * limit it relates to being in the left column on the same line.
> +	 */
> +	for (i = slot = 0; i < limit_count; i++, slot++) {
> +		if (!(slot & 1)) {
> +			if (slot)
>  				printf("\n%*s", label_size + 10, "");
>  			printf("(");
>  		} else {
> @@ -167,14 +174,20 @@ static void print_limits(struct sensor_s
>  		}
>  		printf(fmt, limits[i].name, limits[i].value,
>  			     limits[i].unit);
> -		if ((i & 1) || i = limit_count - 1) {
> +
> +		/* If needed, skip one slot to avoid hyst on first column */
> +		skip = i + 2 < limit_count && limits[i + 2].name = hyst_str &&
> +		       !(slot & 1);
> +
> +		if (((slot + skip) & 1) || i = limit_count - 1) {
>  			printf(")");
>  			if (alarm_count && !alarms_printed) {
>  				print_alarms(alarms, alarm_count,
> -					     (i & 1) ? 0 : 16);
> +					     (slot & 1) ? 0 : 16);
>  				alarms_printed = 1;
>  			}
>  		}
> +		slot += skip;
>  	}
>  	if (alarm_count && !alarms_printed)
>  		print_alarms(alarms, alarm_count, 32);
> @@ -239,18 +252,18 @@ static void get_sensor_limit_data(const
>  }
>  
>  static const struct sensor_subfeature_list temp_max_sensors[] = {
> -	{ SENSORS_SUBFEATURE_TEMP_MAX_HYST, NULL, 0, "hyst" },
> +	{ SENSORS_SUBFEATURE_TEMP_MAX_HYST, NULL, 0, hyst_str },
>  	{ -1, NULL, 0, NULL }
>  };
>  
>  static const struct sensor_subfeature_list temp_crit_sensors[] = {
> -	{ SENSORS_SUBFEATURE_TEMP_CRIT_HYST, NULL, 0, "crit hyst" },
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT_HYST, NULL, 0, hyst_str },
>  	{ -1, NULL, 0, NULL }
>  };
>  
>  static const struct sensor_subfeature_list temp_emergency_sensors[] = {
>  	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST, NULL, 0,
> -	    "emerg hyst" },
> +	    hyst_str },
>  	{ -1, NULL, 0, NULL }
>  };
>  
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
