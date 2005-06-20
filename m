From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 20 Jun 2005 08:02:05 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <20050619190933.6af07e7d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <429CEBC2.80609@hasw.net>
In-Reply-To: <429CEBC2.80609@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

> Ok, here's a patch against 2.6.12-rc6.
> (...)
> I've now added only support for the auto-pwm with slope setting and a
> check for  revision 3.

Here is my review of your patch. Sorry for the delay.

>  static u16 chip_type;
> +static u8  chip_revision;

No space alignment in the kernel code. Either align with tabs, or don't
align.

> +#define IT87_REG_SG_TEMP_OFF(nr) 	(0x60 + (nr) * 8)
> +#define IT87_REG_SG_TEMP_START(nr)	(0x61 + (nr) * 8)
> +#define IT87_REG_SG_TEMP_FULL(nr)	(0x62 + (nr) * 8)
> +#define IT87_REG_SG_START_PWM(nr)	(0x63 + (nr) * 8)

This last name isn't logical, should be IT87_REG_SG_PWM_START (or swap
the other ones, at your option).

> +#define SLOPE_FROM_REG(val) ((val) ? (1 << (val-1)) : 0)

Parentheses are not properly placed for macro safety. It should be:

#define SLOPE_FROM_REG(val) ((val) ? 1 << ((val)-1) : 0)

> +	u8 fan_limit_off[3];	/* Register value */
> +	u8 fan_limit_start[3];	/* Register value */
> +	u8 fan_limit_full[3];	/* Register value */
> +	u8 fan_limit_stpwm[3];	/* Register value */
> +	u8 fan_am_ctrl[3];	/* Register value */
> +	u8 fan_point2_pwm[3];	/* Used for slope calculation */

I don't much like the names you chose. For one thing, it's not obvious
that they are for SmartGuardian/auto-PWM. You should prefix them with
sg_ or auto_pwm_ rather than fan_. For another, temperature values
aren't clearly labelled as such. What about sg_temp_off, sg_temp_start,
sg_temp_full, sg_pwm_start, sg_am_ctrl and sg_pwm_point2?

> +static void calc_slope(struct it87_data *data, int nr)
> +{
> +	u8 val = data->fan_point2_pwm[nr];
> +	
> +	if (data->fan_limit_full[nr] <= data->fan_limit_start[nr])
> +		val = 14;
> +	else {
> +		val -= data->fan_limit_stpwm[nr];
> +		val /= (data->fan_limit_full[nr] - data->fan_limit_start[nr]);
> +	}

Where does this "14" value come from? If full speed temperature happens
to be below the start temperature, we're in trouble anyway, so why
bother?

+	data->fan_am_ctrl[nr] &= ~0x03;

Shouldn't this be ~0x07?

+	if (val > 48)
+		data->fan_am_ctrl[nr] |= 0x07;	/* 64 PWM / K */

What does the "K" stands for? Kelvin? I think "PWM/degree" would be
clearer.

> +	/* Automatic mode - SmartGuardian */
> +	val += (val && (data->manual_pwm_ctl[nr] & 0x80)) ? 1 : 0;

An "if" statement would be clearer IMHO.

> +	return sprintf(buf,"%d\n", val);

Add a space after the first comma (there are many of these in the rest
of the patch).

> +	/* Return 0 if automatic mode is enabled */
> +	return sprintf(buf,"%d\n", (data->manual_pwm_ctl[nr] & 0x80) ? 0 : PWM_FROM_REG(data->manual_pwm_ctl[nr]));

This is unsafe. You should hold the lock (&data->update_lock), else
data->manual_pwm_ctl[nr] may have a different on second read, and you
may display a completely bogus PWM value. Same is true for all other
functions in which you access more than one field of the data structure
(or one, but more than once), you have to hold the lock.

> +			/* Enable temperature smoothing and fan spin up  time */

Extra space between "up" and "time". What is this spin up time BTW? The
datasheet is unclear, to say the least.

> +			data->fan_am_ctrl[nr] = 0x80 | 0x18;
> +			it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
> +			/* If start pwm and pwm step size not set, apply safe values */
> +			if (data->fan_limit_stpwm[nr] = 0) {
> +				data->fan_limit_stpwm[nr] = PWM_TO_REG(128);
> +				it87_write_value(client, IT87_REG_SG_START_PWM(nr), data->fan_limit_stpwm[nr]);
> +			}
> +			if ((data->fan_am_ctrl[nr] & 0x07) = 0) {
> +				/* 16 PWM values / K */
> +				data->fan_am_ctrl[nr] |= 0x05;
> +				it87_write_value(client, IT87_REG_SG_AM_CTRL(nr), data->fan_am_ctrl[nr]);
> +			}

This isn't correct. Tracking data->fan_am_ctrl[nr], I can see you are
setting it to 0x98, then writing it to the chip, then testing it with &
0x07 = 0 (will always be true), set it to 0x9D and write it to the chip
again. This isn't correct. You must not change the slope value if it was
set to a sane value before, and you must not write twice to the same
register (waste of time).

> +	data->fan_limit_start[nr] = val;

This lacks a sanity check. Same for the two other ones.

As a side note, I think I would have forced point2's PWM value to 255,
rather than letting the user set it. Having this PWM value too low will
have bad effects due to the lack of hysteresis (the fan will go from low
speed to full speed and back again and again), forcing it to be as near
from full speed as possible would solve this problem.

> +static ssize_t set_pwm_auto_channels_temp(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
> (...)
> +	if (val < 0 || val > 4)
> +		return -EINVAL;

3 isn't a valid value, but will pass through.

> +		data->manual_pwm_ctl[nr] = 0x80 | (val >> 1);

This bit shifting is a trick which happens to work in this specific
case, but wouldn't work anymore if there were a 4th temperature channel,
for example. So please don't use it.

> +	/* Set current fan mode registers */
> +	for (i = 0; i < 3; i++) {
> +		data->manual_pwm_ctl[i] = it87_read_value(client, IT87_REG_PWM(i));
> +	
> +		/* Get fan control registers for SmartGuardian automatic mode */
> +		data->fan_limit_off[i] = it87_read_value(client, IT87_REG_SG_TEMP_OFF(i));
> +		data->fan_limit_start[i] = it87_read_value(client, IT87_REG_SG_TEMP_START(i));
> +		data->fan_limit_full[i] = it87_read_value(client, IT87_REG_SG_TEMP_FULL(i));
> +		data->fan_limit_stpwm[i] = it87_read_value(client, IT87_REG_SG_START_PWM(i));
> +		data->fan_am_ctrl[i] = it87_read_value(client, IT87_REG_SG_AM_CTRL(i));
> +	}

This doesn't belong to the init function but to the device_update
function. Additionally, you should do this if and only if the device
actually supports the auto-pwm code (so you have to remember this in
some structure field).

Please provide an updated patch. Don't forget to also update the
revision detection code. You have to check for different revision for
the IT8705F and IT8712F chips, so you really have to test the
combination of chip and revision.

Thanks,
-- 
Jean Delvare
