From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Jun 2010 11:53:17 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <20100605135317.3ec2ca53@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi David,

On Fri, 04 Jun 2010 10:23:26 -0700, David Mathog wrote:
> > OK, then you can run the following command to instantiate the device:
> > 
> > echo lm90 0x4c > /sys/bus/i2c/devices/i2c-2/new_device
> 
> That works.
> 
> lm90-i2c-2-4c
> Adapter: NVIDIA i2c adapter 
> temp1:       +29.0°C  (low  =  +0.0°C, high = +105.0°C)  
>                       (crit = +127.0°C, hyst = +117.0°C)  
> temp2:       +19.6°C  (low  = -11.0°C, high = +94.0°C)  
>                       (crit = +127.0°C, hyst = +117.0°C)  
> 
> 
> Verified that these go up when the graphics card is busy.

The values are surprising. temp1 is on the sensor chip itself, so it's
the graphics adapter's temperature. Sounds reasonable. temp2 OTOH is a
remote sensors, which typically monitors the GPU. It should be much
hotter, and can anyway not be cooler than the board.

Are you sure sensors-detect found an LM90 chip and not an LM99? The
LM99 has a 16 degrees offset on temp2, 35°C would see more reasonable.

> Where would one normally put this on an Ubuntu system?
> Somewhere in /etc/init.d, or as a line in /etc/modules, or ???

I am not familiar with Ubuntu nor Debian, so I can't help with this,
sorry.

> > > > (...)
> > > > Remaining points:
> > > > 
> > > > * Voltages: I don't know which of in4, in5 or in7 corresponds to +12V.
> > > >   I suspect in4, but I'm not certain. Please write down all the values
> > > >   displayed for +12V in the BIOS, and then all the values displayed
> > > >   for in4, in5 and in7 by "sensors". Voltage sensors almost always
> > > >   oscillate between two values, sometimes more. If in4 is +12V, then
> > > >   maybe in5 may be +3.3 Stand-By (3VSB). No idea about in7.
> > > 
> > > In4 oscillates between 3.02 and 3.04, in5 is stable at 3.36, in7 reads
> > > 2.00 or 2.02.  In the BIOS reading there is no oscillation. +12V is
> > > 11.985V and +3.3V=3.344V.
> > 
> > Did you try leaving the monitoring panel and entering it again? Maybe
> > the BIOS doesn't update the values dynamically.
> 
> Tried adding two more fans, both reasonably high current, and the 12V
> reading stayed at 11.985.  Entering and exiting the BIOS system monitor
> didn't change that.  While running linux I could make in4, in5, and in7
> shift very slightly by running a couple of copies of burnK7.  Not sure
> the result is real. In the third column no load but set governor to
> performance.  Results:
>      noload     loaded  performance
> in4  3.02,3.04  3.01    3.02,3.04
> in5  3.36       3.34    3.34 
> in7  2.00       2.90    2.66   <-- so it scales with the governor.

The the results with in7 are repeatable, then in7 is indeed used, it
isn't a negative voltage as I thought, and is also not a
"standard" (constant) voltage. I wasn't aware of any voltage changing
that way other than Vcore, so I'm stuck.

> > Anyway, I still believe that in4 is +12V, and Speedfan seems to agree.
> > I disagree with their scaling though, they apparently used a scaling
> > factor of 4.00, but this makes their reading diverge a lot from the
> > BIOS': 12.16 V instead of 11.985 V. The scaling factor is more likely
> > in the 3.94-3.97 range. I have an old nForce2 board here where they
> > used 3.963 (according to my guesses back then), maybe that's the same
> > on yours.
> 
> Hmm, could be due to the CPU speed scaling.  In the BIOS I'm pretty sure
> the CPUs are both running at their maximum speed of 2800MHz, but in
> Windows and linux they scale down to 800MHz.  Plugged a DMM into a molex

Good point.

> connector and measured this for the performance and ondemand governors:
>      2800MHz  800Mz
> 5V    5.07    5.06
> 12V  12.03    12.04
> 
> (It's a really cheap DMM, certainly not accurate to the last decimal place.)
> 
> > > The K10 temperature rises/falls more slowly than temp2 or temp3.
> > 
> > This is strange, as the digital sensor is supposed to be very close to
> > the core.
> 
> Also strange, k10temp only shows a single temperature, but it is a dual
> core system. 
> 
> cat /proc/cpuinfo | grep processor
> processor       : 0
> processor       : 1
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +21.4°C  (high = +70.0°C, crit = +72.0°C)  
> 
> k8temp running on a different system with Opteron 280 proessors shows
> the temperature of each core, like this:
> 
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +23.0C                                    
> Core1 Temp:  +31.0C                                    

This is expected. As I understand it, the K8 sensor was per-core (or
even 2 sensors per core) while the K10 sensor is per CPU package.

> > (OTOH they claim that pin 3 of the NB FAN is not connected, which is
> > certainly wrong, otherwise you wouldn't get a speed reading for that
> > fan. So the manual may not be trustworthy.)
> 
> It wouldn't be the first time.
> 
> > There seems to be many hardware revisions of your board. For the
> > records, can you tell us which one you have?
> 
> Both the box and the board itself say "Rev 1.1".

OK, thanks for the info.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
