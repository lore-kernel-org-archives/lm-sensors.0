From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jan 2010 11:53:06 +0000
Subject: Re: [lm-sensors] ADT 7490 report
Message-Id: <20100120125306.2766a0e9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B56E28D.6080704@ast.cam.ac.uk>
In-Reply-To: <4B56E28D.6080704@ast.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Roderick,

On Wed, 20 Jan 2010 11:01:33 +0000, Roderick Johnstone wrote:
> I have an Intel DP55WB motherboard which sensors-detect reports has an 
> adt 7490 chip.
> 
> Probing for `Analog Devices ADT7490'...                     Success!
>      (confidence 5, driver `to-be-written')
> 
> I downloaded the standalone driver from:
> http://khali.linux-fr.org/devel/misc/adt7490/
> as linked from:
> http://www.lm-sensors.org/wiki/Devices
> 
> After building and modprobing, sensors reports:
> 
> linux> sensors
> adt7490-i2c-0-2c
> Adapter: SMBus I801 adapter at 1000
> in0:         +1.50 V  (min =  +0.00 V, max =  +3.31 V)
> in1:         +0.87 V  (min =  +0.00 V, max =  +2.99 V)
> in2:         +3.29 V  (min =  +0.00 V, max =  +4.39 V)
> in3:         +5.16 V  (min =  +0.00 V, max =  +6.68 V)
> in4:        +12.01 V  (min =  +0.00 V, max = +15.69 V)
> in5:         +2.17 V  (min =  +0.00 V, max =  +4.48 V)
> fan1:        728 RPM  (min =    0 RPM)
> fan2:          0 RPM  (min =    0 RPM)
> fan3:       1124 RPM  (min =    0 RPM)
> fan4:          0 RPM  (min =    0 RPM)
> temp1:         FAULT  (low  = -127.0°C, high = +127.0°C)  ALARM
>                        (crit = +100.0°C, hyst = +100.0°C)
> temp2:       +35.2°C  (low  = -127.0°C, high = +127.0°C)
>                        (crit = +65.0°C, hyst = +61.0°C)
> temp3:       +37.8°C  (low  = -127.0°C, high = +127.0°C)
>                        (crit = +65.0°C, hyst = +61.0°C)

Thanks for reporting. Glad to seem it seems to work fine for you.

> The fan speeds look plausible, compared with what I have seen reported 
> in the bios.
> 
> But, I was expecting to see temperatures for each of the 4 cores in the 
> i7-860 cpu.
> 
> I'd be happy to work with the developer in testing any updates that 
> might fix this.

The CPU core temperatures would be reported by another driver:
coretemp.

The temperatures reported by the ADT7490 are the temperature of that
chip itself (temp2) and the temperatures of 2 external thermal diodes
(temp1 and temp3). temp1 isn't connected on your system. As the ADT7490
is on your motherboard, temp2 is the motherboard temperature. temp3
could be anything on the motherboard: CPU, CPU socket, north bridge...

As a starter, you can add the following to your configuration file:

chip "adt7490-i2c-*-2c"

   label temp2 "M/B Temp"


I don't know which kernel version is needed for the coretemp driver to
support the i7. Please share the contents of /proc/cpuinfo with us (the
first core is enough) and also let us know which kernel version you're
running.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
