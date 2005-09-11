From: philippe.roubach@free.fr (ROUBACH Philippe)
Date: Sun, 11 Sep 2005 16:41:58 +0000
Subject: [lm-sensors] lm-sensor asb100/CPU temp(AMD) problem
Message-Id: <200509111641.23414.philippe.roubach@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

As avised by Jean Delvare i define again my pb

1. DEF
Under Mandrake 9.2 kernel 2.4.22.10 lm*sensors 2.8.0 i have :
 asb100/CPU Temp, asb100/M/B Temp and asw83l785ts/NeForce2 Temp
 we see the three temperatures which change during second, minute 

Under Mandriva LE 2005 kernel 2.6.11 lm-sensors 2.9.0
 and Mandriva 2006 RC1 kernel 2.6.12 lm-sensors 2.9.1 i have :
 asb100/CPU Temp, asb100/M/B Temp and asw83l785ts/NeForce2 Temp
 we see temperatures which change during second, minute for M/B and NeForce2
 but the temperature of CPU Temp stays steady during all day, week, month.

my bios gives me the MB temp and the CPU temp.

Under MDK 9.2 i very that :
- asb100/MB temp is the bios/MB temp
- asb/100/CPU temp is the bios CPU temp

Under MDV LE 2005 and 2006rc1 i verify that :
- asb100/MB temp is the bios/MB temp
- asb/100/CPU temp(48 ?C <=> 25*1.9) is a type of CPU temp but stays steady in 
the contrary of the bios CPU temp which changes frequently. 

2. My CONF
2.1 My HARDWARE

MB : ASUS A7N8X-X
Processor: ?AuthenticAMD mod?le: ?AMD Athlon(tm) XP 2600+ barton
Famille CPUID: 6 Mod?le: 10 Num?ro de mod?le: 0
Chipset NForce2

3 DIAG
3.1. Output of the sensors command
********************************************************
[root@ ~]# sensors
eeprom-i2c-0-52
Adapter: SMBus nForce2 adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

w83l785ts-i2c-1-2e
Adapter: SMBus nForce2 adapter at 5500
temp:        +64?C  (high =  +110?C)

asb100-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5500
VCore 1:   +1.70 V  (min =  +1.57 V, max =  +1.73 V)
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.00 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +11.49 V  (min = +10.82 V, max = +13.19 V)
-12V (reserved):
          -12.01 V  (min =  -0.00 V, max =  -0.00 V)
-5V (reserved):
           -5.04 V  (min =  -0.00 V, max =  -0.00 V)
CPU Fan:  5037 RPM  (min = 1997 RPM, div = 4)
Chassis Fan:
          3154 RPM  (min = 3994 RPM, div = 2)
Power Fan:   0 RPM  (min = 3994 RPM, div = 2)
M/B Temp:    +50?C  (high =   +45?C, hyst =   +40?C)
CPU Temp (Intel):
             +28?C  (high =   +60?C, hyst =   +50?C)
Power Temp:
              -0?C  (high =   +45?C, hyst =   +40?C)
CPU Temp (AMD):
             +25?C  (high =   +60?C, hyst =   +50?C)
vid:      +1.650 V  (VRM Version 9.0)
alarms:

[root@ ~]#
********************************************************

3.2 sensors.conf/asb100
********************************************************
# This example was tested vs. Asus P4S333
#
chip "asb100-*"
    set vrm 9.0

    label in0 "VCore 1"
    set in0_min vid * 0.95
    set in0_max vid * 1.05

    label in1 "VCore 2"
    ignore in1
    set in1_min vid * 0.95
    set in1_max vid * 1.05

    label in2 "+3.3V"
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05

    label in3 "+5V"
    compute in3 1.68 * @ ,  @ / 1.68
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05

    label in4 "+12V"
    compute in4 3.8 * @ , @ / 3.8
    set in4_min 12  * 0.90
    set in4_max 12  * 1.10

    label in5 "-12V (reserved)"
    #ignore in5
    compute in5 -@ * 3.97 ,  -@ / 3.97
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10

    label in6 "-5V (reserved)"
    #ignore in6
    compute in6 -@ * 1.666 , -@ / 1.666
    set in6_max -5  * 0.95
    set in6_min -5  * 1.05

    label temp1 "M/B Temp"
    set temp1_over 45
    set temp1_hyst 40

    label temp2 "CPU Temp (Intel)"
    #ignore temp2
    set temp2_over 60
    set temp2_hyst 50

    # PWRTMP connector on P4S333, for external sensor
    label temp3 "Power Temp"
    #ignore temp3
    set temp3_over 45
    set temp3_hyst 40


    # Used for Athlon diode, ignore for P4S333
    label temp4 "CPU Temp (AMD)"
    set temp4_over 60
    set temp4_hyst 50
    #ignore temp4

    label fan1 "CPU Fan"
    set fan1_div 4
    set fan1_min 2000

    label fan2 "Chassis Fan"
    set fan2_div 2
    set fan2_min 4000

    label fan3 "Power Fan"
    set fan3_div 2
    set fan3_min 4000

*******************************************************

Thanks in advance

--
Philippe ROUBACH
