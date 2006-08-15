From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Aug 2006 22:12:19 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <20060816001219.0c9261d6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> > Do you know systems where this is actually needed? When porting the
> > vt8231 driver, we made the choice to always trust the BIOS. Nobody
> > complained about this. The right configuration depends on the hardware,
> > and the user is unlikely to know better than the BIOS.
> 
> Legacy reasons I guess. It was in the 2.4 driver (I believe someone
> reported that some BIOSes didn't set it properly) so I kept it around.

Not necessarily. The founders of the lm_sensors project were hardware
people, sometimes soldering the chips on their own to write the
drivers, etc. They tended to make everything configurable regardless of
the need, just in case. We've been simplifying a number of drivers
while porting them to 2.6, because the target audience is less likely
to use a soldering iron, and more likely to mess everything up if given
the options to do so. I think it's useful to keep this background in
mind when porting drivers.

> I'd like to keep it unless you insist in removing it.

I'm not insisting, this module parameter is really not intrusive.

> > > +static const u8 regtemp[]    = {0x20, 0x21, 0x1f, 0x22, 0x23, 0x24, 0x25};
> > > +static const u8 regtempmax[] = {0x1d, 0x3d, 0x39, 0x2b, 0x2d, 0x2f, 0x31};
> > > +static const u8 regtemphyst[]        = {0x1e, 0x3e, 0x3a, 0x2c, 0x2e, 0x30, 0x32};
> >
> > The Linux 2.4 driver has the limits of temp1 and temp3 swapped. I
> > assume this is a bug in the 2.4 driver, and yours is correct? If so, we
> > should fix the 2.4 driver.
> 
> No, this matches the 2.4 driver.

Really, I don't think so. That's what we have in the 2.4 driver:

http://www.lm-sensors.org/browser/lm-sensors/trunk/kernel/chips/vt1211.c

122 	static const u8 regtemp[] = { 0x20, 0x21, 0x1f, 0x22, 0x23, 0x24, 0x25 };
123 	static const u8 regover[] = { 0x39, 0x3d, 0x1d, 0x2b, 0x2d, 0x2f, 0x31 };
124 	static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e, 0x2c, 0x2e, 0x30, 0x32 };

regtemp is similar, but regover and reghyst have their 1st and 3rd
elements swapped. The datasheet matches your version, so this has to be
a bug in the 2.4 driver. In doubt, you could check if the alarm flags
for temp1 and temp3 trigger as expected.

>                                   So temp1 and temp3 are swapped. I had
> a discussion with Rudolf (I believe) about this a while ago and we
> decided to match 2.4 first and once the 2.6 driver is accepted I'll
> fix both 2.4 and 2.6 at the same time. Otherwise I have to patch 2.4
> now and I'm busy enough getting 2.6 accepted :-)

Bad idea, we don't want to break compatibility more often than strictly
needed. If you really want to swap temp1 and temp3 in their "natural"
position, fine with me, but that's now or never. Once the 2.6 driver is
merged, the decision is pretty much carved in stone.

> > > +#define TEMP_TO_REG(ix, val) ((ix) = 0 ? \
> > > +                              SENSORS_LIMIT((((val) / 1000) + 51), \
> > > +                                     0, 255) : \
> > > +                              SENSORS_LIMIT(((val) / 1000), 0, 255))
> >
> > No official formula for temp1? Indeed I can't find any in the datasheet
> > nor BIOS porting guide :( I think it's OK to "scale" temp1 inside the
> > driver, however the Linux 2.4 driver didn't, so if we want a common
> > configuration file we'll have to modify the Linux 2.4 driver. It would
> > also be nice to check on another system how accurate your empirical
> > formula is.
> 
> Hmm... Are you leaning toward userspace scaling for temp1? I really
> don't care...

No, I'm fine with scaling temp1 in the driver.

> If I take the same approach as with the temp1/temp3 swapping I'd say I
> match the 2.4 implemenation first and fix both 2.4 and 2.6 later. OK?

No. Whatever you do in 2.6 right now is pretty much forever. The 2.4
driver will need to be adjusted anyway, so I don't mind changing it a
bit more to match your choices for the 2.6 driver.

> > BTW, I see you don't export the additional precision bits for these
> > temperature channels. Any reason why? The original driver supported
> > them.
> 
> Lazyness. I don't think those 2 LSBs justify the effort to export
> them. Really, who cares about centi-degrees and how much actual value
> do they really provide (other than white noise)?

I can't tell how good the chip is. I don't think it's so hard to get
the additional bits in place, just look at the vt8231 driver and copy
the code ;)

Going the "who cares about that precision" way is a sliding slope.
Thinking about it, who cares about the voltages? Most people would be
plain happy with just an "OK" flag and don't care about the exact
value. Maybe even a single flag for all voltages. After all, PSU can't
be fixed anyway, so if one voltage line is not OK you need a new PSU.
Then temperatures, who needs several sensors? The CPU temperature is
the only thing which is really important, and one degree resolution
should be enough for everyone. As for fans, as long as the system
doesn't get too hot, who cares about the exact speed? Again, either the
fan is spinning, or it's not and you have to change it. That's the kind
of reasoning which led to what ACPI offers when it comes to hardware
monitoring, i.e. about 5% of what lm_sensors does :(

But that's your choice anyway, no big deal, I agree ;)

> > > +static u8 vt1211_read8(struct vt1211_data *data, u8 reg)
> > > +{
> > > +     return inb(data->addr + reg);
> > > +}
> > > +
> > > +static void vt1211_write8(struct vt1211_data *data, u8 reg, u8 val)
> > > +{
> > > +     outb(val, data->addr + reg);
> > > +}
> >
> > These two should certainly be inlined for performance.
> 
> OK and what exactly does inline do?

The function calls will be subtituted with the function contents at
compilation time (same as a macro, but cleaner as you have parameter
type checks as with a regular function.) The theory is that the
compiler can guess when it should be inlining the functions, but the
facts are that the compiler needs some hints.

> > > + *  -------------------------------------------------------------------- */
> >
> > Missing dash ;)
> 
> :-)

