From: paul@astropaul.com (Paul Reilly)
Date: Sun, 12 Nov 2006 23:47:02 +0000
Subject: [lm-sensors] Tyan S2877 CPU Temp Erratic
Message-Id: <1163375222.4557b2764fc69@mail.third-rock.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,
I have a Tyan S2877 motherboard. I had lm-sensors working perfectly,
but every now and then the CPU temp field, goes wrong. For instance
it was reporting around 50'C for ages, then after a reboot, it now
reports -199.75?C . Opening the box, and checking all is OK. BIOS
reports correct temp (around 48'C). Restarting multiple times, and
still can't get it to go back to report correct CPU temp.

I am using the LM85 module/code forced to use a ADT7463 chip
as this best matches my hardware. My sensors.conf and output of
sensors is shown below. NOTE, I only have one CPU in this dual
socket board.

CPU1 Temp:-199.75?C  (low  =   -71?C, high =   -73?C)

Any one seen this problem before or know a fix?
The CPU is a dual-core Opteron 265.
Thanks in advance for any help.
Paul

# sensors
w83627hf-isa-0c00
Adapter: ISA adapter
CPU2 Volt: +0.14 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +3.44 V  (min =  +2.82 V, max =  +3.79 V)
CPU1 DIMM Volt:
           +2.62 V  (min =  +1.55 V, max =  +3.58 V)
Chassis Fan 2:
          8881 RPM  (min = 7258 RPM, div = 2)
Chassis Fan 1:
          3792 RPM  (min = 4090 RPM, div = 2)              ALARM
alarms:

adt7463-i2c-1-2e
Adapter: SMBus nForce2 adapter at a040
CPU2 DIMM Volt:
           +0.000 V  (min =  +2.47 V, max =  +2.73 V)   ALARM
CPU1 Volt: +1.383 V  (min =  +1.28 V, max =  +1.42 V)
+5V:      +5.007 V  (min =  +4.74 V, max =  +5.26 V)
+12V:     +11.938 V  (min = +11.38 V, max = +12.62 V)
CPU1 Fan:  5960 RPM  (min =    0 RPM)
CPU2 Fan:     0 RPM  (min =    0 RPM)
fan3:      9152 RPM  (min =    0 RPM)
CPU2 Temp:-71.25?C  (low  =  -200?C, high =   -73?C)     ALARM FAULT
CPU1 Temp:-199.75?C  (low  =   -71?C, high =   -73?C)
vid:      +1.550 V  (VRM Version 2.4)

------------------------------------------------------------
#######
#    Sensors configuration file used by 'libsensors' for Tyan S2877
#
#  To support NFORCE4 SMBus controller, version 2.9.1 is at least
#  If using Linux Kernel 2.6.x, version 2.6.12 is at least
#
#  To your /etc/modules.conf file, add the lines:
#     alias char-major-89 i2c-dev
#
#  To your /etc/rc.xxx files, add the lines:
#     modprobe i2c-nforce2
#     modprobe i2c-isa
#     modprobe lm85 force_adm1027=1,0x2e
#     modprobe w83627hf
#     sensors -s
#
#  Then copy this file to /etc/sensors.conf
#
#  Notes:
#
# Edited by: Raphael Deng <raphaeld at tyan.com> 04.10.06
# Changed @08/07/2006
# Add "force_adm1027" parameter @ 08/08/2006
#######


#chip "adm1027-*"
chip "adt7463-*"

    ignore pwm1
    ignore pwm2
    ignore pwm3
    ignore fan4
    ignore in2
    ignore in5
    ignore in6
    ignore in7
    ignore temp2

    label in0 "CPU2 DIMM Volt"
    label in1 "CPU1 Volt"
    label in3 "+5V"
    label in4 "+12V"

    label fan1 "CPU1 Fan"
    label fan2 "CPU2 Fan"
    label fan4 "Chassis Fan 0"

    label temp1 "CPU2 Temp"
    label temp3 "CPU1 Temp"

    set in0_min  2.6 * 0.95
    set in0_max  2.6 * 1.05
    set in1_min  1.35 * 0.95
    set in1_max  1.35 * 1.05
    set in3_min  5.0 * 0.95
    set in3_max  5.0 * 1.05
    set in4_min  12.0 * 0.95
    set in4_max  12.0 * 1.05

    compute temp1 @-72,  @+72
    compute temp3 @-72,  @+72

chip "w83627hf-*"

        ignore pwm1
  ignore pwm2
        ignore pwm3
        ignore in1
        ignore in3
        ignore in4
        ignore in6
        ignore in7
        ignore in8
        ignore fan3
        ignore temp1
        ignore temp2
        ignore temp3
        ignore vid
        ignore alarm
        ignore beep_enable

        label in0 "CPU2 Volt"
        label in2 "+3.3V"
        label in5 "CPU1 DIMM Volt"

        label fan2 "Chassis Fan 1"
        label fan1 "Chassis Fan 2"

# current lm sensors has some issue on these 2 sensors type supporting
#       label temp2 "CPU1 VRM Temp"
#       label temp1 "CPU2 VRM Temp"

#       set sensor1 3435
#       set sensor2 3435

