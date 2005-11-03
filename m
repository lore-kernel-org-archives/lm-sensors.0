From: davidhaertig@earthlink.net (David Haertig)
Date: Thu, 03 Nov 2005 16:49:32 +0000
Subject: [lm-sensors] lm-sensors install changed/corrupted
Message-Id: <436A31D2.20006@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <43699477.5000809@earthlink.net>
In-Reply-To: <43699477.5000809@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> My guess is that the POST hangs because of the high (and obviously
>> incorrect) CPU temp value.

LOL.  Yeah, could be the BIOS is saying "Hey, this guy's CPU is
already hot enough to roast a chicken ... maybe we shouldn't
continue with the boot process!"  (Although it will merrily
continue booting if I simply tell it not to DISPLAY my hardware
status during POST.  Sounds like the BIOS could use a little
more robust programming!)

>> The first thing to try would be to unlug the system for a few minutes.
>> Don't just power it off. Unplug it. Most motherboard nowadays are still
>> powered even when the system is off. I expect your system to be back to
>> normal when you then plug it in. Until the next time you load the it87
>> driver and/or run "sensors -s", that is.

Bingo!  I don't know why I didn't think of this.  I unplugged
for about 45 minutes and now all appears back to normal.

Now that I no longer think lm-sensors did some non-reversable
voodoo on my motherboard, I'll play around with things more
tonight after work (gotta go now).

A quick note on one of your other questions:

>>>Do you want to add these lines to /etc/modules automatically? (yes/NO)NO
>> 
>> How come that the it87 driver is loaded if you did not add it to
>> /etc/modules? 

The first time I ran sensors-detect I >> did << tell it to add the
lines to /etc/modules.  After that I experienced my POST problems
on reboot.  So then I ran sensors-detect a second time, to supply you
with the info that I thought you'd need.  It was the output of that
second run that I attached to my post.  During that second run
I did >> not << tell sensors-detect to add the lines to /etc/modules
because I knew they would (should?) already be there.  Note that
I was not able to boot to run sensors-detect that second time until
some time later ... after figuring out the BIOS setup change I needed
to get my computer bootable again.

This also answers one of your other questions:

>> How come that you use the lm90 driver while sensors-detect did not
>> suggest you should do so?

sensors-detect >> did << suggest that I use lm90 on the first run.
On the second run it apparently did not (possibly because the lm90
module was already loaded from the first run?)  I did not notice
the inconsistancy in the sensors-detect output from the first and
second runs until you pointed it out here.

Unfortunately, I did not capture sensors-detect output the first
time I ran it, so I cannot post that here to prove to you what I'm
saying.  I do take notes in a logbook whenever I'm twiddling with
my computer however, and I can tell you what sensors-detect daid
the firt run.  Not exact words, but I can transcribe the jist
of what was said from my handwritten notes pretty closely.  Here goes:

--- transcribe ---

Driver 'lm90' should be inserter
   Bus SMBus nForce2 adapter at 4c40
   Busdriver 'ic2-nforce2' I2C addresss 0x4c
   Chip Natl semiLM90 (confidence: 8)

Driver 'eeprom' should be inserted
   Bus SMBus nforce2 adapter at 4c00
   Busdriver 'ic2-nforce2' I2C address 0x50
   Chip SPD EEPROM (confidence: 8)

Driver 'it87' should be inserted
   ISA bus address 0x0290 Busdriver i2c-isa
   Chip ITE 8712F Super IO sensor (confidence: 9)

If you have a choice, do you want ISA of I2C/SMBus?: ISA

Automatically add these lines to /etc/modules?: YES

#--- cut here ---
# I2C adapter drivers
i2c-nforce2
i2c-isa
# I2C chip driver
lm90
eeprom
it87
#--- cut here ---

--- transcribe ---

After the above, I manually looked at /etc/modules and verified
that the lines had automatically been added.

