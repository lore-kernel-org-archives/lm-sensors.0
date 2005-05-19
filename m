From: theodore@aurora.eexi.gr (Theodore J. Soldatos)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: Gigabyte 8KNXP
Message-Id: <Pine.LNX.4.53.0401031408180.10688@aurora.eexi.gr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Well, i just opened a ticket about Gigabyte 8KNXP hoping to reply to
myself with a partial solution, but it looks that i can just open the
ticket and i can't reply. So, here is the partial solution that i have so
far:

lm_sensors 2.8.2 (just user tools), Linux 2.6.0 SMP

Modules used:

it87 (parameter: temp_type=0x1c)
i2c_sensor
i2c_isa
i2c_core

The configuration is actually the default conf, with several changes for
temperature and fans. Note that i can't measure any other temp than the
CPU one even from Windows with MBM5. I can't be sure if this happens to
all 8KNXP's or it is just my problem. The Box temperature in MBM5 it has a
permanent reading of 25C.

Configuration (sensors.conf):

chip "it87-*" "it8705-*" "it8712-*"

label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "Stdby"
    label in8 "VBat"

    set in0_min 1.5 * 0.95
    set in0_max 1.5 * 1.05
    set in1_min 2.4
    set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    set in5_max -12 * 0.95
    set in5_min -12 * 1.05
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    ignore  vid
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    compute in5 (7.67 * @) - 27.36  ,  (@ + 27.36) / 7.67
    compute in6 (4.33 * @) - 13.64  ,  (@ + 13.64) / 4.33
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
   ignore temp1
   ignore temp2
    label temp3       "CPU"
    compute temp3  (@ + 20) / 0.9686,  (@ * 0.9686) + 65
    set   temp3_over  45
    set   temp3_hyst  25
    set fan1_div 2
    set fan1_min 0
    set fan2_div 4
    set fan2_min 3000
    set fan3_min 3000

And the output of sensors command is:

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.52 V  (min =  +1.42 V, max =  +1.56 V)
VCore 2:   +2.62 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
+3.3V:     +3.34 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.27 V  (min =  +4.72 V, max =  +5.24 V)   ALARM
+12V:     +12.28 V  (min = +11.36 V, max = +12.60 V)
-12V:     -16.09 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -8.05 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
Stdby:     +1.50 V  (min =  +4.72 V, max =  +5.24 V)   ALARM
VBat:      +4.08 V
fan1:     2884 RPM  (min =    0 RPM, div = 2)
fan2:     2220 RPM  (min = 2986 RPM, div = 4)          ALARM
fan3:     3199 RPM  (min = 3000 RPM, div = 2)
CPU:         +36?C  (low  =  +113?C, high =  +133?C)   sensor = invalid

The fan readings look ok (i do have the PSU fan and a box fan connected to
the motherboard). The CPU temp also looks normal (at least it goes up and
down in a logical way and the readings are similar to the ones of MBM5). I
don't understand the "sensor = invalid" line.

The voltage readings as you can see are partially ok. -12 and -5 are
obviously wrong. I did'nt spend more time for voltages, because i don't
actually care much.

That is all i managed to find out. Could you please put that info in reply
to my ticket as reference for other owners of the same motherboard ?

Thanks in advance,

T.


Theodore=J.=Soldatos=_\_===========================
=  theodore@eexi.gr =_/_=== "Greed is never good" - Linus Torvalds ====
=   bafh@hellug.gr  =_\_====== http://w4u.eexi.gr/~theodore ======
=   tsol@space.gr   =_/_========== Space Hellas ==========
