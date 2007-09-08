From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 08 Sep 2007 13:26:15 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] hwmon/lm85: Let the user set the fan
Message-Id: <191fb4ca0709080626r7607ba10oa6df5df486322e45@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Trying to set the fan min limit to 0 currently writes 0 to the
> register, which is an invalid value. It's read back as -1 and the
> alarm flag is raised. Instead we should write 0xffff (maximum
> value), which reads back as 0 and no alarm flag is raised.
>
> Signed-off-by: Jean Delvare <khali at linux-fr.org>
> ---
>  drivers/hwmon/lm85.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> --- linux-2.6.22-rc6.orig/drivers/hwmon/lm85.c	2007-07-01 14:30:37.000000000 +0200
> +++ linux-2.6.22-rc6/drivers/hwmon/lm85.c	2007-07-01 17:00:44.000000000 +0200
> @@ -145,7 +145,12 @@ static int lm85_scaling[] = {  /* .001 V
>  #define INS_FROM_REG(n,val)	SCALE((val), 192, lm85_scaling[n])
>
>  /* FAN speed is measured using 90kHz clock */
> -#define FAN_TO_REG(val)		(SENSORS_LIMIT( (val)<=0?0: 5400000/(val),0,65534))
> +static inline u16 FAN_TO_REG(unsigned long val)
> +{
> +	if (!val)
> +		return 0xffff;
> +	return SENSORS_LIMIT(5400000 / val, 1, 0xfffe);
> +}
>  #define FAN_FROM_REG(val)	((val)=0?-1:(val)=0xffff?0:5400000/(val))
>
>  /* Temperature is reported in .001 degC increments */
> @@ -391,7 +396,7 @@ static ssize_t set_fan_min(struct device
>  	int nr = to_sensor_dev_attr(attr)->index;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm85_data *data = i2c_get_clientdata(client);
> -	long val = simple_strtol(buf, NULL, 10);
> +	unsigned long val = simple_strtoul(buf, NULL, 10);
>
>  	mutex_lock(&data->update_lock);
>  	data->fan_min[nr] = FAN_TO_REG(val);
>

Looks good.

Acked-by: Juerg Haefliger <juergh at gmail.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
