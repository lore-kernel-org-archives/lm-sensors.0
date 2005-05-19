From: arpi@thot.banki.hu (Arpi)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Fwd: ls_sensors, fscscy.o & watchdog
Message-Id: <200306031544.h53Fi53L008047@mail.mplayerhq.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030603170000.78ca4d75.khali@linux-fr.org>
In-Reply-To: <20030603170000.78ca4d75.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Hi A'rpi, nice to see you there :)
:)

> > I've spent few hours experiencing with the watchdog feature of the
> > Fujitsu Siemens server board (don't ask the model name, what i know is
> > that it uses serverworks CSB5 chipset) using lm_sensors 2.7.0's fscscy
> > driver.(I needed it because i have random hangup (once a week, so hard
> > to debug...) on a server).
> > 
> > Ok, so there is /proc/sys/dev/sensors/fscscy-i2c-0-73/wdog, containing
> > 3 0..255 values for the 3 watchdog registers.
> > 
> > The first one is the time counter, it counts backwards (seems
> > write-only, at least you can't read the current counter back). It's in
> > 2 seconds base, so writting 30 there means 60 seconds delay. It seems
> > whole 0..255 range is supported, so up to 510 seconds. writting 0
> > means immediate hardware reset.
> 
> According to the docs, this is read and write. I'll check the code and
> update if required.

Yes, in viewpoint of code (and you :)) it's R/W. But the value you can read
back is the same as you wrote there, not the current value of the counter
(as I expected).

> > The second number is unknown to me, it
> > doesn't matter what value i put there.
> 
> According to the docs again, it is supposed to be a "state" register, so
> it's probably meant to be read from, not written to (also the same docs
> say it's read and write).

It's always 0. Even if i write there something, i got 0 back.
Maybe it's non-zero at the monment of reset :)))

> > The third is the control
> > register, with flags 16, 32 and 128. If i write only 16 or 144
> > (128+16), it means system reset when the counter reaches 0. If i OR
> > 32, it has no effect.
> 
> Do you mean that the 6th bit has no effect, or that setting it to 1
> disables the watchdog?
5th, not 6th

Seems it disables the watchdog, at least when i set it, bit 4 has no effect.
So only 'working' values for me were 16 and 144 (8+16), for other values
it does nothing when the counter reach 0.
(at least i see nothing happening)

> > So, the world's simples watchdog using this mainboard:
> > 
> > while true ; do
> >   echo 30 0 16 > /proc/sys/dev/sensors/fscscy-i2c-0-73/wdog
> >   sleep 10
> > done

^^^ this is the main point, to get it working :)
actually i'm not interested (and i have no time) to do more experimenting
with wdog, with the above 4-liner it works as expected form a watchdog.

> > it does hardware reset after 1 minutes, if this script is killed or
> > system hangup occurs.
> > 
> > Also note, that BIOS has a strange setting, named OS Boot Retry Count,
> > set to 0 by default, it changes watchdog behaviour to power off
> > instead of reset.(0=poweroff 1..7=reset). It took me a while to find
> > this...
> 
> Thanks for reporting your experience (and success). Never used a
> watchdog myself, but I know how it works and your explanations make
> sense.

Same here, I've never used such thing, and I always hoped i will never have
to use such thing, but this bastard mainboard keeps crashing and doing
unpredictable hangup (tried various stresstests etc) so i had to do sth :)

> > Please add the above to the documentation (doc/chips/fscscy), so i can
> > save a few hours of resetting for other people :)
> 
> It will be done :)

thanks :)
i hope it helps somebody... before i started to experiment on a live
production server i searched through the net for this info
but found nothing :(


A'rpi / Astral & ESP-team

--
Developer of MPlayer G2, the Movie Framework for all - http://www.MPlayerHQ.hu
