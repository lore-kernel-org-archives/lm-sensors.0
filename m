From: Patrick Kowalzick <patrick.kowalzick@web.de>
Date: Sun, 07 Oct 2007 15:00:54 +0000
Subject: [lm-sensors] Configuration Via Epia EN12000
Message-Id: <feasb5$tsb$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear all,

I was trying to add my configuration here:
http://www.lm-sensors.org/wiki/Configurations

... but was not able to edit/create pages.

Can you help me editing the wiki?

Anyway, I appended my configuration. I compared the temperature values 
with "pc health" information in the bios screens, and they seem to be ok.

Regards,
Patrick


MB: Via Epia EN12000 (same as EN15000)
I just inserted the block starting with "#PK:", rest worked "out of the 
box" (thanks a lot). "sensors.conf" shipped with debian etch.


chip "w83697hf-*"

# Same as above for w83781d except that in5 and in6 are computed 
differently.
# Rather than an internal inverting op amp, the 82d/83s use standard 
positive
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

# no in1 on this chip.

     label in0 "VCore"
     label in2 "+3.3V"
     label in3 "+5V"
     label in4 "+12V"
     label in5 "-12V"
     label in6 "-5V"
     label in7 "V5SB"
     label in8 "VBat"

# Tyan Trinity S2495 KT400 has a few differences. Thanks to Eric Schumann
# for proving this information. Same is true for Epox 8K3A and 8KHA+.
# Thanks to Thomas Schorpp for additional feedback.
#    label in2 "VAgp"
#    label in5 "+3.3V" # aka. Vio
#    label in6 "Vdimm"
#    label in7 "VBat"
#    label in8 "V5SB"
#
# You'll also want to comment out the in5 and in6 compute lines right below,
# and rename compute in7 to compute in8.

     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
     compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
     compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
     compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# 697HF does not have VID inputs so you MUST set your core
# voltage limits below. Currently set for 1.8V core.
#               vvv

     set in0_min 0.8 * 0.95
     set in0_max 0.8 * 1.05

     set in2_min 3.3 * 0.95
     set in2_max 3.3 * 1.05
     set in3_min 5.0 * 0.95
     set in3_max 5.0 * 1.05
     set in4_min 12 * 0.90
     set in4_max 12 * 1.10
     set in5_max -12 * 0.90
     set in5_min -12 * 1.10
     set in6_max -5 * 0.95
     set in6_min -5 * 1.05
     set in7_min 5 * 0.90
     set in7_max 5 * 1.10
     set in8_min 3.0 * 0.80
     set in8_max 3.0 * 1.20

# And for Tyan Trinity S2495 KT400 and Epox 8K3A and 8KHA+:
#    set in2_min 1.5 * 0.95
#    set in2_max 1.5 * 1.05
#    set in5_min 3.3 * 0.95
#    set in5_max 3.3 * 1.05
#    set in6_min 2.5 * 0.95 # 2.6 on Epox
#    set in6_max 2.5 * 1.05 # 2.6 on Epox
#    set in7_min 3.0 * 0.90
#    set in7_max 3.0 * 1.10
#    set in8_min 5 * 0.90
#    set in8_max 5 * 1.10

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
#   set sensor1 1
#   set sensor2 2
#   set sensor3 3435

# examples for temperature limits
#    set temp1_over 40
#    set temp1_hyst 37
#    set temp2_over 52
#    set temp2_hyst 47

# PK:
# Via Epia EN12000EG/EN15000G specific
     ignore in5
     ignore in6

     label temp1 "M/B Temp"
     label temp2 "CPU Temp"

     label fan1 "Case Fan"
# connector only for EN12000EG, cpu fan for EN15000G
     label fan2 "CPU Fan"

# temperatures are quite low and tuned towards fancontrol config
     set temp1_over 66
     set temp1_hyst 65
     set temp2_over 50
     set temp2_hyst 45

# as fancontrol takes control of the fans, min=0
     set fan1_min 0
     set fan2_min 0



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
