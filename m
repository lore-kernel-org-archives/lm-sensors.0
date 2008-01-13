From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sun, 13 Jan 2008 05:37:32 +0000
Subject: Re: [lm-sensors] lmsensors and gkrellm
Message-Id: <4dfa50520801122137p34b5c302pbd6e8b87147ce7a7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200801131658.26068.kiwionabike@xnet.co.nz>
In-Reply-To: <200801131658.26068.kiwionabike@xnet.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Carren,

On Jan 12, 2008 8:58 PM, Carren Stuart <kiwionabike@xnet.co.nz> wrote:
> Hi :-)
>
> I'm hoping somebody here can enlighten me.
>
> I'm running OpenSUSE 10.3 on an Acer Travelmate laptop with an Intel Core Duo
> 1.6GHz processor.
>
> I finally figured out how to get lmsensors running and configured so that I
> could get my hdd temps showing up in gkrellm.
>
> I'm confused about something though ....
>
> Prior to getting this working GKrellM showed under CPU temp:
>
> thermal_zone/TZ00
> thermal_zone/TZ01
>
> with corresponding temps (dual core processor)
>
> Since fixing lmsensors however it now shows two extra entries:
>
> coretemp-hwmon0/temp1
> coretemp-hwmon1/temp1
>
> Also with corresponding temp readings.
>
> BUT the readings are not the same. The coretemp readings are several degrees
> lower than the thermal_zone readings, and the two cores are often showing
> different temps, whereas in the thermal_zone readings, the cores are nearly
> always showing the same temp.
>
> I'm assuming the coretemps are what is being detected by lmsensors, so what is
> reading the thermal_zone temps?
>
> Which readings are likely to be the most accurate ones i.e. the ones I should
> take notice of?
>
> EDIT: Just as an example ...
>
> right now the thermal_zone reading is showing temps of 51 and 51. The coretemp
> reading is showing 45 and 41. That's a significant difference when it comes
> to knowing when to be concerned about a particular temp.
>
> If anyone can explain to me what the difference is between the thermal_zone
> readings and the coretemp readings, and which of the two is considered more
> accurate/reliable, I'd appreciate it.
>
> Thanks in advance,
>
> ~ Carren

The coretemp readings come from a digital temperature sensor inside
the processor. The processor provides PCI device entries which access
these internal sensors.

The thermal_zone readings come from ACPI, so they might come from any
source, but 99% of the time, they are analog temperature sensors on
the processor, read by converting from analog to digital on the
motherboard. The processor does have a temperature sensor pin for each
core, which is this analog sensor.

Surprisingly, you really have 4 temperature sensors. Each core has a
digital and an analog sensor. The analog sensor is likely located on
the top of the chip, inside its ceramic housing and close to the
heatsink. On chips where this is the case, the analog sensor moves
more slowly than the digital sensor, since the heat has to travel a
short distance to reach the sensor. The digital sensor is likely
located right next to the gates that are generating the heat.

Also keep in mind that the analog and digital sensors might be in
different regions of the chip, and so one might heat up as its section
of the chip is very active compared to the other.

What does this mean for you? Well, you don't want any of the sensors
to go too high, since they are all measuring real temperatures.

Also, you might be able to cool things down faster by watching the
coretemp sensors, since they respond more quickly to changes in the
load on the chip. But your CPU fan is probably watching the analog
sensors, so it will be slow to react to a sudden change in CPU
temperature.

But don't feel like high temperatures mean instant death. Intel and
Acer have probably taken good care to be sure the chip can't be
permanently damaged -- in fact, if the chip actually gets close to
damaging itself, the laptop will probably turn off, instantly, without
warning.

At high temperatures, the chip may not be damaged but may not function
right. If you get random segfaults and crashes that aren't
software-related, and you are wondering what part of your hardware is
the problem, having a few extra temperature sensors might help you
diagnose your CPU's health.

Hope that helps,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
