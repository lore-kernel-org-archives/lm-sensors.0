From: hanyongkui99@gmail.com (Yongkui Han)
Date: Mon, 23 Oct 2006 02:43:31 +0000
Subject: [lm-sensors] About the "CPU temp" output of ADM1025A chip
Message-Id: <2ca62ec0610221943g12b80c5fo6197d70d95048b19@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
In-Reply-To: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Thanks so much for your reply.

I downloaded the CPU burn program, and run it to see how high the CPU temp
can reach.

I run the CPU burn program for 10 minutes = 600 seconds. The temperature
curve for the CPU burn program is attached for your reference. The highest
temperature reached is 53C. I also drew the temperature curve for the 900
seconds before running cpuburn, and for the 300 seconds after cpuburn
program exited.

In the attachments, the file cpuburn.pdf is the complete temperature curve
for nearly 1800 seconds. The file cpuburn.100s.pdf is for the 100
seconds time interval of [850, 950] only.

The CPU temp is increased 4C (from 39C to 43C) during the first 8 seconds
when cpuburn program starts running. But it takes about 300 seconds for the
CPU temp to reach 53C. Does the CPU temp grow fast or slowly?

Based on the temperature curve, which one do you think the CPU temp is for?
The thermal diode inside the CPU chip, or just a thermistor?

Thanks!

Regards,
Yongkui


On 10/22/06, Rudolf Marek <r.marek at assembler.cz> wrote:
>
> Hi Yongkui,
>
> > Thanks very much for your help.
>
> Well always good to hear it. Unfortunately I have not so much free time
> recently
> for this kind of lm-sensors support stuff.
>
> > The pin numbers for the thermal diode in the Pentium 4 CPU are H38 and
> > E39. I think the PIN 9 and 10 of ADM1025A chip are connected to the PIN
> > H38 and E39 of the Pentium 4 CPU. So the temperature output "CPU Temp"
> > from lm-sensors should be the temprature reading of this thermal diode.
>
> Good.
>
> > The datasheet of my Pentium 4 CPU is here:
> > http://www.intel.com/design/pentium4/datashts/249198.htm
> > ftp://download.intel.com/design/Pentium4/datashts/24919805.pdf
> >
> >
> > A picture for my CPU chip and the ADM1025A chip is attached. You can see
> > in the picture that the ADM1025A chip sits close to the Pentium 4 CPU
> > chip (the top-right location).
>
> It should be so - the analog lines are as shortest as possible.
>
> > The followings are some observations from my experiments with
> lm-sensors:
> > -----------------------------------
> > The operating system is idle: CPU5C, M/B4C.
> > I run many CPU-intensive programs to see how high the CPU temperature
> > can reach.
> > The highest temperature I observed are: CPUUC, M/BGC
> > The largest temperature difference between CPU and M/B is 8C.
> > It takes about 8 minutes for the CPU temp to reach 55C, and then stay at
> > 55C. This means it reached its steady state temperature.
>
> Hmm this indicates perhaps the thermistor instead of the diode. It takes
> too
> long. The core temperature should grow very very fast. But if the pins are
> connected to the socket it must be diode. (and it seems that the chip is
> for
> diode only)
>
> > I expect the CPU temperature could reach 80C or 90C for some
> > CPU-intensive programs. But unfortunatly, 55C is the highest temperature
> > I observed so far. 55C is not so high in my opinion, why the CPU
> > temperature cannot reach 80C or 90C? The critical temperature for the
> > Pentium 4 CPU chip to shut down is 135C.
>
> Yes true.
>
> > Now I am wondering where this thermal diode is located inside the
> > Pentium 4 CPU. Is this thermal diode located near the Integer Register
> > unit, or near the Floating-point Multiplication unit,  or near the Level
> > 2 Cache unit? You know, there is a large temperature difference between
> > two different locations on the CPU chip.
>
> Well this is not known. If some parts get too hot the CPU  might throttle
> a bit
> to cool down. Maybe you could try the "cpuburn" software.
> http://packages.debian.org/unstable/misc/cpuburn.html
> (for debian)
>
> > Do you have any hints about the thermal diode location in the Pentium 4
> > CPU chip?
>
> No but you may take a look to: Intel(r) 64 and IA-32 Architectures Software
> Developer's Manual, Volume 3A: System Programming Guide describes the
> operating-system support environment of an IA-32 and Intel(r) 64
> architectures,
> including: memory management, protection, task management, interrupt and
> exception handling, multi-processor support, and thermal and power
> management
> features.
>
> There are some notes and stuff about the thermal monitor (the digital
> sensor
> have core/core2 cpus so perhaps not yours)
>
> http://www.intel.com/design/pentium4/manuals/index_new.htm
>
> All in all there is more then one temperature sensor, sometimes there is
> digital
> temperature sensor, and even the diode is locate on other place...
>
>
> You may check the "IA32_THERM_STATUS MSR" via MSR reads (/dev/msr/...)
>
> http://www.google.com/codesearch?q=+rdmsr.c+show:EynqVEYBclg:kdySSoK4L6Y:chKAG6mOivc&sa=N&cd=1&ct=rc&cs_p=http://www.stillhq.com/extracted/x86info-wx.tgz&cs_f=x86info-wx/x86info-1.11/rdmsr.c#a0
>
> To sum it up. You need some cpuburn to burn the cpu. Then the temp should
> grow
> quickly. Using the MSR you may check if the CPU defend itself when too
> hot.
>
> I hope it will help you during your experiments. If you burn the CPU to
> dead ;),
> buy Core 2 CPU it has the embedded temperature sensor (and I wrote the
> driver
> recently)
>
> Regards
> Rudolf
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061022/eca992a8/attachment-0001.html 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cpuburn.pdf
Type: application/pdf
Size: 3367 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061022/eca992a8/attachment-0002.pdf 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cpuburn.100s.pdf
Type: application/pdf
Size: 1728 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061022/eca992a8/attachment-0003.pdf 
