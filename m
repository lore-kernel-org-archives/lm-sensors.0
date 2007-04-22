From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Apr 2007 19:07:29 +0000
Subject: Re: [lm-sensors] Need some guidance on adhering to the sysfs
Message-Id: <20070422210729.5c361567@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On Thu, 19 Apr 2007 11:13:20 -0600, George T. Joseph wrote:
> > On Thu, 12 Apr 2007 10:50:30 -0600, George T. Joseph wrote:
> > > These chips have 2 temp points.  The low temp (auto_point1_temp) is
> > > simple enough to map to the corresponding register.  The high point
> > > (auto_point2_temp) isn't so easy because it's implemented as a range
> > > with the low temp as a base.  Even worse, range is not an arbitrary
> > > value; it's a value from a list of 16.  So if a user 
> > > chooses 26 for a low point and 50 for a high point, that's a range of
> > > 24 except that 24 isn't a valid range value.  The closest values are
> > > either 20 or 26.67.
> > > Also, if the user sets the high point then changes the low 
> > > point, the high point will probably have to be changed because the new
> > > calculated range might not be a valid value.
> > 
> > Pick the nearest possible value for auto_point2_temp. If
> > auto_point1_temp is changed afterwards, indeed the range register
> > should be adjusted so that auto_point2_temp is preserved as much as
> > possible (principle of least surprise). I understand there 
> > will be some
> > loss, but that's better than ignoring the issue altogether. I do not
> > expect it to be a big deal in practice, as I think the users typically
> > set auto_point1 first.
> 
> OK, I can do that but rather than "nearest" point I'll have to go with
> the lower range value because the higher range value could result in a
> heat related failure.

Well, the user (or user-space application) should never assume that the
value he/she wrote to the sysfs file is exactly what will be applied.
The sysfs file should always be read back afterwards for confirmation.
The value can always be constrained into an arbitrary range or
resolution be trimmed to fit in the register. But I'm fine either way.

> > > Auto_point_pwm is also an issue.  Where there are 4 temp 
> > zones, there
> > > are only 3 pwm outputs and the assignment of pwm to zone 
> > can be changed
> > > by the user or automatically by the chip.   
> > 
> > Automatically, based on what?
> > What is a "temp zone" for this device?
> > 
> > We have a mapping file (auto_channels) between PWM outputs and
> > temperature inputs which is supposed to address this issue.
> 
> The chip has 4 "zones".  Each zone can be configured from 7 sources
> available: 2 remote diodes, the internal chip temp, and 4 PECI bus
> temps.  I've created a temp[1-4]_source file for this.

Let me make sure I understand how the chip works. The chip has 7
temperature inputs, but only 4 can be active at the same time? Or it
has 7 temperature inputs and only 4 can be used for automatic fan speed
control at a given time?

There's only one temperature input in each zone at any given time?

> There are 3 PWM
> outputs, each of which can be controlled by a single zone, or by the
> "hottest of zone 2 or 3",  "hottest of zone 1, 2, or 3", or "hottest of
> zone 1, 2, 3, or 4".  "hottest" is determined in real time by the chip.
> The actual zone controlling a pwm output at any point in time is found
> in a separate register.  I have that exposed as
> pwm[1-3]_auto_zone_assigned.

Am I right assuming that user-space could easily compute this by
comparing the temperature values directly?

> Min and max pwms are associated to the pwm output itself while the temp
> min and maxes are associated to the zones.  Hence the following is valid
> and what I expose...
> pwm[1-3]_auto_channels_temp
> pwm[1-3]_auto_point[1-2]_pwm
> temp[1-4]_auto_point[1-2]_temp
> temp[1-4]_auto_point[1-2]_temp_hyst

This fits OK in the current standard interface, right?

> Another little issue I just realized has to do with what happens to pwm
> output when a temp is BELOW the minimum for the zone.  You can configure
> the pwm output to be either off or run at the minimum set.  If you want
> it to be off, you can't just set the min pwm to 0 because that would
> imply that when the temp does rise to the min temp, the pwm slope would
> start from 0.  That's not good because the fan might not even run until
> the pwm duty cycle is above 50 or 75.

This is a common issue. Most chips include a "spin-up" duty-cycle,
duration pair which is used whenever a PWM output goes from zero to
non-zero in automatic mode. I assume your chip does something like that
(even if it the duty cycle and duration might not be configurable)?

> The behavior needed is that when
> the temp is below the min, the fan is off, when the temp reaches the min
> temp, the fan runs at the min pwm duty cycle then scales up as the temp
> does.  So, I'll have to create a separate sysfs file for this control
> and it's going to need a name.  Can you suggest one that means "turn the
> pwm off if the temp is below the auto_point1_temp"?  
> Maybe pwm[1-3]_auto_point1_pwm_off_if_below :)

In fact, several other chips have a similar feature, but we never
bothered exposing it (i.e. the user has to live with the chip's default
or whatever the BIOS set.) If you really want to expose this, I have no
idea of a nice file name for it, sorry. Name it what you want.

> (...)
> > Feel free to create a file under Documentation/hwmon for your driver
> > and document the limitations if you think the user might be confused.
> 
> It's not difficult, just convoluted.  I have to synthesize sysfs files
> from multiple registers which weren't designed to be related by the
> manufacturer.

You can as well see it the other way around. The manufacturer decided
to split a given information into two separate registers, or to have
one register for two different things. Our standard defines individual
values, one value per file, chips sometimes don't.

> I have a documentation file ready but I'm afraid that rather than
> describing the capabilities of the chip it's going to be mostly
> explaining the fallout from shoehorning it into a shoe that's one size
> to small. :)

Don't blame the standard. Blame the manufacturers for coming up with
different limitations and weird ways of expressing similar ideas with
each new device they design. For example, the fact that only a limited
number of discrete temperature ranges between the two trip points are
allowed is really a limitation of the device. No better standard on our
side would help there. That's exactly the kind of thing I think is
worth documenting. This should save us a number of support mails from
the users.

> > > 3) Adhere to the standard where possible without creating 
> > > the compound relationships.  So what I'd do is...
> > >  temp[1-4]_auto_point_temp_min
> > >  temp[1-4]_auto_point_temp_range
> > >  temp[1-4]_auto_point_temp_hyst
> > >  pwm[1-3]_auto_channels_temp
> > >  pwm[1-3]_auto_point_pwm_min
> > >  pwm[1-3]_auto_point_pwm_max
> > > 
> > > 4) Or I could just name them what they're named in the data sheet...
> > > 
> > >  temp[1-4]_fan_temp_limit
> > >  temp[1-4]_range
> > >  temp[1-4]_hyst
> > >  pwm[1-3]_config
> > >  pwm{1-3]_min
> > >  pwm[1-3]_max
> > 
> > This would be particularly confusing, as these names don't show the
> > relations between the items.
> 
> Which is confusing, 3 or 4?  I agree that 4 might be but 3 is as
> straightforward as you can get.

I meant that proposal 4 was confusing, at least with these short names.
The user can't guess what the files really do without reading the
datasheet or documentation. Proposal 3 is a bit better, but not perfect
either. For example, you know that temp[1-4]_auto_point_temp_range is
the difference between temp[1-4]_auto_point_temp_min (which exists) and
temp[1-4]_auto_point_temp_min (which doesn't exist.) But how does the
user know that? He/she can guess, but maybe he/she won't.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
