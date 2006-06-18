From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 10:11:16 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <20060618121116.760ccea1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lou,

First of all, I would suggest that you switch to a better e-mail
client. The one you use doesn't handle character encodings properly,
and generate very crappy HTML code.

> I am running CentOS 4 (uname -r 2.6.9-34.0.1.EL) with an ECS NFORCE3-939 MB
> and AMD Athlon64 3000+ processor
> 
> I am having problems with the CPU temp and core voltage value using
> lm-sensors.

> Had to adjust voltages computations for in5 and in6 from a post I found
> regarding a TYAN mb that had the same chip:    
> 
>     compute in5 (@ * (1+4.14)) - (4.096*4.14)  ,  (@ + (4.096*4.14)) / (1+4.14)
> 
>     compute in6 (@ * (1+2.14)) - (4.096*2.14)  ,  (@ + (4.096*2.14)) / (1+2.14)

These are very board-specific. What makes you think these lines are
correct for your board? Do the displayed values (and labels) match what
the BIOS displays? Many recent motherboards do not monitor negative
voltage lines anymore.

> [root at web etc]# sensors
> it87-isa-0290
> Adapter: ISA adapter
> CPU VCore: +1.07 V  (min =  +1.28 V, max =  +1.42 V)   ALARM
> +1.5V:     +1.47 V  (min =  +1.42 V, max =  +1.57 V)
> +3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.92 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +11.71 V  (min = +11.39 V, max = +12.61 V)
> -12V:     -12.11 V  (min = -12.60 V, max = -11.37 V)
> -5V:       -4.80 V  (min =  -5.25 V, max =  -4.75 V)
> Stdby:     +5.03 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +2.94 V
> CPU Fan:  3245 RPM  (min = 3013 RPM, div = 8)
> Case Fan:  981 RPM  (min =  664 RPM, div = 8)
> Temp1:        +4?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor
> Temp2:       +30?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor
> 
> Everything looks good except the CPU core voltage and CPU temp.  
> 
> The bios reads 1.37V for coreV but lm_sensors reads 1.07 consistently.

This can be explained easily. Your Athlon64 3000+ must have the
so-called "Cool'n'Quiet" feature, which lets it adjust voltage and
frequency depending on load. I have a similar processor (Athlon64
3200+, socket 939) those voltage ranges from 1.1V (idle) to 1.4V (full
load.) This seems to be roughly the same for you.

You may try commenting out the following line in your configuration file
(in the it87-* section, of course):
#   ignore  vid
If the VID pins are properly wired on your system, this should report
the nominal voltage for your CPU and you should see it change depending
on the load.

So it's really only a matter of setting the proper limits for that kind
of CPU. Try the following:

   set in0_min 1.1 * 0.95
   set in0_max 1.4 * 1.05

> The bios for temps: MB = 31 and CPU = 52.  Both are pretty consistent in the
> bios.
> 
> The CPU temperature in lm_sensors fluctuates between -5 and 50.  I have
> tried using the diode for both temp1 and temp2 and ignoring different
> combinations with no success.  If the temperature was consistent I would
> feel better like a correction factor was needed but it is all over the
> place.

What about temp3?

Or there could be an additional temperature sensor on the board. Can we
see the full output of sensors-detect?

>         Also the chip designation in sensors.conf is 
> 
> chip "it87-*" "it8712-*"
> 
> If I have just "it8712-*" it does not detect the configuration in the
> sensors.conf and uses all defaults.

In kernel 2.6.9 your chip is identified by the driver as "it87" (see
the first line of "sensors"), but in later kernels it is better
identified as "it8712". We put both in the configuration file so that
the same file works with all kernels.

-- 
Jean Delvare

