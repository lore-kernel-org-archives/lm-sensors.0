From: fako@freemail.hu (Holub Zoltan)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: p5a-b sensor
Message-Id: <20040624160213.GA959@terminal.dnsalias.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!!

The old (Rev 1.03) mobo is broken so i cant dump it.

> You flashed to same version ?
yes, i flashed p5a-b 1010 bios 
i dont see 1010 on the asus ftp now. Maybe removed because it has bugs:)
Now i dont have direct access to the computer so i cant try another bios.

i2c-dev is compiled into kernel.

# modprobe i2c_ali15x3
# ./i2cdetect -l
i2c-0   unknown         SMBus ALI15X3 adapter at e800           Algorithm
unavailable

# ./i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0.
  I will probe address range 0x03-0x77.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX


# ./i2cdump 0 0x2d
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2d, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: 8e 8e de ba c4 db c9 27 ff 37 ff ff 00 ff 00 ed    ???????'.7.....?
30: b0 10 04 00 00 04 80 00 02 03 01 00 24 08 00 00    ???..??.???.$?..
40: 01 d8 0f ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c    ???.?.@?-??@???\
50: 00 7f 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff    .??....??.......
60: 8e 8c de ba c4 db cc 27 ff 37 ff ff 00 ff 00 ed    ???????'.7.....?
70: b0 10 04 00 00 04 80 00 02 03 01 00 24 08 00 00    ???..??.???.$?..
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 8e 8e de b8 c4 db c9 27 ff 38 ff ff 00 ff 00 ed    ???????'.8.....?
b0: b0 10 04 00 00 04 80 00 02 03 01 00 24 08 00 00    ???..??.???.$?..
c0: 01 c8 0f ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c    ???.?.@?-??@???\
d0: 00 7f 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff    .??....??.......
e0: 8b 8e de ba c4 dd ca 27 ff 38 ff ff 00 ff 00 ed    ???????'.8.....?
f0: b0 10 04 00 00 04 80 00 02 03 01 00 24 08 00 00    ???..??.???.$?..

# sensors
No sensors found!

# modprobe w83781d

# ./i2cdetect -l
i2c-0   unknown         SMBus ALI15X3 adapter at e800           Algorithm
unavailable

# ./i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0.
  I will probe address range 0x03-0x77.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX


# i2cdump 0 0x2d
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2d, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: 8e 8d df bb c5 db ca 27 ff 6f ff ff 00 ff 00 ed    ???????'.o.....?
30: b0 10 04 00 00 04 80 00 02 03 01 00 24 08 00 00    ???..??.???.$?..
40: 01 c8 0f 00 00 00 40 50 2d 01 01 40 01 95 80 5c    ???...@P-??@???\
50: 10 01 80 ff ff ff 00 00 11 ff ff ff ff ff ff ff    ???.....?.......
60: 8e 8c df ba c4 db cb 27 ff 6f ff ff 00 ff 00 ed    ???????'.o.....?
70: b0 10 04 00 00 04 80 00 02 03 01 00 24 08 00 00    ???..??.???.$?..
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 8f 8e de ba c4 db ca 27 ff 6e ff ff 00 ff 00 ed    ???????'.n.....?
b0: b0 10 04 00 00 04 80 00 02 03 01 00 24 08 00 00    ???..??.???.$?..
c0: 01 c8 0f 00 00 00 40 50 2d 01 01 40 01 95 80 5c    ???...@P-??@???\
d0: 10 01 80 ff ff ff 00 00 11 ff ff ff ff ff ff ff    ???.....?.......
e0: 8e 8d de ba c4 db c9 27 ff 6e ff ff 00 ff 00 ed    ???????'.n.....?
f0: b0 10 04 00 00 04 80 00 02 03 01 00 24 08 00 00    ???..??.???.$?..


# sensors
w83781d-i2c-0-2d
Adapter: SMBus ALI15X3 adapter at e800
CPU Core:  +2.26 V  (min =  +0.00 V, max =  +4.08 V)
I/O:       +3.57 V  (min =  +2.82 V, max =  +3.79 V)
+5V:       +4.95 V  (min =  +0.11 V, max =  +0.43 V)       ALARM
+12V:     +12.04 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
-12V:     -12.35 V  (min =  -0.22 V, max =  -7.12 V)       ALARM
-5V:       -4.91 V  (min =  -0.00 V, max =  -0.05 V)       ALARM
CPU Fan:  6136 RPM  (min = 18750 RPM, div = 2)              ALARM
temp1:       +39?C  (high =    +3?C, hyst =    +1?C) 
temp2:     +39.0?C  (high =   +57?C, hyst =   +50?C)
temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)
vid:      +3.500 V

I dont know what is temp1, its show same as temp2.
temp2 is the CPU
temp3 was the MB temp on the old mobo.
The old mb has same output except for temp3


thx

fako
     
