From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support for DDR2 DRAM??
Message-Id: <18741356.1094840060197.JavaMail.root@daisy.psp.pas.earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
In-Reply-To: <28703505.1094766606690.JavaMail.root@louie.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well, it's somewhat better now, but still not quite right:

# sensors eeprom-i2c-0-53
eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0540
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       invalid (14 11 96 4)

The memory sticks are 1GB each.

Here's the output of i2cdump you initially requested:

# ./prog/dump/i2cdump 0 0x53
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x53, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 08 0e 0b 60 48 00 05 50 60 02 82 04 04 00    ?????`H.?P`????.
10: 0c 04 18 00 01 05 01 50 60 00 00 3c 1e 3c 28 01    ???.???P`..<?<(?
20: 35 47 15 27 3c 28 1e 00 00 37 69 80 23 2d 0f 00    5G?'<(?..7i?#-?.
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 11 fa    ..............??
40: 2c ff ff ff ff ff ff ff 01 31 38 48 54 46 31 32    ,.......?18HTF12
50: 38 37 32 59 2d 34 30 45 41 32 20 02 00 04 11 c1    872Y-40EA2 ?.???
60: 18 83 2b 00 00 00 00 00 00 00 00 00 00 00 00 00    ??+.............
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 0f    ...............?


I really am impressed with the fast response.   Thank you.

David
