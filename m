From: roger@planbit.co.uk (Roger Lucas)
Date: Thu, 17 Nov 2005 18:02:43 +0000
Subject: [lm-sensors] VT8231 patch for review
Message-Id: <20051117170150.8CD5C12E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051116150825.2410D12E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051116150825.2410D12E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Please can you send me a copy of the changed file that you have, then we are
in sync.

I will dig into the alarms a bit more.  What I could see happening was the
alarm being set correctly if the fan speed was below the limit set by the
user.  Unfortunately, the alarm was not being set if the fan had completely
stopped rotating, which should still be an alarm condition.  Also, the alarm
was also set if the fan was rotating but no minimum speed was set.  The code
I added made the alarm work as follows:

	Min = 0		: Alarm OFF
	Fan RPM > Min 	: Alarm OFF
	Fan RPM < Min 	: Alarm ON

I will see if I can get the isadump utility to show me what is actually
going on in the registers and confirm the additional alarm code was
required.

I am happy to take a look at the latest 2.9.2 sensors library and user space
utility to bring it in line with the current numbering scheme - these should
be minor changes.  I don't have a 2.4-based system here, however, so it
won't be easy for me to update the 2.4 version of the VT8231 kernel module
unless I reinstall a system here, which I am not really too keen to do.  Is
there anyone who is responsible for the 2.4 version of the module who can
take on that work?

Thanks,

Roger

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: 17 November 2005 15:56
> To: roger@planbit.co.uk
> Cc: Mark Studebaker; LM Sensors
> Subject: RE: [lm-sensors] VT8231 patch for review
> 
> 
> Hi Roger,
> 
> On 2005-11-16, Roger Lucas wrote:
> > Again, revised patch attached.  The array overflow in the fan
> > configuration was upsetting the fan readings, which is now fixed.  The
> > alarm flags from the device are not what as expected, so I have added
> > code to explicitly correct the alarm behaviour.  The alarm is now set
> > if the fan stalls and a minimum RPM has been set.  The alarm is
> > explicitly cleared if the fan is not spinning and no minimum RPM has
> > been set.  These problems were masked by the fan array overflow you
> > spotted.
> 
> I am quite surprised by the alarm problems you are reporting. Please
> remember that alarms usually wear off only after they have been read at
> least once, and the driver caches the register values for 1.5 second, so
> it might take some time before alarms show, and even more for past
> alarms to disappear.
> 
> I'm also a bit worried because in theory, the drivers should always
> return data which reflects the hardware status, and let userspace decide
> what must be ignored or altered. This is especially true of alarm flags.
> If we wanted them to be always accurate and real-time, we could generate
> them in software rather than relying on the hardware.
> 
> Alarm flags not matching expectations may also reveal bugs in the
> drivers. You should use isadump to really watch register values rather
> than trusting the driver when investigating this kind of issue. So,
> please double check what is happening here.
> 
> > I have updated the temperature measurement for temp2-6, but I have no
> way
> > of testing this code as I have no hardware that matches it.  Hopefully
> > someone can test it and report back.  It also includes your performance
> > optimisations for the fan LSB calculations, but again I have no way to
> > test temp2-6 for this.
> 
> Well, if it's broken, users will hopefully let us know. Your driver will
> unquestionably receive a number of fixes during the next few months,
> that's unavoidable, you never can get it all right the first time, no
> matter how many review cycles we have gone through.
> 
> > I hope I have got the header information and patch format correct now -
> > I had been using an older version of Quilt (not sure which as I could
> > not find any way to get Quilt to report its version number) and this
> > included the trailing whitespace removal, so hopefully this is OK too.
> 
> Looks OK to me. Quilt can tell its own version since version 0.41, so if
> you can't, you must have an older version.
> 
> > Finally, I have added my contact details to the MAINTAINERS list.
> 
> Great. I will accept this version of the patch and push it upstream,
> modulo a few coding style cleanups and last minute fixes:
> 
> > +#define TEMP_FROM_REG(reg)    	  ((253 - (reg)) * 250 / 210)
> > +#define TEMP_MAXMIN_FROM_REG(reg) ((253 - (reg)) * 1000 / 210)
> > +#define TEMP_MAXMIN_TO_REG(val)   (253 - (val) * 210 / 1000)
> 
> Broken alignment.
> 
> > +#define CFG_INFO_VOLT(id)	{ &sensor_dev_attr_in##id##_input.dev_attr,
> \
> > +				&sensor_dev_attr_in##id##_min.dev_attr, \
> > +				&sensor_dev_attr_in##id##_max.dev_attr, \
> > +				}
> > +#define CFG_INFO_VOLT(id)	{ &sensor_dev_attr_in##id##_input.dev_attr,
> \
> > +				&sensor_dev_attr_in##id##_min.dev_attr, \
> > +				&sensor_dev_attr_in##id##_max.dev_attr, \
> > +				}
> 
> Same macro defined twice?
> 
> > +	for (i=0; i < ARRAY_SIZE(cfg_info_volt); i++)	{
> 
> Invalid use of tab.
> 
> > +	u16 low = vt8231_read_value(client, VT8231_REG_TEMP_LOW01);
> > +
> > +	low = (low >> 6) | ((low & 0x30) >> 2) | (vt8231_read_value(client,
> > +				VT8231_REG_TEMP_LOW25) << 4);
> > +
> > +	down(&data->update_lock);
> > +
> > +	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> > +	    || !data->valid) {
> 
> This means that any read operation on any sysfs file will trigger two
> register reads, bypassing the caching mecanism which precisely tries to
> prevent this. I will move the reads back inside the jiffies-protected
> area.
> 
> BTW, there is a potential problem with temperature readings: how to make
> sure that the 2 LSB we read belong to the same sample as the 8 MSB? Some
> chips latch one half when the other is read, some don't. I couldn't
> find any hint in the datasheet. We might have to strengthen the code if
> problems arise on this front.
> 
> We now need to update lm_sensors2 CVS so that it will work with this new
> driver. To do:
> * Update libsensors (mostly temp inputs renumbering).
> * Update the 2.4 driver (again, temp inputs renumbering).
> * Update the sensors programe (again, temp inputs renumbering).
> * Update sensors.conf.eg. Not only temp input renumbering/reordering, but
> also voltage and temperature formula changes.
> 
> I would expect the new voltage compute lines to be in the form:
> 
>     compute in2 @ / K, @ * K
> 
> where K is one of the constants listed above the declarations of these
> lines.
> 
> Thermistor-base temperatures should also have a simplified formula,
> although that's still a bit complex due to the thermistor equation.
> I'll think about it.
> 
> At this point the 2.4 driver will still be broken and we'll have to fix
> it ASAP.
> 
> Thanks,
> --
> Jean Delvare

