From: Trent Piepho <tpiepho@freescale.com>
Date: Sun, 13 Apr 2008 00:12:13 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring deviceZ
Message-Id: <Pine.LNX.4.64.0804121208400.18542@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412173221.7b2a2f41@hyperion.delvare>
In-Reply-To: <20080412173221.7b2a2f41@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 12 Apr 2008, Jean Delvare wrote:
> On Thu, 3 Apr 2008 18:29:13 -0700 (PDT), Trent Piepho wrote:
>> Add controls that configure settings normally done by the BIOS.  Turned on
>> with CONFIG_SENSORS_LM63_SETUP
>
> What system do you need this for?

A new embedded device.  There is no bios, and we are the designers of the
hardware.  I want to configure the lm63 using Linux, because it's by far the
easiest and most convenient way to do it.  The hardware changes a lot, and the
way I want the LM63 configured changes with it.  And how it should be
configured isn't exactly written in stone somewhere.  I need to figure out
what I want by changing things are seeing how it works.

I realize that some of these settings aren't something the average desktop
user will want to change or see.  But for an embedded developer, they are
useful.  That why I made it an config option.  There are plenty of other
options in the kernel designed for embedded systems.

>> pwm1_polarity:  0 = low for fan off, 1 = low for fan on.  Changing the
>
> I am reluctant to accept this as a run-time option... It's a good thing
> that you preserve the fan speed, but still, one of the polarities is
> wrong, and wrong polarity doesn't bode well with automatic fan speed

If the default LM63 polarity is wrong, how is it supposed to be changed? 
Suppose the correct polarity depends on the hardware revision?  Or some
kind of configuration setting?  It's possible that the polarity of the lm63
will be controlled by a dip switch in the next hardware revision, as the
polarity also controls whether the lm63 comes out of reset with the fan on
or off, and if one can use pwm and fan speed monitoring at the same time.

One of the benefits of using embedded Linux vs something like vxworks is
that linux has things like sysfs.  You can debug your hardware just by
reading and writing to easily named files with the shell.  Beats needing to
recompile and and re-flash an entire image to change anything, or typing in
cryptic hex sequences to a debugger.

> control, which the LM63 implements: you'll end up with either fan at full
> speed (bad) or stopped (worse). The polarity should really be set
> before the driver is loaded and never changed after that.

Set by what?  Create a second lm63 setup only driver that does it?  Put a
copy of the LM63 driver into U-Boot and then add this setting to that
driver?  IMHO, it makes a lot more sense to add one more setting to a
driver and infrastructure that is already there, than to create some
entirely new system just to change one thing.

>> fan1_enable:  Enables/disables fan tach monitoring.  Turning this on/off
>>  	will create/remove the other fan related sysfs files.
>
> Again I am reluctant to make this a run-time selection, because you're
> not just enabling/disabling the tachometer function, you're also
> disabling/enabling the ALERT output which shares the same pin. Only one
> configuration is correct for the hardware setup, so it should be set
> once and for all before the driver is loaded.

Again, set by what?  I can move one resistor on my board and change the
lm63's connection from fan monitoring to alert output, so I want to be able
to configure the lm63 as well.  I want to see if both work, so I need
to be able to change the lm63 setting.

Think of it from my perspective and anyone else who is designing hardware. 
There is some LM63 setting we want to be able to change.  Do you add a
small bit of code to a driver that's already written, that you're already
loading, has all the infrastructure in place to make the code simple to
write, and will present the same interface for changing this settings as
changing all the other settings?  Or do you create some entirely new system
from scratch, that doesn't give you macros for register names or anything to
start with, and gives a different interface for changing this one setting than
is used to change everything else?  And what about when you want to change
these things while the system is running?  If you don't change them with the
lm63 driver, how does the lm63 driver cope with "something else" changing the
settings out from under it?

>> conv_rate:  Set the conversion rate, format is log2(frequency)
>
> I fail to see the point of this one, given that the driver caches the
> data for 1 second anyway?

