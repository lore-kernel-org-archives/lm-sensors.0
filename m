From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040111154426.312e9182.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > If you have questions that are not answered there, ask. If you want
> > things to be added to the document, tell me.
> 
> How would you name the file, where the chip revision will be made
> available (rev, revision, ...)? Should it be made availble?

I don't think that any other drivers do, but this is no reason for yours
not to. "revision" sounds fine.

> HERMES has a 'Global event status register'. It's something like
> alarms. E. g. bit 0 tells you, that there is a 'Global fan fault
> event'. Which fan is faulty must be determined by looking at the fan
> status registers, where bit 2 tells one, that the fan is faulty.
> 
> Is it ok to create fan_status1...3 files, containing the fan's status
> register value?

This makes sense.

> Concerning alarms: what do you mean by comparator mode?

Some chipsets can be configured in different modes. Interrupt mode means
that alarms don't wear off automatically as the cause of the alarm
disappears. Comparator means that it does. I'm not too comfortable with
changing modes, since hardware may be wired so as to work in one mode
and not in the other. So I would leave things as they are.

> HERMES e. g. signals 'Global fan fault event' as long as any of the
> fan status registers signals 'Fan fault'. Clearing all fan status
> registers (by writing this bit2 to 1) will finally have HERMES clear
> the 'Global fan fault event' (Globel event status register bit 0). Is
> this the expected behaviour?

I'm surprise that you are allowed to write to a status registers. Would
you rather mean "as the bit2 clears itself due to the fan working
correctly again"?

Anyway, the "Global fan fault event" is only a summary (technically a
logical OR) of the other registers' bit2, so it doesn't really matter.
What does (as far as interrupt vs comparator mode is concerned) is how
fan registers bit2 is cleared.

> One of the event bits is called 'Global software event'. This bit can
> be set and cleared by writing bit 0 of the global control register to
> 1 respectively 0. Is it ok to supply a file named 'control' for this
> purpose?

I don't see when you will want to set it. Can you provide a concrete
example?

> Concerning beep*: I assume, that the hardware must support some way of
> making noise, when an alarm occurs. This is not the case for HERMES.

Then you just don't have beep* files. That said, chipsets that do don't
make noise themselves. Instead, they have some way to have the PC
speaker make noise for them (don't know all the details).

> Concerning in_input*: HERMES only tells me unscaled values for +5.0V,
> +12.0V and +3.0V for the backup battery. In the current release, I
> used dmidecode to get the scaling factors and offsets from my
> mainboard and used them to finally hardcode scaling of the supplied
> values.
> 
> What shall I do for kernel 2.6.x? Which numbers shall I append to
> in_input? Where shell I put the battery voltage? Is there a way to
> read the dmi values from withing the fscher module?

I don't really see the problem here, but I admit I haven't read the
Hermes data sheet. If scaling factors are motherboard-dependant, they
don't belong to your driver but to /etc/sensors.conf instead. That is,
your driver will return the raw value, and then the conversions formulae
are taken from the configuration files. People with a different
motherboard only have to edit the configuration file, as opposed to edit
the kernel driver code and recompile. Your 2.4 driver should do the same
BTW, unless I misunderstood something.

And no, I don't think you can get dmi values from a kernel module.

> Concerning temp*: HERMES supplies a 'Sensor status register' for each 
> temperature sensor, where it signals over temperature respectively
> sensor hadrware faults (similar to fan_status). Is it ok to supply
> temp_status files?

Go for it. Strange how they split their alarms in so many different
registers. Usually we combine all of them into a single, 32-bit max
value (the "alarms" file) but it looks like the Hermes has just too many
of them do to so. Unless only a few bits are used in each registers? If
the total number of alarm bits is less than 32, you should consider
combining them all into a single value.

> Finally the watchdog:
> I'd supply a 'watchdog_control' file, which is used e. g. to retrigger
> the watchdog. Then I would supply a 'watchdog_status' file, which
> tells you that a system reset due to a watchdog event has occured. And
> last but not least a file 'watchdog_preset' where to set the watchdog
> time.
> 
> Is this all ok?

No objection.

> > Please note that limits initialization has been removed from all
> > drivers since it sometimes caused much trouble, and the same can be
> > achived with "sensors -s". That's not a 2.6 porting issue, but
> > that's something new since you wrote your original driver.
> 
> Can you tell me more, if it is still of interest?

Basically we considered that limits initializations belong to
user-space, and is done with "sensors -s" which reads them from
/etc/sensors.conf, so leaving them into the driver themselves
additionally wasn't needed. This makes drivers smaller.

We are also considering removing some initializations (not limits this
time) that are known to cause problems for certain chips, but that's
something different.

For you, all what this means is that if your old fscher driver used to
set limits as it is loaded, you are invited not to port that part of the
code into your 2.6 driver.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
