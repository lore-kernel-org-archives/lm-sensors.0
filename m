From: nyet@nyet.org (Nye Liu)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Success with TYAN Tomcat i810ef S2420 with IT8712F.. few minor mods
Message-Id: <20020320014917.GA2696@curtisfong.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a Tyan Tomcat i810ef S2460 that has the ITE IT8712F chip.

The it87 entry doesn't work for me in the default sensors.conf

mine is attached.

Also, it seems the sensors are in diode mode on that board
(at least cpu1 is) so I had to add 
options it87 temp_type=0x3



-- 
"It's clearly a budget. It's got lots of numbers in it." -- George W. Bush, Reuters, May 5, 2000
-------------- next part --------------
chip "it87-*"

# The values below have been tested on tomcat i810 S2420

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "Stdby"
    label in8 "VBat"

    set in0_min 2 * 0.95
    set in0_max 2 * 1.05
    set in1_min 1.8 * 0.95
    set in1_max 1.8 * 1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    set in5_min -12 * 1.10
    set in5_max -12 * 0.90
    set in6_min -5 * 1.05
    set in6_max -5 * 0.95
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05

    # vid not monitored by IT8715F
    ignore  vid

# Vs = (1 + Rin/Rf) * Vin - (Rin/Rf) * Vref.
# Vref = 4.096 volts, Vin is voltage measured, Vs is actual voltage.
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
# The next two are negative voltages (-12 and -5).
# The following formulas must be used. Unfortunately the datasheet
# does not give recommendations for Rin, Rf, but we can back into
# them based on a nominal +2V input to the chip, together with a 4.096V Vref.
# Formula:
#    actual V = (Vmeasured * (1 + Rin/Rf)) - (Vref * (Rin/Rf))
#    For -12V input use Rin/Rf = 4.14	(232/56)
#    For -5V input use Rin/Rf = 2.14	(120/56)
# Then you can convert the forumula to a standard form like:
    compute in5 (@ * (1+4.14)) - (4.096*4.14)  ,  (@ + (4.096*4.14)) / (1+4.14)
    compute in6 (@ * (1+2.14)) - (4.096*2.14)  ,  (@ + (4.096*2.14)) / (1+2.14)
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# Temperature

    label temp1       "Temp1/MB"
    set   temp1_over  60
    set   temp1_hyst  20

    label temp2       "Temp2/MB"
    set   temp2_over  60
    set   temp2_hyst  20
    
    label temp3       "Temp3/CPU"
    set   temp3_over  60
    set   temp3_hyst  20

    ignore temp2
    ignore temp3	# only for PII or PIII?

# Fans

    label fan1  "CPU Fan"
    label fan2  "Chas Fan"
    label fan3  "MISC Fan"

    set fan1_min 3000
    set fan2_min 0
    set fan3_min 0

    ignore fan2
    ignore fan3
