From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 May 2010 20:05:14 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <20100529220514.550fed78@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi David,

On Fri, 28 May 2010 11:38:59 -0700, David Mathog wrote:
> Anybody have a sensors.conf for this board that works?

I don't.

> Attempting to get lm-sensors working on a Gigabyte MA785GMT-UD2H
> motherboard on Ubuntu 10.04LTS.   Kernel is 2.6.32-22, lm-sensors is
> 3.1.2-2, and CPU is AMD Athlon(tm) II X2 240 Processor. sensors-detect
> added these to /etc/modules:
> 
>  it87
>  lm90

Did you actually load the lm90 driver? It doesn't show below. Maybe it
was for a graphics adapter?

> and made some comment about k10temp.  There is no k10temp module, but
> there is a k8temp.  modprobe k8temp doesn't change anything though.

The k10temp driver was added in kernel 2.6.33. It is also available as
a standalone driver at:
http://khali.linux-fr.org/devel/misc/k10temp/

> In any case, the output of sensors clearly isn't correct, for instance,
> there are no 5V and 12V readings:
> 
> it8718-isa-0228
> Adapter: ISA adapter
> in0:         +1.14 V  (min =  +0.00 V, max =  +4.08 V)   
> in1:         +1.60 V  (min =  +0.00 V, max =  +4.08 V)   
> in2:         +3.36 V  (min =  +0.00 V, max =  +4.08 V)   
> in3:         +2.99 V  (min =  +0.00 V, max =  +4.08 V)   
> in4:         +3.04 V  (min =  +0.00 V, max =  +4.08 V)   
> in5:         +3.36 V  (min =  +0.00 V, max =  +4.08 V)   
> in6:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in7:         +2.00 V  (min =  +0.00 V, max =  +4.08 V)   
> Vbat:        +3.12 V
> fan1:       1662 RPM  (min =    0 RPM)
> fan2:          0 RPM  (min =    0 RPM)
> fan3:          0 RPM  (min =    0 RPM)
> fan4:       1184 RPM  (min =    0 RPM)
> temp1:       +27.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermistor
> temp2:       +27.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermal diode
> temp3:       +29.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermistor
> cpu0_vid:   +1.050 V

You "simply" need a proper configuration file. If you want help from
us, we need the following:

* Messages in the kernel log when loading the it87 driver.
* If you have Windows installed on the machine, all the values reported
  by Gigabyte's EasyTune software.
* All the hardware monitoring values reported in the BIOS. If some
  items oscillate between different values, we need all values.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
