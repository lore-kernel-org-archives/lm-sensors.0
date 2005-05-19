From: hiro_yuki_mori@yahoo.co.jp (Mori Hiroyuki)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Sensor results of P4P800
Message-Id: <20031207172558.63883.qmail@web1210.mail.yahoo.co.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
In-Reply-To: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Delvare-san,

I inform you of current staus.
If you have any idea of improvement, could you give me?

*** Start of /etc/sensors.conf (w83627thf-* part) ***
chip "w83782d-*" "w83627thf-*"

# Same as above for w83781d except that in5 and in6 are
computed differently.
# Rather than an internal inverting op amp, the 82d/83s
use standard positive
# inputs and the negative voltages are level shifted by a
3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

    label in0 "VCore"
#    label in1 "VCore 2"
    label in1 "+12V"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "-12V"
#    label in5 "-12V"
#    label in6 "-5V"
    label in7 "V5SB"
    label in8 "VBat"
    label temp1 "M/B Temp"
    label temp2 "CPU Temp"

    compute in0 @/2, @*2
    compute in1 ((28/10)+1)*@, @/((28/10)+1)
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# adjust this if your vid is wrong; see doc/vid
#   set vrm 9.0

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min 12 * 0.90
    set in1_max 12 * 1.10

    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_max -12 * 0.90
    set in4_min -12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

# set up sensor types (thermistor is default)
# 1 = PII/Celeron Diode; 2 = 3904 transistor;
# 3435 = thermistor with Beta = 3435
# If temperature changes very little, try 1 or 2.
   set sensor1 3435
   set sensor2 1
   set sensor3 3435

# examples for temperature limits
    set temp1_over 40
    set temp1_hyst 37
    set temp2_over 52
    set temp2_hyst 47
#    set temp3_over 52
#    set temp3_hyst 47

*** End of /etc/sensors.conf (w83627thf-* part) ***

*** Start of sensors ***
# sensors -s; sensors 

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

w83627thf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.53 V  (min =  +0.00 V, max =  +0.00 V)
+12V:     +12.24 V  (min = +10.83 V, max = +13.19 V)
+3.3V:     +3.36 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.14 V  (min =  +4.74 V, max =  +5.24 V)
-12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
V5SB:      +5.02 V  (min =  +4.74 V, max =  +5.24 V)
VBat:      +3.22 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =  351 RPM, div = 32)
fan2:     2777 RPM  (min = 5273 RPM, div = 2)
fan3:        0 RPM  (min =   87 RPM, div = 128)
M/B Temp:    +22  (high =   +40, hyst =   +37)   sensor thermistor
CPU Temp:  +22.0 (high =   +52, hyst =   +47)   sensor PII/Celeron diode
temp3:    +208.0  (high =   +80, hyst =   +75)   sensor thermistor
vid:      +0.000 V
alarms:
beep_enable:
          Sound alarm enabled
*** End of sensors ***

hiro_yuki_mori@yahoo.co.jp

__________________________________________________
Do You Yahoo!?
Yahoo! BB is Broadband by Yahoo!
http://bb.yahoo.co.jp/
