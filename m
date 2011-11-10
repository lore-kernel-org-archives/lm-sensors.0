From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Nov 2011 13:07:48 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (max1111) change sysfs interface
Message-Id: <20111110140748.1f19b461@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320843721-2916-1-git-send-email-eric.y.miao@gmail.com>
In-Reply-To: <1320843721-2916-1-git-send-email-eric.y.miao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Wed,  9 Nov 2011 21:02:01 +0800, Eric Miao wrote:
> This patch fixed the inconsistent max1111 sysfs interface as pointed
> out by Jean Delvare:
> 
>     It was pointed to me that the max1111 driver doesn't implement the
>     standard sysfs interface for hwmon drivers (as described in
>     Documentation/hwmon/sysfs-interface). It exports files adc[0-3]_in,
>     which
>     aren't part of the standard interface. Presumably these should be
>     renamed to in[0-3]_input. Renaming them is probably not sufficient
>     though, as I see no scaling done in the driver. As the MAX1111 chip has
>     a documented full scale of 2.048V, I take it that the LSB of the ADC
>     has a weight of 8 mV. Exporting raw register values to user-space is
>     not OK.
> 
> Reported-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
>  drivers/hwmon/max1111.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
> index c97b78e..5586cca 100644
> --- a/drivers/hwmon/max1111.c
> +++ b/drivers/hwmon/max1111.c
> @@ -106,11 +106,14 @@ static ssize_t show_adc(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	return sprintf(buf, "%d\n", ret);
> +	/* assume the reference voltage to be 2.048V, with an 8-bit sample,
> +	 * the LSB weight is 8mV
> +	 */
> +	return sprintf(buf, "%d\n", ret * 8);
>  }
>  
>  #define MAX1111_ADC_ATTR(_id)		\
> -	SENSOR_DEVICE_ATTR(adc##_id##_in, S_IRUGO, show_adc, NULL, _id)
> +	SENSOR_DEVICE_ATTR(in##_id##_input, S_IRUGO, show_adc, NULL, _id)
>  
>  static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>  static MAX1111_ADC_ATTR(0);
> @@ -120,10 +123,10 @@ static MAX1111_ADC_ATTR(3);
>  
>  static struct attribute *max1111_attributes[] = {
>  	&dev_attr_name.attr,
> -	&sensor_dev_attr_adc0_in.dev_attr.attr,
> -	&sensor_dev_attr_adc1_in.dev_attr.attr,
> -	&sensor_dev_attr_adc2_in.dev_attr.attr,
> -	&sensor_dev_attr_adc3_in.dev_attr.attr,
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
>  	NULL,
>  };
>  

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
