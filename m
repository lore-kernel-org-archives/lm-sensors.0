From: paul.aviles@palei.com (Paul Aviles)
Date: Tue, 08 Nov 2005 17:57:42 +0000
Subject: [lm-sensors] adm1027 on 2.6.9-5.EL
Message-Id: <20051108160731.M51375@palei.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <XVkq04oM.1131444138.7357880.khali@localhost>
In-Reply-To: <XVkq04oM.1131444138.7357880.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is my output i get.

# i2cdump 0 0x2e b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: c7 74 c5 c4 00 29 23 25 a1 02 6e 03 a0 02 00 00    ?t??.)#%??n???..
30: 40 40 40 64 64 64 00 00 00 00 00 00 00 27 41 6a    @@@ddd.......'Aj
40: 05 80 01 d3 be d2 6b 82 b6 ca b6 ca 00 ff 05 44    ??????k?????..?D
50: 05 28 05 32 65 04 96 09 65 04 ff ff 02 42 02 74    ?(?2e???e?..?B?t
60: c7 74 e0 00 40 40 40 3c 5a 28 42 64 2e 44 40 00    ?t?.@@@<Z(Bd.D@.
70: 00 00 00 00 00 00 7e 40 06 00 00 55 00 00 00 02    ......~@?..U...?
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
[root@andeya1 /]#



On Tue, 8 Nov 2005 16:11:06 +0100 (CET), Jean Delvare wrote
> Hi again Paul,
> 
> > > vid:      -3.425 V  (VRM Version 9.1)
> >
> > Wow. Not good. What value does /sys/bus/i2c/devices/0-002e/cpu0_vid
> > contain?
> 
> That and the missing +12V reading make me suspicious about the fact that
> you actually have an ADM1027 chip. I suspect that you actually have 
> an ADT7463 chip, misdetected (which is plausible when I look at the driver
> code in 2.6.9). Do you confirm this? If you do not know which chip 
> you do have, please provide the output of "i2cdump 0 0x2e b", this should
> answer my question.
> 
> According to the datasheet, the ADT7463 can use VRM 10 (i.e. 6-bit 
> VID values), while other chips in the family couldn't (5-bit VID 
> values). This is done by connecting VID5 to the +12V input, and 
> changing a configuration bit in the chip. This would explain the 
> lack of +12V reading. This also explains the bogus VID reading, as 
> the driver code didn't expect the new configuration bits in the VID 
register.
> 
> We'll need to update the lm85 driver to support that case.
> 
> Thanks,
> --
> Jean Delvare


--
Open WebMail Project (http://openwebmail.org)

