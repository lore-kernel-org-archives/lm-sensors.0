From: Salewski@PHYSnet.Uni-Hamburg.de (Stefan Salewski)
Date: Sun, 25 Dec 2005 12:14:02 +0000
Subject: [lm-sensors] ASUS A8N-SLI Premium motherboard and lm_sensors
Message-Id: <43AE8D0A.2040609@PHYSnet.Uni-Hamburg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some days ago I installed lm_sensors to check mainboard voltages,
temperatures and fan speed. sensors-detect has succesfully detected
the available sensors, but output of command sensors was not fully
correct with default configuration file. I was not able to find a
special configuration file for this motherboard, so I tried to adapt
the existing one. Here is the result of my work -- maybe it is useful
for someone.


# Sensors configuration file used by 'libsensors'
# sensors version 2.9.2 with libsensors version 2.9.2 (Gentoo Linux)
#
# This is an adapted version of the lm_sensors configuration file for
# ASUS A8N-SLI Premium motherboard (S. Salewski, 24-DEC-2005).
# The default configuration file (/etc/sensors.conf) gives a wrong value
# for -12V and labels for CPU- and M/B-Temperature were exchanged.
# Substitution of the original sensors.conf with this file results in
# an output of command sensors similar to   
#
# it8712-isa-0290
# Adapter: ISA adapter
# VCore:     +1.36 V  (min =  +1.01 V, max =  +1.60 V)
# +3.3V:     +3.26 V  (min =  +3.14 V, max =  +3.47 V)
# +5V:       +4.95 V  (min =  +4.76 V, max =  +5.24 V)
# +12V:     +11.97 V  (min = +11.39 V, max = +12.61 V)
# -12V:     -11.77 V  (min = -12.68 V, max = -11.32 V)
# Stdby:     +4.87 V  (min =  +4.76 V, max =  +5.24 V)
# VBat:      +3.09 V
# Fan1:     1205 RPM  (min =  664 RPM, div = 8)
# Fan2:        0 RPM  (min =  664 RPM, div = 8)
# Fan3:       -1 RPM  (min =  664 RPM, div = 8)
# CPU Temp:    +41 C  (low  =   +15 C, high =   +55 C)   sensor = thermistor
# M/B Temp:    +37 C  (low  =   +15 C, high =   +45 C)   sensor = thermistor
# Chipset Temp:+35 C  (low  =   +15 C, high =   +50 C)   sensor = thermistor

# These values seems to be reasonable and are similar to the values
# displayed in BIOS, but may be wrong!

chip "it87-*" "it8712-*"

# Voltage monitors as advised in the It8705 data sheet
# VCore2 and -5V voltage is not available for ASUS A8N-SLI Premium
    label in0 "VCore"
    #label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    #label in6 "-5V"
    label in7 "Stdby"
    label in8 "VBat"

# vid is monitored by IT8712, but this value is not very useful
# and reported value (0.8V) seems to be to low.
# Range of vid can be modified with commands like
# echo 90 > /sys/bus/i2c/devices/9191-0290/vrm
# but the following statement does not work.
#    set vrm 90
# So we ignore vid, VCore2 and -5V value
    ignore vid
    ignore in1
    ignore in6

# Compute +5 and +12 voltage as usual
    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)

# For this family of chips the negative voltage equation is different from
# the lm78.  The chip uses two external resistor for scaling but one is
# tied to a positive reference voltage.  See IT8712F_V0.8.2.pdf datasheet
# (www.ite.com.tw/product_info/file/pc/IT8712F_V0.8.2.pdf) page 91.
# Actual (displayed) voltage Vs depends of chip input voltage Vin:
# Vs = (1 + Rin/Rf) * Vin - (Rin/Rf) * Vref. (from datasheet)
# Vref = 4.096 V is chip reference voltage.
# If these two equations are correct, we can approximate the unknown
# quotient of voltage divider (resistors) Rin/Rf so that Vs V.
# We can solve the above formula for Rin/Rf and use for Vin the value
# cat /sys/bus/i2c/devices/9191-0290/in5_input (2.960) or simple iterate
# until diplayed value is approximately -12 V.
#  This results in Rin/Rf = 13.17, which we substitute in the above equation
     compute in5 (14.17 * @) - 53.94  ,  (@ + 53.94) / 14.17

# Compute 5 V standby voltage as usual
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# Set tolerance for voltages. Message "Alarm" is displayed if outside.

    set in0_min 1.0
    set in0_max 1.6
    #set in1_min 2.4
    #set in1_max 2.6
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    set in5_max -12 * 0.95
    set in5_min -12 * 1.05
    #set in6_max -5 * 0.95
    #set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    #the chip does not support in8 min/max

# Temperature
# Sensor types: 2 = thermistor; 3 = thermal diode; 0 = unused
    set sensor1 2
    set sensor2 2
    set sensor3 2

    label temp1       "CPU Temp"
    set   temp1_over  55
    set   temp1_low   15
    label temp2       "M/B Temp"
    set   temp2_over  45
    set   temp2_low   15
    label temp3       "Chipset T"
    set   temp3_over  50
    set   temp3_low   15
# Temperature temp1 raises slowly with CPU load, temp3 raises very fast
# with load, temp3 changes very slowly and is higher than case temperature.

# Fans
    label fan1 "Fan1"
    label fan2 "Fan2"
    label fan3 "Fan3"
    set fan1_min 600
    set fan2_min 600 # not connected for me
    set fan3_min 600 # not connected for me

