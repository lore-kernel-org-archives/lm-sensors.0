From: davidhaertig@earthlink.net (David Haertig)
Date: Thu, 03 Nov 2005 06:46:12 +0000
Subject: [lm-sensors] lm-sensors install
Message-Id: <4369A473.9030408@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <43699E62.9040702@gmail.com>
In-Reply-To: <43699E62.9040702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant -

Thanks for the quick reply.  However, I don't understand your
concerns about what compiler or kernel I have installed.
I did not recompile the kernel BTW.  I downloaded a binary
kernel from Debian SID, but I needed the kernel source and the
newer compiler to compile the nVidia drivers.

After installing lm-sensors (apt-get install, then sensor-detect)
I rebooted.  The first reboot I tried was a soft one ("Logoff and
restart" from within Gnome Desktop).  My second reboot was a
total power down one.

Anyway, the hang is during POST.  This is way before any OS is
loaded, tainted kernel or not.  I'm not even to the MBR -> XOSL Boot
Manager -> Grub -> Linux Kernel yet.  I'm still in POST (firmware).
Drivers and kernels are not in the picture at this stage of booting.
The harddisk hasn't even been accessed yet!

This is the last thing I expected to happen when I installed
lm-sensors.  I can imagine (and even expected) some configuration
and/or twiddling would be needed after rebooting Linux.  I see
no way his COULD have happened unless somehow, something that
was done as part of the lm-sensors install (probing?) messed up
the IT8712 chip, the BIOS, or something else in hardware/firmware
on the motherboard.  That's why I'm asking for help here.
I'm hoping that what I think happened is not what really happened.
Or at least there's an easy fix for it.

Thanks!


Grant Coady wrote:
> David Haertig wrote:
> 
>>Hi all -
>>
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
> Did you power cycle?  Or, are you saying lm_sensors wrote eeprom
> somewhere or was it something stayed in memory over reboot?
> 
> ...
> 
>>    Can dual-boot to Windows 2000 Pro SP4 or MSDOS
> 
> Second opinion about hardware from SpeedFan 4.26 under windows
> may be valuable?  http://www.almico.com/speedfan.php
> 
> 
>>    lm-sensors 1:2.9.1-1sarge2 (apt-get from Debian stable)
> 
> 
> Grab lm_sensors 2.9.2 -- it is the latest (last I looked)
> 
>>Technically I guess this is a mixed stable/unstable Debian
>>system ... but mostly it's standard Sarge 3.1r0a  The only
>>things downloaded from unstable are the kernel, the kernel
>>source, and gcc version 4.0  These were needed to support
> 
>               ^^^^^^^^^^^^^^^-->  is this safe for kernel compile??
> 
> 
>>my nForce3 SATA and onboard ethernet.  The nVidia display
>>drivers were downloaded from nVidia's website and compiled
>>locally.
> 
> Please try without nvidia (ie. non-tainted kernel)
> 
> Cheers,
> Grant.
> 
> 
