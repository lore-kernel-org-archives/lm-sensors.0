From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Mar 2010 10:59:21 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] Hwmon: f71882fg: use strict_stro(l|ul)
Message-Id: <20100323115921.7d094e64@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269185834-10266-1-git-send-email-me@mortis.eu>
	<1269185834-10266-2-git-send-email-me@mortis.eu>
	<20100322112308.13d58db4@hyperion.delvare>
	<20100322114157.GA14077@salidar.me.mortis.eu>
In-Reply-To: <20100322114157.GA14077@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Hans de Goede <hdegoede@redhat.com>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Giel,

On Mon, 22 Mar 2010 12:41:57 +0100, Giel van Schijndel wrote:
> On Mon, Mar 22, 2010 at 11:23:08AM +0100, Jean Delvare wrote:
> > On Sun, 21 Mar 2010 16:37:14 +0100, Giel van Schijndel wrote:
> >> Use the strict_strol and strict_stroul functions instead of simple_strol
> >> and simple_stroul respectively in sysfs functions.
> >> 
> >> Signed-off-by: Giel van Schijndel <me@mortis.eu>
> >> ---
> >>  drivers/hwmon/f71882fg.c |   89 ++++++++++++++++++++++++++++++++++++++--------
> >>  1 files changed, 74 insertions(+), 15 deletions(-)
> >> 
> >> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> >> index 21bc661..5c725a3 100644
> >> --- a/drivers/hwmon/f71882fg.c
> >> +++ b/drivers/hwmon/f71882fg.c
> >> @@ -1128,7 +1128,10 @@ static ssize_t store_fan_full_speed(struct device *dev,
> >>  {
> >>  	struct f71882fg_data *data = dev_get_drvdata(dev);
> >>  	int nr = to_sensor_dev_attr_2(devattr)->index;
> >> -	long val = simple_strtol(buf, NULL, 10);
> >> +	long val;
> >> +
> >> +	if (strict_strtol(buf, 10, &val) = -EINVAL)
> >> +		return -EINVAL;
> >
> > That's not correct. You want to return an error if strict_strtol()
> > returns _any_ error, not just -EINVAL. Maybe the current
> > implementation can't return any other error code, but you should not
> > assume this will always be the case in the future.
> 
> Agreed. New patch follows this line:
> ------------------------------------------------------------------------
> Hwmon: f71882fg: use strict_stro(l|ul) instead of simple_strto$1
> 
> Use the strict_strol and strict_stroul functions instead of simple_strol
> and simple_stroul respectively in sysfs functions.
> 
> Signed-off-by: Giel van Schijndel <me@mortis.eu>
> ---
>  drivers/hwmon/f71882fg.c |  133 ++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 104 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 21bc661..4230729 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -1127,8 +1127,12 @@ static ssize_t store_fan_full_speed(struct device *dev,
>  				    const char *buf, size_t count)
>  {
>  	struct f71882fg_data *data = dev_get_drvdata(dev);
> -	int nr = to_sensor_dev_attr_2(devattr)->index;
> -	long val = simple_strtol(buf, NULL, 10);
> +	int err, nr = to_sensor_dev_attr_2(devattr)->index;
> +	long val;
> +
> +	err = strict_strtol(buf, 10, &val);
> +	if (err)
> +		return err;
>  
>  	val = SENSORS_LIMIT(val, 23, 1500000);
>  	val = fan_to_reg(val);
> (...)

Looks good to me this time. I'll apply this patch unless Hans objects.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
