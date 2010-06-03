From: "David Mathog" <mathog@caltech.edu>
Date: Thu, 03 Jun 2010 17:56:12 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <E1OKEeK-0006ot-Vy@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > 
> > > Did you actually load the lm90 driver? It doesn't show below. Maybe it
> > > was for a graphics adapter?
> > 
> > lsmod | grep lm90
> > lm90                   12125  0 
> > 
> > Loaded, but apparently not working.
> 
> OK, most probably the chip is on an Nvidia graphics adapter. To get it
> to work, you'll need to run sensors-detect again and write down the i2c
> bus number and the address at which the chip is detected.

i2c-2, found lm90
also
I2c 0x4c

> > > http://khali.linux-fr.org/devel/misc/k10temp/
> > 
> > That link is timing out right now, will try later.
> 
> Works for me...

Got it through an anonymizer.  Apparently khali's web server or firewall
is blocking Caltech.  I have seen this before on a couple of other
sites, sometimes our central mail server gets blacklisted and that ends
up in other sites' firewall rules.

> > > * If you have Windows installed on the machine, all the values
reported
> > >   by Gigabyte's EasyTune software.
> > > * All the hardware monitoring values reported in the BIOS. If some
> > >   items oscillate between different values, we need all values.
> > EasyTune won't run, W7 complains about a checksum in some driver it
> > contains and won't let it start.
> 
> Did you check for an update on their website maybe?

Yes.  The current version has an AODDriver.sys with an invalid checksum
once installed, and W7 blocks it from running.


> Remaining points:
> 
> * Voltages: I don't know which of in4, in5 or in7 corresponds to +12V.
>   I suspect in4, but I'm not certain. Please write down all the values
>   displayed for +12V in the BIOS, and then all the values displayed for
>   in4, in5 and in7 by "sensors". Voltage sensors almost always
>   oscillate between two values, sometimes more. If in4 is +12V, then
>   maybe in5 may be +3.3 Stand-By (3VSB). No idea about in7.

In4 oscillates between 3.02 and 3.04, in5 is stable at 3.36, in7 reads
2.00 or 2.02.  In the BIOS reading there is no oscillation. +12V is
11.985V and +3.3V=3.344V.

> * Temperatures: I really don't know who is who, nor whether the sensor
>   types are set properly. Try comparing the temperatures between idle
>   and full load. If one value raises much faster than the others, that
>   would be the CPU temperature. Also check the motherboard manual, if
>   they say where the thermal sensors are, that would be useful.
 
                  2xburnK7               idle
Temp1              29.0                   30.0
Temp2              49.0                   28.0
Temp3              43.0                   30.0
K10Temp1           41.0                   19.5

The K10 temperature rises/falls more slowly than temp2 or temp3.


> * Fans: please check how many fan headers your board has. If you have a
>   spare fan, I would appreciate if you could plug it in the free
>   header(s). This will help us figure out the labels of fan2 and fan3.
>   My guess is that one of them is what the BIOS labels SysFan, and the
>   other one is not connected.

There are 3:
fan1  CPU_FAN
fan2  SYS_FAN
fan4  NB_FAN

verified by plugging/unplugging that this was how they mapped.  I
plugged a 60mm ~5000rpm fan into SYS_FAN and it read only 2710 RPM, but
in the BIOS it had "System Smart Fan Control is enabled", so the
motherboard may have been running it at less than full speed.  The test
fan only has 3 pins, plugged into a 4 pin header.  Since the speed
control should be on pin 4, which isn't connected, I think maybe SYS_FAN
is off by a factor of 2. Did not test SYS_FAN speed in the BIOS.  

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
