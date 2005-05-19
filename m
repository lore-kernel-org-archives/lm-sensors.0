From: ojoa@gatrixx.com (Oliver Joa)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: i2c-pport and pcf8574
Message-Id: <Pine.LNX.4.55.0308101908080.6058@majestix.gallier.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,

i want to use the i2c-pport driver to control some pcf8574. i have wired
the pcf8574 to the parallel-port and connected 8 leds to the pcf8574 to
show the status of the 8 bit outports. i have loaded the following
modules:

debian:/home/olli# lsmod
Module                  Size  Used by    Not tainted
rtc                     5916   0  (unused)
i2c-proc                6016   0  (unused)
i2c-dev                 3776   0
i2c-pport               1440   0
i2c-algo-bit            7880   0  [i2c-pport]
i2c-core               14464   0  [i2c-proc i2c-dev i2c-algo-bit]
eepro100               18572   1  (autoclean)
mii                     2288   0  (autoclean) [eepro100]

dmesg gives me the following:
i2c-core.o: i2c core module version 2.8.0 (20030714)
i2c-pport.o: i2c
Primitive parallel port adapter module version 2.8.0
(20030714)
i2c-pport.o: found device at 0x378.
i2c-dev.o: Registered 'Primitive Parallel port adaptor' as minor 0

when i make a:
strace i2cset 0 0x20 0x0 1
i get the following:

nanosleep({5, 0}, {5, 0})               = 0
ioctl(3, 0x720, 0xbffffcf0)             = -1 EPERM (Operation not
permitted)
write(2, "Warning - write failed\n", 23Warning - write failed
) = 23
ioctl(3, 0x720, 0xbffffcf0)             = -1 EPERM (Operation not
permitted)
write(2, "Warning - readback failed\n", 26Warning - readback failed
) = 26

debian:/home/olli# cat /dev/i2c-0
cat: /dev/i2c-0: Remote I/O error

it seems that there is a i/o problem.

debian:/home/olli# cat /proc/bus/i2c
i2c-0   i2c             Primitive Parallel port adaptor         Bit-shift
algorithm
debian:/home/olli# cat /proc/bus/i2c-0
debian:/home/olli#

debian:/proc/sys/dev/sensors# ls -la
total 0
dr-xr-xr-x    2 root     root            0 Aug 10 19:15 .
dr-xr-xr-x    5 root     root            0 Aug 10 19:15 ..
-rw-r--r--    1 root     root            0 Aug 10 19:15 chips
debian:/proc/sys/dev/sensors# cat chips
debian:/proc/sys/dev/sensors#

an i2cdump 0 0x20 does not get any values from the chip.

do you have any idea why i can not get a connection to the chip?

thank

oliver joa


-- 
Dipl. Inf. (FH) Oliver Joa, senior IT-architect

Gatrixx NetSolutions GmbH, Karl-Goetz-Strasse 5, 97424 Schweinfurt
Fon +49 9721 797 420,  Fax +49 9383 999-58,  Mobil +49 160 47874 62
E-Mail ojoa@gatrixx.com, ojoa@gmx.net, oliver@j-o-a.de
http://www.finanztreff.de/
