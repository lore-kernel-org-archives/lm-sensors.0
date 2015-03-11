From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 11 Mar 2015 04:37:31 +0000
Subject: Re: [lm-sensors] ASUS X99-E WS / AMD HD 5870
Message-Id: <54FFC68B.1010902@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1425971533.19075.15.camel@gmail.com>
In-Reply-To: <1425971533.19075.15.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/10/2015 12:12 AM, Nybbles2Bytes wrote:
> Hi,
>
> Thanks in advance for any help!
>
> The following is the basics of my hardware. It's a very new machine.
>
> My hardware is:
> * Motherboard: ASUS X99-E WS
> * CPU: Intel Core i7-5960X
> * Graphics card: AMD HD 5870
> * Water cooling for the processor
>
Nice system.

> There's a widget that just called temperature that goes on a KDE4
> desktop panel and it shows the following sensors:
>
>
> acpi/Thermal_Zone/0/Temperature               100 F
> lmsensors/coretemp-isa-0000/Physical_id_0     100 F
> lmsensors/radeon-pci-0600/temp1               140 F
> lmsensors/coretemp-isa-0000/Core_0             70 F
> lmsensors/coretemp-isa-0000/Core_1             70 F
> lmsensors/coretemp-isa-0000/Core_2             70 F
> lmsensors/coretemp-isa-0000/Core_3             70 F
> lmsensors/coretemp-isa-0000/Core_4             70 F
> lmsensors/coretemp-isa-0000/Core_5             70 F
> lmsensors/coretemp-isa-0000/Core_6             70 F
> lmsensors/coretemp-isa-0000/Core_7             70 F
>
> The cores 0 to 7 are obviously the cores of my processor and the
> "radeon-pci-0600" is my graphics card. Now however it gets uncertain.
>

acpi is the cpu temperature as well. Kind of odd that the package
temperature is much higher than the core temperatures - I don't
recall ever seeing that. Of course, I also never had the pleasure
of using to such a fancy CPU either ...

> Looking around on the on the lm sensor site I saw a list of motherboards
> and mine wasn't in the list.
>
The motherboard doesn't have to be known. Check out 'Device support status'
at http://www.lm-sensors.org/wiki/Devices.

> * Does this mean I can't trust the sensors I don't know because lm
> sensors probably doesn't understand them anyway?
>

The kernel _does_ know which motherboard it is running on, but for the
most part it does not need that information. A temperature is a
temperature, and a voltage is a voltage, no matter which motherboard
it is measured on. lm-sensors only uses the information provided to it
by the kernel, and does not need to know the specific motherboard.
It needs to be _configured_ for motherboard specifics (see below),
but that is a different question.

Question is really how accurate the various sensors are, and that is
determined by the chip measuring the voltages or temperatures, not by
the motherboard. For example, Intel CPU temperature sensors are known
to be inaccurate at low temperatures (not as bad as AMD or Intel Atom,
though).

> * If lm sensors doesn't know my MB how do I get that information into lm
> sensors?
>
Look for the sensors-detect program to determine if there are more sensors
in addition to the ones already detected. If you have a recent kernel (3.12
or later), you might want to try "sudo modprobe nct6775". This will give
you access to the sensors on the Super-IO chip (NCT6791D according to
information available online).

Note that to make sense of the voltage sensor readings provided by
the Super-IO chip, you'll need to do some work and add the configuration
to /etc/sensors3.conf. http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
gives you some hints of what you'll need to do.
http://www.lm-sensors.org/wiki/Configurations/Asus/H87-Pro might be
a good start, since that motherboard uses the same Super-IO chip,
and Asus has the tendency to use similar settings on its various
motherboards.

> * How do I know physically "where a sensor is"/"what it's for" that
> isn't obvious like the core sensors are?
>
Only the motherboard manufacturer can tell you where sensors are
physically located, and usually they don't provide that information.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
