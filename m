From: frdurso@yahoo.com.br (Fernando Rocha Durso)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <1069914737.4880.11.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't know if you received this...

I?ve downloaded i2c and lm-sensors from CVS patched a new "fresh" kernel
source, compiled it and installed i2c and sensors, after i?ve ran
sensors-detect, then rebooted and typed sensors... it worked!

Hope it's usefull...

here?s my output:
 
fernando@athlon:~$ sensors
eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Unknown EEPROM type (65)
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.63 V  (min =  +1.57 V, max =  +1.73 V)
VCore 2:   +1.71 V  (min =  +1.57 V, max =  +1.73 V)       ALARM
+3.3V:     +3.28 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.01 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +12.08 V  (min = +10.83 V, max = +13.19 V)
-12V:     -11.93 V  (min = -13.16 V, max = -10.90 V)
-5V:       -5.14 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.54 V  (min =  +4.74 V, max =  +5.24 V)
VBat:      +2.98 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 14062 RPM, div = 2)
fan2:     3609 RPM  (min = 112500 RPM, div = 2)
fan3:        0 RPM  (min = 2481 RPM, div = 4)
temp1:       +41?C  (high =   +99?C, hyst =    +1?C)   sensor thermistor      
temp2:     +45.0?C  (high =  +120?C, hyst =  +115?C)   sensor thermistor      
temp3:     +33.0?C  (high =  +120?C, hyst =  +115?C)   sensor thermistor      
vid:      +1.650 V
alarms:
beep_enable:
          Sound alarm disabled

root@athlon:~# lsmod
Module                  Size  Used by    Not tainted
ppp_synctty             6304   0  (unused)
ppp_async               7680   1
ppp_generic            15996   3  [ppp_synctty ppp_async]
slhc                    5392   0  [ppp_generic]
w83781d                20432   0  (unused)
eeprom                  4496   0  (unused)
i2c-proc                6548   0  [w83781d eeprom]
i2c-isa                  748   0  (unused)
i2c-nforce2             3368   0  (unused)
i2c-core               14660   0  [w83781d eeprom i2c-proc i2c-isa
i2c-nforce2]
parport_pc             15684   1  (autoclean)
lp                      6784   0  (autoclean)
parport                24992   1  (autoclean) [parport_pc lp]
ipt_REJECT              3512   4  (autoclean)
iptable_filter          1740   1  (autoclean)
ip_tables              15136   2  [ipt_REJECT iptable_filter]
printer                 7392   0
usb-ohci               19016   0  (unused)
ehci-hcd               17544   0  (unused)
usbcore                62016   1  [printer usb-ohci ehci-hcd]
8139too                16200   1
mii                     2496   0  [8139too]
crc32                   2848   0  [8139too]
ide-scsi               10224   0
agpgart                41688   0  (unused)
apm                    10024   1

root@athlon:~# cat /proc/sys/dev/sensors/eeprom-i2c-0-51/*
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0

root@athlon:~# wich sensors
-su: wich: command not found
root@athlon:~# ldd $(wich sensors)
-su: wich: command not found
ldd: missing file arguments

 
root@athlon:~# ls -l /usr/local/lib/libsensors.*
-rw-r--r--    1 root     root       146396 2003-11-26 13:48
/usr/local/lib/libsensors.a
lrwxrwxrwx    1 root     root           15 2003-11-26 13:48
/usr/local/lib/libsensors.so -> libsensors.so.3
lrwxrwxrwx    1 root     root           19 2003-11-25 22:45
/usr/local/lib/libsensors.so.2 -> libsensors.so.2.0.1
-rw-r--r--    1 root     root       117212 2003-11-25 22:45
/usr/local/lib/libsensors.so.2.0.1
lrwxrwxrwx    1 root     root           19 2003-11-26 13:48
/usr/local/lib/libsensors.so.3 -> libsensors.so.3.0.0
-rw-r--r--    1 root     root       144065 2003-11-26 13:48
/usr/local/lib/libsensors.so.3.0.0

root@athlon:~# ls -l /usr/lib/libsensors.*
/usr/bin/ls: /usr/lib/libsensors.*: Arquivo ou diret?rio n?o encontrado

dmesg:
 
Starting eeprom update, slice 0
eeprom.o: 0x51 EEPROM contents (row 1): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
<7>Starting device update
eeprom.o: 0x51 EEPROM contents (row 1): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
<7>Starting device update
eeprom.o: 0x51 EEPROM contents (row 1): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
<7>Starting device update
Starting eeprom update, slice 0
eeprom.o: 0x51 EEPROM contents (row 1): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
<7>Starting device update
Starting eeprom update, slice 0
eeprom.o: 0x51 EEPROM contents (row 1): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
eeprom.o: 0x51 EEPROM contents (row 2): 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x22 0x00
Starting eeprom update, slice 1
eeprom.o: 0x51 EEPROM contents (row 3): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
eeprom.o: 0x51 EEPROM contents (row 4): 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x22 0x00
Starting eeprom update, slice 2
eeprom.o: 0x51 EEPROM contents (row 5): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
eeprom.o: 0x51 EEPROM contents (row 6): 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x22 0x00
Starting eeprom update, slice 3
eeprom.o: 0x51 EEPROM contents (row 7): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
eeprom.o: 0x51 EEPROM contents (row 8): 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x22 0x00
Starting eeprom update, slice 4
eeprom.o: 0x51 EEPROM contents (row 9): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
eeprom.o: 0x51 EEPROM contents (row 10): 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x22 0x00
Starting eeprom update, slice 5
eeprom.o: 0x51 EEPROM contents (row 11): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
eeprom.o: 0x51 EEPROM contents (row 12): 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x22 0x00
Starting eeprom update, slice 6
eeprom.o: 0x51 EEPROM contents (row 13): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
eeprom.o: 0x51 EEPROM contents (row 14): 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x22 0x00
Starting eeprom update, slice 7
eeprom.o: 0x51 EEPROM contents (row 15): 0x43 0x43 0x41 0x54 0x33 0x00
0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
eeprom.o: 0x51 EEPROM contents (row 16): 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x02 0x00 0x00 0x22 0x00

thanks
