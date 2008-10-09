From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Oct 2008 09:09:54 +0000
Subject: Re: [lm-sensors] [PATCH 11/12] adt7470: Check input range when
Message-Id: <20081009110954.2d5a9201@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011919.12701.2422.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011919.12701.2422.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Mon, 06 Oct 2008 18:19:19 -0700, Darrick J. Wong wrote:
> 

No description for this patch? IMHO it's large enough to deserve one.

> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/hwmon/adt7470.c |   77 +++++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 64 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index ef26014..5acc800 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -345,6 +345,11 @@ static ssize_t show_temp_min(struct device *dev,
>  	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
>  }
>  
> +static int range_check(const long val, const long min, const long max)
> +{
> +	return val >= min && val <= max;
> +}

Should definitely be inlined.

> +
>  static ssize_t set_temp_min(struct device *dev,
>  			    struct device_attribute *devattr,
>  			    const char *buf,
> @@ -353,7 +358,14 @@ static ssize_t set_temp_min(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +	long temp;
> +
> +	if (strict_strtol(buf, 10, &temp))
> +		return -EINVAL;
> +
> +	temp /= 1000;

While you're here, proper rounding would be welcome.

> +	if (!range_check(temp, 0, 255))
> +		return -EINVAL;

For temperature, voltage and fan speed values, the standard behavior is
best effort: we pick the nearest available value instead of returning
an error. We have a function for that: SENSORS_LIMIT(). Please use it.

Rationale: the boundaries for these values are chip-dependent so it
isn't fair to cause user commands to fail. We do range checks for
values which are normalized, such as PWM values (range 0-255 for all
chips) or when discrete values have specific meanings so picking the
nearest possible value makes no sense (e.g. PWM modes.)

>  
>  	mutex_lock(&data->lock);
>  	data->temp_min[attr->index] = temp;
> @@ -381,7 +393,14 @@ static ssize_t set_temp_max(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +	long temp;
> +
> +	if (strict_strtol(buf, 10, &temp))
> +		return -EINVAL;
> +
> +	temp /= 1000;
> +	if (!range_check(temp, 0, 255))
> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	data->temp_max[attr->index] = temp;
> @@ -430,11 +449,14 @@ static ssize_t set_fan_max(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10);
> +	long temp;
>  
> -	if (!temp)
> +	if (strict_strtol(buf, 10, &temp) || !temp)
>  		return -EINVAL;
> +
>  	temp = FAN_RPM_TO_PERIOD(temp);
> +	if (!range_check(temp, 0, 65535))

Do you really want to accept 0 as a valid value? show_fan_max() will
consider it an invalid value.

> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	data->fan_max[attr->index] = temp;
> @@ -465,11 +487,14 @@ static ssize_t set_fan_min(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10);
> +	long temp;
>  
> -	if (!temp)
> +	if (strict_strtol(buf, 10, &temp) || !temp)
>  		return -EINVAL;
> +
>  	temp = FAN_RPM_TO_PERIOD(temp);
> +	if (!range_check(temp, 0, 65535))

Ditto.

> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	data->fan_min[attr->index] = temp;
> @@ -507,9 +532,12 @@ static ssize_t set_force_pwm_max(struct device *dev,
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10);
> +	long temp;
>  	u8 reg;
>  
> +	if (strict_strtol(buf, 10, &temp))
> +		return -EINVAL;
> +
>  	mutex_lock(&data->lock);
>  	data->force_pwm_max = temp;
>  	reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> @@ -537,7 +565,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10);
> +	long temp;
> +
> +	if (strict_strtol(buf, 10, &temp) || !range_check(temp, 0, 255))
> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	data->pwm[attr->index] = temp;
> @@ -564,7 +595,10 @@ static ssize_t set_pwm_max(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10);
> +	long temp;
> +
> +	if (strict_strtol(buf, 10, &temp) || !range_check(temp, 0, 255))
> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_max[attr->index] = temp;
> @@ -592,7 +626,10 @@ static ssize_t set_pwm_min(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10);
> +	long temp;
> +
> +	if (strict_strtol(buf, 10, &temp) || !range_check(temp, 0, 255))
> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_min[attr->index] = temp;
> @@ -630,7 +667,14 @@ static ssize_t set_pwm_tmin(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +	long temp;
> +
> +	if (strict_strtol(buf, 10, &temp))
> +		return -EINVAL;
> +
> +	temp /= 1000;
> +	if (!range_check(temp, 0, 255))
> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_tmin[attr->index] = temp;
> @@ -658,11 +702,14 @@ static ssize_t set_pwm_auto(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = simple_strtol(buf, NULL, 10);
>  	int pwm_auto_reg = ADT7470_REG_PWM_CFG(attr->index);
>  	int pwm_auto_reg_mask;
> +	long temp;
>  	u8 reg;
>  
> +	if (strict_strtol(buf, 10, &temp))
> +		return -EINVAL;
> +
>  	if (attr->index % 2)
>  		pwm_auto_reg_mask = ADT7470_PWM2_AUTO_MASK;
>  	else
> @@ -716,10 +763,14 @@ static ssize_t set_pwm_auto_temp(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> -	int temp = cvt_auto_temp(simple_strtol(buf, NULL, 10));
>  	int pwm_auto_reg = ADT7470_REG_PWM_AUTO_TEMP(attr->index);
> +	long temp;
>  	u8 reg;
>  
> +	if (strict_strtol(buf, 10, &temp))
> +		return -EINVAL;
> +
> +	temp = cvt_auto_temp(temp);
>  	if (temp < 0)
>  		return temp;
>  

Please send an updated patch.

Same comments apply to the adt7473 patch as well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
