From: 4ernov <4ernov@gmail.com>
Date: Wed, 02 Feb 2011 09:34:44 +0000
Subject: Re: [lm-sensors] How to distinguish sensors on Xeon multi-socket
Message-Id: <AANLkTimKLBbUPb2j5sLqp-+4qNtmZOJ7pP73gR1Es-Hr@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201102012323.13215.4ernov@gmail.com>
In-Reply-To: <201102012323.13215.4ernov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

2011/2/2 Jean Delvare <khali@linux-fr.org>:
> On Tue, 1 Feb 2011 17:23:04 -0800, Guenter Roeck wrote:
>> On Tue, Feb 01, 2011 at 03:23:13PM -0500, Alexey Chernov wrote:
>> > Hello,
>> >
>> > I have two socket motherboard with two Xeon's 5345 installed on them, so
>> > overall it's 8 cores. Using lm_sensors all of them are detected correctly out
>> > of the box, but the problem is that after certain Linux kernel upgrade (I
>> > believe it's somewhere around 2.6.32) matching kernel on both processors
>> > started to be called identically. I have two 'Core 0', two 'Core 1' etc. and
>> > it drives mad many applications which use lm_sensors. Here's the output of
>
> These are badly written applications, which need to be fixed
> regardless of what the coretemp did, does, or will do. Label uniqueness
> across multiple sensor devices isn't and has never been guaranteed. We
> only guarantee uniqueness of symbols within each given chip.
> Application which needs unique keys must use the combination of the
> chip name + the symbol name; definitely not the label.

That's right and this is what I want to do with one of them but the
question is how to do it properly. Thank you for suggestion on unique
keys. What is "symbol name"? Does it stand for sensors_feature struct
or label?

>> > 'sensors' command:
>> > sensors
>> > radeon-pci-0700
>> > Adapter: PCI adapter
>> > temp1:       +77.0°C
>> >
>> > coretemp-isa-0000
>> > Adapter: ISA adapter
>> > Core 0:      +70.0°C  (high = +86.0°C, crit = +100.0°C)
>> >
>> > coretemp-isa-0001
>> > Adapter: ISA adapter
>> > Core 2:      +63.0°C  (high = +86.0°C, crit = +100.0°C)
>> >
>> > coretemp-isa-0002
>> > Adapter: ISA adapter
>> > Core 0:      +69.0°C  (high = +86.0°C, crit = +100.0°C)
>> >
>> > coretemp-isa-0003
>> > Adapter: ISA adapter
>> > Core 2:      +69.0°C  (high = +86.0°C, crit = +100.0°C)
>> >
>> > coretemp-isa-0004
>> > Adapter: ISA adapter
>> > Core 1:      +68.0°C  (high = +86.0°C, crit = +100.0°C)
>> >
>> > coretemp-isa-0005
>> > Adapter: ISA adapter
>> > Core 3:      +65.0°C  (high = +86.0°C, crit = +100.0°C)
>> >
>> > coretemp-isa-0006
>> > Adapter: ISA adapter
>> > Core 1:      +68.0°C  (high = +86.0°C, crit = +100.0°C)
>> >
>> > coretemp-isa-0007
>> > Adapter: ISA adapter
>> > Core 3:      +67.0°C  (high = +86.0°C, crit = +100.0°C)
>> >
>> > I try to fix the KDE sensors applet as it shows only 4 cores and ignores
>> > remaining ones due to name collision. But I really don't know how to
>> > distinguish the certain cores of the processors. Could you please give me a
>> > reference how can I tell, for instance one 'Core 0' from another? The ideal
>> > case is if they can be addressed as 'Processor 1/Core 0' but I can't find the
>> > right way.
>>
>> No idea.
>
> Currently, you can't.
>
>> I added the driver maintainer to this e-mail; maybe your problem helps to explain
>> why Jean and I believe that the driver should instantiate itself per CPU, not per core.
>
> Yes, definitely. The above output should really look like:
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +70.0°C  (high = +86.0°C, crit = +100.0°C)
> Core 1:      +68.0°C  (high = +86.0°C, crit = +100.0°C)
> Core 2:      +63.0°C  (high = +86.0°C, crit = +100.0°C)
> Core 3:      +65.0°C  (high = +86.0°C, crit = +100.0°C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 0:      +69.0°C  (high = +86.0°C, crit = +100.0°C)
> Core 1:      +68.0°C  (high = +86.0°C, crit = +100.0°C)
> Core 2:      +69.0°C  (high = +86.0°C, crit = +100.0°C)
> Core 3:      +67.0°C  (high = +86.0°C, crit = +100.0°C)
>
> where 0000 and 0001 would be the CPU numbers. This would be much easier
> for users to figure out what they're seeing. We're waiting for the
> coretemp driver maintainer to implement this.
>
> In the meantime, a workaround would be to align the hwmon device
> numbers with the CPU number, so that the user can at least look-up
> in /proc/cpuinfo to find out who is who. But there is no guarantee for
> the CPU enumeration order to stay the same across reboots, so the
> interest would be limited in practice.

Is it about lm-sensors or the applications? As for the applications I
think it's the possible solution because the list of sensors could be
generated on every startup of the app and if there were some mapping
between hwmon and, say, 'core id' in /proc/cpuinfo, the processors can
be recognized.

>
> --
> Jean Delvare
>

Jean, thank you very much for detailed information. I hope it helps a
lot to fix my problem.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
