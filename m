From: marco@noope.de (Marco Balle)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: IMPORTANT INFORMATION for Ticket 933 Tyan Server Board: Thunder  K7X MPX (2468)
Message-Id: <000201c22c2e$e6f63c90$1f00a8c0@noope>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lm-sensors team,

some specs of the new Tyan Thunder K7X 2468 Board. I made this with the
Tyan monitoring tool in windows 2000.
I try to explain the sensors, and I have made some pictures of the tyan
monitoring tool, where you can see everything (how much sensors and
where they are and what they do).

There are six temperature sensors:

CPU1 (on the CPU)
CPU2 (on the CPU)
VRM1 (on the Board behind one of the CPU sockets between the 4
condensers)
VRM2 (right of one CPU between the 4 coils)
DDR (by the DDR RAM sockets)
AGP (beside the AGP Clot)

And there are 8 FAN connectors:

CPU1 Fan
CPU2 Fan
Chassis Fan 1
Chassis Fan 2
Chassis Fan 3 *not shown in the tool
Chassis Fan 4 *not shown in the tool
Chassis Fan 5
Chassis Fan 6

And there are 9 voltages?:

CPU1 Core Volt
CPU2 Core Volt
System Volt 3,3V
System Volt 5V
System Volt 12V
System Volt -12V
AGP Volt
DDR Volt
Battery Volt

Please take a look at the pictures. Now you should know how much sensors
on the board are.
There are two sensor chips I think:
w83627hf and w83782d

I made a ticket with number 933 - there you can see the results. Here
again the output of sensors:

modules.conf:
# I2C module options
alias char-major-89 i2c-dev
options w83781d init=1 force_subclients=0,0x2c,0x4a,0x4b
after a sensors -s here the output of sensors:

w83782d-i2c-0-28
Adapter: SMBus AMD768 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.74 V  (min =  +1.74 V, max =  +1.93 V)       ALARM
VCore 2:   +1.21 V  (min =  +1.74 V, max =  +1.93 V)
+3.3V:     +3.39 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.94 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.86 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.29 V  (min = -13.21 V, max = -10.90 V)
-5V:       +0.11 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.07 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.24 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     8333 RPM  (min = 3000 RPM, div = 2)
fan2:     8132 RPM  (min = 3000 RPM, div = 2)
fan3:     5192 RPM  (min = 1500 RPM, div = 4)
temp1:       +55?C  (limit =  +60?C)                       sensor = 3904

transistor
temp2:     +55.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 
transistor   ALARM
temp3:     +56.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 
transistor   ALARM
vid:      +1.850 V
alarms:
beep_enable:
          Sound alarm disabled


w83627hf-i2c-0-2c
Adapter: SMBus AMD768 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.72 V  (min =  +1.74 V, max =  +1.93 V)       ALARM
VCore 2:   +1.74 V  (min =  +1.74 V, max =  +1.93 V)       ALARM
+3.3V:     +3.28 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.07 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +10.75 V  (min = +10.79 V, max = +13.19 V)
-12V:      +2.51 V  (min = -13.21 V, max = -10.90 V)
-5V:       +0.08 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.24 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)
fan3:        0 RPM  (min = 1500 RPM, div = 4)
temp1:       +49?C  (limit =  +60?C)                       sensor = 3904

transistor
temp2:     +41.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 
transistor
temp3:     +36.5?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 
transistor
vid:      +1.850 V
alarms:
beep_enable:
          Sound alarm disabled

This are the standby temperatures, also shown on the picture (ok 10mins
after a stress test). The standby temeratures (0% CPU utillisation) are:
CPU1: 57?C
CPU2: 57?C
VRM1: 52?C
VRM2: 60?C
DDR:  36?C
AGP:  41?C

This is shown in the Tyan windows tool, and I am sure, that are the
correct temperatures.

The CPU FAN speeds are ~5000rpm - you can see this in the fan picture. 
lm-ensors says about 8000rpm.
The third FAN connector (chassis 1) is connected to a FAN control
system, which give a rpm of 3000. Sensors see ~5000rpm.

I hope this information can help you, to make sensors usable for this
Board.
Or do a configure anything wrong?

Best regards

Marco Balle
marco@noope.de

-------------- next part --------------
A non-text attachment was scrubbed...
Name: voltage.jpg
Type: image/jpeg
Size: 84031 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/voltage.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: board-original.jpg
Type: image/jpeg
Size: 97951 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/board-original.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: board-overview.jpg
Type: image/jpeg
Size: 104435 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/board-overview.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Fan.jpg
Type: image/jpeg
Size: 78735 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/Fan.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: temp-agp.jpg
Type: image/jpeg
Size: 96195 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/temp-agp.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: temp-cpu1.jpg
Type: image/jpeg
Size: 97642 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/temp-cpu1.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: temp-cpu2.jpg
Type: image/jpeg
Size: 96145 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/temp-cpu2.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: temp-ddr.jpg
Type: image/jpeg
Size: 97886 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/temp-ddr.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Temperature.jpg
Type: image/jpeg
Size: 75960 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/Temperature.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: temp-vrm1.jpg
Type: image/jpeg
Size: 94737 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/temp-vrm1.jpg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: temp-vrm2.jpg
Type: image/jpeg
Size: 96751 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020715/b64efe2e/temp-vrm2.jpg
