From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lmsensors-CVS on 2.6.0-test10
Message-Id: <20031129223910.027c2e26.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031126190459.724240ad.npfdd@gmx.net>
In-Reply-To: <20031126190459.724240ad.npfdd@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I got it working!
> All I had to do was to include ISA support in the kernel. (in the
> meantime I switched to test11)

You are also invited to update your local lm_sensors2 CVS repository.
We've been fixing a couple of problems these last few days.

> Now I load the following modules:
> w83781d, i2c_sensor, i2c_dev, i2c_isa, i2c_i801, i2c_core
> and get these results from sensors:
> 
> w83627thf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> in0:       +3.14 V  (min =  +0.00 V, max =  +0.00 V)              
> in1:       +3.20 V  (min =  +0.00 V, max =  +0.00 V)              
> in2:       +3.36 V  (min =  +2.98 V, max =  +3.63 V)              
> in3:       +3.04 V  (min =  +2.69 V, max =  +3.26 V)              
> in4:       +3.07 V  (min =  +2.85 V, max =  +3.46 V)              
> in7:       +3.04 V  (min =  +2.69 V, max =  +3.26 V)              
> in8:       +3.30 V  (min =  +2.70 V, max =  +3.30 V)       ALARM  
> fan1:        0 RPM  (min =  187 RPM, div = 32)                     
> fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
> fan3:     2500 RPM  (min = 1500 RPM, div = 4)                     
> temp1:       +31?C  (high =  +127?C, hyst =   +60?C)   sensor > thermistor           
> temp2:     +33.0?C  (high =   +60?C, hyst =   +50?C)   sensor > PII/Celeron diode           
> temp3:    +208.0?C  (high =   +50?C, hyst =   +50?C)   sensor > thermistor           
> vid:      +0.000 V
> alarms:   
> beep_enable:
>           Sound alarm disabled
> 
> Now I'll have to find the proper settings in the conf file for my
> board.

That's the least to say. Looks like you don't have a config file at all.
Make sure you have /etc/sensors.conf. If not, copy it from
lm_sensors2/etc/sensors.conf.eg. It should be a lot better (both labels
and values).

> Some strange things in the above listing are: fan3 is the power
> supply and corresponds exactly with the real values but the processor
> fan is not listed. Maybe because my BIOS always complains it "failed"?
> It rotates very slow since I exchanged the Intel boxed for a more
> silent one. But it definately rotates. :)

Then you want to play with divisors. Slower fans need increased
divisors. If it's very slow, you need a very big divisor. In this case
it would be fan2 (since fan1 already as max divisor and still doesn't
show any value).

> And I don't know what temperature belongs to CPU or mainboard and
> what's the third?

Usually, temp1 is the chipset internal temperature, which is considered
to be your motherboard temperature. temp2 would be your CPU here, you
can run some compilation job or even cpuburn to make sure (the CPU
temperature will raise quickly). temp3 is probably not wired to
anything, 208 is a common value in this case.

Let us know how it goes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
