From: S.Assmann@gmx.de (Stefan Assmann)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: lm_sensors problem with sis96x and adm1021
Message-Id: <41B9BDFD.6070102@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

actually I wanted to send this email to the lm_sensors mailing-list but 
I couldn't find it.
Maybe you could tell me the address so I know next time :-)

I already started a ticket with the number 1841.
When running sensors -s and then sensors I get

asus:/sys/bus/i2c/devices/0-004c# sensors
max1617-i2c-0-4c
Adapter: SiS96x SMBus adapter at 0x0c00
Board:       +56??C  (low  =    +0??C, high =   +70??C)
CPU:         +54??C  (low  =   +50??C, high =   +70??C)

So the values for Board have been set correctly but for CPU it shows no 
effect.

I was told to send a dump of the chip so here it is.

asus:/sys/bus/i2c/devices/0-004c# i2cdump 0 0x4c
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x4c, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 39 32 00 00 04 46 00 37 00 00 00 00 00 00 00 00    92..?F.7........
10: 80 00 00 00 00 00 55 55 00 64 64 64 64 64 64 64    ?.....UU.ddddddd
20: 64 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    d???????????????
30: 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    ????????????????
40: 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    ????????????????
50: 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    ????????????????
60: 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    ????????????????
70: 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    ????????????????
80: 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    ????????????????
90: 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    ????????????????
a0: 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a    ????????????????
b0: 0a 0a 0a 0a 0a 0a 0a 00 00 00 00 00 00 00 00 00    ???????.........
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4d 4d    ..............MM


I really appreciate your work. Thank you!

Greetings,
Stefan
