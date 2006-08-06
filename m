From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 06 Aug 2006 15:47:37 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc2-mm1] hwmon: unchecked return
Message-Id: <20060806174737.f74a1d89.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802130811.GF3141@jupiter.solarsys.private>
In-Reply-To: <20060802130811.GF3141@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

A few more comments:

> Here is asb100.c... I'll add lm75, lm78, smsc47b397, and w83627hf
> to this patch as I have time.  (Jean: don't apply yet.)

I see little reason to not apply this patch. I don't know for sure what
we will do for the other drivers, but what we have come up with for the
asb100 is so nice that I just can't think of any better solution for
this driver.

BTW, do you have any plan to convert the asb100 driver to use the
"dynamic" sysfs callbacks? This would kill some more macros, and shrink
the driver size even more.

One minor comment on the code:

> +static struct attribute *asb100_attributes[] = {
> +	&dev_attr_in0_input.attr,
> +	&dev_attr_in0_min.attr,
> +	&dev_attr_in0_max.attr,
> +	&dev_attr_in1_input.attr,
> +	&dev_attr_in1_min.attr,
> +	&dev_attr_in1_max.attr,
> +	&dev_attr_in2_input.attr,
> +	&dev_attr_in2_min.attr,
> +	&dev_attr_in2_max.attr,
> +	&dev_attr_in3_input.attr,
> +	&dev_attr_in3_min.attr,
> +	&dev_attr_in3_max.attr,
> +	&dev_attr_in4_input.attr,
> +	&dev_attr_in4_min.attr,
> +	&dev_attr_in4_max.attr,
> +	&dev_attr_in5_input.attr,
> +	&dev_attr_in5_min.attr,
> +	&dev_attr_in5_max.attr,
> +	&dev_attr_in6_input.attr,
> +	&dev_attr_in6_min.attr,
> +	&dev_attr_in6_max.attr,
> +
> +	&dev_attr_fan1_input.attr,
> +	&dev_attr_fan1_min.attr,
> +	&dev_attr_fan1_div.attr,
> +	&dev_attr_fan2_input.attr,
> +	&dev_attr_fan2_min.attr,
> +	&dev_attr_fan2_div.attr,
> +	&dev_attr_fan3_input.attr,
> +	&dev_attr_fan3_min.attr,
> +	&dev_attr_fan3_div.attr,
> +
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp1_max.attr,
> +	&dev_attr_temp1_max_hyst.attr,
> +	&dev_attr_temp2_input.attr,
> +	&dev_attr_temp2_max.attr,
> +	&dev_attr_temp2_max_hyst.attr,
> +	&dev_attr_temp3_input.attr,
> +	&dev_attr_temp3_max.attr,
> +	&dev_attr_temp3_max_hyst.attr,
> +	&dev_attr_temp4_input.attr,
> +	&dev_attr_temp4_max.attr,
> +	&dev_attr_temp4_max_hyst.attr,
> +
> +	&dev_attr_cpu0_vid.attr,
> +	&dev_attr_vrm.attr,
> +	&dev_attr_alarms.attr,
> +	&dev_attr_pwm1.attr,
> +	&dev_attr_pwm1_enable.attr,
> +
> +	NULL,
> +};

The rationale for leaving a comma at the end of the last line of arrays
is to minimize the diff when later adding a line at the end of that
array. In the case of a NULL-terminated list, nothing will ever be
added after that last line, so I'd say we don't want that last comma.

Thanks,
-- 
Jean Delvare

