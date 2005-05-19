From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <40015850.1080403@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>Now as kernel 2.6.0 is released, I feel the need to port fscher to
>>2.6.0. I've already started today, but didn't have success so far.
> 
> That would be great to have a ported driver for sure :)

[snip]

>>Attached you'll find what I've done so far. Please send me your
>>comments and hints.
> 
> I'd suggest you first read Documentation/i2c/porting-clients as found in
> Linux 2.6.1-rc1 and later. That's a document I wrote about porting chip
> drivers from linux 2.4 to linux 2.6. I believe that almost all questions
> you'd ask are answered there. If you don't mind, I'll take a look at
> your code after you read that document and applied its contents to
> your driver.

I had a look at it.

> If you have questions that are not answered there, ask. If you want
> things to be added to the document, tell me.

How would you name the file, where the chip revision will be made available 
(rev, revision, ...)? Should it be made availble?

HERMES has a 'Global event status register'. It's something like alarms. E. g. 
bit 0 tells you, that there is a 'Global fan fault event'. Which fan is faulty 
must be determined by looking at the fan status registers, where bit 2 tells 
one, that the fan is faulty.

Is it ok to create fan_status1...3 files, containing the fan's status register 
value?

Concerning alarms: what do you mean by comparator mode?

HERMES e. g. signals 'Global fan fault event' as long as any of the fan status 
registers signals 'Fan fault'. Clearing all fan status registers (by writing 
this bit2 to 1) will finally have HERMES clear the 'Global fan fault event' 
(Globel event status register bit 0). Is this the expected behaviour?

One of the event bits is called 'Global software event'. This bit can be set 
and cleared by writing bit 0 of the global control register to 1 respectively 
0. Is it ok to supply a file named 'control' for this purpose?

Concerning beep*: I assume, that the hardware must support some way of making 
noise, when an alarm occurs. This is not the case for HERMES.

Concerning in_input*: HERMES only tells me unscaled values for +5.0V, +12.0V 
and +3.0V for the backup battery. In the current release, I used dmidecode to 
get the scaling factors and offsets from my mainboard and used them to finally 
hardcode scaling of the supplied values.

What shall I do for kernel 2.6.x? Which numbers shall I append to in_input? 
Where shell I put the battery voltage? Is there a way to read the dmi values 
from withing the fscher module?

Concerning temp*: HERMES supplies a 'Sensor status register' for each 
temperature sensor, where it signals over temperature respectively sensor 
hadrware faults (similar to fan_status). Is it ok to supply temp_status files?

Finally the watchdog:
I'd supply a 'watchdog_control' file, which is used e. g. to retrigger the 
watchdog. Then I would supply a 'watchdog_status' file, which tells you that a 
  system reset due to a watchdog event has occured. And last but not least a 
file 'watchdog_preset' where to set the watchdog time.

Is this all ok?

> Please note that limits initialization has been removed from all
> drivers since it sometimes caused much trouble, and the same can be
> achived with "sensors -s". That's not a 2.6 porting issue, but that's
> something new since you wrote your original driver.

Can you tell me more, if it is still of interest?

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

