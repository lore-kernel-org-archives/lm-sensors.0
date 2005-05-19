From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <4001968E.1080207@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>>If you have questions that are not answered there, ask. If you want
>>>things to be added to the document, tell me.

[ snip: revision file ]

>>HERMES has a 'Global event status register'. It's something like
>>alarms. E. g. bit 0 tells you, that there is a 'Global fan fault
>>event'. Which fan is faulty must be determined by looking at the fan
>>status registers, where bit 2 tells one, that the fan is faulty.
>>
>>Is it ok to create fan_status1...3 files, containing the fan's status
>>register value?
> 
> This makes sense.
> 
>>Concerning alarms: what do you mean by comparator mode?
> 
> Some chipsets can be configured in different modes. Interrupt mode means
> that alarms don't wear off automatically as the cause of the alarm
> disappears. Comparator means that it does. I'm not too comfortable with
> changing modes, since hardware may be wired so as to work in one mode
> and not in the other. So I would leave things as they are.

HERMES doesn't allow changing this behaviour (at least it is not documented). 
So, from the above, I'd say that HERMES is using interrupt mode.

>>HERMES e. g. signals 'Global fan fault event' as long as any of the
>>fan status registers signals 'Fan fault'. Clearing all fan status
>>registers (by writing this bit2 to 1) will finally have HERMES clear
>>the 'Global fan fault event' (Globel event status register bit 0). Is
>>this the expected behaviour?
> 
> I'm surprise that you are allowed to write to a status registers. Would
> you rather mean "as the bit2 clears itself due to the fan working
> correctly again"?

No, it's not cleared automatically. The BIOS also uses this bit to show the 
user an appropriate 'FAN failed' message at boot time.

> Anyway, the "Global fan fault event" is only a summary (technically a
> logical OR) of the other registers' bit2, so it doesn't really matter.
> What does (as far as interrupt vs comparator mode is concerned) is how
> fan registers bit2 is cleared.

Well, as stated above, you have to write 4 to the fan status register, which 
will in turn clear bit 2 of the fan status register. If no more fan status 
registers indicate a fan failure, the 'Global fan fault event' will clear too 
(simple OR-logic, as you mentioned above).

>>One of the event bits is called 'Global software event'. This bit can
>>be set and cleared by writing bit 0 of the global control register to
>>1 respectively 0. Is it ok to supply a file named 'control' for this
>>purpose?
 >
> I don't see when you will want to set it. Can you provide a concrete
> example?

When an alarm condition is active, the mainboard drives a LED at a frequency 
of 5 Hz (or 2 Hz, depending on the kind of event, if the documentation is 
correct).

By setting bit 0 in the 'Global control register', bit 4 ('Global software 
event') of the 'Global event status register' turns on, and therefore, the 
alert LED starts flashing.

I use the computer with this mainboard as video disk recorder. One practical 
use of the 'Global software event' might be to indicate the 'almost out of 
disk space' condition, as the machine then needs additional care soon.

[ snip: beep files ]

>>Concerning in_input*: HERMES only tells me unscaled values for +5.0V,
>>+12.0V and +3.0V for the backup battery. In the current release, I
>>used dmidecode to get the scaling factors and offsets from my
>>mainboard and used them to finally hardcode scaling of the supplied
>>values.
>>
>>What shall I do for kernel 2.6.x? Which numbers shall I append to

Which suffixes shall I choose for the unscaled 5 V and 12 V voltages, and 
especially, which one for the 3 V backup battery?

>>in_input? Where shell I put the battery voltage? Is there a way to
>>read the dmi values from withing the fscher module?
> 
> I don't really see the problem here, but I admit I haven't read the
> Hermes data sheet. If scaling factors are motherboard-dependant, they

 From the documentation I would say, that they are. They could easily change 
with the next board revision.

> don't belong to your driver but to /etc/sensors.conf instead. That is,
> your driver will return the raw value, and then the conversions formulae
> are taken from the configuration files. People with a different
> motherboard only have to edit the configuration file, as opposed to edit
> the kernel driver code and recompile. Your 2.4 driver should do the same
> BTW, unless I misunderstood something.

You've got it. Currently, they are hardcoded. The next time, they will go to 
/etc/sensors.conf.

> And no, I don't think you can get dmi values from a kernel module.

That would have been the user friendliest way ;-)

>>Concerning temp*: HERMES supplies a 'Sensor status register' for each 
>>temperature sensor, where it signals over temperature respectively
>>sensor hadrware faults (similar to fan_status). Is it ok to supply
>>temp_status files?
> 
> Go for it. Strange how they split their alarms in so many different
> registers. Usually we combine all of them into a single, 32-bit max
> value (the "alarms" file) but it looks like the Hermes has just too many
> of them do to so. Unless only a few bits are used in each registers? If

True. Each fan status has just one bit while each temperature sensor has 2.

> the total number of alarm bits is less than 32, you should consider
> combining them all into a single value.

Well, all status flags would be no more than 32. Shall I therefore drop 
fan_status*, temp_status* and watchdog_status and put them all together into 
alarms?

Clearing a certain fan status bit would then require to calculate a proper 
value. This value must then be written into alarms to get the bit cleared. 
Writing -1 to alarms would therefore clear all clearable status bits. The 
others would then get updated by HERMES' internal logic.

The drawback is, that one has to fiddle around with large powers of two. This 
  makes it more complicated for a human beeing to see at a glance, where the 
problem is.

What do you think?

[ snip: watchdog ]

>>>Please note that limits initialization has been removed from all
>>>drivers since it sometimes caused much trouble, and the same can be
>>>achived with "sensors -s". That's not a 2.6 porting issue, but
>>>that's something new since you wrote your original driver.
>>
>>Can you tell me more, if it is still of interest?
> 
> Basically we considered that limits initializations belong to
> user-space, and is done with "sensors -s" which reads them from
> /etc/sensors.conf, so leaving them into the driver themselves
> additionally wasn't needed. This makes drivers smaller.

So, with a single 'sensors -s' instruction one could for example set all the 
pwm* values for the fans?

Currently, I use

	echo 4 2 > /proc/sys/dev/sensors/fscher*/fan1
	echo 4 1 > /proc/sys/dev/sensors/fscher*/fan2
	echo 4 1 > /proc/sys/dev/sensors/fscher*/fan3

This would then be obsolete.

> We are also considering removing some initializations (not limits this
> time) that are known to cause problems for certain chips, but that's
> something different.
> 
> For you, all what this means is that if your old fscher driver used to
> set limits as it is loaded, you are invited not to port that part of the
> code into your 2.6 driver.

No, there was no such code in the old fscher driver.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
