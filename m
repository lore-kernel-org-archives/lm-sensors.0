From: mirage@kaotik.org (Tiago Sousa)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Ported lm80 to Linux 2.6
Message-Id: <Pine.LNX.4.58.0402192303050.23248@home.darksun.com.pt>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076403383.40289cb779c27@imp.gcu.info>
In-Reply-To: <1076403383.40289cb779c27@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 18 Feb 2004, Jean Delvare wrote:
> Now, there's a theory I would like to confirm, if you can provide one
> more dump. I'd like you to load i2c-isa and via686a. Then note the
> address of the via686a. If should be relatively high (such as 0x5800 or
> 0x6000). Then unload via686a and dump it using the following command:
> isadump -f 0x<address>

darksun:~# isadump -f 0x6000
  WARNING! Running this program can cause system crashes, data loss and worse!
  I will probe address range 0x6000 to 0x60ff.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
10: 00 00 00 ce e2 ff 26 85 00 00 00 00 00 c7 b7 81
20: d0 96 91 15 cf c2 c5 7f 7f 9d 00 d2 a8 e7 bd e4
30: ba de b5 dc b4 ff ff ff ff c7 b7 e1 e1 c7 b7 a2
40: 01 13 16 00 00 00 00 50 2d 85 00 40 00 00 00 00
50: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
60: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
70: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

> This should give you a dump similar to what i2cdump gave you so far.
> Please send it to me :)

Even my untrained eyes see the similarities. Seems you've hit jackpot. :)

> (BTW, your lm80 driver will be part of Linux 2.6.4, in case I didn't
> already told you! Congratulations.)

Great! As small a contribution as it is, it makes me happy to be able to
help the project.

--
Tiago Sousa
