From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Tue, 09 Nov 2010 05:49:58 +0000
Subject: [lm-sensors] Supermcro X7SPA-H LM_Sensors Configuration
Message-Id: <50187.75.142.173.238.1289281798.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org


I recently obtained a Supermicro X7SPA-H motherboard for a NAS project,
loaded Fedora Core 13 on it ('mdadm' in FC 14 acted very
flaky...'unreliable' compared to FC 13), and developed a "local"
LM_Sensors configuration to share.

After referencing the configuration on the LM_Sensors.org web site
(http://www.lm-sensors.org/wiki/Configurations/SuperMicro/X7SPA), I came
up with a very slightly different configuration.

- I found no need to set limits on 'in6' since the limits shown in
"sensors" and those shown in Supermicro's "sdt" are the same and seem
"reasonable".

- I made very minor changes to naming certain inputs.

- I ignored "temp 3" since I could not easily correlate that to anything I
found meaningful or 'reasonable'; it's temperature reading always seemed
much lower that CPU diode or System thermistor readings, sometimes by
almost 50 percent less. Supermicro's "sdt" utility under Linux only
reports 2 temperatures and they correlate closely to 'temp 1' and 'temp
2'.

My "local.conf" file is based on studying the BIOS (Supermicro version
1.0c), the Supermicro SuperoDoctor utility [Supero Doctor II - Linux
version 2.73(101019)] for Linux, and the output of "sensors".

Note: The only 'adjustments' in Supermicro's Version 1.0c BIOS alter the
CPU overheat alarm ('early' or 'default') and the 'Fan Speed' (4 settings
controlling PWM percentages 100/70/50/30) applied to both 4-pin fan
headers (silk-screened: CPU Fan, SYS Fan) on the motherboard.


[X@X ~]# dmidecode | more
# dmidecode 2.10
SMBIOS 2.6 present.
21 structures occupying 1134 bytes.
Table at 0x0009F000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: American Megatrends Inc.
        Version: 1.0c
        Release Date: 05/26/2010
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 4096 kB
[snip]

[X@X ~]# uname -a
Linux X 2.6.34.7-61.fc13.x86_64 #1 SMP Tue Oct 19 04:06:30 UTC 2010 x86_64
x86_64 x86_64 GNU/Linux
[X@X ~]# sensors -v
sensors version 3.1.2+SVN with libsensors version 3.1.2+SVN
[X@X ~]#

[X@X ~]# sdt

***************************************************************************
 Supero Doctor II - Linux version 2.73(101019)
 Copyright(c) 1993-2010 by Super Micro Computer, Inc. http://supermicro.com/
***************************************************************************
Monitored Item            High Limit  Low Limit     Status
----------------------------------------------------------------------
CPU Fan Speed                               712       1318
SYS Fan Speed                               712        777
CPU Core Voltage                1.39       0.72       1.16
VichCore Voltage                1.16       0.94       1.04
+12V Voltage                   13.31      10.75      11.78
+3.3V Voltage                   3.63       2.98       3.30
DIMM Voltage                    1.98       1.62       1.83
+5V Voltage                     5.50       4.51       5.06
+3.3Vsb Voltage                 3.63       2.98       3.28
VBAT Voltage                    3.30       2.70       3.02
System Temperature            75/167                 36/96
CPU Temperature               85/185                 36/96
Chassis Intrusion                                     Good
Power Supply Failure                                  Good
--------------------------------------------- Mon Nov  8 23:28:46 2010

[X@X ~]# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +21.0°C  (crit = +100.0°C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +22.0°C  (crit = +100.0°C)

w83627dhg-isa-0ca0
Adapter: ISA adapter
Vcore:       +1.16 V  (min =  +0.72 V, max =  +1.39 V)
Vnbcore:     +1.04 V  (min =  +0.94 V, max =  +1.16 V)
AVCC:        +3.30 V  (min =  +2.98 V, max =  +3.63 V)
+3.3V:       +3.30 V  (min =  +2.98 V, max =  +3.63 V)
VDIMM:       +1.83 V  (min =  +1.62 V, max =  +1.98 V)
+5V:         +5.06 V  (min =  +4.51 V, max =  +5.50 V)
+12V:       +11.90 V  (min = +10.75 V, max = +13.31 V)
3VSB:        +3.28 V  (min =  +2.98 V, max =  +3.63 V)
Vbat:        +3.02 V  (min =  +2.70 V, max =  +3.30 V)
CPU Fan:    1288 RPM  (min =  712 RPM, div = 8)
SYS Fan:     767 RPM  (min =  712 RPM, div = 8)
SYS Temp:    +36.0°C  (high = +75.0°C, hyst = +70.0°C)  sensor thermistor
CPU Temp:    +36.0°C  (high = +85.0°C, hyst = +82.0°C)  sensor = diode

[X@X ~]# cat /etc/sensors.d/local.conf
chip "w83627dhg-*"

    label in0 "Vcore"
    label in1 "Vnbcore" <- name per BIOS, called 'VichCore' by "sdt"
    label in2 "AVCC"
    label in3 "+3.3V"
    label in4 "VDIMM"
    label in5 "+5V"
    label in6 "+12V"
    label in7 "3VSB"
    label in8 "Vbat"
    label fan2 "CPU Fan"
    label fan4 "SYS Fan"
    label temp1 "SYS Temp"
    label temp2 "CPU Temp"

    ignore fan1
    ignore fan3
    ignore fan5
    ignore temp3
    ignore cpu0_vid

    compute in5 @*4,@/4
    compute in6 @*16,@/16

    set in2_min  3.3 * 0.90 <- copied from sensors3.conf
    set in2_max  3.3 * 1.10 <- copied from sensors3.conf
    set in3_min  3.3 * 0.90 <- copied from sensors3.conf
    set in3_max  3.3 * 1.10 <- copied from sensors3.conf
    set in7_min  3.3 * 0.90 <- copied from sensors3.conf
    set in7_max  3.3 * 1.10 <- copied from sensors3.conf
    set in8_min  3.0 * 0.90 <- copied from sensors3.conf
    set in8_max  3.0 * 1.10 <- copied from sensors3.conf




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
