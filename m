From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Sensors on IBM eServer 335/345?
Message-Id: <XWMLdWbK.1106222838.0006240.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2A5055C0-6929-11D9-98D6-003065F94C4C@cs.umass.edu>
In-Reply-To: <2A5055C0-6929-11D9-98D6-003065F94C4C@cs.umass.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Armen,

> The long and the short:  IBM hardware support tells me there is
> hardware monitoring in this machine, but that it is indeed proprietary,
> and they are not willing to release any specifications with regards to
> hardware monitoring chips.  The proprietary hardware is meant to go
> with their proprietary monitoring software.  Sorry about that - up
> until this email I was optimistic that though they'd have proprietary
> software, the hardware would be *somewhat* standard. D'oh. :)

Now you should really tell them that you won't buy hardware from them
again because you want to be able to use standard software.

> Since the motherboard in this machine has hardware sensors (and a fancy
> optional software package to go with it), My guess is that the Xeon
> chips also have temperature sensors.  Is the access method of the Xeon
> temperature sensors such that IBM could have found a way to prevent
> third-party software (i.e. open source i2c/lmsensors) from retrieving
> this data?  Or could there be a fairly easy way to access this data?
> How does lmsensors get this data from the Xeon chip?

Hard to say whether the Xeon have embedded monitoring chips, or only
thermal diodes connected to one or more external monitoring chips. I
think I remember it depends on exactly which Xeon you have. Try checking
the docs if you can find any for the exact Xeon you have

Lm_sensors will normally access the Xeon embedded monitoring chips
through whatever SMBus master happens to be on that system. They don't
seem to be there on your system, or if they are it might be hidden on a
different SMBus segment controlled by some multiplexing gate, itself
possibly controlled by arbitrary GPIOs on some chip (the Nat'l
Super-I/O for example). We simply can't guess the hardware setup
without the help of IBM, and I wouldn't could on it :(

> Regarding the unusual config register value, I removed the module and
> reinserted it with the suggested argument (fix_hstcfg=1).  Syslog
> revealed:
>
> ===cut here==> Found ServerWorks CSB5 South Bridge device
> i2c-piix4.o: Working around buggy BIOS (I2C)
> i2c-dev.o: Registered 'SMBus PIIX4 adapter at 0440' as minor 0
> ===cut here==>
> However, when I ran sensors-detect again, my machine hung.

The fix should not be used unless the SMBus itself doesn't work without
it. Your SMBus works (you can see eeproms on it), hardware monitoring
chips are simply not there.

> [ Incidently, I have noticed that old i2c and lmsensors drivers allow
> old themselves to load on new i2c drivers.  I've rebooted since that
> case, of course, but is there ever a case where a user would want
> mismatched versions of i2c/lmsensors drivers?  It just seems to me that
> bad things could happen if that were the case...I know I've done that
> accidently and its caused erroneous driver behavior with bttv and i2c
> on a separate machine.  Should there be a check to make sure
> i2c/lmsensors drivers aren't being accidently mismatched? ]

Your're right, mixing versions is not recommended. However there is no
simple rule to find out what versions are compatible, which is why no
check is done. It is left to the user to check the logs and update
whatever needs be if he/she suspects that old drivers might cause
trouble.

Note that all in Linux 2.6 all drivers are part of the kernel tree so
that kind of compatibility issue is gone.

> I did notice that the above sensors-detect output finds a chip "Nat.
> Semi. PC8741x Super IO", but does not find hardware monitoring
> capabilities on it.  Maybe this is IBM's proprietary monitoring chip.

No, this is a regular Super-I/O made by National Semiconductor. It simply
happens not to have hardware monitoring capabilities. We list such
Super-I/O chips in sensors-detect simply because some Super-I/O chips do
have hardware monitoring capabilities, and listing all known chips is
the only way we won't try to guess what new chip a user is reporting
about when it simply is an old chip with no hardware monitoring
capabilities.

What is possible is that IBM uses the PC8741x GPIO pins to hide/unhide
things on the SMBus.

It is also possible that the PC8741x can be used as a SMBus or Access.Bus
master. You can download the datasheet from National and check by
yourself. But if this is the case, we don't have a driver for it anyway.

--
Jean Delvare
