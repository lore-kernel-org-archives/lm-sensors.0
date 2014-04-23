From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 23 Apr 2014 16:30:56 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (lm92) Drop function macros
Message-Id: <20140423183056.6f2713fa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140421034351.GA11607@roeck-us.net>
In-Reply-To: <20140421034351.GA11607@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 20 Apr 2014 20:43:51 -0700, Guenter Roeck wrote:
> Function macros obfuscate code and increase code size, so drop them.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Drop comma after t_num_regs
>     Declare register array as const and with explicit size
> 
>  drivers/hwmon/lm92.c |  165 +++++++++++++++++++++++++-------------------------
>  1 file changed, 82 insertions(+), 83 deletions(-)
> (...)
> +static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
> +			   const char *buf, size_t count)
>  {
> -	struct lm92_data *data = lm92_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_crit)
> -		       - TEMP_FROM_REG(data->temp1_hyst));
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm92_data *data = i2c_get_clientdata(client);
> +	int nr = attr->index;
> +	long val;
> +	int err = kstrtol(buf, 10, &val);

I would separate variable declaration from actual code here, that would
be easier to read and would be consistent with the code in
set_temp_hyst().

> +	if (err)
> +		return err;
> +
> +	mutex_lock(&data->update_lock);
> +	data->temp[nr] = TEMP_TO_REG(val);
> +	i2c_smbus_write_word_swapped(client, regs[nr], data->temp[nr]);
> +	mutex_unlock(&data->update_lock);
> +	return count;
>  }

Other than this it looks good to me, although I can't test. Do you
happen to have a register dump from an LM92, MAX6635 or any compatible
chip?

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
