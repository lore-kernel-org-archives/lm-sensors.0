From: beejay@gentoo.org (Benjamin Judas)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <1099509211.11618.23.camel@antares.hausnetz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Another info requested by Jean on IRC:


antares /home/benni # i2cdump 1 0x2f
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x2f, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 8a 00 00 01 00 00 ff    .........?..?...
10: 00 00 7f 00 00 10 00 00 00 00 00 00 00 00 00 80    ..?..?.........?
20: 00 00 00 b7 00 00 00 7f ff ff ff ff 00 ff 00 ed    ...?...?.......?
30: b0 40 84 2a 84 41 4a 00 9d 00 08 00 01 18 ff ff    ?@?*?AJ.?.?.??..
40: 01 fc 6f 00 00 00 00 5f 2f 11 01 44 01 95 80 5c    ??o...._/??D???\
50: ff ff ff ff ff ff 00 80 71 70 ff 00 00 00 05 ff    .......?qp....?.
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a    ?.?.....????<<??
90: 00 00 00 01 ff 00 00 00 01 01 3c 18 00 00 01 01    ...?....??<?..??
a0: ff ff ff 00 00 00 00 00 17 fc 6f 18 00 ff ff ff    ........??o?....
b0: b8 00 00 ff 10 90 30 01 20 41 ff ff 34 00 ff ff    ?...??0? A..4...
c0: 7f 00 00 4b 00 55 00 ff 7f 00 00 4b 00 50 00 ff    ?..K.U..?..K.P..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff 00 ff 00 01 00 ff ff 02 ff 00 00 11 ff 1d    .....?...?...?.?
antares /home/benni # i2cdump 1 0x2d
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x2d, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: b5 b8 ce cd cc c9 00 cd a7 f8 a5 ac 8c 68 54 f8    ??????.??????hT?
10: a5 f8 a5 ff 00 00 00 0c 50 4b 2d 50 4b 00 00 00    ???....?PK-PK...
20: 72 71 cd b6 ca ca ca 1e 43 ff ff 7f 54 7f 54 e3    rq??????C..?T?T?
30: b9 cd a7 ed 9d 00 00 00 00 50 4b c6 00 08 00 00    ?????....PK?.?..
40: 01 80 00 00 00 0c 00 44 00 42 01 40 00 50 80 06    ??...?.D.B?@.P??
50: ff ff 00 ff ff ff ff ff 31 8f 02 d5 ff 48 e2 1f    ........1???.H??
60: 71 71 cc b5 c9 c9 ca 1e 43 ff ff 7f 54 7f 54 e3    qq??????C..?T?T?
70: b9 cd a7 ed 9d 00 00 00 00 50 4b c6 00 08 00 00    ?????....PK?.?..
80: b6 b9 cd cd cb c9 00 cd a7 f8 a5 ac 8c 68 54 f8    ??????.??????hT?
90: a5 f8 a5 ff 00 00 00 0c 50 4b 2e 50 4b 00 00 00    ???....?PK.PK...
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
antares /home/benni # i2cdump 1 0x2b
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x2b, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: fe 71 71 00 00 00 00 00 08 40 84 ff ff ff ff ff    ?qq.....?@?.....
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
f0: 00 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10    .???????????????

-- 

Benjamin Judas

---------------------------------------------------------------------                                  
Gentoo-developer                        http://dev.gentoo.org/~beejay
Giessen, Germany                                http://www.gentoo.org

GPG-Key         : 0xC31DEDD8
Key-Fingerprint : 4E65 AAFE 785B 61D8 E4D9  1671 E017 87B7 C31D EDD8
Jabber          : beejay@im.gentoo.org


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041103/c5317588/attachment.bin
