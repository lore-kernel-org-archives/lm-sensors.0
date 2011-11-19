From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Nov 2011 09:01:27 +0000
Subject: Re: [lm-sensors] Biostar TA880GB+ Motherboard Information
Message-Id: <20111119100127.2c33fdfc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
In-Reply-To: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Fri, 18 Nov 2011 22:32:09 -0800, Paul Norman wrote:
> I was going to add this to the wiki, but was unable to figure out how to
> register to add it. Someone on IRC suggested I post to the mailing list.

Yes, the wiki is read-only for user to avoid spam.

> My Ubuntu server runs on a Biostar TA880GB+ AM3 motherboard, with a 880G
> northbridge and an Athelon II processor.
> 
> Finding no configuration information for this motherboard, I proceeded to
> write it, using the fairly detailed information in the BIOS to match up
> sensors with what they measure. I overvolted parts in the BIOS to verify
> that I had the configuration right.
> 
> My configuration file is as follows. I am running sensors version 3.3.0 with
> libsensors version 3.3.0
> 
> chip "it8721-isa-*"
> 
> # Temperatures
>     label temp1 "CPU"
>     label temp2 "Northbridge"
>     label temp3 "Mainboard"
> 
> # fans
> # Assuming fans are connected as specified on the motherboard.
> # CPU fan is a 4 pin PWM connector, the others are 3 pin.
>     label fan1 "CPU Fan"
>     label fan2 "System Fan 1"
>     label fan3 "System Fan 2"
> 
> # Voltages
>     #Not sure what in0 and in1 are. They're stable, maybe +12V and +5V lines
> in need of scaling?
>     label in2 "Vcore"
>     label in3 "+3.3V"
>     label in4 "NB Voltage"
>     label in5 "DDR Voltage"
>     label in6 "HT Voltage"
>     label in7 "+3.3Vsb"
> 
> 
> chip "acpitz-virtual-0"
> # This is essentially the same as the CPU temperature.

This could be problematic. If ACPI reads from the same registers as the
IT8712F chip, as these accesses are not synchronized, they could
collide. This is a problem affecting many boards unfortunately, with no
good solution so far.

>     label temp1 "temp1"

This is a no-op.

 chip "k10temp-pci-00c3"
> #    temp1 represents the CPU temperature but is not in any physical unit
>     label temp1 "temp2"

This is pretty confusing. Either leave it alone or give it a proper
name ("CPU").

The fact that the value doesn't seem to match the reality is known.
Some CPU models have broken sensors. The rest returns a relative value.
From Documentation/hwmon/k10temp:

"There is one temperature measurement value, available as temp1_input in
sysfs. It is measured in degrees Celsius with a resolution of 1/8th degree.
Please note that it is defined as a relative value; to quote the AMD manual:

  Tctl is the processor temperature control value, used by the platform to
  control cooling systems. Tctl is a non-physical temperature on an
  arbitrary scale measured in degrees. It does _not_ represent an actual
  physical temperature like die or case temperature. Instead, it specifies
  the processor temperature relative to the point at which the system must
  supply the maximum cooling for the processor's specified maximum case
  temperature and maximum thermal power dissipation."

Unfortunately we still lack a way to let user-space know about this
limitation.

> The Northbridge temperature is not listed in the BIOS, but it's the only
> component that runs that hot, is not affected by CPU load, and is affected
> by CPU fan speed (the cooler gets some air to the northbridge)
> 
> I'm pretty sure that in0 and in1 are +5V and +12V readings since those are
> shown in the BIOS, but I don't know of a way to tell them apart.

Go to the BIOS and watch the +5V and +12V values. Write down every
different sample you manage to get. The more samples, the better. Then
check the raw values (from sensors -u) for in0 and in1. Write down all
samples as well if there are many. From that we can find out who is who
and the scaling factors.

> Fancontrol does work with this setup although with my cooling it doesn't
> accomplish much since the loudest and most powerful fans are cooling my
> drives. Biostar makes some other 880G-based motherboards and this
> configuration may apply to them too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
