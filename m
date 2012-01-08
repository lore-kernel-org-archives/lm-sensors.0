From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 08 Jan 2012 17:15:12 +0000
Subject: Re: [lm-sensors] [PATCH 17/17] drivers/hwmon/i5k_amb.c: fix
Message-Id: <20120108171512.GA23387@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326039820-11147-17-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326039820-11147-17-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Sun, Jan 08, 2012 at 11:23:40AM -0500, Frans Meulenbroeks wrote:
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
>  drivers/hwmon/i5k_amb.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index d22f241..c516bdc 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -159,7 +159,10 @@ static ssize_t store_amb_min(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i5k_amb_data *data = dev_get_drvdata(dev);
> -	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> +	unsigned long temp;
> +	int ret = kstrtoul(buf, 10, &temp) / 500;

This divides the error code by 500, not temp.

> +	if (ret < 0)
> +		return ret;
>  
>  	if (temp > 255)
>  		temp = 255;
> @@ -175,7 +178,10 @@ static ssize_t store_amb_mid(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i5k_amb_data *data = dev_get_drvdata(dev);
> -	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> +	unsigned long temp;
> +	int ret = kstrtoul(buf, 10, &temp) / 500;

Same here.

> +	if (ret < 0)
> +		return ret;
>  
>  	if (temp > 255)
>  		temp = 255;
> @@ -191,7 +197,10 @@ static ssize_t store_amb_max(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct i5k_amb_data *data = dev_get_drvdata(dev);
> -	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> +	unsigned long temp;
> +	int ret = kstrtoul(buf, 10, &temp) / 500;

and here.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
