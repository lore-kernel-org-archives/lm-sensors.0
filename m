From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Apr 2008 13:35:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fix common race conditions, batch 2
Message-Id: <20080407153558.23802617@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080406180721.GN27659@mars.solarsys.private>
In-Reply-To: <20080406180721.GN27659@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 6 Apr 2008 14:07:21 -0400, Mark M. Hoffman wrote:
> Hi:
> 
>  atxp1.c    |    2 ++
>  coretemp.c |    2 ++
>  dme1737.c  |    6 ++++++
>  f71882fg.c |   14 ++++++++++----
>  gl518sm.c  |   18 ++++++++++++++----
>  gl520sm.c  |   16 ++++++++++++----
>  it87.c     |   26 ++++++++++++++++----------
>  7 files changed, 62 insertions(+), 22 deletions(-)
> 
> NB: reviewers are also encouraged to have a look at these files, in which I
> found no race condtions of this class:
> 
> ds1621.c
> f71805f.c
> f75375s.c
> fscher.c
> fschmd.c
> fscpos.c
> i5k_amb.c
> ibmpex.c

I checked ds1621.c and f71805f.c and I didn't find any race condition
either.

> 
> commit e62da7be499f5553ce682aa6830a4e51ab293619
> Author: Mark M. Hoffman <mhoffman@lightlink.com>
> Date:   Sun Apr 6 13:45:00 2008 -0400
> 
>     hwmon: fix common race conditions, batch 2
>     
>     Most hwmon drivers have one or more race conditions that could cause the driver
>     to display incorrect data; in the absolute worst case, these races could allow
>     divide-by-zero/OOPS.  The most common of these involves a race between setting
>     a fan divider and displaying the fan data (RPMs).  This patch fixes these race
>     conditions by taking the update lock (or equivalent) as necessary.
>     
>     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> 

Looks good, suggestions for improvement inline below. I also tested the
it87 part, no problem.

> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 70239ac..1fbaeff 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -93,12 +93,14 @@ static ssize_t show_temp(struct device *dev,
>  	struct coretemp_data *data = coretemp_update_device(dev);
>  	int err;
>  
> +	mutex_lock(&data->update_lock);
>  	if (attr->index = SHOW_TEMP)
>  		err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
>  	else if (attr->index = SHOW_TJMAX)
>  		err = sprintf(buf, "%d\n", data->tjmax);
>  	else
>  		err = sprintf(buf, "%d\n", data->ttarget);
> +	mutex_unlock(&data->update_lock);

You really only need to grab the mutex for the first case (attr->index
= SHOW_TEMP).

>  	return err;
>  }
>  

<snip>

> diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
> index 8984ef1..804018d 100644
> --- a/drivers/hwmon/gl520sm.c
> +++ b/drivers/hwmon/gl520sm.c
> @@ -273,9 +273,13 @@ static ssize_t get_fan_input(struct device *dev, struct device_attribute *attr,
>  {
>  	int n = to_sensor_dev_attr(attr)->index;
>  	struct gl520_data *data = gl520_update_device(dev);
> +	int result;
>  
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_input[n],
> -						 data->fan_div[n]));
> +	mutex_lock(&data->update_lock);
> +	result = FAN_FROM_REG(data->fan_input[n],
> +				data->fan_div[n]);

Would fit on a single line.

> +	mutex_unlock(&data->update_lock);
> +	return sprintf(buf, "%d\n", result);
>  }
>  
>  static ssize_t get_fan_min(struct device *dev, struct device_attribute *attr,
> @@ -283,9 +287,13 @@ static ssize_t get_fan_min(struct device *dev, struct device_attribute *attr,
>  {
>  	int n = to_sensor_dev_attr(attr)->index;
>  	struct gl520_data *data = gl520_update_device(dev);
> +	int result;
>  
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[n],
> -						 data->fan_div[n]));
> +	mutex_lock(&data->update_lock);
> +	result = FAN_FROM_REG(data->fan_min[n],
> +				 data->fan_div[n]);

Here too.

> +	mutex_unlock(&data->update_lock);
> +	return sprintf(buf, "%d\n", result);
>  }
>  
>  static ssize_t get_fan_div(struct device *dev, struct device_attribute *attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
