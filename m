From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <4001B2DE.60407@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>Well, as stated above, you have to write 4 to the fan status register,
>>which will in turn clear bit 2 of the fan status register. If no more
>>fan status registers indicate a fan failure, the 'Global fan fault
>>event' will clear too (simple OR-logic, as you mentioned above).
> 
> Writing a 1 to the bit so that it is reset is a strange idea, isn't it?
> ;)

Well, how would you indicate the bit to clear otherwise?

[ snip: global software event ]

>>Which suffixes shall I choose for the unscaled 5 V and 12 V voltages,
>>and especially, which one for the 3 V backup battery?
> 
> I don't see any difficulty here. They are in0, in1 and in2. We never
> give names to the channels, only number. Labels are set with
> sensors.conf.

Ok, so everything is like before, besides the values beeing unscaled.

[ snip: voltage scaling ]

>>>Go for it. Strange how they split their alarms in so many different
>>>registers. Usually we combine all of them into a single, 32-bit max
>>>value (the "alarms" file) but it looks like the Hermes has just too
>>>many of them do to so. Unless only a few bits are used in each
>>>registers? If
>>
>>True. Each fan status has just one bit while each temperature sensor
>>has 2.
>>
>>>the total number of alarm bits is less than 32, you should consider
>>>combining them all into a single value.
>>
>>Well, all status flags would be no more than 32. Shall I therefore
>>drop fan_status*, temp_status* and watchdog_status and put them all
>>together into alarms?
> 
> That's what I was suggesting, but...
> 
>>Clearing a certain fan status bit would then require to calculate a
>>proper value. This value must then be written into alarms to get the
>>bit cleared. Writing -1 to alarms would therefore clear all clearable
>>status bits. The others would then get updated by HERMES' internal
>>logic.
> 
> ...the fact that you could write to this file would be something
> unusual. And it would for sure make your code more complex, if not
> unreadable (unless you document it a lot). That might not be worth it,
> especially since the benefit would be thin. It is very interesting to
> respect file namings when the name is enough for a third party software
> to use the value. This isn't the case with alarms anyway, since the
> meaning of each bit is driver-dependant. So in the end, if having
> different files is more convenient, go for it.

I think so, too.

> I'd like to hear Greg (and possibly others) about this though.

BTW: I'm not on the ML.

>>The drawback is, that one has to fiddle around with large powers of
>>two. This makes it more complicated for a human beeing to see at a
>>glance, where the problem is.
> 
> This is the way it is done in all other drivers. Users are not supposed
> to read raw values from /sys or /proc. They run sensors or any other
> piece software which decode the alarms file for them. So that's not a
> valid reason IMHO.

Ok, but then I should complete the output of sensors for fscher and also 
include alarms and watchdog.

>>So, with a single 'sensors -s' instruction one could for example set
>>all the pwm* values for the fans?
>>
>>Currently, I use
>>
>>	echo 4 2 > /proc/sys/dev/sensors/fscher*/fan1
>>	echo 4 1 > /proc/sys/dev/sensors/fscher*/fan2
>>	echo 4 1 > /proc/sys/dev/sensors/fscher*/fan3
> 
> You like reading and writing to /proc files directly, don't you? ;)

Maybe, I was just to lazy to look for a different solution. From coding the 
module, I knew that it would work that easy ;-).

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
