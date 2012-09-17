From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 17 Sep 2012 19:05:57 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (ads7871) Add 'name' sysfs attribute
Message-Id: <20120917210557.3a3c1f1c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347396773-32108-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347396773-32108-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Sep 2012 13:52:52 -0700, Guenter Roeck wrote:
> The 'name' sysfs attribute is mandatory for hwmon devices, but was missing
> in this driver.
> 
> Cc: Paul Thomas <pthomas8589@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Candidate for -stable
> 
>  drivers/hwmon/ads7871.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
> index e837707..1b53aa4 100644
> --- a/drivers/hwmon/ads7871.c
> +++ b/drivers/hwmon/ads7871.c
> @@ -139,6 +139,12 @@ static ssize_t show_voltage(struct device *dev,
>  	}
>  }
>  
> +static ssize_t ads7871_show_name(struct device *dev,
> +				 struct device_attribute *devattr, char *buf)
> +{
> +	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
> +}
> +
>  static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_voltage, NULL, 0);
>  static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_voltage, NULL, 1);
>  static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_voltage, NULL, 2);
> @@ -148,6 +154,8 @@ static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_voltage, NULL, 5);
>  static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_voltage, NULL, 6);
>  static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_voltage, NULL, 7);
>  
> +static DEVICE_ATTR(name, S_IRUGO, ads7871_show_name, NULL);
> +
>  static struct attribute *ads7871_attributes[] = {
>  	&sensor_dev_attr_in0_input.dev_attr.attr,
>  	&sensor_dev_attr_in1_input.dev_attr.attr,
> @@ -157,6 +165,7 @@ static struct attribute *ads7871_attributes[] = {
>  	&sensor_dev_attr_in5_input.dev_attr.attr,
>  	&sensor_dev_attr_in6_input.dev_attr.attr,
>  	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	&dev_attr_name.attr,
>  	NULL
>  };
>  

Good catch.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
