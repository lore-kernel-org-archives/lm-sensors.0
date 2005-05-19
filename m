From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: [PATCH 2.6] ADM1030 and Co sensors chips support for 2.6.7-mm1
Message-Id: <20040630020455.GG3064@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040622195209.77f852a6.alex@alexdalton.org>
In-Reply-To: <20040622195209.77f852a6.alex@alexdalton.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexandre:

Just a couple nits to pick...

* Alexandre d'Alton <alex@alexdalton.org> [2004-06-22 19:52:09 +0200]:

(liberal snips)

> +#define AUTO_TEMP_MAX_FROM_REG(reg)		\
> +	AUTO_TEMP_RANGE_FROM_REG(reg) +		\
> +	AUTO_TEMP_MIN_FROM_REG(reg)

Should add outer parens there.

> +#define fan_auto_channel_offset(offset)						\
> +static ssize_t show_fan_auto_channel_##offset (struct device *dev, char *buf)	\
> +{										\
> +	return show_fan_auto_channel(dev, buf, 0x##offset - 1);			\
> +}										\
> +static ssize_t set_fan_auto_channel_##offset (struct device *dev,		\
> +	const char *buf, size_t count)						\
> +{										\
> +	return set_fan_auto_channel(dev, buf, count, 0x##offset - 1);		\
> +}										\
> +static DEVICE_ATTR(auto_fan##offset##_channel, S_IRUGO | S_IWUSR,		\
> +		   show_fan_auto_channel_##offset,				\
> +		   set_fan_auto_channel_##offset)

A recent driver core patch *necessitates* the trailing semicolon for DEVICE_ATTR().

> +static DEVICE_ATTR(auto_temp##offset##_off, S_IRUGO,				\
> +		   show_auto_temp_##offset##_off, NULL);			\
> +static DEVICE_ATTR(auto_temp##offset##_min, S_IRUGO | S_IWUSR,			\
> +		   show_auto_temp_##offset##_min, set_auto_temp_##offset##_min);\
> +static DEVICE_ATTR(auto_temp##offset##_max, S_IRUGO | S_IWUSR,			\
> +		   show_auto_temp_##offset##_max, set_auto_temp_##offset##_max)

Likewise for the last of these three.

> +static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR,		\
> +		   show_pwm_##offset, set_pwm_##offset)

And here... eh, there are more but you get the point.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
