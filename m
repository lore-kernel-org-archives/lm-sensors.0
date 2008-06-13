From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Fri, 13 Jun 2008 21:31:54 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080613233154.7d414ff5@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 13 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > (...)
> > Eventually I will look into this in the future, would be nice to
> > keep/restore alarms, divider, pwm settings and other configurations
> > of chips on resume (be it from S3/Suspend to RAM or from suspend to
> > disk)
> 
> Thinking about it, I see no reason why these settings would be lost on
> suspend-to-ram. Suspend-to-disk certainly will need some care.

At least PWM settings got lost on the nforce I did try it on.

The only time I tried suspend on the it87 system I didn't check (and my
small daemon that regulates fan speeds based on CPU-temp [k8temp] and
hdd temps [hddtemp] took ower control anyhow as soon as userspace was no
more frozen - sidenote: I would appreciate if libsensors also knew
about PWM :))
I didn't have a look at other settings like limits and the like.
For reasonable testing I will have to wait for suspend/resume support
in framebuffer/drm for my AMD chipset's integrated graphics, the system
usually not being stable after resume


> > 
> > #sensors
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:  +38.0°C                                    
> > Core1 Temp:  +25.0°C                                    
> > 
> > it8712-isa-0e80
> > Adapter: ISA adapter
> > VCore 1:     +1.17 V  (min =  +0.00 V, max =  +4.08 V)
> > VCore 2:     +0.82 V  (min =  +0.00 V, max =  +4.08 V)
> > +3.3V:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)
> > +5V:         +4.89 V  (min =  +0.00 V, max =  +6.85 V)
> > +12V:        +4.99 V  (min =  +0.00 V, max = +16.32 V)
> > -12V:       -13.74 V  (min = -27.36 V, max =  +3.93 V)
> > -5V:         -1.10 V  (min = -13.64 V, max =  +4.03 V)
> > Stdby:       +4.92 V  (min =  +0.00 V, max =  +6.85 V)
> > VBat:        +3.26 V
> > fan1:       3375 RPM  (min =    0 RPM, div = 8)
> > fan2:       1548 RPM  (min =    0 RPM, div = 8)
> > M/B Temp:    +20.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor > > thermal diode CPU Temp:    +46.0°C  (low  =  -1.0°C, high > > +127.0°C)  sensor = thermal diode Temp3:       +25.0°C  (low  > > -1.0°C, high = +127.0°C)  sensor = transistor cpu0_vid:   +1.550 V
> > 
> > fan1 = CPU fan
> >   (pwm1=2, pwm1_enable=1, pwm1_freq7500)
> > fan2 = artic cooling themperature controlled FAN
> >   (note: a drive-bay fan is controlled by pwm2 but has no
> >    tachometer - just in case the chip would make an assumption)
> > no fan 3 though pwm3 files exist
> 
> The driver asks the chip which fan channels are enabled, and only
> exposes the enabled ones (unless none is enabled, in which case it
> enables them all.) We didn't implement the same for PWM outputs (yet).
> 
> How many fan headers does your motherboard have?
My motherboard has 2 fan headers

> And how many fans are displayed in the BIOS?
The BIOS shows just two as expected, fan1 (CPU) and fan2 (System):

# Values reported by BIOS
CPU Temp: 33°C
System temp: 45°C
CPU FAN: 5769 RPM
Sys FAN: 1496 RPM

CPU Core: 1.1V
+1.2V:   1.168V
+3.3V:   3.008V
+5V:     4.992V
+1.8V:   1.76V

> The driver code assumes, that, if the BIOS enables some of the fan
> inputs, it will enable _all_ the inputs which the motherboard is
> using. But it is possible that a BIOS enables just the inputs it
> needs. If so, we'll have to revisit our strategy.
> 
> Now that you mention it, my own it87 chip only displays two fans, too,
> while there are 3 fan headers on the board. I don't use the 3rd one
> myself, but that's still a problem in general. I wonder if the BIOS
> would enable it if there was a 3rd fan connected there.
> 
> > > I've asked the original author for an update, let's see if he
> > > sends something.
> > 
> > I've seen the ping, lets see if he will answer
> 
> With this patch, you wouldn't have to care about fan clock divisors at
> all, so it would be more comfortable.
Yes, without (possibly wrong) range-adjustment life is more comfortable.

Are there other changes between the driver's hardware knowledge and
revision 8?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
