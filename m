From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Sat, 05 Nov 2005 23:49:36 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <200511052348.43595.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> I developed new patch. Please see attachment. As you can see it is quite
> simple one. It just add PCI IDs to PIIX4 driver.
>
> Please can you repeat your tests with this patch?
> (apply patch to i2c-piix4 and modprobe i2c-piix4; modprobe i2c-dev)

It works for me.

> Additionaly I want to know:
> i2cdetect 0
> i2cdump 0 0x50
> i2cdump 0 0x50 c
> i2cdump 0 0x50
> i2cdetect 0
> If this sequence produces same results. Also please modprobe eeprom driver
> and try to read from the chip this way: hexdump -C
> /sys/bus/i2c/devices/0-0050/eeprom

Dump is in attachment.
I tried decode-dimms.pl and it works for my two dimms.

There are found clients with sensors-detect:
------------------------------ 
Client found at address 0x2d
Probing for `SMSC LPC47M15x or LPC47M192'... Success!
    (confidence 6, driver `to-be-written')
Client found at address 0x2f
Client found at address 0x38
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69
------------------------------

If I understand correctly, is it possible to access chip LPC47MXXX
through i2c or isa?
Driver smsc47m1 always use i2c-isa driver.

Best regards,

Pavel Ruzicka
-------------- next part --------------
[root@home i2c_adapter]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX 2f
30: XX XX XX XX XX XX XX XX 38 XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

[root@home i2c_adapter]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 08 01 02 20 00 60 70 00 00 3c 28 3c 28 40    ????? .`p..<(<(@
20: 60 60 40 40 00 00 00 00 00 00 00 00 00 00 00 00    ``@@............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7c    ...............|
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

[root@home i2c_adapter]# i2cdump 0 0x50 c
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x50, mode byte consecutive read
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 08 01 02 20 00 60 70 00 00 3c 28 3c 28 40    ????? .`p..<(<(@
20: 60 60 40 40 00 00 00 00 00 00 00 00 00 00 00 00    ``@@............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7c    ...............|
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

[root@home i2c_adapter]# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 08 01 02 20 00 60 70 00 00 3c 28 3c 28 40    ????? .`p..<(<(@
20: 60 60 40 40 00 00 00 00 00 00 00 00 00 00 00 00    ``@@............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7c    ...............|
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

[root@home i2c_adapter]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX 2f
30: XX XX XX XX XX XX XX XX 38 XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX


[root@home i2c_adapter]# hexdump -C /sys/bus/i2c/devices/0-0050/eeprom
00000000  80 08 07 0d 0a 02 40 00  04 50 60 00 82 08 00 01  |......@..P`.....|
00000010  0e 04 08 01 02 20 00 60  70 00 00 3c 28 3c 28 40  |..... .`p..<(<(@|
00000020  60 60 40 40 00 00 00 00  00 00 00 00 00 00 00 00  |``@@............|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 7c  |...............||
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000080  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |????????????????|
*
00000100

[root@home devices]# hexdump -C /sys/bus/i2c/devices/0-0051/eeprom
00000000  80 08 07 0d 0a 02 40 00  04 50 60 00 82 08 00 01  |......@..P`.....|
00000010  0e 04 08 01 02 20 00 60  70 00 00 3c 28 3c 28 40  |..... .`p..<(<(@|
00000020  60 60 40 40 00 00 00 00  00 00 00 00 00 00 00 00  |``@@............|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 7c  |...............||
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000080  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |????????????????|
*
00000100
