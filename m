From: wolf__@web.de (Jens Wenske)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Problems with SIS950 on a GA-7VTXE
Message-Id: <3C5EDF0E.9050008@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i installed my new mainboard from Gigabyte GA-7VTXE with a Athlon XP and 
tried to get my sensors work under linux. I downloaded lm-sensors via 
CVS at feb 4th. The compilation and installation worked fine but i had 
trouble figuring out which modules to use and in which row. This row 
worked somehow:

modprobe i2c-viapro
modprobe i2c-isa
modprobe it87
rmmod i2c-isa
insmod i2c-isa

(no kidding ... this is it!)

... which leads to following sensor-output:

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
in0:       +1.72 V  (min =  +1.53 V, max =  +1.87 V)
in1:       +1.21 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
in2:       +3.29 V  (min =  +1.48 V, max =  +1.80 V)   ALARM
in3:       +2.86 V  (min =  +2.68 V, max =  +3.26 V)
in4:       +2.97 V  (min =  +2.84 V, max =  +3.45 V)
in5:       +1.79 V  (min =  +1.50 V, max =  +1.82 V)
in6:       +1.02 V  (min =  +0.81 V, max =  +0.97 V)   ALARM
in7:       +2.92 V  (min =  +2.68 V, max =  +3.26 V)
in8:       +0.00 V
fan1:     5672 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
temp1:       +36?C  (min =  +20?C, max =  +60?C)
temp2:        +3?C  (min =  +20?C, max =  +60?C)
temp3:       -55?C  (min =  +20?C, max =  +60?C)
vid:       +0.00 V

As you can see some values doesnt make sense at all =) Only the in0, 
in2, fan1 and temp1 are correct (core, 3.3V, cpu-fan, mb-temp).

Any tips around? ... i am using kernel 2.4.17.

Cheers,
jw

