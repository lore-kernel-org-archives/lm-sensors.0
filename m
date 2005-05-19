From: horvaths@fi.inf.elte.hu (HORVATH Szabolcs)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: [new hardware] k7vta3
Message-Id: <20020714155004.GA5149@solyom>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I bought a new motherboard (and a cpu, case of course) yesterday.
It is an K7VTA3, from Elite Group Systems. (www.ecs.com.tw)

BIOS said (PC Health Status):
CPU V-core:	  1.76V
+2.5V:		  2.54V
+3.3V:		  3.24V
+5V:		  4.91V
+12V:		 13.04V
Voltage Battery:  3.21V
Curr.System Temp:44?C
Current CPU Temp:43?C
CPU FAN 1:     4963 RPM

I edited /etc/sensors.conf. Now, ``sensors'' said:

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
CPU V-core:
           +1.76 V  (min =  +1.61 V, max =  +1.77 V)
+2.5V:     +2.54 V  (min =  +2.40 V, max =  +2.60 V)
+3.3V:     +3.24 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.91 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +13.04 V  (min = +10.80 V, max = +13.16 V)
VBat:      +3.20 V
Processor's Fan:
          4963 RPM  (min = 2657 RPM, div = 2)
Mainboard:   +44?C  (min =  +20?C, max =  +60?C)
Processor:   +32?C  (min =  +20?C, max =  +60?C)

I attached my /etc/sensors.conf.
Sorry for my bad English, and I hope it helps for anyone.


Have a nice day!

-- 
Horv?th Szabolcs,  <horvaths@fi.inf.elte.hu>
-------------- next part --------------
#
# Manufacturer:	Elitegroup (ECS)
# Model:	K7VTA3 (chipset: VT8367)
#
# Usage:	modprobe i2c-isa && modprobe it87
#
# Reported by Horvath Szabolcs <horvaths@fi.inf.elte.hu>, 2002-07-14
#

chip "it87-*"

# Temperature
    label temp1 "Mainboard"
    set temp1_over  60
    set temp1_hyst  20

    label temp2 "Processor"
    set temp2_over 60
    set temp2_hyst 20

# Fans
    label fan1 "Processor's Fan"
    set fan1_min 2000
    ignore fan2
    ignore fan3

    label in0 "CPU V-core"
    label in1 "+2.5V"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in8 "VBat"

# Volts
    set in0_min 1.7 * 0.95
    set in0_max 1.7 * 1.05
    set in1_min 2.4
    set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)

    # following sensors don't provide usable information
    ignore in5
    ignore in6
    ignore in7
    ignore temp3
    ignore vid
