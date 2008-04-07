From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 07 Apr 2008 05:49:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fix common race conditions, batch 2
Message-Id: <47F9B5D2.1070503@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080406180721.GN27659@mars.solarsys.private>
In-Reply-To: <20080406180721.GN27659@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
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

<snip>

> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index cbeb498..a97ebde 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -593,9 +593,12 @@ static ssize_t show_temp_max_hyst(struct device *dev, struct device_attribute
>  {
>  	struct f71882fg_data *data = f71882fg_update_device(dev);
>  	int nr = to_sensor_dev_attr(devattr)->index;
> +	int res;
>  
> -	return sprintf(buf, "%d\n",
> -		(data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
> +	mutex_lock(&data->update_lock);
> +	res = (data->temp_high[nr] - data->temp_hyst[nr]) * 1000;
> +	mutex_unlock(&data->update_lock);
> +	return sprintf(buf, "%d\n", res);
>  }
>  
>  static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
> @@ -670,9 +673,12 @@ static ssize_t show_temp_crit_hyst(struct device *dev, struct device_attribute
>  {
>  	struct f71882fg_data *data = f71882fg_update_device(dev);
>  	int nr = to_sensor_dev_attr(devattr)->index;
> +	int res;
>  
> -	return sprintf(buf, "%d\n",
> -		(data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
> +	mutex_lock(&data->update_lock);
> +	res = (data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000;
> +	mutex_unlock(&data->update_lock);
> +	return sprintf(buf, "%d\n", res);
>  }
>  
>  static ssize_t show_temp_type(struct device *dev, struct device_attribute

I don't believe this is necessary, as data->temp_ovt / data->temp_high can be 
changed independend of data->temp_hyst. SO if a reader and a writer are racing 
with the locks the reader will either get the value from before or after the 
read, and without the lock, the same.

There are no parts of the code which change both data->temp_ovt/data->temp_high 
and data->temp_hyst at _the same time_. With the one exception being the code 
reading the values back from the IC in update_device(), so unless something is 
mucking with the hardware underneath us, in which case we have much bigger 
problems! , there us no race here.

The non locking in these functions was done by design.

With that said, I have no objections against this patch if it gives people a 
nice safe warm fuzzy feeling to have this patch present.

---

Talking about something else touching the hardware, maybe we should change the 
code which reads non changing registers periodically to actually check for 
unexpected changes, and yell if these are found, because AFAIK thats the only 
reason why we read these registers periodically even though they should 
theoretically never change.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