It might make sense to lower the frequency to 1 Hz then, no?  I think the
default is 16 or 32 Hz.  I wonder how the conversion rate affects the
automatic fan speed control?  It doesn't trip instantly, there is some
filtering that goes on.  And the LM63's power consumption?  I suppose one
could test and measure these things, if only there was a convenient way to
change the conversion rate and then observe the effect.....

> pwm_auto_point1_temp_hyst: read/write
> pwm_auto_point[2-8]_temp_hyst: read only

Why not make them all read/write?  Then they could all be defined to use
the same store function and not need to worry if they should be read
only or not.

> This basically leaves only two or three configuration bits (pwm1_polarity,
> fan1_enable and maybe conv_rate if you can explain) that would belong
> to CONFIG_SENSORS_LM63_SETUP. Quite frankly, I'd rather see you use
> i2cset to write them to the LM63 chip at boot time, rather than adding
> code to the lm63 driver, even as a separate option. You'll have to

Well, why write a lm63 driver at all?  Just use i2cset for everything. 
Looking up register values in the datasheet and converting them to hex
bytes in your head gets old fast.  It's also very convenient to put
something like this:

echo $SYSCFG_PWM_POLARITY > /sys/class/hwmon/hwmon0/device/pwm1_polarity

In your startup script.  Instead of having to include i2cset and i2cdump on
your embedded device (there goes another sector of flash) and trying to
implement a script that sets the necessary bit.

> Preliminary note: many lines over 80 columns in your patch, please fix.

I thought this was just a warning now.  The long function names used in
this driver make some lines that are just a few characters over 80 columns
very ugly to wrap, which the existing driver code doesn't do either.  For
example, my function definition for set_pwm1_enable() is 83 character, but
the existing one for show_pwm1_enable() is 84.

>> +	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG_FAN, data->config_fan);
>
> You should not assume that data->config_fan was up-to-date. Do a proper
> read/modify/write cycle instead.

I thought lm63_update_device() would refresh it, but I see that's not the
case.

Still, only a few registers in the LM63 are "volatile" and will be changed
by the lm63 device.  For those that aren't, it's just a waste to re-read
them each time lm63_update_device() is called.  They won't change and
usually one doesn't care about their value anyway.

Now, one could change these registers with i2cset.  But there is no way to
have an *atomic* read/modify/write cycle with the i2c layer!  Assuming that
data->config_fan will remain valid for a 1 second cache is just as wrong as
assuming it's always valid in the face of something from outside the driver
modifying the lm63.

w.r.t config_fan, doesn't the existing code that uses it, e.g.
show_pwm1_enable(), have the exact same problem?  It calls lm63_update_device,
even though that doesn't update config_fan.  And then it prints config_fan
without refreshing it.


>> +	/* Invert duty cycle, to keep fan at the same setting */
>> +	data->pwm1_value = 2 * data->pwm1_freq - data->pwm1_value;
>
> Same for data->pwm1_value, it might not be up-to-date.

In this case I do call lm63_update_device(), which *does* update
pwm1_value.

It should be up-to-date, depending on how you define up-to-date.  Since
there is no way to lock the i2c bus, there will *always* be a race
condition if you allow something besides the lm63 driver to modify the
lm63.  IMHO, the only reasonable way to write the driver is to assume that
nothing else will be driving the chip at the same time.  If one can not
assume this, then every single hwmon driver is broken.  And since the
buses and chips involved do not support atomic transactions of the type
needed, there is no way to fix them.

>> +static ssize_t show_pwm1_polarity(struct device *dev,
>> +				  struct device_attribute *dummy, char *buf)
>> +{
>> +	struct lm63_data *data = lm63_update_device(dev);
>
> Why call lm63_update_device()? data->config_fan isn't updated by this
> function.

I just copied the code from show_pwm1_enable()

>> +	i2c_smbus_write_byte_data(client, LM63_REG_CONFIG1, data->config);
>> +	mutex_unlock(&data->update_lock);
>
> I don't like this... For one thing, removing files to create them right
> after is ugly. For another, libsensors scans sysfs for attributes at
> initialization time and doesn't expect attributes to be added or
> removed after that.

This isn't something that changes a lot, if ever, and it's the easiest way
to do it.  Otherwise it's a lot more work to become robust against sysfs
and the config work becoming out of sync.  I thought code simplicity and
clarity were more important than speed in this case.

libsensors would be OK, if one sets fan1_enable before starting whatever
app uses it, right?

>> +	/* Value is log2(rate) */
>> +	if (val < -4 || val > 5)
>> +		return -EINVAL;
>
> What a friendly unit ;)

