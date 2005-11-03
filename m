From: gcoady@gmail.com (Grant Coady)
Date: Thu, 03 Nov 2005 06:22:45 +0000
Subject: [lm-sensors] lm-sensors install
Message-Id: <43699E62.9040702@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Haertig wrote:
> Hi all -
> 
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

Did you power cycle?  Or, are you saying lm_sensors wrote eeprom
somewhere or was it something stayed in memory over reboot?
> 
...
>     Can dual-boot to Windows 2000 Pro SP4 or MSDOS
Second opinion about hardware from SpeedFan 4.26 under windows
may be valuable?  http://www.almico.com/speedfan.php

>     lm-sensors 1:2.9.1-1sarge2 (apt-get from Debian stable)

Grab lm_sensors 2.9.2 -- it is the latest (last I looked)
> 
> Technically I guess this is a mixed stable/unstable Debian
> system ... but mostly it's standard Sarge 3.1r0a  The only
> things downloaded from unstable are the kernel, the kernel
> source, and gcc version 4.0  These were needed to support
              ^^^^^^^^^^^^^^^-->  is this safe for kernel compile??

> my nForce3 SATA and onboard ethernet.  The nVidia display
> drivers were downloaded from nVidia's website and compiled
> locally.
Please try without nvidia (ie. non-tainted kernel)

Cheers,
Grant.

