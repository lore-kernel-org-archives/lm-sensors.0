From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Jul 2015 03:28:01 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (nct7802) add temperature sensor type attribute
Message-Id: <55935E41.9020107@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435619148-4929-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435619148-4929-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Constantine Shulyupin <const@MakeLinux.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Constantine,

On 06/29/2015 04:05 PM, Constantine Shulyupin wrote:
> From: const <const@MakeLinux.com>
>
> Sensor type:
> 3 diode (current mode), MD=1
> 4 thermistor, MD=2
>
> Reference:
> Nuvoton Hardware Monitoring IC NCT7802Y
> 7.2.32 Mode Selection Register
> Location : Index 22h
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---

>   static struct attribute *nct7802_temp_attrs[] = {
> +	&sensor_dev_attr_temp1_type.dev_attr.attr,
>   	&sensor_dev_attr_temp1_input.dev_attr.attr,
>   	&sensor_dev_attr_temp1_min.dev_attr.attr,
>   	&sensor_dev_attr_temp1_max.dev_attr.attr,
> @@ -485,7 +529,9 @@ static struct attribute *nct7802_temp_attrs[] = {
>   	&sensor_dev_attr_temp1_fault.dev_attr.attr,
>   	&sensor_dev_attr_temp1_beep.dev_attr.attr,
>
> -	&sensor_dev_attr_temp2_input.dev_attr.attr,		/* 9 */
> +	/* 10: */

My problem with this kind of change isn't that much that I wrote
the code and I tend to use the other mechanism. My problem is that
if I accept it, someone else who adds another attribute may change
it back tomorrow, or find yet another means to express the same.
And we'd end up with a lot of churn for pretty much personal preference
reasons.

So, please refrain from making changes like this.

> +	&sensor_dev_attr_temp2_type.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
>   	&sensor_dev_attr_temp2_min.dev_attr.attr,
>   	&sensor_dev_attr_temp2_max.dev_attr.attr,
>   	&sensor_dev_attr_temp2_crit.dev_attr.attr,
> @@ -495,7 +541,9 @@ static struct attribute *nct7802_temp_attrs[] = {
>   	&sensor_dev_attr_temp2_fault.dev_attr.attr,
>   	&sensor_dev_attr_temp2_beep.dev_attr.attr,
>
> -	&sensor_dev_attr_temp3_input.dev_attr.attr,		/* 18 */
> +	/* 20: */
> +	&sensor_dev_attr_temp3_type.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
>   	&sensor_dev_attr_temp3_min.dev_attr.attr,
>   	&sensor_dev_attr_temp3_max.dev_attr.attr,
>   	&sensor_dev_attr_temp3_crit.dev_attr.attr,
> @@ -505,7 +553,8 @@ static struct attribute *nct7802_temp_attrs[] = {
>   	&sensor_dev_attr_temp3_fault.dev_attr.attr,
>   	&sensor_dev_attr_temp3_beep.dev_attr.attr,
>
> -	&sensor_dev_attr_temp4_input.dev_attr.attr,		/* 27 */
> +	/* 30: */
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
>   	&sensor_dev_attr_temp4_min.dev_attr.attr,
>   	&sensor_dev_attr_temp4_max.dev_attr.attr,
>   	&sensor_dev_attr_temp4_crit.dev_attr.attr,
> @@ -514,7 +563,8 @@ static struct attribute *nct7802_temp_attrs[] = {
>   	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
>   	&sensor_dev_attr_temp4_beep.dev_attr.attr,
>
> -	&sensor_dev_attr_temp5_input.dev_attr.attr,		/* 35 */
> +	/* 38: */
> +	&sensor_dev_attr_temp5_input.dev_attr.attr,
>   	&sensor_dev_attr_temp5_min.dev_attr.attr,
>   	&sensor_dev_attr_temp5_max.dev_attr.attr,
>   	&sensor_dev_attr_temp5_crit.dev_attr.attr,
> @@ -523,7 +573,8 @@ static struct attribute *nct7802_temp_attrs[] = {
>   	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
>   	&sensor_dev_attr_temp5_beep.dev_attr.attr,
>
> -	&sensor_dev_attr_temp6_input.dev_attr.attr,		/* 43 */
> +	/* 46: */
> +	&sensor_dev_attr_temp6_input.dev_attr.attr,
>   	&sensor_dev_attr_temp6_beep.dev_attr.attr,
>
>   	NULL
> @@ -541,25 +592,31 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
>   	if (err < 0)
>   		return 0;
>
> -	if (index < 9 &&
> +	/* temp1 */

This comment is redundant with RD1. Same for the other temp comments below.

Thanks,
Guenter

> +	if (index < 10 &&
>   	    (reg & 03) != 0x01 && (reg & 0x03) != 0x02)		/* RD1 */
>   		return 0;
> -	if (index >= 9 && index < 18 &&
> +
> +	/* temp2 */
> +	if (index >= 10 && index < 20 &&
>   	    (reg & 0x0c) != 0x04 && (reg & 0x0c) != 0x08)	/* RD2 */
>   		return 0;
> -	if (index >= 18 && index < 27 && (reg & 0x30) != 0x20)	/* RD3 */
> +	/* temp3 */
> +	if (index >= 20 && index < 30 && (reg & 0x30) != 0x20)	/* RD3 */
>   		return 0;
> -	if (index >= 27 && index < 35)				/* local */
> +
> +	/* temp4, local */
> +	if (index >= 30 && index < 38)
>   		return attr->mode;
>
>   	err = regmap_read(data->regmap, REG_PECI_ENABLE, &reg);
>   	if (err < 0)
>   		return 0;
>
> -	if (index >= 35 && index < 43 && !(reg & 0x01))		/* PECI 0 */
> +	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
>   		return 0;
>
> -	if (index >= 0x43 && (!(reg & 0x02)))			/* PECI 1 */
> +	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
>   		return 0;
>
>   	return attr->mode;
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
