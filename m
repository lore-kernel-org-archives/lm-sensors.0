From: paul@astropaul.com (Paul Reilly)
Date: Thu, 03 Nov 2005 19:56:15 +0000
Subject: [lm-sensors] Temp readings on w83627 ?
Message-Id: <1131043911.436a5c47eaa11@mail.third-rock.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I have a Tyan S2850 (Tiger K8S) motherboard
which has the winbond 83627HF sensors

I am usnig the sensors.conf from the Tyan
website (show below) - and my Fan speeds are
correct, but the temperature values are wrong
(They are reported correctly in the BIOS)

Listed below is output from running sensors,
and also my /etc/sensors.conf

Can anyone say how to fix the temp readings?
Thanks,
Paul

# sensors
w83627hf-isa-0290
Adapter: ISA adapter
3.3V:      +3.44 V  (min =  +3.14 V, max =  +3.47 V)
DDR VTT:   +1.26 V  (min =  +1.18 V, max =  +1.31 V)
DDR 2.5V:  +2.51 V  (min =  +2.37 V, max =  +2.62 V)
Fan2:     5232 RPM  (min = 2657 RPM, div = 2)
CPU Fan:  6958 RPM  (min = 2657 RPM, div = 2)
Fan5:     10887 RPM  (min =    0 RPM, div = 2)
temp1:       -48?C  (high =   +45?C, hyst =   +40?C)   sensor = thermistor
temp2:     -48.0?C  (high =   +45?C, hyst =   +40?C)   sensor = thermistor
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
vid:      +0.000 V  (VRM Version 2.4)
alarms:
beep_enable:
          Sound alarm disabled

sensors -v
sensors version 2.9.1 with libsensors version 2.9.1



---------------------------------------------------------------
sensors.conf
---------------------------------------------------------------

#######
#    Sensors configuration file used by 'libsensors' for Tyan S2850
#
#  To your /etc/modules.conf file, add the lines:
#     alias char-major-89 i2c-dev
#
#  To your /etc/rc.xxx files, add the lines:
#     modprobe i2c-amd756
#     modprobe w83781d
#     sensors -s
#
#  Then copy this file to /etc/sensors.conf
#
#  Notes: You need to run sensors -s at start up
#
# Edited by: Raphael Deng <raphaeld@tyan.com> 10.04.04
#
#######

chip "w83782d-*"

    ignore temp3

    label in0 "CPU Volt"
    label in1 "SouthBridge 1.8V"
    label in3 "5V"
    label in4 "12V"
    label in5 "HT 1.2V"
    label in6 "USB 1.8V"
    label in2 "3.3V Standby"
    label in7 "5V Standby"
    label in8 "Battery Volt"

    label fan1 "Fan3"
    label fan2 "Fan4"
    label fan3 "Fan6"

    label temp1 "CPU Temp"
    label temp2 "VRM Temp"

    compute in3 ((6.8/10)+1)*@  ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in7 ((6.8/10)+1)*@  ,  @/((6.8/10)+1)
    compute temp1 @+66, @-66

# if slow fans report 0, change these values to 4
#    set fan1_div 2
#    set fan2_div 2
#    set fan3_div 2

    set sensor1 2
    set sensor2 2

    set in0_min  1.5 * 0.95
    set in0_max  1.5 * 1.05
    set in1_min  1.8 * 0.95
    set in1_max  1.8 * 1.05
    set in2_min  3.3 * 0.95
    set in2_max  3.3 * 1.05
    set in3_min  5.0 * 0.95
    set in3_max  5.0 * 1.05
    set in4_min  12.0 * 0.95
    set in4_max  12.0 * 1.05
    set in5_min  1.2 * 0.95
    set in5_max  1.2 * 1.05
    set in6_min  1.8 * 0.95
    set in6_max  1.8 * 1.05
    set in7_min  5.0 * 0.95
    set in7_max  5.0 * 1.05
    set in8_min  3.3 * 0.95
    set in8_max  3.3 * 1.05

chip "w83627hf-*"

    ignore in0
    ignore in1
    ignore in3
    ignore in6
    ignore in7
    ignore in8
#    ignore temp1
#    ignore temp2
    ignore temp3

    label in2 "3.3V"
    label in4 "DDR VTT"
    label in5 "DDR 2.5V"

    label fan2 "CPU Fan"
    label fan1 "Fan2"
    label fan3 "Fan5"


# if slow fans report 0, change these values to 4
#    set fan1_div 2
#    set fan2_div 2
#    set fan3_div 2

    set in2_min  3.3 * 0.95
    set in2_max  3.3 * 1.05
    set in4_min  1.25 * 0.95
    set in4_max  1.25 * 1.05
    set in5_min  2.5 * 0.95
    set in5_max  2.5 * 1.05

    set beep_enable 0
---------------------------------------------------------------
