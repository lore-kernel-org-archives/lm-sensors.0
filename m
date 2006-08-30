From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 30 Aug 2006 11:01:28 +0000
Subject: [lm-sensors] [PATCH 2.6.18-rc4-mm3] hwmon: unchecked return
Message-Id: <20060830130128.26c1966e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060830030502.GA5104@jupiter.solarsys.private>
In-Reply-To: <20060830030502.GA5104@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> This patch fixes up some hwmon drivers so that they no longer ignore
> return status from device_create_file().  Compile-tested only.

Looks good to me, I'd only have two minor comments (I always do, it
seems...) No need to resend this patch (unless you want to), but you
may want to take them into account for later patches.

> +++ linux-2.6.18-rc4-mm3/drivers/hwmon/lm80.c
> @@ -394,6 +394,48 @@ static int lm80_attach_adapter(struct i2
>  	return i2c_probe(adapter, &addr_data, lm80_detect);
>  }
>  
> +static struct attribute *lm80_attributes[] = {
> +	&dev_attr_in0_min.attr,
> +	&dev_attr_in1_min.attr,
> +	&dev_attr_in2_min.attr,
> +	&dev_attr_in3_min.attr,
> +	&dev_attr_in4_min.attr,
> +	&dev_attr_in5_min.attr,
> +	&dev_attr_in6_min.attr,
> +	&dev_attr_in0_max.attr,
> +	&dev_attr_in1_max.attr,
> +	&dev_attr_in2_max.attr,
> +	&dev_attr_in3_max.attr,
> +	&dev_attr_in4_max.attr,
> +	&dev_attr_in5_max.attr,
> +	&dev_attr_in6_max.attr,
> +	&dev_attr_in0_input.attr,
> +	&dev_attr_in1_input.attr,
> +	&dev_attr_in2_input.attr,
> +	&dev_attr_in3_input.attr,
> +	&dev_attr_in4_input.attr,
> +	&dev_attr_in5_input.attr,
> +	&dev_attr_in6_input.attr,
> +	&dev_attr_fan1_min.attr,
> +	&dev_attr_fan2_min.attr,
> +	&dev_attr_fan1_input.attr,
> +	&dev_attr_fan2_input.attr,
> +	&dev_attr_fan1_div.attr,
> +	&dev_attr_fan2_div.attr,
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp1_max.attr,
> +	&dev_attr_temp1_max_hyst.attr,
> +	&dev_attr_temp1_crit.attr,
> +	&dev_attr_temp1_crit_hyst.attr,
> +	&dev_attr_alarms.attr,
> +
> +	NULL
> +};

If you were grouping the attributes visually as you did in some other
drivers, I agree it would make (some) sense to have a blank line before
the NULL terminator. However, with a single block of attributes, it's a
bit harder to justify this last blank line.

>  	/* The ADT7463 has an optional VRM 10 mode where pin 21 is used
>  	   as a sixth digital VID input rather than an analog input. */
>  	data->vid = lm85_read_value(new_client, LM85_REG_VID);
> -	if (!(kind = adt7463 && (data->vid & 0x80))) {
> -		device_create_file(&new_client->dev, &dev_attr_in4_input);
> -		device_create_file(&new_client->dev, &dev_attr_in4_min);
> -		device_create_file(&new_client->dev, &dev_attr_in4_max);
> +	if (!(kind = adt7463 && (data->vid & 0x80)))
> +		if ((err = device_create_file(&new_client->dev,
> +					&dev_attr_in4_input))
> +		 || (err = device_create_file(&new_client->dev,
> +					&dev_attr_in4_min))
> +		 || (err = device_create_file(&new_client->dev,
> +					&dev_attr_in4_max)))
> +			goto ERROR3;

As a maintainer, I don't much like nested "if"s without curly braces,
especially when the conditions span over multiple lines. It's very easy
to mess up when later trying to add an "else" clause to the outer-most
"if". Thus I'd recommend to keep the curly braces for the outer-most
"if" in this case. If nothing else, it also makes the patch a couple
lines smaller ;)

Thanks,
-- 
Jean Delvare

