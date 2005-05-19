From: roverr@dogpound.is-a-geek.org (roverr)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: asus a7v8x-x sensors.conf
Message-Id: <1055092603.1329.11.camel@junkyard>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

First, please subscribe me to this list, faq 6.4 says there's no
automatic subscription.  My email address is <roverr at
dogpound-is-a-geek.org>

Second I'm trying to get lm-sensors 2.70 on debian to work with my asus
a7v8x-x motherboard.  I have an initial cut at sensors.conf, it might
help others and possibly someone will have ideas for improvement.

My it87 section of sensors.conf, alarms modified for my particulars, as
usual your mileage may vary.

.......
chip "it87-*" "it8705-*" "it8712-*"

# The values below have been tested on Asus CUSI, CUM motherboards.

# Voltage monitors as advised in the It8705 data sheet

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
set in0_max 1.5 * 1.17 <== my Tbred runs at 1.65v but the voltage
resolution seems inadequate, increase upper alarm
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
#the chip does not support in8 min/max

# vid is not monitored by IT8705F
# and is not supported by driver at this time
ignore vid
ignore in1 <== ignore vcore2
ignore in5 <== ignore -12v
ignore in6 <== ignore -5v

# If 3.3V reads 2X too high (Soyo Dragon, for example),
# comment out following line.
# compute in2 2*@ , @/2 <=== comment this out
#
compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
compute in4 ((30/10) +1)*@ , @/((30/10) +1)
# For this family of chips the negative voltage equation is different
from
# the lm78. The chip uses two external resistor for scaling but one is
# tied to a positive reference voltage. See ITE8705/12 datasheet (SIS950
# data sheet is wrong)
# Vs = (1 + Rin/Rf) * Vin - (Rin/Rf) * Vref.
# Vref = 4.096 volts, Vin is voltage measured, Vs is actual voltage.

# The next two are negative voltages (-12 and -5).
# The following formulas must be used. Unfortunately the datasheet
# does not give recommendations for Rin, Rf, but we can back into
# them based on a nominal +2V input to the chip, together with a 4.096V
Vref.
# Formula:
# actual V = (Vmeasured * (1 + Rin/Rf)) - (Vref * (Rin/Rf))
# For -12V input use Rin/Rf = 6.68
# For -5V input use Rin/Rf = 3.33
# Then you can convert the forumula to a standard form like:
compute in5 (7.67 * @) - 27.36 , (@ + 27.36) / 7.67
compute in6 (4.33 * @) - 13.64 , (@ + 13.64) / 4.33
#
# this much simpler version is reported to work for a
# Eltite Group K7S5A board
#
# compute in5 -(36/10)*@, -@/(36/10)
# compute in6 -(56/10)*@, -@/(56/10)
#
compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)

# Temperature
#
# Important - if your temperature readings are completely whacky
# you probably need to change the sensor type. This must be done
# with 'modprobe it87 temp_type=0xXX', you can't fix it in this file.
# See ../doc/chips/it87 for details and valid 'XX' values!!!
#
label temp1 "Temp1/CPU" <== changed, temp1 is cpu, not motherboard
set temp1_over 85 <== changed to 85, max die temp for athlon tbred,
also changed bios to shutdown at 85
set temp1_hyst 20
label temp2 "Temp2/MB" <== changed, temp2 is motherboard, not cpu
set temp2_over 45
set temp2_hyst 25
ignore temp3 <== ignore, temp3 appears unused
label temp3 "Temp3"
set temp3_over 45
set temp3_hyst 25

# Fans
set fan1_min 4000 <== cpu fan nominal is 4500rpm, lower min
set fan2_min 2800 <== my front case fan is low noise panaflow, nominal
3000rpm
ignore fan3 <== ignore back case fan, there is no fan 3 header on the
mb, my fan3 is direct connect to psu
set fan3_min 3000

Regards, Gary
