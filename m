From: ovis@thecourtofeden.org (ivo)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <Pine.LNX.4.58.0409031352170.3522@shi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 i2cdump 0 0x2e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x2e, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 74 6f bf c4 c0 2f 26 25 ab 09 ff ff ff ff df 23    to???/&%??....?#
30: 4d 4d 4d 00 00 00 00 00 00 00 00 00 00 00 5c 68    MMM...........\h
40: 05 83 01 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ???...........??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 02 22 22 7a    ????........?""z
60: 80 80 e8 88 4d 4d 4d 38 2d 2d 45 41 41 24 40 00    ????MMM8--EAA$@.
70: 4d 4d 4d 09 09 09 09 09 09 00 30 00 40 00 ec 18    MMM??????.0.@.??
80: 1e a4 0e 00 00 76 c6 cf d1 00 40 40 09 09 0b 00    ???..v???.@@???.
90: 04 04 04 04 0c 0c 0c 5a f1 00 00 00 23 00 00 00    ???????Z?...#...
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

 i2cdump 0 0x50
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-0, address 0x50, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 08 0e 0a 60 40 00 05 3d 50 00 82 08 00 00    ?????`@.?=P.??..
10: 0c 04 38 00 02 00 30 3d 50 50 60 3c 1e 3c 2d 80    ??8.?.0=PP`<?<-?
20: 25 38 10 23 3c 1e 1e 00 00 3c 69 80 1e 28 00 00    %8?#<??..<i??(..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 e1    ..............??
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 bb 00 00 00 00 00 00 00    ........?.......
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................


On Fri, 3 Sep 2004, Jean Delvare wrote:

> > > Does the eeprom driver works?
> >
> > it seems to load
>
> But does "sensors" then display the corresponding memory information?
>
> > > What does i2cdump on 0,0x2e or 0,0x50 returns?
> >
> > i2cdump 0,0x2e
> > Error: First argument not a number!
>
> My bad, the syntax is "i2cdump 0 0x2e" (i.e. space, not comma). "0,0x2e" was
> really only a way to refer to the chip, not what had to be typed on the
> command line. Sorry.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/
>
>
