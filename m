From: sebastic@xs4all.nl (Sebastiaan Couwenberg)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lmsensors2 & linux-2.6.-test11
Message-Id: <3FCBCD0C.2010406@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've compiled linux kernel 2.6-test11 with i2c support and got 
lmsensors2 from cvs.
I have a Chaintech 7VJDA motherboard with the VIA KT266A chipset, and 1 
bank of DDR266 RAM (non ecc).

when executing the sensors command (after loading the appropriate 
modules suggested by sensors-detect),
I get a segfault when reading the eeprom data.
I've put the info I tought was relevant below, please inform me if you 
need more info.

If you are not the right person to address this bugreport to, please 
forward it to the correct person.

Cheers,

Bas Couwenberg

root@anubis:~# sensors -v
sensors version 2.8.1
root@anubis:~# sensors
it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.72 V  (min =  +1.42 V, max =  +1.56 V)   ALARM
VCore 2:   +3.28 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
+3.3V:     +6.52 V  (min =  +3.12 V, max =  +3.44 V)   ALARM
+5V:       +4.89 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.96 V  (min = +11.36 V, max = +12.60 V)
-12V:     -20.30 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -2.51 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
Stdby:     +4.99 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +2.99 V
fan1:     3426 RPM  (min =    0 RPM, div = 2)
fan2:     2824 RPM  (min = 2657 RPM, div = 2)
fan3:        0 RPM  (min = 2657 RPM, div = 2)          ALARM
Temp1/MB:    +47?C  (low  =   +20?C, high =   +40?C)   sensor = thermistor
Temp2/CPU:  +124?C  (low  =   +25?C, high =   +45?C)   sensor = invalid
Temp3:       +41?C  (low  =   +25?C, high =   +45?C)   sensor = thermistor

eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
ERROR: data 1

Segmentation fault
root@anubis:~# lsmod
Module                  Size  Used by
it87                   22784  0
eeprom                  7040  0
i2c_sensor              3456  2 it87,eeprom
i2c_isa                 2816  0
i2c_dev                 9344  0
i2c_viapro              7052  0
i2c_core               21892  6 it87,eeprom,i2c_sensor,i2c_isa,i2c_dev,i2c_viapro
ipv6                  241920  12
autofs4                14592  1
af_packet              18436  2
nls_iso8859_1           4864  3
nls_cp437               6528  3
agpgart                28108  0
8139too                22144  0
mii                     5248  1 8139too
crc32                   4992  1 8139too
apm                    17772  2
rtc                    11848  0
root@anubis:~# ls -l /sys/bus/i2c/*/*/*
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/0-0051/detach_state
-r--r--r--    1 root     root          256 Dec  2 02:58 /sys/bus/i2c/devices/0-0051/eeprom
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/0-0051/name
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/alarm
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/detach_state
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/fan_div1
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/fan_div2
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/fan_div3
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/fan_input1
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/fan_input2
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/fan_input3
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/fan_min1
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/fan_min2
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/fan_min3
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input0
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input1
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input2
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input3
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input4
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input5
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input6
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input7
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/in_input8
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_max0
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_max1
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_max2
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_max3
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_max4
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_max5
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_max6
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_max7
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_min0
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_min1
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_min2
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_min3
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_min4
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_min5
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_min6
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/in_min7
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/name
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/sensor1
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/sensor2
-rw-r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/sensor3
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/temp_input1
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/temp_input2
-r--r--r--    1 root     root         4096 Dec  2 02:58 /sys/bus/i2c/devices/1-0290/temp_input3
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/temp_max1
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/temp_max2
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/temp_max3
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/temp_min1
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/temp_min2
-rw-r--r--    1 root     root            0 Dec  2 03:00 /sys/bus/i2c/devices/1-0290/temp_min3
lrwxrwxrwx    1 root     root           39 Dec  2 02:58 /sys/bus/i2c/drivers/IT87xx/1-0290 -> ../../../../devices/legacy/i2c-1/1-0290
lrwxrwxrwx    1 root     root           56 Dec  2 02:58 /sys/bus/i2c/drivers/eeprom/0-0051 -> ../../../../devices/pci0000:00/0000:00:11.0/i2c-0/0-0051

/sys/bus/i2c/devices/0-0051/power:
total 0
-rw-r--r--    1 root     root         4096 Dec  2 02:58 state

/sys/bus/i2c/devices/1-0290/power:
total 0
-rw-r--r--    1 root     root         4096 Dec  2 02:58 state


