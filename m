From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Fri, 13 Jan 2006 02:18:10 +0000
Subject: [lm-sensors] Questions on sensors.conf
Message-Id: <43C70DE2.20707@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <dq6sc5$n2s$1@sea.gmane.org>
In-Reply-To: <dq6sc5$n2s$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Joachim Schrod wrote:

>Hi,
>
>I started to use lm_sensors to monitor my hardware. In particular, I want to
>monitor temperature and fan functionality.
>  
>
Welcome!

>The system has an Intel D865GBF ATX Mainboard, with a Pentium 4 3 GHz processor,
>800 MHz FSB, 1 MB Cache. I'm using lm_sensors version 2.9.1 that came with SUSE 
>10.0.
>  
>
That should be fairly similar to the D865PERL which was one of the MB on 
which the lm85 driver was originally developed and tested.

>sensors-detect went fine, it detected the LM85 sensor chip "lm85b-i2c-0-2e";
>start of the lm_sensors service as well, then calling sensors got:
>
>CPU_Fan:   2669 RPM  (min = 4000 RPM)                     ALARM
>fan2:         0 RPM  (min =    0 RPM)
>fan3:         0 RPM  (min =    0 RPM)
>fan4:         0 RPM  (min =    0 RPM)
>CPU:         +45 C  (low  =   +10 C, high =   +50 C)
>Board:       +36 C  (low  =   +10 C, high =   +35 C)     ALARM
>Remote:      +37 C  (low  =   +10 C, high =   +35 C)     ALARM
>
>Oops, obviouslsy too much alarms for my taste. ;-)
>So I learned that I have to configure /etc/sensors.cfg.
>  
>
Have you read the lm85 chip documentation in doc/chips/lm85 ?

>First, I wanted to check the measured values. So I rebooted and looked into the 
>BIOS read-out.
>My BIOS reports the CPU temperature to be 56?C, System Zone 1 as 40?C, and 
>System Zone 2 as 45?C. (Wherever zone 1 and 2 are -- I assume that they match 
>temp2_* and temp3_* whereas temp1_* is the CPU.)
>The CPU fan speed is the same, so that doesn't need any adaption.
>  
>
Be careful.  When a CPU is sitting in the BIOS, it is usually in a 
spin-loop which usually puts the CPU in a maximum power situation.  So 
the CPU temperatures in the BIOS will frequently be higher than you 
observe under an operating system like Linux where the CPU is put into 
the HALT state when there isn't any work to do.

The "Board" sensor (temp2) is actually internal to the lm85 chip.  So if 
you can *find* the chip which is labeled lm85, that will be the location 
of that temperature...

Generally, I'm surprised that the limits are set this low.  They are too 
low for a P4 CPU.  If you know your fan is spinning slower, then set a 
more appropriate low limit.  If the system temperatures are above the 
limit, then set a higher limit that makes sense.  Most comercial 
electronics are capable of operating up to 70degC.  But a reasonable 
case internal ambient temperature is 42 degC.  A temperature sensor on 
the motherboard that is close to a high power component or function like 
the VRM (Vcore power supply) for the CPU *will* read higher than ambient 
because heat from the power transistors in the VRM disipate heat through 
the copper traces on the motherboard and the motherboard itself.  This 
heats components near them on the motherboard.  It wouldn't be 
unreasonable for the "Remote" temperature sensor to in fact be located 
very near the VRM to in effect measure the temperature of the VRM.

>So here's my first question:
>Is it best practice to assume that the BIOS values are OK and to add compute 
>statements to increase the lm_sensors values to match them?
>  
>
Unless the values are *way* off, or you have a way to measure the same 
temperature or value using independant means _at the same time_, I would 
recommend you *not* adjust the readings returned by an lm_sensors chip 
driver.

Did the BIOS program the temp#_offset registers?  Can you report the 
values from those configuration registers?

>And my second question:
>The semantics of the temperature limits in sensors.conf are still unclear to me.
>
>There is temp#_min, temp#_max, temp#_hyst, and temp#_over.
>  
>
Some chips use "over" and "hyst" while others use "min" and "max".  A 
given temperature sensor almost never has both.

>min and max are not explained.
>  
>
What documentation are you reading?

>hyst and over are not used in the LM85 example configuration.
>  
>
Because the lm85 uses minimum and maximum temperature limits.

If the temperature is less than the minimum or greater than the maximum, 
an ALARM is signalled.  If it's between the values, then there is no error.

>In addition, the documentation of lm85 mentions other sensors.conf variables 
>named zone#_{limit,hyst,range,critical} which aren't used at all. It looks as if 
>the documentation is out of date and these variables don't exist any more. Is 
>that assumption true?
>  
>
The zone#_ values were originally implemented in the 2.4 version of the 
driver.  They control the automatic fan speed control features of the 
lm85 chip.  The first port of the lm85 driver to the 2.6 kernel did not 
include those configuration registers.  They have since been added back 
to the 2.6 driver.

But in the 2.6 kernel, the lm_sensors team tried to enforce a consistent 
set of values for automatic fan speed control.  So at least in 2.6.13, 
the name and values have changed and things are worked around in the 
driver to present the "standard" interface values:
   temp#_auto_temp_{off,min,max,crit}
   pwm#_auto_pwm_{min,minctl,freq}

:v)

