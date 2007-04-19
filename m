From: "George T. Joseph \(development\)" <gtj.devel@peakin.com>
Date: Thu, 19 Apr 2007 23:30:11 +0000
Subject: Re: [lm-sensors] Need some guidance on adhering to the sysfs
Message-Id: <22E26940476D1E48AA6F292B5316C9C33810@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33804@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I like it.  It fits. 

> -----Original Message-----
> From: Juerg Haefliger [mailto:juergh@gmail.com] 
> Sent: Thursday, April 19, 2007 1:04 PM
> To: George T. Joseph (development)
> Cc: Jean Delvare; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Need some guidance on adhering to 
> the sysfs standards
> 
> George, Jean,
> 
> I'm struggling with the same issue for the DME1737 I'm currently
> working on. This chip also features temp zones and "hottest of x,y,z"
> PWM control. The current sysfs standard is not flexible enough to
> handle these features, especially the combination of a single PWM
> being controlled by multiple temp inputs and multiple PMWs being
> controlled by the same temp input. I believe we need another layer of
> mapping. I.e. temp->pwm is not sufficient, but rather temp->zone->pwm.
> 
> I therefore propose the add the following sysfs attributes to 
> our standard:
> 
> zone[1-*]_auto_channels_temp   for temp-to-zone mapping
> pwm[1-*]_auto_channels_zone   for zone-to-pwm mapping
> zone[1-*]_auto_point[1-*]_temp   for zone temp auto points.
> 
> What do you guys think?
> 
> ...juerg
> 
> 
> 
> On 4/19/07, George T. Joseph (development) 
> <gtj.devel@peakin.com> wrote:
> > Thanks Jean,
> >
> > More comments in line...
> >
> > george
> >
> > > -----Original Message-----
> > > From: Jean Delvare [mailto:khali@linux-fr.org]
> > > Sent: Thursday, April 19, 2007 8:48 AM
> > > To: George T. Joseph (development)
> > > Cc: lm-sensors@lm-sensors.org
> > > Subject: Re: [lm-sensors] Need some guidance on adhering to
> > > the sysfs standards
> > >
> > > Hi George,
> > >
> > > On Thu, 12 Apr 2007 10:50:30 -0600, George T. Joseph
> > > \(development\) wrote:
> > > > I'm wrapping up the Andigilog driver and am having problems
> > > trying to
> > > > adhere to the sysfs auto_point definitions.
> > > >
> > > > These chips have 2 temp points.  The low temp 
> (auto_point1_temp) is
> > > > simple enough to map to the corresponding register.  
> The high point
> > > > (auto_point2_temp) isn't so easy because it's 
> implemented as a range
> > > > with the low temp as a base.  Even worse, range is not 
> an arbitrary
> > > > value; it's a value from a list of 16.  So if a user
> > > chooses 26 for a
> > > > low point and 50 for a high point, that's a range of 24
> > > except that 24
> > > > isn't a valid range value.  The closest values are either
> > > 20 or 26.67.
> > > > Also, if the user sets the high point then changes the low
> > > point, the
> > > > high point will probably have to be changed because the new
> > > calculated
> > > > range might not be a valid value.
> > >
> > > Pick the nearest possible value for auto_point2_temp. If
> > > auto_point1_temp is changed afterwards, indeed the range register
> > > should be adjusted so that auto_point2_temp is preserved 
> as much as
> > > possible (principle of least surprise). I understand there
> > > will be some
> > > loss, but that's better than ignoring the issue 
> altogether. I do not
> > > expect it to be a big deal in practice, as I think the 
> users typically
> > > set auto_point1 first.
> >
> > OK, I can do that but rather than "nearest" point I'll have 
> to go with
> > the lower range value because the higher range value could 
> result in a
> > heat related failure.
> >
> > >
> > > > Auto_point_pwm is also an issue.  Where there are 4 temp
> > > zones, there
> > > > are only 3 pwm outputs and the assignment of pwm to zone
> > > can be changed
> > > > by the user or automatically by the chip.
> > >
> > > Automatically, based on what?
> > > What is a "temp zone" for this device?
> > >
> > > We have a mapping file (auto_channels) between PWM outputs and
> > > temperature inputs which is supposed to address this issue.
> >
> > The chip has 4 "zones".  Each zone can be configured from 7 sources
> > available: 2 remote diodes, the internal chip temp, and 4 PECI bus
> > temps.  I've created a temp[1-4]_source file for this.  
> There are 3 PWM
> > outputs, each of which can be controlled by a single zone, or by the
> > "hottest of zone 2 or 3",  "hottest of zone 1, 2, or 3", or 
> "hottest of
> > zone 1, 2, 3, or 4".  "hottest" is determined in real time 
> by the chip.
> > The actual zone controlling a pwm output at any point in 
> time is found
> > in a separate register.  I have that exposed as
> > pwm[1-3]_auto_zone_assigned.
> >
> > Min and max pwms are associated to the pwm output itself 
> while the temp
> > min and maxes are associated to the zones.  Hence the 
> following is valid
> > and what I expose...
> > pwm[1-3]_auto_channels_temp
> > pwm[1-3]_auto_point[1-2]_pwm
> > temp[1-4]_auto_point[1-2]_temp
> > temp[1-4]_auto_point[1-2]_temp_hyst
> >
> > Another little issue I just realized has to do with what 
> happens to pwm
> > output when a temp is BELOW the minimum for the zone.  You 
> can configure
> > the pwm output to be either off or run at the minimum set.  
> If you want
> > it to be off, you can't just set the min pwm to 0 because that would
> > imply that when the temp does rise to the min temp, the pwm 
> slope would
> > start from 0.  That's not good because the fan might not 
> even run until
> > the pwm duty cycle is above 50 or 75.  The behavior needed 
> is that when
> > the temp is below the min, the fan is off, when the temp 
> reaches the min
> > temp, the fan runs at the min pwm duty cycle then scales up 
> as the temp
> > does.  So, I'll have to create a separate sysfs file for 
> this control
> > and it's going to need a name.  Can you suggest one that 
> means "turn the
> > pwm off if the temp is below the auto_point1_temp"?
> > Maybe pwm[1-3]_auto_point1_pwm_off_if_below :)
> >
> > >
> > > > Finally, there's only 1 hysteresis value per zone, not 1
> > > per auto_point
> > > > so should I do an auto_point1_temp_hyst and an
> > > auto_point2_temp_hyst and
> > > > have them both point to the same register or maybe a
> > > > auto_point_temp_hyst without an index?
> > >
> > > Make auto_point1_temp_hyst writable and auto_point2_temp_hyst
> > > read-only.
> >
> > Easy enough.
> >
> > >
> > > > I guess I have 4 options...
> > > >
> > > > 1) Don't implement auto_point functionality at all.  A 
> bad choice I
> > > > believe.
> > > >
> > > > 2) Implement the logic to get as close as possible to the
> > > standard but
> > > > this is going to be very confusing to a user especially 
> the range
> > > > business since changing 1 value can force change of others.
> > >  It's also
> > > > going to increase the complexity of the driver significantly.
> > >
> > > Yes, please do this. It shouldn't be so hard. See my advice above.
> > >
> > > Feel free to create a file under Documentation/hwmon for 
> your driver
> > > and document the limitations if you think the user might 
> be confused.
> >
> > It's not difficult, just convoluted.  I have to synthesize 
> sysfs files
> > from multiple registers which weren't designed to be related by the
> > manufacturer.
> >
> > I have a documentation file ready but I'm afraid that rather than
> > describing the capabilities of the chip it's going to be mostly
> > explaining the fallout from shoehorning it into a shoe 
> that's one size
> > to small. :)
> >
> > >
> > > > 3) Adhere to the standard where possible without creating
> > > the compound
> > > > relationships.  So what I'd do is...
> > > >  temp[1-4]_auto_point_temp_min
> > > >  temp[1-4]_auto_point_temp_range
> > > >  temp[1-4]_auto_point_temp_hyst
> > > >  pwm[1-3]_auto_channels_temp
> > > >  pwm[1-3]_auto_point_pwm_min
> > > >  pwm[1-3]_auto_point_pwm_max
> > > >
> > > > 4) Or I could just name them what they're named in the 
> data sheet...
> > > >
> > > >  temp[1-4]_fan_temp_limit
> > > >  temp[1-4]_range
> > > >  temp[1-4]_hyst
> > > >  pwm[1-3]_config
> > > >  pwm{1-3]_min
> > > >  pwm[1-3]_max
> > >
> > > This would be particularly confusing, as these names 
> don't show the
> > > relations between the items.
> > >
> >
> > Which is confusing, 3 or 4?  I agree that 4 might be but 3 is as
> > straightforward as you can get.
> >
> > > --
> > > Jean Delvare
> > >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
