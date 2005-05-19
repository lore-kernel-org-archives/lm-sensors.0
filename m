From: fishor@gmx.net (Alexey Fisher)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: max1617a
Message-Id: <1910435530.20040515102106@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509133827.04734a7e.khali@linux-fr.org>
In-Reply-To: <20040509133827.04734a7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi  Jean,
 I provide you dump of 0x4d and 0x1f.
in a moment I try to fix sach a bagy DSDT for ACPI ... ACPI can't finde thermo-sensor too. 
 Sanky werymatch , what you traing to help me :-)


Best regards,
 Alexey                            mailto:fishor@gmx.net
-------------- next part --------------
Script started on Tue 11 May 2004 10:32:04 PM CEST
[root@inna root]# i2cdetect 
Error: No i2c-bus specified!
Syntax: i2cdetect [-f] I2CBUS
  I2CBUS is an integer
  With -f, scans all addresses (NOT RECOMMENDED)
  i2cdetect -l lists installed busses only
  Installed I2C busses:
    i2c-0	unknown   	SMBus PIIX4 adapter at 2180     	Algorithm unavailable
[root@inna root]# i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 1f 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX XX XX XX XX XX XX XX XX XX 4d XX XX 
50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX                         
[root@inna root]# i2cdump 0 0x1f
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x1f, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
10: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
20: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
30: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
40: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
50: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
60: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
70: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
80: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
90: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
a0: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
b0: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
c0: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
d0: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
e0: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
f0: 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00 0d 0d 00 00    ??..??..??..??..
[root@inna root]# i2cdump 0 0x4d
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x4d, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 4b 5d 12 80 02 04 04 37 c9 04 04 04 04 04 04 04    K]?????7????????
10: 64 5f 04 04 04 04 04 04 04 04 04 04 04 04 04 04    d_??????????????
20: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
30: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
40: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
50: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
60: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
70: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
80: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
90: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
a0: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
b0: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
c0: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
d0: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
e0: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04 04    ????????????????
f0: 04 04 04 04 04 04 04 04 04 04 04 04 04 04 4d 04    ??????????????M?
[root@inna root]# exit
exit

Script done on Tue 11 May 2004 10:33:39 PM CEST
