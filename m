From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 03 Nov 2005 13:19:35 +0000
Subject: [lm-sensors] lm-sensors install changed/corrupted
Message-Id: <b1C8ViHe.1131019624.6021630.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43699477.5000809@earthlink.net>
In-Reply-To: <43699477.5000809@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

On 2005-11-03, David Haertig wrote:
> I'm a bit confused here.  After installing lm-sensors where
> everything went smoothly, I rebooted.  My computer then
> hung in POST!!!  At the normal "Display PC hardware health"
> screen.  It got so far as to display "CPU temp = 246 degrees
> celcius"  (Yikes! - I doubt that's accurate) and then hung.
> 100% repeatable.  I then disabled "Show H/W Monitor in POST"
> in the BIOS and was able to boot successfully.  The "sensors"
> program displays bogus numbers, but I couldn't care less
> about that right now.  I more concerned that I'm now having
> a problem >>> in POST <<< ???!!!

My guess is that the POST hangs because of the high (and obviously
incorrect) CPU temp value.

You *should* care about the fact that "sensors" displays bogus numbers.
Fixing these is likely to solve your problem.

It is possible that the it87 driver and/or "sensors -s" reprogrammed
your IT8712F chip improperly, resulting in this incorrect CPU temp
value. We have yet to understand how it may have happened. I can't
remember of any similar report.

It is also possible that this ain't related to lm_sensors. Just because
it sounds like a reasonable assumption doesn't make it true. What else
did you do before the problem occured?

The first thing to try would be to unlug the system for a few minutes.
Don't just power it off. Unplug it. Most motherboard nowadays are still
powered even when the system is off. I expect your system to be back to
normal when you then plug it in. Until the next time you load the it87
driver and/or run "sensors -s", that is.

> Technically I guess this is a mixed stable/unstable Debian
> system ... but mostly it's standard Sarge 3.1r0a  The only
> things downloaded from unstable are the kernel, the kernel
> source, and gcc version 4.0  These were needed to support
> my nForce3 SATA and onboard ethernet.  The nVidia display
> drivers were downloaded from nVidia's website and compiled
> locally.

It is highly discouraged to use a different compiler for third-party
drivers than the one which was used to compile the kernel in the first
place. Do you know which compiler was used for the kernel itself?

Which kernel are you running?

> Module                  Size  Used by
> nvidia               3699176  12

Proprietary driver, huh? How may we be certain that this isn't the cause
of your problem? We can't. So you should stop using that module while
you are debugging this issue.

> it87                   27712  0
> eeprom                  7280  0
> lm90                   13924  0
> i2c_sensor              3264  3 it87,eeprom,lm90
> i2c_isa                 1888  0
> i2c_nforce2             6752  0
> i2c_core               21776  6
>                      it87,eeprom,lm90,i2c_sensor,i2c_isa,i2c_nforce2

How come that you use the lm90 driver while sensors-detect did not
suggest you should do so?

> Do you want to add these lines to /etc/modules automatically? (yes/NO)NO

How come that the it87 driver is loaded if you did not add it to
/etc/modules? Do the Debian init scripts load the hardware monitoring
modules? Do they run "sensors -s" at some point? If they do, you want
to disabled that for the moment, until we understand what's going on.

What does the output of "sensors" look like?

What does the "it87-*" or "it8712-*" section of your
/etc/sensors.conf file look like?

> it87: Found IT8712F chip at 0x290, revision 7

The device was found and I don't see any problem related to it in the
logs.

--
Jean Delvare
