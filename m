From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Sep 2012 16:38:51 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (ad7314) Add 'name' sysfs attribute
Message-Id: <20120917163851.GE1925@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347396773-32108-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347396773-32108-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ping

On Tue, Sep 11, 2012 at 01:52:53PM -0700, Guenter Roeck wrote:
> The 'name' sysfs attribute is mandatory for hwmon devices, but was missing
> in this driver.
> 
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> candidate for -stable
> 
>  drivers/hwmon/ad7314.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
> index 455294f..37c01e7 100644
> --- a/drivers/hwmon/ad7314.c
> +++ b/drivers/hwmon/ad7314.c
> @@ -87,10 +87,18 @@ static ssize_t ad7314_show_temperature(struct device *dev,
>  	}
>  }
>  
> +static ssize_t ad7314_show_name(struct device *dev,
> +				struct device_attribute *devattr, char *buf)
> +{
> +	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
> +}
> +
> +static DEVICE_ATTR(name, S_IRUGO, ad7314_show_name, NULL);
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
>  			  ad7314_show_temperature, NULL, 0);
>  
>  static struct attribute *ad7314_attributes[] = {
> +	&dev_attr_name.attr,
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	NULL,
>  };
> -- 
> 1.7.9.7
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
