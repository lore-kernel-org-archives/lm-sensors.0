From: Carren Stuart <kiwionabike@xnet.co.nz>
Date: Sun, 13 Jan 2008 07:52:13 +0000
Subject: Re: [lm-sensors] lmsensors and gkrellm
Message-Id: <200801132052.13787.kiwionabike@xnet.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200801131658.26068.kiwionabike@xnet.co.nz>
In-Reply-To: <200801131658.26068.kiwionabike@xnet.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun January 13 2008 6:37:32 pm you wrote:

> The coretemp readings come from a digital temperature sensor inside
> the processor. The processor provides PCI device entries which access
> these internal sensors.
>
> The thermal_zone readings come from ACPI, so they might come from any
> source, but 99% of the time, they are analog temperature sensors on
> the processor, read by converting from analog to digital on the
> motherboard. The processor does have a temperature sensor pin for each
> core, which is this analog sensor.

One would think therefore that the coretemp values would generally read higher 
than the ACPI values, given that the coretemp sensors are embedded in the 
core? This isn't the case with mine however - the thermal_zone values are 
always significantly higher.

<SNIP>

> What does this mean for you? Well, you don't want any of the sensors
> to go too high, since they are all measuring real temperatures.

Which is another area of confusion to me. I have tried to find out what the 
recommended temp range is for my processor, but when I emailed Intel they 
told me they couldn't help me as my processor was an OEM product not a retail 
product. They suggested I contact Acer, which I did, but never got a 
response, so I'm still flying blind as far as knowing what temps would be 
considered "high" or " cause for concern" for my processor.

> Also, you might be able to cool things down faster by watching the
> coretemp sensors, since they respond more quickly to changes in the
> load on the chip. But your CPU fan is probably watching the analog
> sensors, so it will be slow to react to a sudden change in CPU
> temperature.

This is interesting. What puzzles me is that the thermal_zone values are 
nearly always exactly the same for both cores, whereas the coretemp values 
are almost always slightly different (which makes more sense to me)

> But don't feel like high temperatures mean instant death. Intel and
> Acer have probably taken good care to be sure the chip can't be
> permanently damaged -- in fact, if the chip actually gets close to
> damaging itself, the laptop will probably turn off, instantly, without
> warning.

Well that's good to know.

Many thanks for the excellent explanation David. Much appreciated :-)

~ Carren


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
