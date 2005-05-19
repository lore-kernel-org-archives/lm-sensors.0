From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <20041021232959.64f86599.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I can already see that I should have done less cut 'N' pasting from
> the 2.4.X driver code.

This is a common "mistake" when porting the drivers. Most of the old
code in the lm_sensors project has known weaknesses and we try to clean
up everything we can on the way to 2.6.

> In the board I have access to(Arima HDAMA), the DAC is only used as
> one of two possible means to drive the speed-controlled fans. 
> Essentially it doesn't look any different to the end user than the PWM
> output.  I've chosen to expose it as the set of sysfs files:
> 
> pwm2
> pwm2_enable
> pwm2_auto_pwm_min
> 
> And allow the user to choose which "pwm" drives the fans, as only one
> is allowed control at a time.  In line with this decision, I intend to
> keep the visible value for the DAC (pwm2) on the same scale as pwm1
> (0-255).

That's an interesting approach, although different from what I did for
the lm87 driver.

One possible issue is that we support monitoring chips, not
motherboards. What if the DAC is used for something different on another
motherboard? This probably has yet to be seen though.

You may have hit a problem of our sysfs interface. The pwm* files should
probably have been named with a more neutral name, with the focus on the
function rather than the technical details. That would have hidden the
method (PWM or DAC) to the user, which may have been better (or not).

I have no strong objection to "faking" the DAC as a PWM output if it
makes everybody happy. This will have to be clearly documented in the
source code and/or the extra doc files though.

BTW, how are pwm1 and pwm2 (aka DAC) linked? if pwm1 and pwm2 correspond
to the same output, shouldn't they be a single pwm file?

> (2) pwmN_auto_pwm_min values initialize at their maximum value of 15.

Should be scaled so that this max value matches the max pwm value
(around 250).

> I just decided that a pwm structure would help keep things tidy
> variable- wise and enforce the association of pwmN with pwmN_enable
> and pwmN_auto_pwm_min, making the code more easily parseable for other
> people besides myself.
> 
> Is there any reason *not* to do this?

No, I was simply curious.

> >dev_dbg will already print "adm1026" in front of the line if I'm not
> >mistaking, so you shouldn't repeat it.
> 
> It also looks like it prints out the bus id string, so I can drop
> "(%d)" as well.  Right?

It's a different id. dev_dbg prints the bus id, while the %d is the chip
id (which is only really needed if you have more than one adm1026 chip
on the system). Other drivers don't print the chip id as far as I
remember, but if you want to keep it, feel free to do.

> > >static ssize_t set_fan_min(struct device *dev, const char *buf,
> > >		size_t count, int nr)
> > >{
> > >	struct i2c_client *client = to_i2c_client(dev);
> > >	struct adm1026_data *data = i2c_get_clientdata(client);
> > >	int     val;
> > >
> > >	down(&data->update_lock);
> > >	val = simple_strtol(buf, NULL, 10);
> > >	data->fan_min[nr] = FAN_TO_REG(val, data->fan_div[nr]);
> > >	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
> > >		data->fan_min[nr]);
> > >	up(&data->update_lock);
> > >	return count;
> > >}
> > 
> > I see no reason to use the update_lock semaphore here. Other I2C
> > client drivers don't.
> 
> I started reviewing the other drivers, and noticed that several of
> them embedded the use of the update_lock semaphore in their
> "XXXX_write_value" functions as opposed to the "set_XXX" functions.  I
> admit to blindly following observed behavior here.  Can you enlighten
> me on the subject?  It looks as if the other drivers still use
> update_lock...

Well, both ways are similar except that if put it the write funtion the
code isn't duplicated. However this prevents the use of the write
function from the update function, since it already holds a lock on the
semaphore.

In most cases I don't see why a lock is needed at all at this point. If
there is a concurent read or write, even to the same register, I don't
see how the use of a lock will change the outcome. However, the lock
shouldn't hurt either, so if you feel better with it, I have no strong
objection.

> > >	device_create_file(&new_client->dev, &dev_attr_temp1_therm);
> > >	device_create_file(&new_client->dev, &dev_attr_temp2_therm);
> > >	device_create_file(&new_client->dev, &dev_attr_temp3_therm);
> > 
> > What are these files for?
> 
> Fooey.  I left these in from the 2.4.X driver, and never noticed that
> there needed to be a way presented to turn the "therm" function on. 
> My fault for assuming that the old driver was had the complete set of
> necessary files.
> 
> I just added:
> 
> temp_therm_enable  (values {0,1})
> 
> to the list of sysfs files and the associated:
> 
> show_temp_therm_enable();
> set_temp_therm_enable();
> 
> functions.
> 
> The adm1026 has a set of 3 registers (one for each temperature
> channel) that allow for a "maximum failsafe" temperature to be set. 
> As you might guess, when any one of the temperatures reaches its
> respective therm value, an interrupt is generated, and all fans go to
> full speed.  This operates independently of the temperature-moderated
> fan control.
> 
> Because it operates independently of the automatic fan control, it
> seems improper to lump it in with the "tempN_auto_pointM_temp" group. 
> Were I to do so, and create "temp[123]_auto_point3_temp", then when
> automatic fan control was enabled, there would be TWO distinct points
> at which the fans would be expected to go to full speed.
> 
> (1)  temp[123]_auto_point2_temp, which is fixed internally by the chip
> at
>      temp[123]_auto_point1_temp + 20 degrees C
> (2)  temp[123]_auto_point3_temp  (AKA, temp[123]_therm)
> 
> This looks obnoxiously confusing.  Moreover, it obscures the reason
> for the existence of tempN_therm, which is to provide a guaranteed
> failsafe "keep- the-magic-smoke-in-the-system" mechanism, no matter
> whether the PWM/DAC output is being manually or automatically
> controlled.

Agreed that it doesn't fit well in the auto-pwm logic.

I think I would simply call these entries temp[123]_crit. It's common
that chips do take actions when critical limits are crossed.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
