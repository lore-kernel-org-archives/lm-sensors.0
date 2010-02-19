From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Feb 2010 09:52:08 +0000
Subject: Re: [lm-sensors] A question regarding ASRock H55DE3 motherboard
Message-Id: <20100219105208.3a5d0044@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B7A403E.7000103@permonline.ru>
In-Reply-To: <4B7A403E.7000103@permonline.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Artem,

On Thu, 18 Feb 2010 16:25:48 +0500, Artem S. Tashkinov wrote:
> echo adt7473 0x2e > /sys/class/i2c-adapter/i2c-3/new_device produced the 
> desired results:
> 
> adt7473-i2c-3-2e
> Adapter: NVIDIA i2c adapter
> in1:         +3.00 V  (min =  +0.00 V, max =  +2.99 V)
> +3.3V:       +3.33 V  (min =  +0.00 V, max =  +4.39 V)
> fan1:        889 RPM  (min =    0 RPM)
> fan2:          0 RPM  (min =    0 RPM)
> fan3:          0 RPM  (min =  164 RPM)  ALARM
> temp1:       +39.2°C  (low  = +65.0°C, high = +85.0°C)  ALARM
>                        (crit = +100.0°C, hyst = +98.0°C)
> Board Temp:  +33.8°C  (low  = +20.0°C, high = +60.0°C)
>                        (crit = +100.0°C, hyst = +96.0°C)
> temp3:       +39.2°C  (low  = +80.0°C, high = +105.0°C)  ALARM
>                        (crit = +136.0°C, hyst = +132.0°C)
> 
> The output needs to be configured (via /etc/sensors.d/chipname.conf), 
> but that's not a problem.

Looks good indeed. I'd guess in1, fan2 and fan3 aren't used so you can
add an "ignore" statement for them. The rest looks good, except the low
limits of temp1 and temp3.

> (...)
> I apologize - it's my double blunder - HWMon shows Winbond W83627DHG 
> chip. So I tried w83627dhg driver and it perfectly works on my system 
> when loaded this way (as you suggested in a previous letter):
> 
> modprobe w83627ehf force_id=0xa020
> 
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:       +0.82 V  (min =  +0.00 V, max =  +1.74 V)
> in1:         +1.85 V  (min =  +0.69 V, max =  +1.91 V)
> AVCC:        +3.39 V  (min =  +2.00 V, max =  +0.56 V)   ALARM
> VCC:         +3.39 V  (min =  +2.86 V, max =  +1.76 V)   ALARM
> in4:         +0.05 V  (min =  +1.53 V, max =  +1.94 V)   ALARM
> in5:         +1.71 V  (min =  +1.32 V, max =  +1.86 V)
> in6:         +0.05 V  (min =  +1.66 V, max =  +1.90 V)   ALARM
> 3VSB:        +3.49 V  (min =  +1.50 V, max =  +2.99 V)   ALARM
> Vbat:        +3.34 V  (min =  +3.71 V, max =  +3.74 V)   ALARM
> fan1:          0 RPM  (min =  217 RPM, div = 64)  ALARM
> fan2:       1004 RPM  (min =  397 RPM, div = 32)
> fan3:          0 RPM  (min =  357 RPM, div = 64)  ALARM
> fan4:          0 RPM  (min =   84 RPM, div = 128)  ALARM
> fan5:          0 RPM  (min =  703 RPM, div = 16)  ALARM
> temp1:       +33.0°C  (high = -13.0°C, hyst = -46.0°C)  ALARM  sensor = 
> thermistor
> temp2:       +36.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
> temp3:      +127.5°C  (high = +80.0°C, hyst = +75.0°C)  ALARM  sensor = 
> thermistor
> cpu0_vid:   +0.000 V

From the above output, it's hard to claim it works "perfectly". Some
values look good, yes, but more careful inspection would be needed to
confirm that all inputs and limits work they way they are supposed to.

> However this means two things, w83627ehf driver needs to be updated to 
> work with my PC (I can send any system information if it's required)

Correct.... We must add support for your chip.

> and  sensors-detect script should also be modified to correctly
> identify my sensors (it missed coretemp driver altogether).

No, sensors-detect does the right thing at the moment. It properly
identifies your Super-I/O chip (which is _not_ a W83627DHG so we just
can't claim it is). As for the coretemp driver, the driver currently
doesn't support your CPU so we can't point the user to it. If we did,
we would receive complaints like "sensors-detect told me to load driver
coretemp but it doesn't work." So we have to do changes in the right
order, that is, first add support to the coretemp driver, and then
change sensors-detect to point to it.

In the meantime, please attach the contents of /proc/cpuinfo for the
records.

> coretemp driver started working after I applied the attached patch, 
> however the readings are wrong, so probably this driver is not yet 
> capable of monitoring Intel Core i5 650 CPU (temperatures are all wrong, 
> there are only two physical CPU cores):
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +23.0°C  (high = +84.0°C, crit = +100.0°C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +26.0°C  (high = +84.0°C, crit = +100.0°C)
> 
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +23.0°C  (high = +84.0°C, crit = +100.0°C)
> 
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +26.0°C  (high = +84.0°C, crit = +100.0°C)

This is the reason why I am waiting for the Intel folks to give us the
details. Apparently your Windows application is reporting temperatures
10 degrees higher, so I would guess that it assumes a critical
temperature limit of 110°C for this CPU model (current temperature is
reported relative to the critical limit.) But I wouldn't really assume
they know it for sure either, given how hard it was to get the
information for the other CPU models.

As for the core count, the coretemp driver will show one device for
each separate CPU entry. If you have 4 entries in /proc/cpuinfo, you
get 4 coretemp devices. If this is a dual core CPU then I have no idea
why you have 4 entries in /proc/cpuinfo.

> Thank you very much, Jean, for your invaluable help.

You're welcome.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
