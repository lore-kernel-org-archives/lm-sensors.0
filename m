From: romain@dolbeau.org (Romain Dolbeau)
Date: Sat, 17 Jun 2006 13:50:57 +0000
Subject: [lm-sensors] Second request to support the 'Analog Devices ADT7476'
Message-Id: <449408C1.1000307@dolbeau.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

The ticket support has forwarded me to the mailing list, I hope
it's ok.

The 'Analog Devices ADT7476' chip has been entered in the
database as 'not supported yet, one request', so this is
a seconde request for the same chip :-)

Motherboard is a Intel D945GNT, it has a properly
detected ADT7476 :

(excerpt from sensors-detect)
#####
Probing for `Analog Devices ADT7476'... Success!
     (confidence 7, driver `to-be-written')
#####

and i2cdump :

#####
dolbeau at dwalin:~$ sudo i2cdump 0 0x2e b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 77 6a c3 ca c5 35 2b 27 ff ff ff ff ff ff ff ff    wj???5+'........
30: 33 4c 4c 00 00 00 00 00 ff ff ff 00 00 76 41 69    3LL..........vAi
40: 05 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 02 22 22 7a    ????........?""z
60: 8a 80 e8 88 33 4c 4c 38 2d 2d 45 41 41 24 40 00    ????3LL8--EAA$@.
70: 00 00 00 00 00 00 3e f7 f0 00 00 55 01 00 00 00    ......>??..U?...
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
#####

module lm85 recognizes the chip but gives wrong outputs.

Thanks in advance for anything that can be done,

-- 
Romain Dolbeau
<romain at dolbeau.org>

