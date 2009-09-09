From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 09 Sep 2009 00:06:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Texas Instruments
Message-Id: <20090908170649.855dd1ff.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090905_120834_010267.tomaz.mertelj@guest.arnes.si>
In-Reply-To: <20090905_120834_010267.tomaz.mertelj@guest.arnes.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomaz.mertelj@guest.arnes.si
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sat, 5 Sep 2009 14:08:34 +0200
tomaz.mertelj@guest.arnes.si wrote:

> +	int temp1_input;
> +	int temp1_min;
> +	int temp1_max;
> +	int temp1_crit;
> +
> +	int temp2_input;
> +	int temp2_min;
> +	int temp2_max;
> +	int temp2_crit;
> +
> +	u16 fan1_input;
> +	u16 fan1_min;
> +	u16 fan1_max;
> +	u8 fan1_div;
> +
> +	u8 pwm1;
> +	u8 temp1_auto_point_temp[3];
> +	u8 temp2_auto_point_temp[3];
> +	u8 pwm1_auto_point_pwm[3];
> +	u8 pwm1_enable;
> +	u8 pwm1_auto_channels_temp;
> +
> +	u8 stat1;
> +	u8 stat2;
> +};
> +
> +
> +#define get_temp_para(name) \
> +static ssize_t get_##name(\
> +		struct device *dev,\
> +		struct device_attribute *devattr,\
> +		char *buf)\
> +{\
> +	struct amc6821_data *data = amc6821_update_device(dev);\
> +	return sprintf(buf, "%d\n", data->name * 1000);\
> +}
> +
> +get_temp_para(temp1_input);
> +get_temp_para(temp1_min);
> +get_temp_para(temp1_max);
> +get_temp_para(temp2_input);
> +get_temp_para(temp2_min);
> +get_temp_para(temp2_max);
> +get_temp_para(temp1_crit);
> +get_temp_para(temp2_crit);
> +
> +#define set_temp_para(name, reg)\
> +static ssize_t set_##name(\
> +		struct device *dev,\
> +		struct device_attribute *attr,\
> +		const char *buf,\
> +		size_t count)\
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct amc6821_data *data = i2c_get_clientdata(client); \
> +	int val = simple_strtol(buf, NULL, 10); \
> +	\
> +	mutex_lock(&data->update_lock); \
> +	data->name = SENSORS_LIMIT(val / 1000, -128, 127); \
> +	if (i2c_smbus_write_byte_data(client, reg, data->name)) {\
> +		dev_err(&client->dev, "Register write error, aborting.\n");\
> +		count = -EIO;\
> +	} \
> +	mutex_unlock(&data->update_lock); \
> +	return count; \
> +}

I'm wondering if these functions need to be so huge.  Couldn't you do

#define set_temp_para(name, reg)\
static ssize_t set_##name(\
		struct device *dev,\
		struct device_attribute *attr,\
		const char *buf,\
		size_t count)\
{\
	return set_helper(dev, attr, buf, count, &dev->name);\
}

And then do all the real work in a common function?  Rather than
expanding tens of copies of the same thing?

Also, the checkpatch warning

WARNING: consider using strict_strtol in preference to simple_strtol
#381: FILE: drivers/hwmon/amc6821.c:228:
+       int val = simple_strtol(buf, NULL, 10); \

is valid.  The problem with simple_strtol() is that it will treat input
of the form "43foo" as "43".  Even though the input was invalid.  A
minor thing, but easily fixed too.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
