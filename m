From: 4ernov <4ernov@gmail.com>
Date: Wed, 02 Feb 2011 07:36:09 +0000
Subject: Re: [lm-sensors] How to distinguish sensors on Xeon multi-socket
Message-Id: <AANLkTim_0fT4zwsNoGh4wuHbY9urmWhec+3e-M0TC2sB@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201102012323.13215.4ernov@gmail.com>
In-Reply-To: <201102012323.13215.4ernov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Thanks, Guenter.

Before the problem appeared (I think, pre-2.6.32 kernels or so) there
were sensors for every core, too, but as I remember they used to have
labels 'Core 0' to 'Core 7', so without similar ones.

2011/2/2 Guenter Roeck <guenter.roeck@ericsson.com>:
> On Tue, Feb 01, 2011 at 03:23:13PM -0500, Alexey Chernov wrote:
>> Hello,
>>
>> I have two socket motherboard with two Xeon's 5345 installed on them, so
>> overall it's 8 cores. Using lm_sensors all of them are detected correctly out
>> of the box, but the problem is that after certain Linux kernel upgrade (I
>> believe it's somewhere around 2.6.32) matching kernel on both processors
>> started to be called identically. I have two 'Core 0', two 'Core 1' etc. and
>> it drives mad many applications which use lm_sensors. Here's the output of
>> 'sensors' command:
>> sensors
>> radeon-pci-0700
>> Adapter: PCI adapter
>> temp1:       +77.0°C
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:      +70.0°C  (high = +86.0°C, crit = +100.0°C)
>>
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> Core 2:      +63.0°C  (high = +86.0°C, crit = +100.0°C)
>>
>> coretemp-isa-0002
>> Adapter: ISA adapter
>> Core 0:      +69.0°C  (high = +86.0°C, crit = +100.0°C)
>>
>> coretemp-isa-0003
>> Adapter: ISA adapter
>> Core 2:      +69.0°C  (high = +86.0°C, crit = +100.0°C)
>>
>> coretemp-isa-0004
>> Adapter: ISA adapter
>> Core 1:      +68.0°C  (high = +86.0°C, crit = +100.0°C)
>>
>> coretemp-isa-0005
>> Adapter: ISA adapter
>> Core 3:      +65.0°C  (high = +86.0°C, crit = +100.0°C)
>>
>> coretemp-isa-0006
>> Adapter: ISA adapter
>> Core 1:      +68.0°C  (high = +86.0°C, crit = +100.0°C)
>>
>> coretemp-isa-0007
>> Adapter: ISA adapter
>> Core 3:      +67.0°C  (high = +86.0°C, crit = +100.0°C)
>>
>> I try to fix the KDE sensors applet as it shows only 4 cores and ignores
>> remaining ones due to name collision. But I really don't know how to
>> distinguish the certain cores of the processors. Could you please give me a
>> reference how can I tell, for instance one 'Core 0' from another? The ideal
>> case is if they can be addressed as 'Processor 1/Core 0' but I can't find the
>> right way.
>>
> No idea.
>
> I added the driver maintainer to this e-mail; maybe your problem helps to explain
> why Jean and I believe that the driver should instantiate itself per CPU, not per core.
>
> Guenter
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
