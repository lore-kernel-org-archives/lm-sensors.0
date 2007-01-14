From: sgeorge.ml@gmail.com (Siju George)
Date: Sun, 14 Jan 2007 22:13:29 +0000
Subject: [lm-sensors] Practical Interpretation of lm-senors Output
Message-Id: <b713df2c0701141401m5d1c58dcjd0c96ad99b0b4bd2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

could some one please help me interpret the output of sensors on two
servers I have?
They are running on Debian Sarge/amd64. The full sensors output of
both systems are given in the end of this mail.

On System-1 I have the following lines.

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.57 V  (min =  +1.86 V, max =  +2.05 V)
VCore 2:   +1.58 V  (min =  +1.86 V, max =  +2.05 V)
+12V:      +5.11 V  (min = +10.82 V, max = +13.19 V)
 -5V:       -3.54 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.75 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +0.06 V  (min =  +2.40 V, max =  +3.60 V)

these values seem to be out of the min/max limits.
Is this a serious problem?
How are the min/max values decided? Is it hardcoded somewhere?
Or should I refer some manuals and adjust the min/max values?
If so where can I find those manuals?
What does "V5SB" and "VBat" mean?

Now,

fan1:     6081 RPM  (min =    0 RPM, div = 2)
fan2:     6250 RPM  (min =    0 RPM, div = 2)
fan3:        0 RPM  (min = 2812 RPM, div = 8)

what does the "div=8" mean?
and the min value for fan3 is 2812. does it mean that it is mandatry
this fan should be running always above that RPM value? or is running
fan1 and fan2 enough?

temp1:       +33?C  (high =   +43?C, hyst =    -1?C)   sensor = thermistor

What does "hyst=" mean?

comming down for System-1

adm1027-i2c-0-2e
Adapter: SMBus AMD756 adapter at 10e0
V1.5:      +2.591 V  (min =  +1.42 V, max =  +1.58 V)   ALARM
VCore:     +1.289 V  (min =  +1.71 V, max =  +1.89 V)   ALARM

Shows it is in an ALARM state when the values fall out of the min/max limits.
In such a situation what can be done to rectify this?
why is not the "ALARM" keyword used when the values for w83627hf-isa-0290
Adapter: ISA adapter fall out of the min/max range earlier?

fan2:     17252 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)

counting the fan1, fan2 and fan3 shown earlier with differrent RPMs
Does this server have 6 fans?
I haven't seen this system because it is in a differrent continent :-(

Board:    +35.00?C  (low  =   +10?C, high =   +35?C)
Remote:   +40.00?C  (low  =   +10?C, high =   +35?C)     ALARM

Board Temperature seems to be on the maximum limit.
Will running additional fan help to reduce the temperature?
What does "Remote:" mean ? Is it the Room temperature outside the chasis?
Also Just wondering how it is measured? Will not the temperature
inside the chasis influence its value?

CPU_PWM:   255
Fan2_PWM:  255
Fan3_PWM:  255
vid:      +1.800 V  (VRM Version 9.1)

what does these values mean. Since there are no min/max values for
this what information can be gathered out of these?

######Comming to System-2########

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +0.00 V  (min =  +1.86 V, max =  +2.05 V)
VCore 2:   +1.54 V  (min =  +1.86 V, max =  +2.05 V)

What is VCore1 and VCore2? actually is there some resource where I can
learn more about related stufff?

VCore 1: seems to be having no voltage at all! This Server runs
without much problems.
Can this be ignored? or how Do I rectify this situation?

-12V:      -1.26 V  (min = -13.18 V, max = -10.80 V)

the above value seems to be much greater than max value.
How do I rectify this?

also what do the "+3.3V, +5V,+12V, -12V and -5V in the begining of the
following lines mean?

+3.3V:     +3.38 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.11 V  (min =  +4.76 V, max =  +5.24 V)
+12V:      +4.99 V  (min = +10.82 V, max = +13.19 V)
-12V:      -1.26 V  (min = -13.18 V, max = -10.80 V)
-5V:       -3.59 V  (min =  -5.25 V, max =  -4.75 V)

--------

again

     adm1027-i2c-0-2d
Adapter: SMBus AMD756 adapter at 10e0
V1.5:      +0.000 V  (min =  +1.42 V, max =  +1.58 V)   ALARM
VCore:     +0.000 V  (min =  +0.00 V, max =  +0.00 V)   ALARM

how do I rectify the above problem?

CPU_Fan:      0 RPM  (min = 4000 RPM)                     ALARM

Does this man that the Fan above the CPU is not working at all?

CPU:      -128.00?C  (low  =   +10?C, high =   +50?C)     ALARM FAULT

What Does the "ALARM FAULT" mean in the above line?
Is it that the sensor is not working correctly? or some other problem?
Should I ask for a board replacement in this case?

