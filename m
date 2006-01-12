From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 12 Jan 2006 22:37:36 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060112233736.3ce3bac6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> Anyways, here's the successful output:
> (...)
> w83687thf-isa-0290
> Adapter: ISA adapter
> in0: +1.10 V (min = +0.70 V, max = +1.87 V)

Most probably your CPU Core voltage. Is it correct? What's your CPU?

> in1: +1.52 V (min = +2.54 V, max = +2.11 V) ALARM

I'd guess this is the AGP voltage (nominal is +1.5V).

> in2: +3.30 V (min = +2.86 V, max = +1.66 V) ALARM

And this could be +3.3V.

> in3: +2.99 V (min = +2.05 V, max = +3.36 V)
> in4: +2.59 V (min = +3.49 V, max = +2.14 V) ALARM
> in7: +2.94 V (min = +0.16 V, max = +0.42 V) ALARM

These ones are probably greater voltages (+5V, +12V...) scaled down. Or
in4 may be Vdimm.

> in8: +3.30 V (min = +0.38 V, max = +3.14 V) ALARM

I'd guess 3VSB (same as +3.3V but when your system is in standby mode.)

> fan1: 1328 RPM (min = 9375 RPM, div = 8) ALARM
> fan2: 1339 RPM (min = 1016 RPM, div = 8)
> fan3: 0 RPM (min = 6136 RPM, div = 2) ALARM

If you only have these two slow fans in the box, that looks OK.

> temp1: +39?C (high = -122?C, hyst = -41?C) sensor = diode ALARM
> temp2: +39.0?C (high = +80?C, hyst = +75?C) sensor = diode
> temp3: +59.0?C (high = +80?C, hyst = +75?C) sensor = diode

May be OK too. You should set temp1's limits to something more
reasonable though.

> vid: +0.275 V (VRM Version 9.0)

Bogus, and this is expected as the W83687THF needs completely different
code for VID, which my initial patch didn't have. I've implemented
that now, a new patch is available here:

http://jdelvare.net2.nerim.net/sensors/hwmon-w83627hf-add-w83687thf-support.patch

Note that it only applies to Linus' git tree (or any recent mm tree),
not 2.6.15 - unless you fix the few rejects manually.

> Pretty happy camper here! Thanks so much guys.
> (...)
> Anyways, definitely count me in for testing any revised/changed code as 
> the result of info gleaned from the data sheet. Looking forward to it!

You're welcome. If you happen to test the patch linked above, please
report the result. Also, I'd like to work on a sample configuration
file for this chip. As the chip is quite rare, maybe we can simply
write a configuration file for your board. Can you please visit the
BIOS setup screens of your system and report all the hardware
monitoring items listed there, in order, with value? Then I'll provide
a configuration file for you to test.

-- 
Jean Delvare

