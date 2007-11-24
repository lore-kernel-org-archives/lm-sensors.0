From: Herbert Valerio Riedel <hvr@gnu.org>
Date: Sat, 24 Nov 2007 21:26:21 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (gl518sm) Refactor fan functions
Message-Id: <1195939581.14108.15.camel@pbook.intra>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071022174642.3c3ce8f0@hyperion.delvare>
In-Reply-To: <20071022174642.3c3ce8f0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,


On Mon, 2007-10-22 at 17:46 +0200, Jean Delvare wrote:
> This makes the code more readable and the binary smaller (by 5% or so).

:-)

> +static ssize_t show_fan_input(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct gl518_data *data = gl518_update_device(dev);
> +	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_in[nr],
> +					DIV_FROM_REG(data->fan_div[nr])));
> +}
> +
> +static ssize_t show_fan_min(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct gl518_data *data = gl518_update_device(dev);
> +	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
> +					DIV_FROM_REG(data->fan_div[nr])));
> +}
> +
> +static ssize_t show_fan_div(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct gl518_data *data = gl518_update_device(dev);
> +	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
> +}

imho, it would have been ok to reduce those 3 instantiations to a macro
template and 3 expansions... but I guess it's a matter of preference :-)

> -	data->fan_min[0] = FAN_TO_REG(val,
> -		DIV_FROM_REG(data->fan_div[0]));
> -	regvalue = (regvalue & 0x00ff) | (data->fan_min[0] << 8);
> +	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));

> +	regvalue = (regvalue & (0xff << (8 * nr)))
> +		 | (data->fan_min[nr] << (8 * (1 - nr)));

this shifting/masking looks a bit confusing to me; as 'nr' is supposed
to take only 2 values, wouldn't it be more readable to use an if/else
construct or an ?: operator? 

> +	regvalue = (regvalue & ~(0xc0 >> (2 * nr)))
> +		 | (data->fan_div[nr] << (6 - 2 * nr));

same thing


except for stylistic comments, patch looks good to me :-)

cheers,
hvr


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
