From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: pwm fan control with IT8705F I/O chip it87 module
Message-Id: <20041218111359.472afb14.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128203714.40067.qmail@web13425.mail.yahoo.com>
In-Reply-To: <20041128203714.40067.qmail@web13425.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonas,

Thanks for the patch and sorry for the delay, crazy week here...

> Here is an updated version of that patch. The pwm values are now
> stored internally as 8 bit instead of throwing away the lowest bit as
> it did earlier (the chip's pwm registers are 7 bit).

Well, why not... Doesn't change much actally, does it?

See my comments inline.

> -/* Reset the registers on init if true */
> -static int reset;

I'm very happy to see this one go :)

> @@ -200,6 +202,8 @@ struct it87_data {
>  	u8 vid;			/* Register encoding, combined */
>  	int vrm;
>  	u32 alarms;		/* Register encoding, combined */
> +	u8 fan_main_ctrl;	/* Register value */
> +	u8 manual_pwm_ctl[3];   /* Register encoding, shifted left */

This is more of a value than encoding.  Also, this is not really a
register value anymore since you will store the value given by the user
on 8-bit, and feed the register with a modified version of it. The fact
that the conversion operation is a simple 1-bit shift is incidental.
What manual_pwm_ctl really holds now is a "real" PWM value, not a
register encoding/value, right?

>  static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
>  {
>  	struct it87_data *data = it87_update_device(dev);
> -	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
> +	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]));

While you're at it, please add a white space after the first comma. Same
holds for the rest of the file, whether you modify lines or add them.

> +static ssize_t set_pwm_enable(struct device *dev, const char *buf,
> +		size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct it87_data *data = i2c_get_clientdata(client);
> +	int tmp;
> +	int val = simple_strtol(buf, NULL, 10);
> +
> +	if (val = 0) {
> +		data->fan_main_ctrl &= ~(1 << nr);
> +		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
> +		/* make sure the fan is on */
> +		tmp = it87_read_value(client, IT87_REG_FAN_CTL);
> +		if ((tmp & (1 << nr)) = 0)
> +			it87_write_value(client, IT87_REG_FAN_CTL, tmp | (1 << nr));

You can probably get rid of this check... See below.

> +	} else if (val = 1) {
> +		/* set SmartGuardian mode */
> +		data->fan_main_ctrl |= (1 << nr);
> +		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
> +		/* set saved pwm value and FAN_CTLX PWM mode bit */
> +		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));

Doesn't quite match your description of manual_pwm_ctl. This will work
OK in manual PWM mode, but if the chip was in automatic mode it'll
switch to manual at this point, right? So the FAN_CTLX PWM mode bit
isn't restored. I'm fine with the code, but the comment would need to be
updated.

> +#define show_pwm_offset(offset)						\
> +static ssize_t show_pwm##offset##_enable (struct device *dev,		\
> +	char *buf)							\
> +{									\
> +	return show_pwm_enable(dev, buf, 0x##offset - 1);		\

Get rid of the 0x## (in other functions too). Mark M. Hoffman got rid of
all of them some times ago (to my great pleasure, needless to say),
let's not introduce them anew.

> +	/* Set current fan mode registers and the default settings for the
> +	 * other mode registers */
> +	for (i = 0; i < 3; i++) {
> +		if (data->fan_main_ctrl & (1 << i)) {
> +			/* pwm mode */
> +			tmp = it87_read_value(client, IT87_REG_PWM(i));
> +			if (tmp & 0x80) {
> +				/* automatic pwm - not yet implemented, but
> +				 * leave the settings made by the BIOS alone
> +				 * until a change is requested via the sysfs
> +				 * interface */
> +			} else {
> +				/* manual pwm */
> +				data->manual_pwm_ctl[i] = PWM_FROM_REG(tmp);
> +			}
> +		} else {
> +			/* on/off mode, make sure the fan is on */
> +			tmp = it87_read_value(client, IT87_REG_FAN_CTL);
> +			if ((tmp & (1 << i)) = 0)
> +				it87_write_value(client,
> +						IT87_REG_FAN_CTL, tmp | (1 << i));
> +		}
> + 	}

The last part here could be simplified IMHO. Just do:
  tmp = it87_read_value(client, IT87_REG_FAN_CTL);
  it87_write_value(client, IT87_REG_FAN_CTL, tmp | 0x07);
to permanently "lock" fans to "on" in "on/off" mode. This is the
expected behavior according to our sysfs interface (pwm off = fan to
full speed).

Doing so spares you several checks and multiple reads/writes on the same
register. This also lets you get rid of some code in set_pwm_enable above.

Note that one could argue that we are not exactly doing the right thing
here. If any fan was in on/off mode and actually stopped (off), we will
fire it up here (both your code and mine) which is contrary to our
policy of non-intrusiveness. The correct behavior would be to switch to
manual PWM mode and set the duty cycle to 0. Or we can do it the other
way around, i.e. the driver would implement manual PWM 0 by switching
the fan to on/off mode, value off. This probably would waste less power
too. However this will make things more complex and I would agree not to
go that direction for now. This can be done at a later time is needed.

OK, looks good overall, please fix the few comment and coding style
issues, change the code where you agree with my proposals, and subit the
patch again. Don't forget to CC: Greg KH if you want him to catch it!

Thanks for the good work,
-- 
Jean Delvare
http://khali.linux-fr.org/