Remote:   +33.00?C  (low  =   +10?C, high =   +35?C)     ALARM

the above value seems to be within the limits, then why is there an "ALARM"?

Thankyou so much for your patience :-)
If there is a link that will give me the information to these problems
please give it to me.

Thankyou all once again :-)

Kind Regards

Siju

##########################################################################
System-1~# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.57 V  (min =  +1.86 V, max =  +2.05 V)
VCore 2:   +1.58 V  (min =  +1.86 V, max =  +2.05 V)
+3.3V:     +3.41 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.21 V  (min =  +4.76 V, max =  +5.24 V)
+12V:      +5.11 V  (min = +10.82 V, max = +13.19 V)
-12V:      -1.26 V  (min = -13.18 V, max = -10.80 V)
-5V:       -3.54 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.75 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +0.06 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     6081 RPM  (min =    0 RPM, div = 2)
fan2:     6250 RPM  (min =    0 RPM, div = 2)
fan3:        0 RPM  (min = 2812 RPM, div = 8)
temp1:       +33?C  (high =   +43?C, hyst =    -1?C)   sensor = thermistor

temp2:     +34.5?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor

temp3:     +39.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor

vid:      +1.950 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-55
Adapter: SMBus AMD756 adapter at 10e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-54
Adapter: SMBus AMD756 adapter at 10e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-51
Adapter: SMBus AMD756 adapter at 10e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-50
Adapter: SMBus AMD756 adapter at 10e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

adm1027-i2c-0-2e
Adapter: SMBus AMD756 adapter at 10e0
V1.5:      +2.591 V  (min =  +1.42 V, max =  +1.58 V)   ALARM
VCore:     +1.289 V  (min =  +1.71 V, max =  +1.89 V)   ALARM
V3.3:      +3.334 V  (min =  +3.13 V, max =  +3.47 V)
V5:       +5.104 V  (min =  +4.74 V, max =  +5.26 V)
V12:      +12.125 V  (min = +11.38 V, max = +12.62 V)
CPU_Fan:  17763 RPM  (min = 4000 RPM)
fan2:     17252 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
CPU:      +42.00?C  (low  =   +10?C, high =   +50?C)
Board:    +35.00?C  (low  =   +10?C, high =   +35?C)
Remote:   +40.00?C  (low  =   +10?C, high =   +35?C)     ALARM
CPU_PWM:   255
Fan2_PWM:  255
Fan3_PWM:  255
vid:      +1.800 V  (VRM Version 9.1)
#####################################################################
System-2# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +0.00 V  (min =  +1.86 V, max =  +2.05 V)
VCore 2:   +1.54 V  (min =  +1.86 V, max =  +2.05 V)
+3.3V:     +3.38 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.11 V  (min =  +4.76 V, max =  +5.24 V)
+12V:      +4.99 V  (min = +10.82 V, max = +13.19 V)
-12V:      -1.26 V  (min = -13.18 V, max = -10.80 V)
-5V:       -3.59 V  (min =  -5.25 V, max =  -4.75 V)
V5SB:      +5.75 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +0.05 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min =    0 RPM, div = 2)
fan3:     9642 RPM  (min = 2860 RPM, div = 2)
temp1:       +15?C  (high =   +11?C, hyst =    -3?C)   sensor thermistor
temp2:     +14.5?C  (high =   +80?C, hyst =   +75?C)   sensor thermistor
temp3:     +20.0?C  (high =   +80?C, hyst =   +75?C)   sensor thermistor
vid:      +1.950 V  (VRM Version 8.2)
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-51
Adapter: SMBus AMD756 adapter at 10e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-50
Adapter: SMBus AMD756 adapter at 10e0
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

adm1027-i2c-0-2d
Adapter: SMBus AMD756 adapter at 10e0
V1.5:      +0.000 V  (min =  +1.42 V, max =  +1.58 V)   ALARM
VCore:     +0.000 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
V3.3:      +3.317 V  (min =  +3.13 V, max =  +3.47 V)
V5:       +5.104 V  (min =  +4.74 V, max =  +5.26 V)
V12:      +12.125 V  (min = +11.38 V, max = +12.62 V)
CPU_Fan:      0 RPM  (min = 4000 RPM)                     ALARM
fan2:         0 RPM  (min =    0 RPM)
fan3:      9747 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
CPU:      -128.00?C  (low  =   +10?C, high =   +50?C)     ALARM FAULT
Board:    +26.00?C  (low  =   +10?C, high =   +35?C)
Remote:   +33.00?C  (low  =   +10?C, high =   +35?C)     ALARM
CPU_PWM:   255
Fan2_PWM:  255
Fan3_PWM:  255
vid:      +0.000 V  (VRM Version 9.1)

######################################################################

