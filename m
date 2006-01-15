From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 15 Jan 2006 16:50:15 +0000
Subject: [lm-sensors] [Asus A8NE-FM/S] Unknown Chip
Message-Id: <43CA7D47.3040800@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43CA1588.8060906@labri.fr>
In-Reply-To: <43CA1588.8060906@labri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've an Asus A8NE-FM/S mother-board running a kernel 2.6.15. I have some
> trouble to find the right hardware monitor chip in the list (the i2c-isa
> bus is recognized fine). Here are some informations:
> 
> I've build-in the i2c-dev, i2c-isa and i2c-nforce2 drivers in the
> kernel. I get two i2c busses (/dev/i2c-0 and /dev/i2c-1).

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: c1 60 c5 c4 c3 80 1f 29 76 10 ff ff ff ff ff ff    ?`?????)v?......
> 30: 39 ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 89    9.............\?
> 40: 05 90 40 00 00 ff 00 ff 00 ff 00 ff 00 ff 80 7f    ??@...........??
> 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 42 42 62 0b    ????........BBb?
> 60: cb 0b 60 b0 39 ff 80 5a 46 46 64 64 64 44 40 00    ??`?9.?ZFFdddD at .
> 70: 39 ff ff 09 09 09 09 09 09 00 00 00 40 00 ec 18    9..??????... at .??
> 80: 7e a4 0e 00 30 60 dd d3 20 00 4d 4d 0b 0b 0c 00    ~??.0`?? .MM???.
> 90: 04 04 04 04 0c 0c 0c 5a f1 c8 00 00 ff 00 ff 00    ???????Z??......
> a0: 00 00 0c 00 02 00 00 0b 0b fe ff fe ff ff ff ff    ..?.?..???.?....
> b0: ff 00 00 00 00 00 28 28 0e 0e 2b 2b 00 00 00 00    ......((??++....
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 

This looks like A8000 chip (and picture of the MB confirms it). We had already some issue with this chip.
(http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012777.html)
We cant support it because we dont have datasheet. At least we can get some values from
it via lm85 driver, just

modprobe the i2c-nforce2
modprobe lm85 force_lm85b=0,0x2e

And now you should see some values from sensors command. Some may be completly wrong but some should be OK.

I hope this helps,

regards
Rudolf


