From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 08:26:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lineage-pem): Fix in1 voltage
Message-Id: <20110316092649.4f3a610e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300233149-2269-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1300233149-2269-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Mar 2011 16:52:29 -0700, Guenter Roeck wrote:
> The alarm bit assumed to be a low voltage alarm bit is not set for low voltage
> alarms, and the alarm bit assumed to be a high voltage alarm turns out to be a
> general alarm bit which is set for both low and high voltage alarms.
> 
> Remove the in1_min_alarm sysfs attribute and rename in1_max_alarm to in1_alarm
> to reflect the situation.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lineage-pem.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/lineage-pem.c b/drivers/hwmon/lineage-pem.c
> index 2fe8e9e..ab63650 100644
> --- a/drivers/hwmon/lineage-pem.c
> +++ b/drivers/hwmon/lineage-pem.c
> @@ -345,9 +345,7 @@ static ssize_t pem_show_fan(struct device *dev, struct device_attribute *da,
>  /* Voltages */
>  static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, pem_show_data, NULL,
>  			  PEM_DATA_VOUT_LSB);
> -static SENSOR_DEVICE_ATTR_2(in1_min_alarm, S_IRUGO, pem_show_bool, NULL,
> -			    PEM_DATA_ALARM_2, ALRM2_OV_LOW);
> -static SENSOR_DEVICE_ATTR_2(in1_max_alarm, S_IRUGO, pem_show_bool, NULL,
> +static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, pem_show_bool, NULL,
>  			    PEM_DATA_ALARM_1, ALRM1_VOUT_OUT_LIMIT);
>  static SENSOR_DEVICE_ATTR_2(in1_crit_alarm, S_IRUGO, pem_show_bool, NULL,
>  			    PEM_DATA_ALARM_1, ALRM1_OV_VOLT_SHUTDOWN);
> @@ -395,8 +393,7 @@ static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, pem_show_bool, NULL,
>  
>  static struct attribute *pem_attributes[] = {
>  	&sensor_dev_attr_in1_input.dev_attr.attr,
> -	&sensor_dev_attr_in1_min_alarm.dev_attr.attr,
> -	&sensor_dev_attr_in1_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in1_alarm.dev_attr.attr,
>  	&sensor_dev_attr_in1_crit_alarm.dev_attr.attr,
>  	&sensor_dev_attr_in2_alarm.dev_attr.attr,
>  

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

Note that this means that this device has now in1_alarm and
in1_crit_alarm. This is a case your proposed rewrite of the "sensors"
code won't properly deal with, as it will only check for limit-specific
alarm flags in the absence of a generic alarm flag (so in this case
in1_crit_alarm will be ignored.) Not that the original code was better,
but maybe it's the right time to get it right.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
