From: "Hans J. Koch" <hjk@hansjkoch.de>
Date: Mon, 16 Jan 2012 21:15:07 +0000
Subject: Re: [lm-sensors] [PATCH 23/39] hwmon: max6650: Fix checkpatch issues
Message-Id: <20120116211507.GE18638@local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326703781-14272-24-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326703781-14272-24-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 16, 2012 at 12:49:25AM -0800, Guenter Roeck wrote:
> Fixed:
> ERROR: do not use assignment in if condition
> ERROR: open brace '{' following struct go on the same line
> ERROR: spaces required around that '||' (ctx:VxV)
> ERROR: switch and case should be at the same indent
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> 
> Cc: Hans J. Koch <hjk@hansjkoch.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Hans J. Koch <hjk@hansjkoch.de>

> ---
>  drivers/hwmon/max6650.c |  113 ++++++++++++++++++++++++++---------------------
>  1 files changed, 63 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
> index 2fc034a..159ce02 100644
> --- a/drivers/hwmon/max6650.c
> +++ b/drivers/hwmon/max6650.c
> @@ -135,8 +135,7 @@ static struct i2c_driver max6650_driver = {
>   * Client data (each client gets its own)
>   */
>  
> -struct max6650_data
> -{
> +struct max6650_data {
>  	struct device *hwmon_dev;
>  	struct mutex update_lock;
>  	int nr_fans;
> @@ -238,8 +237,13 @@ static ssize_t set_target(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct max6650_data *data = i2c_get_clientdata(client);
> -	int rpm = simple_strtoul(buf, NULL, 10);
>  	int kscale, ktach;
> +	unsigned long rpm;
> +	int err;
> +
> +	err = kstrtoul(buf, 10, &rpm);
> +	if (err)
> +		return err;
>  
>  	rpm = SENSORS_LIMIT(rpm, FAN_RPM_MIN, FAN_RPM_MAX);
>  
> @@ -300,7 +304,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct max6650_data *data = i2c_get_clientdata(client);
> -	int pwm = simple_strtoul(buf, NULL, 10);
> +	unsigned long pwm;
> +	int err;
> +
> +	err = kstrtoul(buf, 10, &pwm);
> +	if (err)
> +		return err;
>  
>  	pwm = SENSORS_LIMIT(pwm, 0, 255);
>  
> @@ -341,14 +350,16 @@ static ssize_t set_enable(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct max6650_data *data = i2c_get_clientdata(client);
> -	int mode = simple_strtoul(buf, NULL, 10);
>  	int max6650_modes[3] = {0, 3, 2};
> +	unsigned long mode;
> +	int err;
> +
> +	err = kstrtoul(buf, 10, &mode);
> +	if (err)
> +		return err;
>  
> -	if ((mode < 0)||(mode > 2)) {
> -		dev_err(&client->dev,
> -			"illegal value for pwm1_enable (%d)\n", mode);
> +	if (mode > 2)
>  		return -EINVAL;
> -	}
>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -389,7 +400,12 @@ static ssize_t set_div(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct max6650_data *data = i2c_get_clientdata(client);
> -	int div = simple_strtoul(buf, NULL, 10);
> +	unsigned long div;
> +	int err;
> +
> +	err = kstrtoul(buf, 10, &div);
> +	if (err)
> +		return err;
>  
>  	mutex_lock(&data->update_lock);
>  	switch (div) {
> @@ -407,8 +423,6 @@ static ssize_t set_div(struct device *dev, struct device_attribute *devattr,
>  		break;
>  	default:
>  		mutex_unlock(&data->update_lock);
> -		dev_err(&client->dev,
> -			"illegal value for fan divider (%d)\n", div);
>  		return -EINVAL;
>  	}
>  
> @@ -529,7 +543,8 @@ static int max6650_probe(struct i2c_client *client,
>  	struct max6650_data *data;
>  	int err;
>  
> -	if (!(data = kzalloc(sizeof(struct max6650_data), GFP_KERNEL))) {
> +	data = kzalloc(sizeof(struct max6650_data), GFP_KERNEL);
> +	if (!data) {
>  		dev_err(&client->dev, "out of memory.\n");
>  		return -ENOMEM;
>  	}
> @@ -596,49 +611,47 @@ static int max6650_init_client(struct i2c_client *client)
>  	}
>  
>  	switch (fan_voltage) {
> -		case 0:
> -			break;
> -		case 5:
> -			config &= ~MAX6650_CFG_V12;
> -			break;
> -		case 12:
> -			config |= MAX6650_CFG_V12;
> -			break;
> -		default:
> -			dev_err(&client->dev,
> -				"illegal value for fan_voltage (%d)\n",
> -				fan_voltage);
> +	case 0:
> +		break;
> +	case 5:
> +		config &= ~MAX6650_CFG_V12;
> +		break;
> +	case 12:
> +		config |= MAX6650_CFG_V12;
> +		break;
> +	default:
> +		dev_err(&client->dev, "illegal value for fan_voltage (%d)\n",
> +			fan_voltage);
>  	}
>  
>  	dev_info(&client->dev, "Fan voltage is set to %dV.\n",
>  		 (config & MAX6650_CFG_V12) ? 12 : 5);
>  
>  	switch (prescaler) {
> -		case 0:
> -			break;
> -		case 1:
> -			config &= ~MAX6650_CFG_PRESCALER_MASK;
> -			break;
> -		case 2:
> -			config = (config & ~MAX6650_CFG_PRESCALER_MASK)
> -				 | MAX6650_CFG_PRESCALER_2;
> -			break;
> -		case  4:
> -			config = (config & ~MAX6650_CFG_PRESCALER_MASK)
> -				 | MAX6650_CFG_PRESCALER_4;
> -			break;
> -		case  8:
> -			config = (config & ~MAX6650_CFG_PRESCALER_MASK)
> -				 | MAX6650_CFG_PRESCALER_8;
> -			break;
> -		case 16:
> -			config = (config & ~MAX6650_CFG_PRESCALER_MASK)
> -				 | MAX6650_CFG_PRESCALER_16;
> -			break;
> -		default:
> -			dev_err(&client->dev,
> -				"illegal value for prescaler (%d)\n",
> -				prescaler);
> +	case 0:
> +		break;
> +	case 1:
> +		config &= ~MAX6650_CFG_PRESCALER_MASK;
> +		break;
> +	case 2:
> +		config = (config & ~MAX6650_CFG_PRESCALER_MASK)
> +			 | MAX6650_CFG_PRESCALER_2;
> +		break;
> +	case  4:
> +		config = (config & ~MAX6650_CFG_PRESCALER_MASK)
> +			 | MAX6650_CFG_PRESCALER_4;
> +		break;
> +	case  8:
> +		config = (config & ~MAX6650_CFG_PRESCALER_MASK)
> +			 | MAX6650_CFG_PRESCALER_8;
> +		break;
> +	case 16:
> +		config = (config & ~MAX6650_CFG_PRESCALER_MASK)
> +			 | MAX6650_CFG_PRESCALER_16;
> +		break;
> +	default:
> +		dev_err(&client->dev, "illegal value for prescaler (%d)\n",
> +			prescaler);
>  	}
>  
>  	dev_info(&client->dev, "Prescaler is set to %d.\n",
> -- 
> 1.7.5.4
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
