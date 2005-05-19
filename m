From: juanpedro@fibertel.com.ar (Juan Pedro Pereyra)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Constant beep and ALARM warnings on ALI1535
Message-Id: <200402021221.56436.juanpedro@fibertel.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401311948.50570.juanpedro@fibertel.com.ar>
In-Reply-To: <200401311948.50570.juanpedro@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

El Domingo, 1 de Febrero de 2004 13:30, escribi?:
> > Ok, but some indicators, like temp, seem to work pretty well and the
> > "i2c-ali1535" makes some sense provided that the k7ada uses an ALI
> > chipset.
>
> i2c-ali1535 is the bus driver and is obviously correct. lm78 is the chip
> driver and I still believe it's not correct.
>
> We already had two reports of Soyo k7ada users having problems with
> lm78. A little web search pointed me to an ALi M1647 chip for your
> board. We don't have support for this. If you can find a data sheet, we
> may be able to write a driver.

Ok, the people from ALI sent me one of those, it's the pdf attached.

>
> > athos:/dev# i2cdump 0 0x2c
> > Warning: no size specified (using byte-data access)
> > Error: Could not open file `/dev/i2c-0' : No such device
> > athos:/dev#
> >
> > <quote> `/dev/i2c-0' exists in filesystem </quote>
>
> You need i2c-ali1535 and i2c-dev loaded.

ok, here it is:
athos:~# i2cdump 0 0x2c
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2c, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff 04 00 ff 00 ff ff ff ff ff ff ff    .....?..........
20: cd b7 6b e6 ff ff ff 20 9f ff ff 00 00 00 00 83    ??k?... ?......?
30: 6a 00 80 ff ff ff ff ff ff 78 73 00 00 ff ff 01    j.?......xs....?
40: 01 00 ff 00 ff ff ff 53 2c 00 00 01 04 ff 1f 01    ?......S,..??.??
50: 73 78 ff 04 92 0f 88 00 00 ff 26 00 ff ff ff ff    sx.????...&.....
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff 04 00 ff 00 ff ff ff ff ff ff ff    .....?..........
a0: cd b7 6b e6 ff ff ff 20 9f ff ff 00 00 00 00 83    ??k?... ?......?
b0: 6a 00 80 ff ff ff ff ff ff 78 73 00 00 ff ff 01    j.?......xs....?
c0: 01 00 ff 00 ff ff ff 53 2c 00 00 01 04 ff 1f 01    ?......S,..??.??
d0: 73 78 ff 04 92 0f 88 00 00 ff 22 00 ff ff ff ff    sx.????...".....
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
athos:~#


-- 
Juan Pedro Pereyra <juanpedro@fibertel.com.ar>
Ciudad de Buenos Aires, Argentina
athos server @ athos.thesource.com.ar
Linux User #344472