Do you have a better unit that easily covers the range 1/16 to 32?  And is
easy to map to the closest power of two?  I didn't see any other controls for
a value like this to copy the units from.  And I figured, why make the driver
harder to write?  If someone doesn't like the units, they can convert them
in userspace.

>> +	data = i2c_smbus_read_byte_data(client, LM63_REG_CONV_RATE);
>
> Because this isn't cached, you're giving users an easy way to saturate
> the SMBus. Either make the attribute readable by root only, or cache
> its value.

I didn't want to add extra stuff to read in lm63_update_device().  Maybe I
should just make this root readable only, it's the least amount of code.

>> +	/* Only support the ranges [23, 700] and [5806, 180000] */
>
> And even then... frequencies 180 kHz, 90 kHz, 700 Hz and 350 Hz are
> hardly usable due to the chip design. I don't really consider PWM steps
> of 50% or 25% as acceptable. In particular when using automatic fan
> speed control, this would probably be awful. I think this is worth a
> note in Documentation/hwmon/lm63. Maybe also output the resulting PWM
> step resolution to the kernel log?

info or debug?  Even when there are just steps of 0%, 50%, 100%, it's still
useful.  You could have a fan that is normally off, but can turn on in an
emergency if the temp gets too high.  A simple on/off control could be enough. 
I've also found that small fans don't like pwm much, they seem to either be
off or nearly off, or on at full power.

>> +	mutex_lock(&data->update_lock);
>> +
>> +	if (val <= 700) {
>> +		data->config_fan |= 8;
>> +		freq = 1400;
>
> FWIW, the datasheet suggests that the frequency is actually 1406 Hz
> (see the Application Notes section 3.1)

You're right.  I bet it's 360 kHz / 256 = 1406.25 Hz.  From the AN, it
somewhere between 1406.2 and 1406.4.  It would probably give the most
accurate results to use the higher frequency, then shift by 8.  There's
got to be an interesting way to use that relationship.

>> +	long val = simple_strtol(buf, NULL, 0);
>> +
>> +	if (!(data->config_fan & 0x20)) /* registers are read-only */
>> +		return -EPERM;
>
> So basically the user has to set PWM in manual mode first before he/she
> can change the points of the automatic mode. While it makes some sense,
> other chips / drivers don't have this limitation, so it might be
> confusing. This should be documented in Documentation/hwmon/lm63.

It's a chip limitation and it didn't seem like I should work around it in the
driver, by turning auto fan mode off and back on.  What if there is an error
half way through and the fan mode gets left in manual mode, with the fan off?
Better to only turn the automatic fan off by explicit user request.

>> +	int data = i2c_smbus_read_byte_data(client,
>> +					    LM63_REG_PWM_AUTO_TEMP + nr * 2);
>
> Should be cached.

Adding all these registers to be read each time update_device is called would
be wasteful.  They don't change on their own.  Cache them once when the driver
loads?  Or have a lm63_update_pwmauto() function that just updates these
registers?

Maybe there is a smbus function that can read them all in one go,
I think the lm63 has an auto-incrementing index register.  That would
be more nice to use.

>> +static ssize_t show_pwm_auto_point_pwm(struct device *dev,
>
> Here again this function looks a lot like show_pwm1(), so it should be
> possible to share the code.

Indeed it should, if it's not going to be enabled by a configuration option. 
I didn't want to confuse the existing code by sticking ifdefs in it.

>> +	&dev_attr_pwm1_auto_hyst,

I forgot the .attr on this line, since fixed.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
