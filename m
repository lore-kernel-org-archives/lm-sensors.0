From: timo-news@eriele.fi (Timo Neuvonen)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Intel D865GLC
Message-Id: <cui0st$i6r$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > So, this problem seems to be solved now; what still remain is that I'm
> > a little suspicious about voltage readings looking too much
> > idealistic, like Vcore 1.500 Volts...
>
> Isn't it rather VID? VID is the nominal voltage value for the CPU, not
> the measured one. in0 or in1 would be. VID is there so that you can set
> the relevant low and high limits to something that makes sense for your
> specific CPU.
>
I think Vcore is measured from pin 'in1', but it produces 'too' good stable
reading of 1.500 anyway -from day to day. It's not exactly the same what I
can see in bios, but the reading is quite stable there too. The slight
difference (1.494 in bios) _could_ be caused by slightly different current
consumption, maybe? I have tested this both in console, and in a terminal
window under X, both result always in 1.500. Strange? I've tried this so far
in only one computer, maybe the next one will give different figures.

Or am I thinking something in a wrong way again? Below is the output of
'sensors' and piece of sensors.conf.
lm_sensors is version 2.8.7-2, from current FC3 rpm.

Limits of Vcore are based to VID, which equals to 0. Is it a variable that
needs to be se manually in the file, or should it be automatically readable
from somewhere.


adm1027-i2c-0-2e
Adapter: SMBus I801 adapter at c400
ERROR: Can't get alarm mask data!
V1.5:      +1.471 V  (min =  +1.42 V, max =  +1.58 V)
VCore:     +1.500 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
V3.3:      +3.403 V  (min =  +3.13 V, max =  +3.47 V)
V5:       +5.156 V  (min =  +4.74 V, max =  +5.26 V)
V12:      +12.313 V  (min = +11.38 V, max = +12.62 V)
CPU_Fan:   3170 RPM  (min = 4000 RPM)                     ALARM
Front/Power_Fan:
           2881 RPM  (min =    0 RPM)
Rear/Exit_Fan:
           2884 RPM  (min =    0 RPM)
CPU:      +27.00?C  (low  =   +10?C, high =   +50?C)
Board:    +25.00?C  (low  =   +10?C, high =   +35?C)
Remote:   +27.00?C  (low  =   +10?C, high =   +35?C)
ERROR: Can't get PWM1 data!
ERROR: Can't get PWM2 data!
ERROR: Can't get PWM3 data!


# Sample configuration for the Intel S845WD1-E
# courtesy of Marcus Schopen
#
chip "lm85c-*" "adm1027-*" "adt7463-*" "lm85-*" "lm85b-*"

   set temp1_max 50

# Voltage inputs
   label in0   "V1.5"      # AGP on Intel S845WD1-E
   label in1   "VCore"
   label in2   "V3.3"
   label in3   "V5"
   label in4   "V12"

# Temperature inputs
   label temp1  "CPU"
   label temp2  "Board"
   label temp3  "Remote"

# Fan inputs
   label fan1   "CPU_Fan"
   label fan2   "Fan2"
   label fan3   "Front/Power_Fan"
   label fan4   "Rear/Exit_Fan"

# PWM Outputs
   label pwm1   "CPU_PWM"
   label pwm2   "Fan2_PWM"
   label pwm3   "Fan3_PWM"

# Voltage scaling is done on-chip.  No 'compute' directive
# should be necessary.  If in0 has external scaling set
# it here.

#   compute in0  @ * 2.5,   @ / 2.5

# Adjust fans speeds for actual pulses per rev
#   compute fan1  @ * 2,  @ / 2    # 1 pulse per rev
#   set fan1_ppr  1                # ADM1027 or ADT7463
#   compute fan2  @ / 2,  @ * 2    # 4 pulse per rev
#   set fan2_ppr  4                # ADM1027 or ADT7463

   ignore fan2
#   ignore fan3
#   ignore fan4

# Set VRM version
   set vrm  9.1   # Pentium 4
# Set voltage limits
   set in0_min  1.5 * 0.95
   set in0_max  1.5 * 1.05
   set in1_min  vid * 0.95
   set in1_max  vid * 1.05
   set in2_min  3.3 * 0.95
   set in2_max  3.3 * 1.05
   set in3_min  5.0 * 0.95
   set in3_max  5.0 * 1.05
   set in4_min   12 * 0.95
   set in4_max   12 * 1.05

# Set Fan limits
   set fan1_min 4000

# Set Temp Limits
   set temp1_min 10
   set temp1_max 50
   set temp2_min 10
   set temp2_max 35
   set temp3_min 10
   set temp3_max 35

