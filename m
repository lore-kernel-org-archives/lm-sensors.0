From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 Jul 2015 21:30:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct7802) Add autopoint attributes
Message-Id: <20150709213058.GA4883@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436395749-4101-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1436395749-4101-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Constantine Shulyupin <const@MakeLinux.com>
Cc: Jean Delvare <jdelvare@suse.de>, "open list:HARDWARE MONITORING" <lm-sensors@lm-sensors.org>, open list <linux-kernel@vger.kernel.org>

Hi Constantine,

On Thu, Jul 09, 2015 at 01:49:08AM +0300, Constantine Shulyupin wrote:
> Introduced PWM_REG, TEMP_REG, auto_pointX_temp, auto_pointX_pwm,
> nct7802_auto_point_attrs, nct7802_auto_point_group.
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>  drivers/hwmon/nct7802.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 2f6bbe5..a3f3063 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -153,6 +153,10 @@ static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
>  	return err ? : count;
>  }
>  
> +#define PWM_REG(_name, _reg) \
> +	SENSOR_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR, \
> +				  show_pwm, store_pwm, _reg)
> +
>  static ssize_t show_pwm_enable(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> @@ -404,6 +408,10 @@ static ssize_t store_temp(struct device *dev, struct device_attribute *attr,
>  	return err ? : count;
>  }
>  
> +#define TEMP_REG(_name, _high, _low) \
> +	SENSOR_DEVICE_ATTR_2(_name, S_IRUGO | S_IWUSR, \
> +				    show_temp, store_temp, _high, _low)
> +

Please drop those macros and use SENSOR_DEVICE_ATTR.. directly.

>  static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
>  			char *buf)
>  {
> @@ -890,11 +898,44 @@ static struct attribute_group nct7802_pwm_group = {
>  	.attrs = nct7802_pwm_attrs,
>  };
>  
> +/* 7.2.115... 0x80-0x83, 0x84 Temperature (X-axis) transition */
> +static TEMP_REG(auto_point1_temp, 0x80, 0);
> +static TEMP_REG(auto_point2_temp, 0x81, 0);
> +static TEMP_REG(auto_point3_temp, 0x82, 0);
> +static TEMP_REG(auto_point4_temp, 0x83, 0);
> +static TEMP_REG(auto_point_crit_temp, 0x84, 0);

I am not really happy with the crit_temp attribute.
Usually we have just gave this another index, ie point5_temp.

Your code is missing the other two tables at register addresses 0x90+
and 0xa0+. Any reason for not including those ?

It might be better to use the attribute names we have used in other
drivers, ie pwm[123]_auto_point[1-5]_pwm and pwm[1-3]_auto_point[1-5]_temp
and support the other two tables as well. One option for the critical
pwm value might be to make it read-only and always report it as 255
for consistency.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