You know, it's a tough job to be a code reviewer. It alters your mind
over time. I just _can't_ read code anymore, or anything else for that
matter, without looking for errors, inconsistencies and possible
cleanups and optimizations. That's exhausting...

> > > +             /* calculate tmp = log2(val) */
> > > +             tmp = 0;
> > > +             for (val >>= 1; val > 0; val >>= 1) {
> > > +                     tmp++;
> > > +             }
> >
> > Wow, this is clever :)
> 
> love it!

You know, I had to copy the code to user-space and test it on a range
of sample input values to convince myself that it was always doing the
right thing. It looked like magic to me at first :)

> > > +             vt1211_write8(data, VT1211_REG_PWM_CTL,
> > > +                           ((data->pwm_ctl[1] << 4) | data->pwm_ctl[0]));
> > > +             break;
> >
> > Do we agree that changing the temperature channel may also change the
> > temperature points as a side effect? Don't we want to prevent that?
> 
> Not sure what you mean, I'll have to think about it.

I mean that the same register value will translate to a different actual
temperature for a thermistor-based channel and a diode-based channel
(and also between temp1 and temp3 in most cases.) This fact makes it
even less smart from VIA to provide a single set of temperature
registers for both PWM channels. I'm a bit worried that changing the
temperature mapping for a PWM channel will magically change the meaning
of the temperature setpoints, that's quite confusing for the user.

This alone would justify giving up that code entirely if nobody has a
board where these PWM channels are wired.

> > > + * 0  0  : pwm1/pwm2 full speed temperature (pwm_auto_temp[0])
> > > + * 0  1  : pwm1/pwm2 high speed temperature (pwm_auto_temp[1])
> > > + * 0  2  : pwm1/pwm2 low speed temperature (pwm_auto_temp[2])
> > > + * 0  3  : pwm1/pwm2 off temperature (pwm_auto_temp[3])
> >
> > Iirk, you have it all reversed. point 0 should be fan off, point with
> > the higher number should be fan at full speed.
> 
> Is this a standard? I just followed the datasheet.

De facto standard. I realize it's not specified in our sysfs-interface
documentation file, but it just happens that all other chips (and thus
drivers) do it that way. It would be very confusing to user-space to
have one driver doing it the other way around.

> > I don't much like drivers changing the interrupt modes. Interrupt lines
> > are physical and may be wired to any kind of system handling them, e.g.
> > shutting the system down or starting an emergency fan etc. Changing the
> > interrupt mode may cause great confusion in this case.
> 
> Hmm... this has been copied from the 2.4 driver. AFAIK nobody
> complained about it. I noticed that on my EPIA M-10000 the interrupt
> mode wasn't set correctly by the BIOS. But then I'm not a 100% sure
> what the correct interrupt mode would be.

The correct mode is the one which matches the hardware wiring. If the
interrupt outputs are not wired, or only processed in software (and we
don't) we are relatively free.

> Are you suggesting to take it out or should I add it as a load parameter?

I don't really suggest anything. As long as it works for the users, I'm
happy. I am simply warning that, if a user ever complains that the
driver breaks some form of hardware protection mechanism on his system,
we'll have to stop overwriting these values for everyone. This was seen
for other drivers already, but I can't predict what will happens for
this one.

> > 3* I am worried about the automatic PWM mode. I understand that there's
> > only one set of temperature registers for both PWM outputs. However
> > both PWM outputs may be mapped to different temperature channels, and
> > these channels may measure the temperature in a different way. So the
> > single register set may lead to related, but different fan behaviors.
> > This will be very confusing for the user. Shouldn't we prevent the user
> > from using temperature channels of different types for PWM1 and PWM2?
> 
> I agree, the VT1211 auto PWM implementation is far from optimal. I'm
> not sure how to go about it though. I can't really tell if it can be
> setup properly using different temp channels for the 2 PWM outputs
> since I don't have a system with PWM controlled fans. I don't like
> limiting the functionality of the driver for some theoretical reason
> just because I don't have the ability to test it. On the other hand
> things can really get screwed up if care is not taken properly...
> At this point I would like to keep it the way it is and just hint in
> the documentation that whoever mocks around with it better knows what
> she/he is doing.

Fine with me. I'm just trying to prevent the users from screwing up
their systems. I just hope that the driver will get enough testing when
ready so we know early if there is any kind of problem.

> > OK, don't be frightened by the number of my comments, I am actually
> > quite happy with your code in general. I see you've been putting energy
> > in sticking to the coding style and the sysfs interface standard, and
> > you also took benefit of the latest technologies available (dynamic
> > sysfs callbacks, platform driver etc.) It's very nice.
> 
> Sigh... I don't want to see an unfavorable review :-)

Yeah, I know, I always sound harsh from the other side. I want high
quality code in the kernel and that's the only way I know of to obtain
it. I'm glad you are willing to cooperate so the result should be
really good. Not everyone is. My standards for quality are certainly
above the average and contributors might get surprised because of this.
The fact is that most drivers that go through my review can then be
left almost untouched for years, because they just work.

Unfavorable reviews are actually much shorter, as I stop as soon as I
am angry enough against the submitter. I'm glad it didn't happen too
often ;)

> Thanks a lot for the thorough review, Jean! I really appreciate it.

You've been waiting for a year, that's the least I could do :)

-- 
Jean Delvare

