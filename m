From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 10 Apr 2010 08:07:30 +0000
Subject: Re: [lm-sensors] Coretemp goes up since 2.6.31.4
Message-Id: <20100410100730.54776659@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100409111733.7bb2b5fa@hyperion.delvare>
In-Reply-To: <20100409111733.7bb2b5fa@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 09 Apr 2010 20:08:18 +0200, dienet wrote:
> On Fri, 09 Apr 2010 11:17:33 +0200, Jean Delvare <khali@linux-fr.org>
> wrote:
> 
> > On Thu, 08 Apr 2010 18:36:34 +0200, dienet wrote:
> >> I was using 2.6.31.4 for quite some time - it works OK.
> >> Command 'sensor' that gives me temperature on my C2D, was saying that
> >> cores have around 28-45 deg (min and maxs on normal day work)
> >> Now on 2.6.33.1 sensors gives temperatures around 32-48 deg. I never  
> >> seen
> >> 29 or below. No room temperature is changing (got two kernels installed,
> >> so I can change it quickly)
> >> Who is telling the truth here? Was there any works on coretemp module
> >> since 2.6.31.4 that made the change in read-out?
> >
> > There were some changes to the coretemp driver in 2.6.32 and 2.6.33,
> > but these shouldn't affect older CPU models and would also not change
> > the readout by a few degrees. You can check if the high temperature
> > limit is the same - then you can assume the driver changes did not
> > affect your system.
> 
> On 2.6.31.4:
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +33.0°C  (high = +100.0°C, crit = +100.0°C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +33.0°C  (high = +100.0°C, crit = +100.0°C)
> 
> On 2.6.33.1:
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +34.0°C  (high = +105.0°C, crit = +105.0°C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +34.0°C  (high = +105.0°C, crit = +105.0°C)
> 
> So there is a 5 deg diffrance. I did not change any config files.

I assume these results are using the original coretemp driver of each
kernel. So, you are in one of these cases where the heuristic changes
in 2.6. I can't say whether this is correct in your case or not, this
heuristic is a horrible mess. But the relevant thing here is that your
CPU is actually running _cooler_ in 2.6.33 than in 2.6.31: 71 degrees
below the critical limit, instead of 67 degrees below the limit
previously. In both cases, you have a huge thermal margin, so it's
alright.

The fact that the high limit has the same value as the critical limit
is certainly a bug, as it doesn't make any sense physically.

> >> I think that because that temp. change fan is working more often.
> >>
> >> I'm using Lenovo ThinkPad T61.
> >
> > This suggests that the temperature increase is real and this isn't just
> > a reporting issue. I suggest that you check
> > in /proc/acpi/processor/*/power, the amount of time spent in C2 and C3
> > states. Also install powertop and run it on both kernels, see if 2.6.33
> > has more frequent wake-ups than 2.6.31.
> 
> On 2.6.31.4 powertop says:
> 
> C3 - 90, 7% of the time
> P (800MHz) - 98%
> Wakeups: 627
> 
> On 2.6.33.1 powertop says:
> 
> C3 - 93% of the time
> P (800MHz) - 98%
> Wakeups: 556

So 2.6.33 is indeed better, which is good news.

> Was running the same programs. Kernel 2.6.33.1 was running for about 1h.
> 
> I'm asuming that /proc/acpi/processor/*/power is used by powertop so I'm
> not paseting it. But it also says that C3 is more often used then others.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
