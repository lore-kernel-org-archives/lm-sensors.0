From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jun 2010 07:43:12 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <20100603094312.2cc47bf7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi David,

On Tue, 01 Jun 2010 11:22:58 -0700, David Mathog wrote:
> > > Attempting to get lm-sensors working on a Gigabyte MA785GMT-UD2H
> > > motherboard on Ubuntu 10.04LTS.   Kernel is 2.6.32-22, lm-sensors is
> > > 3.1.2-2, and CPU is AMD Athlon(tm) II X2 240 Processor. sensors-detect
> > > added these to /etc/modules:
> > > 
> > >  it87
> > >  lm90
> > 
> > Did you actually load the lm90 driver? It doesn't show below. Maybe it
> > was for a graphics adapter?
> 
> lsmod | grep lm90
> lm90                   12125  0 
> 
> Loaded, but apparently not working.

OK, most probably the chip is on an Nvidia graphics adapter. To get it
to work, you'll need to run sensors-detect again and write down the i2c
bus number and the address at which the chip is detected.

> > > and made some comment about k10temp.  There is no k10temp module, but
> > > there is a k8temp.  modprobe k8temp doesn't change anything though.
> > 
> > The k10temp driver was added in kernel 2.6.33. It is also available as
> > a standalone driver at:
> > http://khali.linux-fr.org/devel/misc/k10temp/
> 
> That link is timing out right now, will try later.

Works for me...

> > > In any case, the output of sensors clearly isn't correct, for instance,
> > > there are no 5V and 12V readings:
> > > 
> > > it8718-isa-0228
> > > Adapter: ISA adapter
> > > in0:         +1.14 V  (min =  +0.00 V, max =  +4.08 V)   
> > > in1:         +1.60 V  (min =  +0.00 V, max =  +4.08 V)   
> > > in2:         +3.36 V  (min =  +0.00 V, max =  +4.08 V)   
> > > in3:         +2.99 V  (min =  +0.00 V, max =  +4.08 V)   
> > > in4:         +3.04 V  (min =  +0.00 V, max =  +4.08 V)   
> > > in5:         +3.36 V  (min =  +0.00 V, max =  +4.08 V)   
> > > in6:         +4.08 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> > > in7:         +2.00 V  (min =  +0.00 V, max =  +4.08 V)   
> > > Vbat:        +3.12 V
> > > fan1:       1662 RPM  (min =    0 RPM)
> > > fan2:          0 RPM  (min =    0 RPM)
> > > fan3:          0 RPM  (min =    0 RPM)
> > > fan4:       1184 RPM  (min =    0 RPM)
> > > temp1:       +27.0Â°C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = thermistor
> > > temp2:       +27.0Â°C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = thermal diode
> > > temp3:       +29.0Â°C  (low  = +127.0Â°C, high = +127.0Â°C)  sensor = thermistor
> > > cpu0_vid:   +1.050 V
> > 
> > You "simply" need a proper configuration file. If you want help from
> > us, we need the following:
> > 
> > * Messages in the kernel log when loading the it87 driver.
> Jun  1 11:12:29 saf04 kernel: [  768.656268] it87: Found IT8718F chip at 0x228, revision 8
> Jun  1 11:12:29 saf04 kernel: [  768.656284] it87: in3 is VCC (+5V)

OK, this gives us the label and scaling for in3.

> There are no messages when lm90 loads.

This is expected.

> > * If you have Windows installed on the machine, all the values reported
> >   by Gigabyte's EasyTune software.
> > * All the hardware monitoring values reported in the BIOS. If some
> >   items oscillate between different values, we need all values.
> EasyTune won't run, W7 complains about a checksum in some driver it
> contains and won't let it start.

Did you check for an update on their website maybe?

>  Here are the BIOS and speedfan 4.40
> values, lined up in those few cases where the label is the same.

OK, Speedfan is better than nothing, but just as us they don't know the
details of each board so their results must be taken with a grain of
salt.

> (Energy saving is turned on when W7 is running, so Vcore may really have
> dropped from 1.488 to 1.14).

Indeed.

> 
>            BIOS     Speedfan
> Vcore      1.488V      -
> Vcore1       -      1.14V
> Vcore2       -      1.60V
> DDR3(1.5v) 1.600V      -
> +3.3V      3.344V   3.36V
> +5V          -      5.05V
> +12V      11.985V  12.16V
> -12V         -       .31V
> -5V          -      4.15V
> +5V          -      3.30V
> Vbat         -      3.12V
> SysTemp    24C          -
> CPUTemp    33C          -
> Temp1        -        29C
> Temp2        -        29C
> Temp3        -        31C
> HDO          -        26C
> Core         -        20C
> CPUFan    1834RPM       -
> SysFan       0RPM       -
> NBFan     1169RPM       -
> Fan1        -        1805RPM
> Fan4        -        1188RPM
> Fan2,3,5    -     (all) 0RPM

OK, this is a good start. I've come up with the following configuration
file for you:

# lm_sensors 3 configuration file for the Gigabyte MA785GMT-UD2H motherboard
# 2010-06-03, Jean Delvare <khali@linux-fr.org>
# Comments welcome!

chip "it8718-*"

### Voltages

   label  in0  "Vcore"
   label  in1  "Vram"    # "DDR3" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   ignore in6
   label  in8  "Vbat"    # Not in BIOS

   # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. For +5V the chip is configured to use
   # internal scaling.
   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)

   # The BIOS won't set any limit for voltages.

   set in0_min  0.825 * 0.95
   set in0_max  1.425 * 1.05
   set in1_min  1.5   * 0.95
   set in1_max  1.6   * 1.05
   set in2_min  3.3   * 0.95
   set in2_max  3.3   * 1.05
   set in3_min  5     * 0.95
   set in3_max  5     * 1.05

### Fans

   label  fan1  "CPU Fan"
   label  fan2  "Case Fan"  # Must be confirmed
   ignore fan3
   label  fan4  "NBr Fan"

   # Adjust for your own fans
   set fan1_min 1500
   set fan4_min 1000

#####

Remaining points:

* Voltages: I don't know which of in4, in5 or in7 corresponds to +12V.
  I suspect in4, but I'm not certain. Please write down all the values
  displayed for +12V in the BIOS, and then all the values displayed for
  in4, in5 and in7 by "sensors". Voltage sensors almost always
  oscillate between two values, sometimes more. If in4 is +12V, then
  maybe in5 may be +3.3 Stand-By (3VSB). No idea about in7.

* Temperatures: I really don't know who is who, nor whether the sensor
  types are set properly. Try comparing the temperatures between idle
  and full load. If one value raises much faster than the others, that
  would be the CPU temperature. Also check the motherboard manual, if
  they say where the thermal sensors are, that would be useful.

* Fans: please check how many fan headers your board has. If you have a
  spare fan, I would appreciate if you could plug it in the free
  header(s). This will help us figure out the labels of fan2 and fan3.
  My guess is that one of them is what the BIOS labels SysFan, and the
  other one is not connected.

With this information I should be able to complete the configuration
file and publish it for other users to benefit.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
