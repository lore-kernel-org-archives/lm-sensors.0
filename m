From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 22 Jan 2012 17:52:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83795) Unconditionally support manual fan speed control
Message-Id: <20120122175210.GA12059@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120122183613.4ba050f6@endymion.delvare>
In-Reply-To: <20120122183613.4ba050f6@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, Jan 22, 2012 at 12:36:13PM -0500, Jean Delvare wrote:
> Manual fan speed control uses a standard interface and has received
> sufficient testing and review by now, it can be enabled
> unconditionally. This includes attributes pwm[1-8], pwm[1-8]_enable,
> pwm[1-8]_mode and pwm[1-8]_freq.
> 
> We only let the user switch from automatic mode to manual mode, but
> not the other way around, as automatic control settings may not have
> been set properly by the BIOS.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/Kconfig  |    9 +++++----
>  drivers/hwmon/w83795.c |   26 ++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> --- linux-3.2.orig/drivers/hwmon/w83795.c	2011-07-22 04:17:23.000000000 +0200
> +++ linux-3.2/drivers/hwmon/w83795.c	2012-01-22 14:50:25.309726525 +0100
> @@ -929,6 +929,14 @@ store_pwm_enable(struct device *dev, str
>  	if (val < 1 || val > 2)
>  		return -EINVAL;
>  
> +#ifndef CONFIG_SENSORS_W83795_FANCTRL
> +	if (val > 1) {
> +		dev_warn(dev, "Automatic fan speed control support disabled\n");
> +		dev_warn(dev, "Build with CONFIG_SENSORS_W83795_FANCTRL=y if you want it\n");
> +		return -EOPNOTSUPP;
> +	}
> +#endif
> +
>  	mutex_lock(&data->update_lock);
>  	switch (val) {
>  	case 1:
> @@ -1625,18 +1633,18 @@ store_sf_setup(struct device *dev, struc
>  #define SENSOR_ATTR_PWM(index) {					\
>  	SENSOR_ATTR_2(pwm##index, S_IWUSR | S_IRUGO, show_pwm,		\
>  		store_pwm, PWM_OUTPUT, index - 1),			\
> +	SENSOR_ATTR_2(pwm##index##_enable, S_IWUSR | S_IRUGO,		\
> +		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1), \
> +	SENSOR_ATTR_2(pwm##index##_mode, S_IRUGO,			\
> +		show_pwm_mode, NULL, NOT_USED, index - 1),		\
> +	SENSOR_ATTR_2(pwm##index##_freq, S_IWUSR | S_IRUGO,		\
> +		show_pwm, store_pwm, PWM_FREQ, index - 1),		\
>  	SENSOR_ATTR_2(pwm##index##_nonstop, S_IWUSR | S_IRUGO,		\
>  		show_pwm, store_pwm, PWM_NONSTOP, index - 1),		\
>  	SENSOR_ATTR_2(pwm##index##_start, S_IWUSR | S_IRUGO,		\
>  		show_pwm, store_pwm, PWM_START, index - 1),		\
>  	SENSOR_ATTR_2(pwm##index##_stop_time, S_IWUSR | S_IRUGO,	\
>  		show_pwm, store_pwm, PWM_STOP_TIME, index - 1),	 \
> -	SENSOR_ATTR_2(pwm##index##_freq, S_IWUSR | S_IRUGO,	\
> -		show_pwm, store_pwm, PWM_FREQ, index - 1),	 \
> -	SENSOR_ATTR_2(pwm##index##_enable, S_IWUSR | S_IRUGO,		\
> -		show_pwm_enable, store_pwm_enable, NOT_USED, index - 1), \
> -	SENSOR_ATTR_2(pwm##index##_mode, S_IRUGO,			\
> -		show_pwm_mode, NULL, NOT_USED, index - 1),		\
>  	SENSOR_ATTR_2(fan##index##_target, S_IWUSR | S_IRUGO, \
>  		show_fanin, store_fanin, FANIN_TARGET, index - 1) }
>  
> @@ -2006,15 +2014,17 @@ static int w83795_handle_files(struct de
>  		}
>  	}
>  
> -#ifdef CONFIG_SENSORS_W83795_FANCTRL
>  	for (i = 0; i < data->has_pwm; i++) {
> +#ifdef CONFIG_SENSORS_W83795_FANCTRL
>  		for (j = 0; j < ARRAY_SIZE(w83795_pwm[0]); j++) {
> +#else
> +		for (j = 0; j < 4; j++) {
> +#endif

In situations like this I came to prefer something like

#ifdef CONFIG_SENSORS_W83795_FANCTRL
#define NUM_PWM_ATTRIBUTES	ARRAY_SIZE(w83795_pwm[0])
#else
#define NUM_PWM_ATTRIBUTES	4
#endif
...
		for (j = 0; j < NUM_PWM_ATTRIBUTES; j++)

to avoid the ifdef in the code, especially in situations like this where opening
and closing brackets no longer match due to the ifdef.

Other than that,

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

I guess this should be independent of the multiline comment patch I sent out earlier.
Would be good, though, if both are in the same tree. Do you want me to take both patches,
or do you want to take them ? Let me know.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
