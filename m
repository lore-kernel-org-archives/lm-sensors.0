From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 27 Sep 2008 11:03:47 +0000
Subject: Re: [lm-sensors] hwmon: (it87) Fix thermal sensor type values
Message-Id: <48DE1313.7070209@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080927125506.307163c7@hyperion.delvare>
In-Reply-To: <20080927125506.307163c7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> The it87 driver doesn't follow the standard sensor type values as
> documented in Documentation/hwmon/sysfs-interface. It uses value 2 for
> thermistors instead of value 4. This causes "sensors" to tell the user
> that the chip is setup for a transistor while it is actually setup for
> a thermistor.
> 
> Using value 4 for thermistors solves the problem. For compatibility
> reasons, we still accept value 2 but emit a warning message so that
> users update their configuration files.
> 

Looks good,

Acked-by: Hans de Goede <hdegoede@redhat.com>

> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> For users of lm-sensors <= 2.10.7, this change will cause the
> thermistors to be reported as "invalid". I've just fixed that in SVN.
> For this reason, I do not want to push the it87 driver fix into the
> kernel immediately. Let's wait for lm-sensors 2.10.8 to be released
> first. In practice, this means that the it87 driver will be fixed in
> kernel 2.6.28.
> 
>  Documentation/hwmon/it87 |    4 ++--
>  drivers/hwmon/it87.c     |   11 ++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> --- linux-2.6.27-rc7.orig/Documentation/hwmon/it87	2008-08-13 09:50:46.000000000 +0200
> +++ linux-2.6.27-rc7/Documentation/hwmon/it87	2008-09-26 17:43:34.000000000 +0200
> @@ -136,10 +136,10 @@ once-only alarms.
>  The IT87xx only updates its values each 1.5 seconds; reading it more often
>  will do no harm, but will return 'old' values.
>  
> -To change sensor N to a thermistor, 'echo 2 > tempN_type' where N is 1, 2,
> +To change sensor N to a thermistor, 'echo 4 > tempN_type' where N is 1, 2,
>  or 3. To change sensor N to a thermal diode, 'echo 3 > tempN_type'.
>  Give 0 for unused sensor. Any other value is invalid. To configure this at
> -startup, consult lm_sensors's /etc/sensors.conf. (2 = thermistor;
> +startup, consult lm_sensors's /etc/sensors.conf. (4 = thermistor;
>  3 = thermal diode)
>  
>  
> --- linux-2.6.27-rc7.orig/drivers/hwmon/it87.c	2008-09-26 09:50:16.000000000 +0200
> +++ linux-2.6.27-rc7/drivers/hwmon/it87.c	2008-09-27 10:01:44.000000000 +0200
> @@ -477,7 +477,7 @@ static ssize_t show_sensor(struct device
>  	if (reg & (1 << nr))
>  		return sprintf(buf, "3\n");  /* thermal diode */
>  	if (reg & (8 << nr))
> -		return sprintf(buf, "2\n");  /* thermistor */
> +		return sprintf(buf, "4\n");  /* thermistor */
>  	return sprintf(buf, "0\n");      /* disabled */
>  }
>  static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
> @@ -493,10 +493,15 @@ static ssize_t set_sensor(struct device
>  
>  	data->sensor &= ~(1 << nr);
>  	data->sensor &= ~(8 << nr);
> -	/* 3 = thermal diode; 2 = thermistor; 0 = disabled */
> +	if (val = 2) {	/* backwards compatibility */
> +		dev_warn(dev, "Sensor type 2 is deprecated, please use 4 "
> +			 "instead\n");
> +		val = 4;
> +	}
> +	/* 3 = thermal diode; 4 = thermistor; 0 = disabled */
>  	if (val = 3)
>  	    data->sensor |= 1 << nr;
> -	else if (val = 2)
> +	else if (val = 4)
>  	    data->sensor |= 8 << nr;
>  	else if (val != 0) {
>  		mutex_unlock(&data->update_lock);
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
