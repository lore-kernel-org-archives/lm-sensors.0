From: "David Mathog" <mathog@caltech.edu>
Date: Tue, 01 Jun 2010 18:22:58 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <E1OJW78-0005sX-HN@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> > Attempting to get lm-sensors working on a Gigabyte MA785GMT-UD2H
> > motherboard on Ubuntu 10.04LTS.   Kernel is 2.6.32-22, lm-sensors is
> > 3.1.2-2, and CPU is AMD Athlon(tm) II X2 240 Processor. sensors-detect
> > added these to /etc/modules:
> > 
> >  it87
> >  lm90
> 
> Did you actually load the lm90 driver? It doesn't show below. Maybe it
> was for a graphics adapter?

lsmod | grep lm90
lm90                   12125  0 

Loaded, but apparently not working.

> 
> > and made some comment about k10temp.  There is no k10temp module, but
> > there is a k8temp.  modprobe k8temp doesn't change anything though.
> 
> The k10temp driver was added in kernel 2.6.33. It is also available as
> a standalone driver at:
> http://khali.linux-fr.org/devel/misc/k10temp/

That link is timing out right now, will try later.
> 
> > In any case, the output of sensors clearly isn't correct, for instance,
> > there are no 5V and 12V readings:
> > 
> > it8718-isa-0228
> > Adapter: ISA adapter
> > in0:         +1.14 V  (min =  +0.00 V, max =  +4.08 V)   
> > in1:         +1.60 V  (min =  +0.00 V, max =  +4.08 V)   
> > in2:         +3.36 V  (min =  +0.00 V, max =  +4.08 V)   
> > in3:         +2.99 V  (min =  +0.00 V, max =  +4.08 V)   
> > in4:         +3.04 V  (min =  +0.00 V, max =  +4.08 V)   
> > in5:         +3.36 V  (min =  +0.00 V, max =  +4.08 V)   
> > in6:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> > in7:         +2.00 V  (min =  +0.00 V, max =  +4.08 V)   
> > Vbat:        +3.12 V
> > fan1:       1662 RPM  (min =    0 RPM)
> > fan2:          0 RPM  (min =    0 RPM)
> > fan3:          0 RPM  (min =    0 RPM)
> > fan4:       1184 RPM  (min =    0 RPM)
> > temp1:       +27.0°C  (low  = +127.0°C, high = +127.0°C)  sensor
= thermistor
> > temp2:       +27.0°C  (low  = +127.0°C, high = +127.0°C)  sensor
= thermal diode
> > temp3:       +29.0°C  (low  = +127.0°C, high = +127.0°C)  sensor
= thermistor
> > cpu0_vid:   +1.050 V
> 
> You "simply" need a proper configuration file. If you want help from
> us, we need the following:
> 
> * Messages in the kernel log when loading the it87 driver.
Jun  1 11:12:29 saf04 kernel: [  768.656268] it87: Found IT8718F chip at
0x228, revision 8
Jun  1 11:12:29 saf04 kernel: [  768.656284] it87: in3 is VCC (+5V)

There are no messages when lm90 loads.

> * If you have Windows installed on the machine, all the values reported
>   by Gigabyte's EasyTune software.
> * All the hardware monitoring values reported in the BIOS. If some
>   items oscillate between different values, we need all values.
EasyTune won't run, W7 complains about a checksum in some driver it
contains and won't let it start.  Here are the BIOS and speedfan 4.40
values, lined up in those few cases where the label is the same.
(Energy saving is turned on when W7 is running, so Vcore may really have
dropped from 1.488 to 1.14).

           BIOS     Speedfan
Vcore      1.488V      -
Vcore1       -      1.14V
Vcore2       -      1.60V
DDR3(1.5v) 1.600V      -
+3.3V      3.344V   3.36V
+5V          -      5.05V
+12V      11.985V  12.16V
-12V         -       .31V
-5V          -      4.15V
+5V          -      3.30V
Vbat         -      3.12V
SysTemp    24C          -
CPUTemp    33C          -
Temp1        -        29C
Temp2        -        29C
Temp3        -        31C
HDO          -        26C
Core         -        20C
CPUFan    1834RPM       -
SysFan       0RPM       -
NBFan     1169RPM       -
Fan1        -        1805RPM
Fan4        -        1188RPM
Fan2,3,5    -     (all) 0RPM

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
