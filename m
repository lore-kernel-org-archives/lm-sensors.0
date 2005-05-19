From: arpi@thot.banki.hu (Arpi)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Fwd: ls_sensors, fscscy.o & watchdog
Message-Id: <200306031515.h53FFaUU023091@mail.mplayerhq.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030603170000.78ca4d75.khali@linux-fr.org>
In-Reply-To: <20030603170000.78ca4d75.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

original recipent's server bounced it back :(

--------- Forwarded message ---------
From: Arpi <arpi@thot.banki.hu>
To: mkn@teraport.de
Subject: ls_sensors, fscscy.o & watchdog

Hi,

I've spent few hours experiencing with the watchdog feature of the Fujitsu
Siemens server board (don't ask the model name, what i know is that it uses
serverworks CSB5 chipset) using lm_sensors 2.7.0's fscscy driver.
(I needed it because i have random hangup (once a week, so hard to debug...)
on a server).

Ok, so there is /proc/sys/dev/sensors/fscscy-i2c-0-73/wdog, containing 3
0..255 values for the 3 watchdog registers.

The first one is the time counter, it counts backwards (seems write-only,
at least you can't read the current counter back). It's in 2 seconds base,
so writting 30 there means 60 seconds delay. It seems whole 0..255 range is
supported, so up to 510 seconds. writting 0 means immediate hardware reset.
The second number is unknown to me, it doesn't matter what value i put there.
The third is the control register, with flags 16, 32 and 128.
If i write only 16 or 144 (128+16), it means system reset when the counter
reaches 0. If i OR 32, it has no effect.

So, the world's simples watchdog using this mainboard:

while true ; do
  echo 30 0 16 > /proc/sys/dev/sensors/fscscy-i2c-0-73/wdog
  sleep 10
done

it does hardware reset after 1 minutes, if this script is killed or system
hangup occurs.

Also note, that BIOS has a strange setting, named OS Boot Retry Count, set
to 0 by default, it changes watchdog behaviour to power off instead of reset.
(0=poweroff 1..7=reset). It took me a while to find this...

Please add the above to the documentation (doc/chips/fscscy), so i can save
a few hours of resetting for other people :)


A'rpi / Astral & ESP-team

--
Developer of MPlayer G2, the Movie Framework for all - http://www.MPlayerHQ.hu

