From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jan 2010 12:35:47 +0000
Subject: Re: [lm-sensors] ADT 7490 report
Message-Id: <20100120133547.0917bfba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B56E28D.6080704@ast.cam.ac.uk>
In-Reply-To: <4B56E28D.6080704@ast.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Jan 2010 12:11:28 +0000, Roderick Johnstone wrote:
> On 20/01/10 11:53, Jean Delvare wrote:
> > The CPU core temperatures would be reported by another driver:
> > coretemp.
> >
> > The temperatures reported by the ADT7490 are the temperature of that
> > chip itself (temp2) and the temperatures of 2 external thermal diodes
> > (temp1 and temp3). temp1 isn't connected on your system. As the ADT7490
> > is on your motherboard, temp2 is the motherboard temperature. temp3
> > could be anything on the motherboard: CPU, CPU socket, north bridge...
> 
> Thank you for such a quick and clear explanation.
> 
> >
> > As a starter, you can add the following to your configuration file:
> >
> > chip "adt7490-i2c-*-2c"
> >
> >     label temp2 "M/B Temp"
> 
> Done.
> 
> linux> sensors
> adt7490-i2c-0-2c
> Adapter: SMBus I801 adapter at 1000
> in0:         +1.50 V  (min =  +0.00 V, max =  +3.31 V)
> in1:         +0.87 V  (min =  +0.00 V, max =  +2.99 V)
> in2:         +3.29 V  (min =  +0.00 V, max =  +4.39 V)
> in3:         +5.16 V  (min =  +0.00 V, max =  +6.68 V)
> in4:        +12.00 V  (min =  +0.00 V, max = +15.69 V)
> in5:         +2.17 V  (min =  +0.00 V, max =  +4.48 V)
> fan1:        754 RPM  (min =    0 RPM)
> fan2:          0 RPM  (min =    0 RPM)
> fan3:       1130 RPM  (min =    0 RPM)
> fan4:          0 RPM  (min =    0 RPM)
> temp1:         FAULT  (low  = -127.0°C, high = +127.0°C)  ALARM
>                        (crit = +100.0°C, hyst = +100.0°C)
> M/B Temp:    +38.0°C  (low  = -127.0°C, high = +127.0°C)
>                        (crit = +65.0°C, hyst = +61.0°C)
> temp3:       +39.0°C  (low  = -127.0°C, high = +127.0°C)
>                        (crit = +65.0°C, hyst = +61.0°C)

OK. While you're here, you can add:

   label in2 "+3.3V"
   label in3 "+5V"
   label in4 "+12V"

as they are pretty obvious, and:

   ignore temp1

for clarity. Not sure which of in0 or in1 is your CPU core voltage...

> > I don't know which kernel version is needed for the coretemp driver to
> > support the i7. Please share the contents of /proc/cpuinfo with us (the
> > first core is enough) and also let us know which kernel version you're
> > running.
> >
> 
> linux> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 30
> model name      : Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz
> stepping        : 5
> (...)
> 
> linux> uname -a
> Linux xpc7.ast.cam.ac.uk 2.6.31.9-174.fc12.x86_64 #1 SMP Mon Dec 21 
> 05:33:33 UTC 2009 x86_64 x86_64 x86_64 GNU/Linux
> 
> This is the current Fedora 12 kernel.

OK. Your CPU is supported since kernel 2.6.32. But don't worry, just as
with the adt7475 driver, it is possible to build an updated driver
outside of the kernel tree. I've prepared it for you, you can download
the driver from:

http://khali.linux-fr.org/devel/misc/coretemp/

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
