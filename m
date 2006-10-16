From: tuharsky@misbb.sk (Mgr. Peter Tuharsky)
Date: Mon, 16 Oct 2006 11:33:35 +0000
Subject: [lm-sensors] Wrong values from ASUS A7N8X-E Deluxe -EAY0Z,
Message-Id: <45336E0F.7050007@misbb.sk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

This is output from sensors on the machine with said motherboard and 
chipset. Please note the values with ALARM flag.
Also note the temp1 high and hyst values. Seems to me that temp3 should 
be processor, temp1 the SBr and temp2 the SYS.



# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.58 V  (min =  +1.42 V, max =  +1.57 V)       ALARM
VCore 2:   +1.55 V  (min =  +1.42 V, max =  +1.57 V)
+3.3V:     +3.38 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.16 V  (min =  +4.76 V, max =  +5.24 V)
+12V:      +4.92 V  (min = +10.82 V, max = +13.19 V)       ALARM
-12V:      -1.34 V  (min = -13.18 V, max = -10.80 V)       ALARM
-5V:       -3.54 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
V5SB:      +5.64 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
VBat:      +2.05 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
fan1:     3375 RPM  (min = 2860 RPM, div = 8)
fan2:     3013 RPM  (min = 6026 RPM, div = 8)              ALARM
fan3:        0 RPM  (min = 2033 RPM, div = 8)              ALARM
temp1:       +36?C  (high =   +88?C, hyst =  -115?C)   sensor = thermistor
temp2:     +35.5?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
temp3:     +42.5?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
vid:      +1.500 V  (VRM Version 2.4)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
           Sound alarm enabled

-----------------------------------


Here's the current (invalid) entry from sensors.conf file, unchanged:

chip "w83782d-*" "w83627hf-*"

# Same as above for w83781d except that in5 and in6 are computed 
differently.
# Rather than an internal inverting op amp, the 82d/83s use standard 
positive
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

     label in0 "VCore 1"
     label in1 "VCore 2"
     label in2 "+3.3V"
     label in3 "+5V"
     label in4 "+12V"
     label in5 "-12V"
     label in6 "-5V"
     label in7 "V5SB"
     label in8 "VBat"

# Abit BP6 motherboard has a few differences. VCore1 and VCore2 are the core
# voltages of the two processors. Vtt is memory bus termination resistors
# voltage.
#    label in1 "Vtt"
#    label in8 "VCore2"

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
     set in1_min vid*0.95
     set in1_max vid*1.05
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
     set in7_min 5 * 0.95
     set in7_max 5 * 1.05
     set in8_min 3.0 * 0.80
     set in8_max 3.0 * 1.20

