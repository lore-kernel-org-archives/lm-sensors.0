From: Mikael Jansson <mail@mikael.jansson.be>
Date: Thu, 08 May 2008 13:44:49 +0000
Subject: Re: [lm-sensors] HP2133 support?
Message-Id: <loom.20080508T134311-707@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20080508T105547-918@post.gmane.org>
In-Reply-To: <loom.20080508T105547-918@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mikael Jansson <mail <at> mikael.jansson.be> writes:

> 
> Hi,
> 
> What are the plans for the HP2133/Mini-Note?  It's a P4M900 SB, and here's 
the 
> [trimmed] output of sensors-detect. 
> 
I've gathered more info, also available at http://rafb.net/p/wPNMMZ76.txt

===============# the following patch applied to my 2.6.24 kernel
# http://lists.lm-sensors.org/pipermail/i2c/2008-January/002711.html

$ sudo i2cdetect -l
i2c-0	smbus     	SMBus Via Pro adapter at 0400   	SMBus adapter
(798) /usr/src/linux-2.6.24-16/drivers/i2c/busses> sudo i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- 1d -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: 30 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- 6e -- 
70: -- -- -- -- -- -- -- --                         
(799) /usr/src/linux-2.6.24-16/drivers/i2c/busses> sudo i2cdump 0 0x1d
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x1d, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3b    ...............;
10: 89 07 87 12 12 00 12 91 00 d1 0e 41 00 00 00 00    ?????.??.??A....
20: 47 0a 01 00 00 00 00 ff 00 f7 00 00 00 34 00 00    G??......?...4..
30: 95 25 14 02 2a 15 12 02 00 00 00 00 00 00 00 00    ?%??*???........
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3b    ...............;
90: 89 07 87 12 12 00 12 91 00 d1 0e 41 00 00 00 00    ?????.??.??A....
a0: 47 0a 01 00 00 00 00 ff 00 f7 00 ff 00 34 00 00    G??......?...4..
b0: 95 25 14 02 2a 15 12 02 00 00 00 00 00 00 00 00    ?%??*???........
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
(800) /usr/src/linux-2.6.24-16/drivers/i2c/busses> sudo i2cdump 0 0x30
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x30, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
(801) /usr/src/linux-2.6.24-16/drivers/i2c/busses> sudo i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 08 0e 0a 61 40 00 05 30 45 00 82 08 00 00    ?????a@.?0E.??..
10: 0c 08 38 01 04 00 07 3d 50 50 60 3c 1e 3c 2d 01    ??8??.?=PP`<?<-?
20: 20 27 10 17 3c 1e 1e 00 06 3c 7f 80 18 22 00 00     '??<??.?<???"..
30: 00 03 00 00 00 00 00 00 00 00 00 00 00 00 12 1c    .?............??
40: ce 00 00 00 00 00 00 00 02 4d 34 20 37 30 54 35    ?.......?M4 70T5
50: 36 36 33 51 5a 33 2d 43 45 36 20 33 51 08 13 76    663QZ3-CE6 3Q??v
60: 38 d3 07 00 53 45 53 30 4e 30 30 00 00 00 00 00    8??.SES0N00.....
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 62 43 63 13 20 35 55 fe e0 00 00 01 19 0a 00    .bCc? 5U??..???.
90: 00 62 43 63 13 20 35 55 80 00 5a 4d 00 49 0c 00    .bCc? 5U?.ZM.I?.
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 52 2f 4d ff ff ff ff ff ff ff ff ff ff ff ff ff    R/M.............
f0: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 04    ?..............?
(802) /usr/src/linux-2.6.24-16/drivers/i2c/busses> sudo i2cdump 0 0x69
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x69, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
20: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
40: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
50: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
60: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
70: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
80: 07 18 19 03 1b 01 06 01 0f 07 00 0d 1c 0b 0f 09    ??????????.?????
90: 0c 0d 1c 0b 0f 00 XX 13 13 13 13 13 13 13 13 13    ?????.X?????????
a0: 07 18 19 03 1b 01 06 01 0f 07 00 0d 1c 0b 0f 09    ??????????.?????
b0: 0c 0d 1c 0b 0f 00 XX 13 13 13 13 13 13 13 13 13    ?????.X?????????
c0: 07 18 19 03 1b 01 06 01 0f 07 00 0d 1c 0b 0f 09    ??????????.?????
d0: 0c 0d 1c 0b 0f 00 XX 13 13 13 13 13 13 13 13 13    ?????.X?????????
e0: 07 18 19 03 1b 01 06 01 0f 07 00 0d 1c 0b 0f 09    ??????????.?????
f0: 0c 0d 1c 0b 0f 00 XX 13 13 13 13 13 13 13 13 13    ?????.X?????????
(803) /usr/src/linux-2.6.24-16/drivers/i2c/busses> sudo i2cdump 0 0x6e
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x6e, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
10: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
20: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
30: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
40: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
50: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
60: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
70: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
80: ff ff ff ff ff ff ff c9 0e ff ff ff ff ff ff ff    .......??.......
90: ff ff ff 00 00 00 ff ff ff ff ff ff ff XX ff ff    .............X..
a0: ff ff ff ff ff ff ff c9 0e ff ff ff ff ff ff ff    .......??.......
b0: ff ff ff 00 00 00 ff ff ff ff ff ff ff XX ff ff    .............X..
c0: ff ff ff ff ff ff ff c9 0e ff ff ff ff ff ff ff    .......??.......
d0: ff ff ff 00 00 00 ff ff ff ff ff ff ff XX ff ff    .............X..
e0: ff ff ff ff ff ff ff c9 0e ff ff ff ff ff ff ff    .......??.......
f0: ff ff ff 00 00 00 ff ff ff ff ff ff ff XX ff ff    .............X..
(804) /usr/src/linux-2.6.24-16/drivers/i2c/busses>
===============
So, given this, what can I do now?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
