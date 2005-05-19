From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [Patch 2.6] it87 part3(pwm)
Message-Id: <20040314112925.585987a3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040313143512.571098a9.komoriya@paken.org>
In-Reply-To: <20040313143512.571098a9.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ohaio Takeru,

(As you can see I just learnt a fourth Japanese word ;))

> Sorry for long silence but I want to go on adding some features
> to it87 for 2.6.

No problem.

> Here's a patch to add pwm[1-3] and pwm_enable[1-3].
> pwm[1-3] are bit different from the ones for 2.4.

Note that the sysfs files naming scheme has changed and pwm_enable[1-3]
is now pwm[1-3]_enable.

> Documentation/i2c/sysfs-interface says that the values for
> pwm[1-3] should be 0-255 while it87 documentation for 2.4 says:
>    Bit 7 of the pwm[1-3] registers enables/disables the chips 
>    automatic temperature control mode for the specified fan.
> 
> I am not sure but I feel it's better to prepare another sysfs
> entry(e.g. sg_enable) for "automatic temperature control mode".
> pwm[1-3] accepts 0-255 with this trial patch. 

You're right, this is the correct way to do the things. Please consider
submitting a patch that changes the CVS driver in the same way as well.
This may be delayed until after your smartguardian patch for 2.6 (since
I guess there will be one).

I'd like to make sure I understand how fan control works for the IT87.
It seems to be a little bit complex, so I'd like you to confirm that I
got it right.

There are three different modes for each fan:

1* On/Off: Bits 2-0 of register 0x13 are clear. Fans are controlled by
bits 0-2 of register 0x14.

(BTW we never access these bits of register 0x14, if I'm not mistaking.
Shouldn't these bits be exported for user control as fan[1-3]_enable?)

2* Manual PWM: Bits 2-0 of register 0x13 are set. Bit 7 of registers
0x15-0x17 is clear. Bits 6-0 of registers 0x15-0x17 control the fan
speed.

3* Auto PWM: Bits 2-0 of register 0x13 are set. Bit 7 of registers
0x15-0x17 is set. Bits 1-0 of registers 0x15-0x17 and various other
"SmartGuardian" registers control the fan speed.

Is this correct?

> BTW, I have not subscribed to this list.
> Would you add me to the list?

Request sent to Phil, should be processed soon ;)

> +#define PWM_TO_REG(val) ((val)<0?0:(val)>255?127:((val)/2))
> +
> +#define PWM_FROM_REG(val) (((val)&0x7f)*2)

I think that /2 should be >>1 and *2 should be <<1. But maybe it'e just
me.

The limit checking in PWM_TO_REG seems unnecessary since you already do
it in set_pwm() below.

> +static ssize_t show_pwm(struct device *dev, char *buf, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct it87_data *data = i2c_get_clientdata(client);
> +	it87_update_client(client);
> +	return sprintf(buf,"%d\n", PWM_FROM_REG(data->pwm[nr]));
> +}

A recent refactoring has been proposed by MMH and accepted. Update
functions now return the data structure, so the callback functions are
more simple.

I invite you to use 2.6.4-mm1 as the base for your patch. It aleady has
your two previous patches.

> +static ssize_t show_pwm_enable (struct device *dev, char *buf, int
> nr)+{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct it87_data *data = i2c_get_clientdata(client);
> +	it87_update_client(client);
> +	if (data->fan_ctrl & (1 << nr))
> +	    return sprintf(buf, "1\n");
> +	return sprintf(buf, "0\n");
> +}

return sprintf(buf, "%d\n", (data->fan_ctrl & (1 << nr)) != 0);?

> +static ssize_t set_pwm_enable (struct device *dev, const char *buf,
> +		size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct it87_data *data = i2c_get_clientdata(client);
> +	int val = simple_strtol(buf, NULL, 10);
> +
> +	data->fan_ctrl &= ~(1 << nr);
> +	if (val = 1)
> +	    data->fan_ctrl |= 1 << nr;
> +	else if (val != 0)
> +	    return -1;
> +	data->fan_ctrl |= 0x70;

I don't think that enabling one PWM should possibly affect the other
fans, so it would be "data->fan_ctrl |= 1 << (nr+4);".

> +static ssize_t show_fan_##offset##_pwm (struct device *dev, char
> *buf)	\+{									\
> +	return show_pwm(dev, buf, 0x##offset - 1);			\
> +}									\
> +static ssize_t show_pwm_##offset##_enable (struct device *dev		\
> +					   , char *buf)			\
> +{									\
> +	return show_pwm_enable(dev, buf, 0x##offset - 1);		\
> +}									\

Care to "symmetrize" the function names? show_fan_##offset##_pwm should
be show_pwm_##offset IMHO.

> +static ssize_t set_fan_##offset##_pwm (struct device *dev, 		\
> +		const char *buf, size_t count) 				\
> +{									\
> +	return set_pwm(dev, buf, count, 0x##offset - 1);		\
> +}									\
> +static ssize_t set_pwm_##offset##_enable (struct device *dev, 	
> \+		const char *buf, size_t count) 				\
> +{									\
> +	return set_pwm_enable(dev, buf, count, 0x##offset - 1);		\
> +}									\

Same here.

Looks good otherwise.

Just one more thing I'd like to hear you about. Bits 1-0 of registers
0x15-0x17 have two different meanings, depending on the value of bit 7
of the same register.

This is likely to cause trouble when one wants to change from automatic
PWM to manual, or the other way around. Since we split the register into
two sysfs files (PWM value and PWM enable), it isn't possible to set the
value of the corresponding register at once. Changing the mode (bit 7)
without also changing bits 6-0 would possibly result in a wrong
intermediate configuration.

(BTW, your code above never checks that bit 7 of these registers is
clear, does it? It should, even if that will change later with your
SmartGuardian patch. You should never accept writing a PWM value to the
register if it's in automatic mode, since the value wouldn't make any
sense. Likewise, you should not return the PWM value if the bit 7 is
set, since bits 6-0 then don't hold a PWM value then.)

I think that the correct way to handle this situation is to store sets
of bits in several internal variables, not just one. Something like:

	u8 pwm_mode[3];
	u8 pwm_value[3];
	u8 pwm_temp[3];

pwm_mode would hold bit 7, pwm_value would hold bits 6-0 when mode is
manual, pwm_temp would hold bits 1-0 when mode is auto.

You would be able to initialize either pwm_value or pwm_temp at driver
load time, depending on the value of pwm_mode. You would have to set a
reasonable default value for the other (0x7f for pwm_value and N for
pwm_temp[N] seems to make sense).

The idea behind that is that you would then be able to change modes
without a wrong intermediate situation. Say that the user switches from
auto to manual, you would be able to write a combination of pwm_mode and
pwm_value into the register. When switching from manual to auto, you
combine pwm_mode and pwm_temp. And you don't lose any information doing
so.

This first patch may look a bit strange because we have to think of
SmartGuardian without actually supporting it. Still this is an
interesting execise IMHO, which forces us to think twice to what we do
and how we do it, and ensures that we correctly understood how things
have to work.

I hope I have been clear. If not, just tell me and I'll make my best to
be clearer.

And if I just got everything plain wrong and what I said just doesn't
make any sense to anyone (which is always possible), tell me too ;)

Aligato :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
