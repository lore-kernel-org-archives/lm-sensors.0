From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 16 Oct 2008 20:38:10 +0000
Subject: Re: [lm-sensors] [RFC v3] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <48F7A632.9040001@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081015212930.GA21854@ovro.caltech.edu>
In-Reply-To: <20081015212930.GA21854@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Ira Snyder wrote:
> Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
> Swap controller I2C monitoring interface.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> I've incorporated the suggestions from the latest posting of this
> driver.
> 
> I didn't see an easy way to combine the LTC4245_VOLTAGE and
> LTC4245_ALARM defines into a single #define. The in[1-4]_min_alarm bits
> are in the FAULT1 register, while the in[5-8]_min_alarm are in the
> FAULT2 register. I could do it with one more macro parameter, but I
> thought that was getting ugly and confusing. Comments?
> 

Looks good now, I've only got one minor issue left (which I'm afraid I missed 
in my reviews before).

> Also, I used a local variable named "current" in a few places. Checking
> the driver with sparse, I get a warning that I'm shadowing the "current"
> variable in arch/powerpc/include/asm/current.h. Should I change the name
> of my variable, or ignore the warning? There isn't any harm in it...
> 

Just ignore the warning.

<snip>

> +/* Return the voltage from the given register in millivolts */
> +static u32 ltc4245_get_voltage(struct device *dev, u8 reg)
> +{

Why dont you make this an s32 (or just an int) and then ..

> +	struct ltc4245_data *data = ltc4245_update_device(dev);
> +	const s32 val = data->vregs[reg - 0x10];
> +	const u8 regval = val;
> +	u32 voltage = 0;
> +
> +	if (unlikely(val < 0))
> +		return 0;
> +
> +	switch (reg) {
> +	case LTC4245_12VIN:
> +	case LTC4245_12VOUT:
> +		voltage = regval * 55;
> +		break;
> +	case LTC4245_5VIN:
> +	case LTC4245_5VOUT:
> +		voltage = regval * 22;
> +		break;
> +	case LTC4245_3VIN:
> +	case LTC4245_3VOUT:
> +		voltage = regval * 15;
> +		break;
> +	case LTC4245_VEEIN:
> +	case LTC4245_VEEOUT:
> +		voltage = regval * 55;

Make this * -55, and ...

<snip>

> +
> +static ssize_t ltc4245_show_voltage(struct device *dev,
> +				    struct device_attribute *da,
> +				    char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	const u32 voltage = ltc4245_get_voltage(dev, attr->index);
> +
> +	/* The VEEIN and VEEOUT registers are for -12V, so
> +	 * we add the negative sign on the output */
> +	if (attr->index = LTC4245_VEEIN || attr->index = LTC4245_VEEOUT)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", voltage * -1);
> +

Remove this special case, and make the %u below %d ?

> +	return snprintf(buf, PAGE_SIZE, "%u\n", voltage);
> +}
> +

<snip>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
