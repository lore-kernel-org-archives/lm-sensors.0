From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 12:51:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asb100) Various cleanups
Message-Id: <20080131125103.GA8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080103231549.3cb00f27@hyperion.delvare>
In-Reply-To: <20080103231549.3cb00f27@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

This patch doesn't apply...

* Jean Delvare <khali@linux-fr.org> [2008-01-03 23:15:49 +0100]:
> * Drop history, it's incomplete and doesn't belong there
> * Drop unused version number
> * Drop trailing spaces
> * Coding style fixes
> * Fold long lines
> * Rename new_client to client
> * Drop redundant initializations to 0
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> ---
>  drivers/hwmon/asb100.c |  124 +++++++++++++++++++++++-------------------------
>  1 file changed, 60 insertions(+), 64 deletions(-)
> 
> --- linux-2.6.24-rc6.orig/drivers/hwmon/asb100.c	2007-12-26 14:39:06.000000000 +0100
> +++ linux-2.6.24-rc6/drivers/hwmon/asb100.c	2007-12-31 11:57:08.000000000 +0100

(...)

> @@ -511,13 +506,15 @@ static ssize_t show_vid(struct device *d
>  static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
>  
>  /* VRM */
> -static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
> +		char *buf)
>  {
>  	struct asb100_data *data = dev_get_drvdata(dev);
>  	return sprintf(buf, "%d\n", data->vrm);
>  }
>  
> -static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
>  {
>  	struct asb100_data *data = dev_get_drvdata(dev);

The above line is not present in the original, nor in any patch I've
seen.  I think you probably meant it to be changed by this patch.
Please respin this one and I'll get it and the rest of the series
applied.

>  	data->vrm = simple_strtoul(buf, NULL, 10);
> @@ -527,7 +524,8 @@ static ssize_t set_vrm(struct device *de
>  /* Alarms */
>  static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
>  
> -static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
> +		char *buf)
>  {
>  	struct asb100_data *data = asb100_update_device(dev);
>  	return sprintf(buf, "%u\n", data->alarms);
> @@ -536,13 +534,15 @@ static ssize_t show_alarms(struct device
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
>  /* 1 PWM */
> -static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr,
> +		char *buf)
>  {
>  	struct asb100_data *data = asb100_update_device(dev);
>  	return sprintf(buf, "%d\n", ASB100_PWM_FROM_REG(data->pwm & 0x0f));
>  }
>  
> -static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct asb100_data *data = i2c_get_clientdata(client);

(...)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