I then ran "lsmod | grep it87" to see if they had been loaded.
Evidently not, since lsmod did not know of them.  So that's
when I rebooted ... to give everything a chance to get
settled down and loaded.  It was that first reboot where
I saw POST displaying a CPU temp of 246 and hanging.  I tried
the reboot multiple times to see if things would improve (they
didn't).  So on the next reboot I went into BIOS setup and
started snooping around.  Nothing looked out of the ordinary
on a quick look, but I can't say I remember each and every
normal BIOS setting on my computer.  While in BIOS setup I
changed the "Display hardware monitor in POST" setting to
"disabled".  Just as a test to see what might happen.  After
doing that I was able to boot normally.  I rebooted again
and went back into BIOS setup on re-enabled that POST hardware
status display.  It hung again.  Disabled it and the hang
was gone.  That's when I posted my first message to this
mailing list.

Thank you for the power down suggestion.  I should have known
to try that.  You would think I'd remember back to days long
past when I got my Electrical Engineering degree.  The mantra
back then was:  "It ain't working?  Check the power.  If it
doesn't have it ... get it there.  If it DOES have it, take
it away for a while, then put it back and see what happens."
This, combined with duct tape and WD-40 lube spray, will allow
you to solve just about any problem!

Jean Delvare wrote:
> Hi David,
> 
> On 2005-11-03, David Haertig wrote:
> 
>>I'm a bit confused here.  After installing lm-sensors where
>>everything went smoothly, I rebooted.  My computer then
>>hung in POST!!!  At the normal "Display PC hardware health"
>>screen.  It got so far as to display "CPU temp = 246 degrees
>>celcius"  (Yikes! - I doubt that's accurate) and then hung.
>>100% repeatable.  I then disabled "Show H/W Monitor in POST"
>>in the BIOS and was able to boot successfully.  The "sensors"
>>program displays bogus numbers, but I couldn't care less
>>about that right now.  I more concerned that I'm now having
>>a problem >>> in POST <<< ???!!!
> 
> 
> My guess is that the POST hangs because of the high (and obviously
> incorrect) CPU temp value.
> 
> You *should* care about the fact that "sensors" displays bogus numbers.
> Fixing these is likely to solve your problem.
> 
> It is possible that the it87 driver and/or "sensors -s" reprogrammed
> your IT8712F chip improperly, resulting in this incorrect CPU temp
> value. We have yet to understand how it may have happened. I can't
> remember of any similar report.
> 
> It is also possible that this ain't related to lm_sensors. Just because
> it sounds like a reasonable assumption doesn't make it true. What else
> did you do before the problem occured?
> 
> The first thing to try would be to unlug the system for a few minutes.
> Don't just power it off. Unplug it. Most motherboard nowadays are still
> powered even when the system is off. I expect your system to be back to
> normal when you then plug it in. Until the next time you load the it87
> driver and/or run "sensors -s", that is.
> 
> 
>>Technically I guess this is a mixed stable/unstable Debian
>>system ... but mostly it's standard Sarge 3.1r0a  The only
>>things downloaded from unstable are the kernel, the kernel
>>source, and gcc version 4.0  These were needed to support
>>my nForce3 SATA and onboard ethernet.  The nVidia display
>>drivers were downloaded from nVidia's website and compiled
>>locally.
> 
> 
> It is highly discouraged to use a different compiler for third-party
> drivers than the one which was used to compile the kernel in the first
> place. Do you know which compiler was used for the kernel itself?
> 
> Which kernel are you running?
> 
> 
>>Module                  Size  Used by
>>nvidia               3699176  12
> 
> 
> Proprietary driver, huh? How may we be certain that this isn't the cause
> of your problem? We can't. So you should stop using that module while
> you are debugging this issue.
> 
> 
>>it87                   27712  0
>>eeprom                  7280  0
>>lm90                   13924  0
>>i2c_sensor              3264  3 it87,eeprom,lm90
>>i2c_isa                 1888  0
>>i2c_nforce2             6752  0
>>i2c_core               21776  6
>>                     it87,eeprom,lm90,i2c_sensor,i2c_isa,i2c_nforce2
> 
> 
> How come that you use the lm90 driver while sensors-detect did not
> suggest you should do so?
> 
> 
>>Do you want to add these lines to /etc/modules automatically? (yes/NO)NO
> 
> 
> How come that the it87 driver is loaded if you did not add it to
> /etc/modules? Do the Debian init scripts load the hardware monitoring
> modules? Do they run "sensors -s" at some point? If they do, you want
> to disabled that for the moment, until we understand what's going on.
> 
> What does the output of "sensors" look like?
> 
> What does the "it87-*" or "it8712-*" section of your
> /etc/sensors.conf file look like?
> 
> 
>>it87: Found IT8712F chip at 0x290, revision 7
> 
> 
> The device was found and I don't see any problem related to it in the
> logs.
> 
> --
> Jean Delvare
> 
