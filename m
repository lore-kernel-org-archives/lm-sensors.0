From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 22 Oct 2006 20:26:12 +0000
Subject: [lm-sensors] About the "CPU temp" output of ADM1025A chip
Message-Id: <453BD3E4.8070509@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
In-Reply-To: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yongkui,

> Thanks very much for your help.

Well always good to hear it. Unfortunately I have not so much free time recently 
for this kind of lm-sensors support stuff.

> The pin numbers for the thermal diode in the Pentium 4 CPU are H38 and 
> E39. I think the PIN 9 and 10 of ADM1025A chip are connected to the PIN 
> H38 and E39 of the Pentium 4 CPU. So the temperature output "CPU Temp" 
> from lm-sensors should be the temprature reading of this thermal diode.

Good.

> The datasheet of my Pentium 4 CPU is here:
> http://www.intel.com/design/pentium4/datashts/249198.htm
> ftp://download.intel.com/design/Pentium4/datashts/24919805.pdf
>  
>  
> A picture for my CPU chip and the ADM1025A chip is attached. You can see 
> in the picture that the ADM1025A chip sits close to the Pentium 4 CPU 
> chip (the top-right location).

It should be so - the analog lines are as shortest as possible.

> The followings are some observations from my experiments with lm-sensors:
> -----------------------------------
> The operating system is idle: CPU5C, M/B4C.
> I run many CPU-intensive programs to see how high the CPU temperature 
> can reach.
> The highest temperature I observed are: CPUUC, M/BGC
> The largest temperature difference between CPU and M/B is 8C.
> It takes about 8 minutes for the CPU temp to reach 55C, and then stay at 
> 55C. This means it reached its steady state temperature.

Hmm this indicates perhaps the thermistor instead of the diode. It takes too 
long. The core temperature should grow very very fast. But if the pins are 
connected to the socket it must be diode. (and it seems that the chip is for 
diode only)

> I expect the CPU temperature could reach 80C or 90C for some 
> CPU-intensive programs. But unfortunatly, 55C is the highest temperature 
> I observed so far. 55C is not so high in my opinion, why the CPU 
> temperature cannot reach 80C or 90C? The critical temperature for the 
> Pentium 4 CPU chip to shut down is 135C. 

Yes true.

> Now I am wondering where this thermal diode is located inside the 
> Pentium 4 CPU. Is this thermal diode located near the Integer Register 
> unit, or near the Floating-point Multiplication unit,  or near the Level 
> 2 Cache unit? You know, there is a large temperature difference between 
> two different locations on the CPU chip.

Well this is not known. If some parts get too hot the CPU  might throttle a bit 
to cool down. Maybe you could try the "cpuburn" software.
http://packages.debian.org/unstable/misc/cpuburn.html
(for debian)

> Do you have any hints about the thermal diode location in the Pentium 4 
> CPU chip?

No but you may take a look to: Intel? 64 and IA-32 Architectures Software 
Developer's Manual, Volume 3A: System Programming Guide describes the 
operating-system support environment of an IA-32 and Intel? 64 architectures, 
including: memory management, protection, task management, interrupt and 
exception handling, multi-processor support, and thermal and power management 
features.

There are some notes and stuff about the thermal monitor (the digital sensor 
have core/core2 cpus so perhaps not yours)

http://www.intel.com/design/pentium4/manuals/index_new.htm

All in all there is more then one temperature sensor, sometimes there is digital 
temperature sensor, and even the diode is locate on other place...


You may check the "IA32_THERM_STATUS MSR" via MSR reads (/dev/msr/...)
http://www.google.com/codesearch?q=+rdmsr.c+show:EynqVEYBclg:kdySSoK4L6Y:chKAG6mOivc&sa=N&cd=1&ct=rc&cs_p=http://www.stillhq.com/extracted/x86info-wx.tgz&cs_f=x86info-wx/x86info-1.11/rdmsr.c#a0

To sum it up. You need some cpuburn to burn the cpu. Then the temp should grow 
quickly. Using the MSR you may check if the CPU defend itself when too hot.

I hope it will help you during your experiments. If you burn the CPU to dead ;), 
buy Core 2 CPU it has the embedded temperature sensor (and I wrote the driver 
recently)

Regards
Rudolf

