From: Joakim Larsson <joakim@bildrulle.nu>
Date: Thu, 13 Mar 2008 18:44:08 +0000
Subject: Re: [lm-sensors] W83627DHG driver on MSI 975x board
Message-Id: <1205433848.5989.5.camel@montecristo>
List-Id: <lm-sensors.vger.kernel.org>
References: <1205271362.6571.9.camel@montecristo>
In-Reply-To: <1205271362.6571.9.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean,

thanks for the hint, Ubuntu Feisty uses lm-sensors 2.10.1 So I compiled
and installed the latest version (3.0.1) and starts to get some results
from sensor, see below. I will go through the configuration now and
figure out why the fan still sounds like my vacuum cleaner.

BR

Joakim


joakim@montecristo:~$ sensors -v
sensors version 3.0.1 with libsensors version 3.0.1
joakim@montecristo:~$ sensors
w83627dhg-isa-0290
Adapter: ISA adapter
VCore:       +1.35 V  (min =  +0.00 V, max =  +1.74 V)   
in1:        +12.46 V  (min =  +6.39 V, max =  +0.90 V)   ALARM
AVCC:        +3.28 V  (min =  +0.54 V, max =  +2.05 V)   ALARM
3VCC:        +3.28 V  (min =  +0.66 V, max =  +0.00 V)   ALARM
in4:         +1.86 V  (min =  +1.07 V, max =  +0.39 V)   ALARM
in5:         +1.46 V  (min =  +1.02 V, max =  +0.06 V)   ALARM
in6:         +5.04 V  (min =  +2.59 V, max =  +4.12 V)   ALARM
VSB:         +3.28 V  (min =  +0.02 V, max =  +1.60 V)   ALARM
VBAT:        +3.09 V  (min =  +1.58 V, max =  +0.32 V)   ALARM
Case Fan:      0 RPM  (min =  376 RPM, div = 64)  ALARM
CPU Fan:    2481 RPM  (min = 2109 RPM, div = 16)
Aux Fan:    1298 RPM  (min =  439 RPM, div = 16)
fan4:          0 RPM  (min = 8881 RPM, div = 4)  ALARM
fan5:          0 RPM  (min = 10227 RPM, div = 4)  ALARM
Sys Temp:    +37.0°C  (high =  +0.0°C, hyst = +16.0°C)  ALARM  sensor thermistor
CPU Temp:    +18.0°C  (high = +110.0°C, hyst = +125.0°C)  sensor = diode
AUX Temp:    +64.0°C  (high = +120.0°C, hyst = +115.0°C)  sensor thermistor


On Wed, 2008-03-12 at 12:08 +0100, Jean Delvare wrote:
> Hi Joakim,
> 
> On Tue, 11 Mar 2008 22:36:02 +0100, Joakim Larsson wrote:
> > On Sun, 2008-03-09 at 20:08 +0100, Joakim Larsson wrote:
> > 
> > ok, so I downloaded the Ubuntu Feisty 2.6.20 kernel source and compiled
> > the modules and then just copied the driver from the 2.6.24 kernel
> > source and recompiled it. Then I did make modules_install. The modules
> > now loads successfully:
> > 
> > $ sudo modprobe hwmon-vid 
> > $ sudo modprobe w83627ehf 
> > $ dmesg
> > <snip>
> > [  127.521735] w83627ehf: Found W83627DHG chip at 0x290
> > <snip>
> > 
> > However when I run sensors I got the following output: 
> > 
> > $ sudo sensors
> > w83627dhg-isa-0290
> > Adapter: ISA adapter
> > 
> > And no other output. I'll try to debug but any hint's appreciated! :-)
> 
> What version of lm-sensors are you using again? w83627dhg support was
> added in 2.10.2.
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
