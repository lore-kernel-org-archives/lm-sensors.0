From: ovis@thecourtofeden.org (ivo)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <Pine.LNX.4.58.0409031532160.1794@shi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Fri, 3 Sep 2004, Jean Delvare wrote:

> > i2cdump 0 0x2e
> > (...)
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 20: 74 6f bf c4 c0 2f 26 25 ab 09 ff ff ff ff df 23    to???/&%??....?#
> > 30: 4d 4d 4d 00 00 00 00 00 00 00 00 00 00 00 5c 68    MMM...........\h
> > 40: 05 83 01 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ???...........??
> > 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 02 22 22 7a    ????........?""z
> > 60: 80 80 e8 88 4d 4d 4d 38 2d 2d 45 41 41 24 40 00    ????MMM8--EAA$@.
> > 70: 4d 4d 4d 09 09 09 09 09 09 00 30 00 40 00 ec 18    MMM??????.0.@.??
> > 80: 1e a4 0e 00 00 76 c6 cf d1 00 40 40 09 09 0b 00    ???..v???.@@???.
> > 90: 04 04 04 04 0c 0c 0c 5a f1 00 00 00 23 00 00 00    ???????Z?...#...
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>
> Did sensors-detect pretend this was an ADM1027? It's not. I would think it's
> an SMSC EMC6D103. This is probably mostly compatible with the LM85 (or maybe
> even the brand new LM96000) and the earlier EMC6C10x. The lm85 driver should
> detect it as a "generic" LM85-compatible chip. This may be improved later by
> checking the datasheet and seeing what features the chip exactly has.

Confirmed  SMSC EMC6D103 !!!!

on a photo of the mobo on the web there was a
ADM1027

>
> --
> Jean Delvare
> http://khali.linux-fr.org/
>
>
