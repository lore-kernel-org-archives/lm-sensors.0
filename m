From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 15 Jan 2006 17:54:12 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060115185412.297ef8e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> Interesting, I'm noticing the limits for temp1 are fluctuating on their 
> own. For example,

That's really weird. These registers are not supposed to change values
unless you ask for a change. Please see if you can refine your
observations as to when and how these values change.

> > http://jdelvare.net2.nerim.net/sensors/hwmon-w83627hf-add-w83687thf-support.patch
> >
> > Note that it only applies to Linus' git tree (or any recent mm tree),
> > not 2.6.15 - unless you fix the few rejects manually.
> > ...
> > If you happen to test the patch linked above, please
> > report the result.
> 
> Haven't tried the patch yet - been busy tracking down some other 
> problems.   Will probably hold off till 2.6.15.1 comes out and then 
> manually make the changes then.

2.6.15.1 is out now. I've generated a patch which will apply properly
on top of it:
http://jdelvare.net2.nerim.net/sensors/linux-2.6.15.1-hwmon-w83687thf.diff

> (...) Anyways, when I had a look at my BIOS settings,  I recorded 
> the following:
> 
> CPU Internal Temp.    43C
> CPU External Temp   51C

It's odd that the external temperature is higher than the internal
temperature. The picture you pointed us to above is much more logical
(internal temperature is higher).

It's really hard to guess which temperature sensors correspond to which
BIOS measurement. I guess that the motherboard manufacturer wouldn't
have added a secondary monitoring chip (the LM90) if not to monitor the
CPU temperature more accurately, so my guess is that "CPU External
Temp" is lm90 temp2. "CPU Internal Temp" may be w83687thf temp2 or
temp3.

> System Temp                 41C

And this would be w83687thf temp1. This is really only a guess at this
point though. A BIOS disassembly and/or additional information from DFI
would be needed here.

You may also put the CPU under load under Linux (with some compilation
or compression work, or by using cpuburn) and see which temperatures
raise quickly.

> Fan1 Speed                  1394 RPM
> Fan2 Speed                  1360RPM

Both values are similar so it'll be hard to say which is which. You may
try to physically slow down either fan to differenciate between them.

> Vcore                             1.40V

in0

> +1.5V                              1.50V

in1

> +3.3V                              3.29V

in2

> VDIMM                         2.59V       ....... although, of course, 
> its now at 2.72V, as described above

in4

> +5V                                 5.04V

most probably in3

> VBAT                              3.29V

in8

> 5VSB                              4.96V

most probably in7

> Smart Fan1 Temperature 60C
> Fan1 Tolerance Value [1]
> Smart Fan2 Temperature 45C
> Fan2 Tolerance Value [1]

These must correspond to the "thermal cruise" mode. We don't support it
for now.

> - Interesting that there is no +12V reading

True, that's unusual, but not unseen.

> Let me know if you need anything else, or clarification of anything.

Well, any additional information you can get regarding the temperature
sensors is welcome. For now, please find attached a sample
configuration file which should be suitable for your motherboard. Copy
it to /etc/sensors.conf and give it a try, please.

This is really only a first short, voltages should be OK, but fans and
temperatures will need more work to find out the appropriate labels.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-Soltek-B9D-FGR.conf
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060115/a0096a26/sensors-Soltek-B9D-FGR.pl
