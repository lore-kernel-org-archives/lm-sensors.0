From: David.Monniaux@ens.fr (David Monniaux)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: ticket #561: Voodoo Banshee monitor readings
Message-Id: <Pine.GSO.4.03.10303092156320.28909-100000@basilic.ens.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As asked:

[david@picsou david]$ sudo i2cdump 3 0x50
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-3, address 0x50, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 ff ff ff ff ff ff 00 26 cd 40 17 00 00 00 00    ........&?@?....
10: 26 0a 01 01 0e 20 18 94 e8 04 88 a0 57 4a 9b 26    &???? ??????WJ?&
20: 12 48 4c bf ef 80 a9 4f 01 01 01 01 01 01 01 01    ?HL????O????????
30: 01 01 01 01 01 01 00 00 00 fe 00 00 00 00 00 00    ??????...?......
40: 00 00 00 00 00 00 00 00 00 00 00 fe 00 00 00 00    ...........?....
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 00    .............?..
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe    ...............?
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 68    ...............h
80: 00 ff ff ff ff ff ff 00 26 cd 40 17 00 00 00 00    ........&?@?....
90: 26 0a 01 01 0e 20 18 94 e8 04 88 a0 57 4a 9b 26    &???? ??????WJ?&
a0: 12 48 4c bf ef 80 a9 4f 01 01 01 01 01 01 01 01    ?HL????O????????
b0: 01 01 01 01 01 01 00 00 00 fe 00 00 00 00 00 00    ??????...?......
c0: 00 00 00 00 00 00 00 00 00 00 00 fe 00 00 00 00    ...........?....
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 00    .............?..
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe    ...............?
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 68    ...............h

Sorry for being late!

David Monniaux            http://www.di.ens.fr/~monniaux
Laboratoire d'informatique de l'?cole Normale Sup?rieure,
Paris, France
