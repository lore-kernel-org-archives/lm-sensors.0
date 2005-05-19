From: frdurso@yahoo.com.br (Fernando Rocha Durso)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <1069703037.8309.4.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

root@athlon:/etc/rc.d# i2cdump 0 0x50
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x50, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 01 40 00 04 50 65 00 82 08 00 01    ??????@.?Pe.??.?
10: 0c 04 10 01 02 20 00 00 00 00 00 50 28 50 28 40    ????? .....P(P(@
20: 60 60 40 40 00 00 00 00 00 00 00 00 00 00 00 00    ``@@............
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 de    ...............?
40: 43 43 41 54 33 00 00 00 01 00 00 00 00 00 00 00    CCAT3...?.......
50: 00 00 00 00 00 00 00 00 00 00 00 02 00 00 22 00    ...........?..".
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

My memory is Samsung DDR 400, i have one DDR with 256 Mb

I hope this is what you asked for...

thanks.


Em Seg, 2003-11-24 ?s 20:38, Jean Delvare escreveu:
> Hello,
> 
> I saw your ticket about the unknown eeprom type. Could you please tell
> us what type of memory you have, which capacity, and provide a dump of
> the eeprom? (i2cdump 0 0x50).
> 
> Thanks.
