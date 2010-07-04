From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Sun, 04 Jul 2010 05:31:57 +0000
Subject: [lm-sensors] LM_Sensors Config for Supermicro X7SLA-L / X7SLA-H
Message-Id: <1238.66.169.177.147.1278221517.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

This configuration has been tested on a Supermicro X7SLA-H motherboard
which uses an Intel Atom 330 CPU. This configuration should be compatible
with the Supermicro X7SLA-L motherboard since both variants have 3 fan
headers and the same Winbond 83627ZDHG-P Super I/O controller chip. The
X7SLA-H motherboard is used in their "SUPERMICRO SYS-5015A-H 1U Barebone
Server".

Supermicro has their own "SuperoDoctor II" software for Linux. The
following is the output from the "sdt" command included in that software:

[root@fatman ~]# sdt

*****************************************************************************
 Supero Doctor II - Linux version 2.71(100409)
 Copyright(c) 1993-2010 by Super Micro Computer, Inc. http://supermicro.com/
*****************************************************************************
Monitored Item            High Limit  Low Limit     Status
----------------------------------------------------------------------
Fan1 Fan Speed                              712       1231
Fan2 Fan Speed                            12053          0  Warning!
Fan3 Fan Speed                              712       2410
MCH Fan Speed                               712       5113
CPU Core Voltage                1.48       0.92       1.17
+1.5V Voltage                   1.65       1.35       1.51
+12V Voltage                   13.24      10.75      12.34
+3.3V Voltage                   3.63       2.98       3.34
DIMM Voltage                    1.99       1.62       1.86
+5V Voltage                     5.50       4.51       5.12
+3.3Vsb Voltage                 3.63       2.98       3.36
VBAT Voltage                    3.30       2.70       3.25
System Temperature            75/167                 32/89
CPU Temperature               82/179                 26/78
Chassis Intrusion                                     Good
--------------------------------------------- Sun Jul  4 00:14:57 2010

My test system currently has a failed "front chassis" fan.

[root@fatman ~]# uname -a
Linux fatman.my.home 2.6.33.5-124.fc13.x86_64 #1 SMP Fri Jun 11 09:38:12
UTC 2010 x86_64 x86_64 x86_64 GNU/Linux

[root@fatman ~]# sensors -v
sensors version 3.1.2 with libsensors version 3.1.2

[root@fatman ~]# sensors -f
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +78.8°F  (crit = +194.0°F)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +82.4°F  (crit = +194.0°F)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +78.8°F  (crit = +194.0°F)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +82.4°F  (crit = +194.0°F)

w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:       +1.17 V  (min =  +0.92 V, max =  +1.48 V)
DIMM_Volt:   +1.86 V  (min =  +1.62 V, max =  +2.00 V)
+3.3V:       +3.34 V  (min =  +2.98 V, max =  +3.63 V)
+12V:       +12.34 V  (min =  +2.95 V, max =  +3.60 V)   ALARM
DIMM_Volt:   +1.86 V  (min =  +1.62 V, max =  +1.99 V)
+5V:         +5.15 V  (min =  +4.51 V, max =  +5.50 V)
+1.5V:       +1.51 V  (min =  +1.35 V, max =  +1.65 V)
3VSB:        +3.36 V  (min =  +2.98 V, max =  +3.63 V)
Vbat:        +3.25 V  (min =  +2.70 V, max =  +3.30 V)
Back Fan:   2445 RPM  (min =  712 RPM, div = 8)
P/S Fan:    1240 RPM  (min =  712 RPM, div = 8)
MCH Fan:    5113 RPM  (min =  712 RPM, div = 8)
Front Fan:     0 RPM  (min =  753 RPM, div = 128)  ALARM
M/B Temp:    +89.6°F  (high = +167.0°F, hyst = +158.0°F)  sensor thermistor
CPU Temp:    +78.8°F  (high = +179.6°F, hyst = +176.0°F)  sensor = diode

My "local" Sensors "conf" file from the "/etc/sensors.d" directory:

[root@fatman ~]# cat /etc/sensors.d/local.conf
# libsensors configuration file
# -----------------------------
#
# This default configuration file only includes statements which do not
# differ from one mainboard to the next. Only label, compute and set
# statements for internal voltage and temperature sensors are included.
#
# In general, local changes should not be added to this file, but rather
# placed in custom configuration files located in /etc/sensors.d. This
# approach makes further updates much easier.
#
# Such custom configuration files for specific mainboards can be found at
# http://www.lm-sensors.org/wiki/Configurations

chip "w83627dhg-*"

    label in0 "Vcore"
#    label in2 "AVCC"
#    label in3 "+3.3V"
    label in2 "+3.3V"
    label in3 "+12V"
    label in7 "3VSB"
    label in8 "Vbat"

    label in1 "DIMM_Volt"
    label in4 "DIMM_Volt"
    label in6 "+1.5V"
    label in5 "+5V"
    label fan1 "Back Fan"
    label fan2 "P/S Fan"
    label fan5 "Front Fan"
    label fan4 "MCH Fan"

    label temp1 "M/B Temp"
    label temp2 "CPU Temp"

#    ignore in1
    ignore fan3
    ignore cpu0_vid
    ignore temp3

    compute in3 @*((269/100)+1), @/((269/100)+1)
    compute in5  @*4, @/4

    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10
#    set in3_min  12 * 0.90
#    set in3_max  12 * 1.10
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.10


Notes on how everything matches up:

                     Motherboard
SDT     LM_Sensors   Silkscreen  Usage
Fan1      Fan2          Fan 1    Power Supply Fan
Fan2      Fan5          Fan 2    Front Fan
Fan3      Fan1          Fan 3    Back Fan
MCH Fan   Fan4         MCH Fan   MCH Fan

Any suggestions on getting the "set in3_min" and "set in3_max" values set
correctly for +/- 10 percent limits?

I determined through experimentation that the "AVCC" value from the
"w83627dhg-*" section of "sensors3.conf" with label "in2" is a "+3.3
Voltage" input. Changing values related to "in2" affected the "+3.3V
Voltage" line in Supermicro's "sdt" command. Thus I figured that "in3" is
the line used for "+12V Voltage" in "sdt". The compute line seems accurate
and the formula was based on info found on the LM_Sensors Wiki for another
chip.

It appears there are 2 separate inputs, "in1" and "in4", for measuring
DIMM Voltage. The motherboard has 2 DIMM sockets. Removing a DIM from
"DIMM_B" did not affect the voltage read by either "in1" or "in4"
suggesting that either input could be safely ignored.

I ignore Temp3 since it displays negative temperatures even though it is
located in a room with an ambient temperature of 78 degrees Fahrenheit.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
