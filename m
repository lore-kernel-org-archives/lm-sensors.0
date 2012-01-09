From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jan 2012 17:01:02 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] sensors: Use defines for array sizes
Message-Id: <20120109180102.764cec13@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326068484-1898-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326068484-1898-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  8 Jan 2012 16:21:23 -0800, Guenter Roeck wrote:
> Use defines for array sizes. For alarm attributes, take into account that both
> the generic alarm flag as well as individual alarm attributes may be provided
> by a driver (even though that should not be the case).
> 
> Remove overflow checks from get_sensor_limit_data(), as overflows should
> no longer happen.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  prog/sensors/chips.c |   82 +++++++++++++++++++++++++-------------------------
>  1 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/prog/sensors/chips.c b/prog/sensors/chips.c
> index d1d2a17..36264a8 100644
> --- a/prog/sensors/chips.c
> +++ b/prog/sensors/chips.c
> (...)
> @@ -517,14 +511,21 @@ static const struct sensor_subfeature_list power_avg_sensors[] = {
>  	{ -1, NULL, 0, NULL }
>  };
>  
> +#define MAX(a, b) ((a) > (b) ? : (b))

This doesn't do what you want. You can't use the short form of ?: here.

> +#define NUM_POWER_ALARMS	4
> +#define NUM_POWER_SENSORS	(ARRAY_SIZE(power_common_sensors) \
> +				 + MAX(ARRAY_SIZE(power_inst_sensors), \
> +				       ARRAY_SIZE(power_avg_sensors)) \
> +				 - NUM_POWER_ALARMS - 2)

According to our parallel discussion about instant+average power
sensors, this can be simplified (ARRAY_SIZE(power_inst_sensors) will
always be greater than ARRAY_SIZE(power_avg_sensors) by design.)

Other than this, changes look OK, feel free to commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
