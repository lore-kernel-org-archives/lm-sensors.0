From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 23 Mar 2009 00:08:10 +0000
Subject: Re: [lm-sensors] LM95241 Driver proposal
Message-Id: <20090322170810.7350923b.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 8 Jan 2009 12:06:10 +0100 "Davide Rizzo" <elpa.rizzo@gmail.com> wrote:

> This patch implements the hwmon driver for the National Semiconductor LM95241
>  triple temperature sensors chip
> 
>
> ...
>
> +
> +/* Conversions and various macros */
> +#define TEMP_FROM_REG(val_h, val_l) (((val_h) & 0x80 ? (val_h) - 0x100 : \
> +    (val_h)) * 1000 + (val_l) * 1000 / 256)

This macro is inefficient or buggy when pass an expression which has
side-effects, because it evaulates an argument multiple times.

Please just turn it into a plain old lower-case C function.

>
> ...
>
> +#define show_type(flag) \
> +static ssize_t show_type##flag(struct device *dev, \
> +				   struct device_attribute *attr, char *buf) \
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct lm95241_data *data = i2c_get_clientdata(client); \
> +\
> +	snprintf(buf, PAGE_SIZE - 1, \
> +		data->model & R##flag##MS_MASK ? "1\n" : "2\n"); \
> +	return strlen(buf); \
> +}
> +show_type(1);
> +show_type(2);
> +
> +#define show_min(flag) \
> +static ssize_t show_min##flag(struct device *dev, \
> +    struct device_attribute *attr, char *buf) \
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct lm95241_data *data = i2c_get_clientdata(client); \
> +\
> +	snprintf(buf, PAGE_SIZE - 1, \
> +		data->config & R##flag##DF_MASK ?	\
> +		"-127000\n" : "0\n"); \
> +	return strlen(buf); \
> +}
> +show_min(1);
> +show_min(2);

hm.  Is this still the preferred way of implementing these sysfs handlers?

>
> ...
>
> +static struct attribute *lm95241_attributes[] = {
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp2_input.attr,
> +	&dev_attr_temp3_input.attr,
> +	&dev_attr_temp2_type.attr,
> +	&dev_attr_temp3_type.attr,
> +	&dev_attr_temp2_min.attr,
> +	&dev_attr_temp3_min.attr,
> +	&dev_attr_temp2_max.attr,
> +	&dev_attr_temp3_max.attr,
> +	&dev_attr_rate.attr,
> +	NULL
> +};

Should this use an attribute group?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
