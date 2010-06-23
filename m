From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Jun 2010 07:53:51 +0000
Subject: Re: [lm-sensors] Too low temp readings on overclocked Intel Atom CPU
Message-Id: <20100623095351.7ca667e6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
In-Reply-To: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Ulf,

Preliminary note: the mAtom 330 is a dual-core CPU, so you really have
2 cores, not 4. I guess that each core has hyper-threading, which is
why you see 4 CPU entries. But I suspect that there's only one sensor
per core, so the coretemp driver should only display 2 values. I've
sent a patch fixing this, but it didn't receive any comment:
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028511.html

About the Asrock software: it is possible that Asrock knows about the
problem and silently compensate for it. You'd need to ask them. But it
is also possible that other CPU samples have working sensors when
overclocked and only yours doesn't. Each CPU is unique when
overclocking. The only way to know for sure would be to run the Asrock
software on your own system.

Don't you have an external hardware monitoring chip on your board? It
would probably be less influenced by overclocking, and would thus be
more reliable for comparing the temperature with and without
overclocking.

Anyway, please note that the CPU temperature values reported by the
coretemp driver are notoriously inaccurate as long as they are way
below the critical limit. This is your case. So the bottom line is that
your CPU is very cool and you have no thermal issue at all.

But beware, problems when overclocking aren't limited to a higher
running temperatures. All kind of issues can happen, which you won't
notice until things start failing mysteriously. And overclocking
doesn't buy you much in practice anyway, as the limiting speed factor
these days is more often the disk and memory speed than the CPU speed.

Jean

On Tue, 22 Jun 2010 11:00:37 +0200, Ulf Granlund wrote:
> 
> Hi Jean, thank you for your answer.
> Some answers to your questions, as far as I can get them:
> The CPU model is "Intel Atom CPU 330 @1.6 GHz" according to system info in the BIOS.
> CPU Voltage: From the manual or the Asrock home page, I have not found any clear specification on exactlywhat parameters the overclocking option alters. I found some hardware review pages on the net stating thatwhen using this option ( with the highest available frequency, 2100 MHz) the CPU voltage is automaticallyset to 1.315 V. I have no idea about how reliable this information is or where they got it from. In the BIOS theoverclocking option is mentioned as "an optimized set" of overclocking parameters, indicating that at least morethan one parameter is affected.
>  When I load the CPU:s there is a clear raise in temperature values both when I am overclocked and when running atstandard speed, but for essentially the same CPU load (watching a movie for 5 minutes) the temperatures are about 10 to 15 °Clower in the overclocked state, which does not seem reasonable.
> In the hardware reviews found on some net sites, it is mentioned that there is a (Windows) systemmonitoring software that is supplied with the system from Asrock. There is data from this softwarepresented in the reviews, where temperature readings are collected in both standard and overclocked states, andfrom that software they get temperature readings that are clearly higher when running overclocked, which seems to bethe most reasonable result. To me this seems to show that it is possible to get reliable temp readings also in the overclockedstate. But then again that software is supplied by Asrock, and I guess they have full control of all parameters.
> Best Regards
> Ulf
> ----------------------------------------
> > Date: Mon, 21 Jun 2010 23:06:05 +0200
> > From: khali@linux-fr.org
> > To: galsjo@hotmail.com
> > CC: lm-sensors@lm-sensors.org; huaxu.wan@intel.com
> > Subject: Re: [lm-sensors] Too low temp readings on overclocked Intel Atom CPU
> >
> > Hi Ulf,
> >
> > On Mon, 21 Jun 2010 12:19:50 +0200, Ulf Granlund wrote:
> >>
> >> Hello,
> >> I am running an Asrock Ion computer under Ubuntu 10.4. It has four Intel Atom CPU cores. In the Asrock BIOS thereis an option to introduce overclocking. I have set the frequency to 1800 MHz insetad of the standard 1600 MHz..
> >
> > By doing this, you are unsupported. If you decide to use your hardware
> > beyond its specification, you shouldn't be surprised if it fails.
> >
> > Please tell us the exact CPU model.
> >
> > Do you know if the overclocking alters only the frequency, or also the
> > CPU core voltage?
> >
> >> After having the computer switched on for several hours, but the CPU:s mainly idle, the output from the sensors command is as below,in a room where ambient temperature is about 22 C.
> >> coretemp-isa-0000Adapter: ISA adapterCore 0:       +4.0°C  (crit = +90.0°C)
> >> coretemp-isa-0001Adapter: ISA adapterCore 1:      +16.0°C  (crit = +90.0°C)
> >> coretemp-isa-0002Adapter: ISA adapterCore 2:       +3.0°C  (crit = +90.0°C)
> >> coretemp-isa-0003Adapter: ISA adapterCore 3:      +16.0°C  (crit = +90.0°C)
> >
> > This is horribly formatted.
> >
> >> Clearly these temperatures are way too low.However, if I set the processor frequency to the standard 1600 MHz,I get:
> >> coretemp-isa-0000Adapter: ISA adapterCore 0:      +17.0°C  (crit = +90.0°C)
> >> coretemp-isa-0001Adapter: ISA adapterCore 1:      +25.0°C  (crit = +90.0°C)
> >> coretemp-isa-0002Adapter: ISA adapterCore 2:      +18.0°C  (crit = +90.0°C)
> >> coretemp-isa-0003Adapter: ISA adapterCore 3:      +25.0°C  (crit = +90.0°C)
> >> Which at least seems far more reasonable.
> >
> > This is very interesting. Adding the coretemp driver maintainer in Cc.
> >
> >> It seems that the more I overclock, the lower the temperature readings get.Can somebody explain how to get correct temp readings? It is of course more importantto me to get correct readings in the overclocked situation than in the standard situation...
> >> The lm-sensors version used is 3.1.2 and the linux kernel version is 2.6.32.
> >
> > First thing to check is: do the temperature values increase or decrease
> > when you load the CPUs?
> >
> > Then I guess you could give a try to the latest version of the driver,
> > as it received changes recently:
> > http://khali.linux-fr.org/devel/misc/coretemp/
> >
> > But anyway, odds are that the sensors are affected by overclocking and
> > nothing can be done, except: don't do it.
> >
> > --
> > Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
