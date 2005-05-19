From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <200407011545.i61FjT8h007427@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>The register is a word on both chips, but
>whereas lm75 stores the temperature from d14 to d8, lm77 does this from
>d10 to d3:
>
>      d15 d14 d13 d12 d11 d10 d9 d8   d7  d6 d5 d4 d3 d2 d1 d0
>lm75  msb b7  b6  b5  b4  b3  b2 b1   lsb x  x  x  x  x  x  x
>lm77  sgn sgn sgn sgn msb b7  b6 b5   b4  b3 b2 b1 b0 x  x  x
>
>where b1 is bit1, x is unused/used for other purposes.

OK, that explains your strange values.

BTW, d15 on lm75 is sign as well. And what's the point in lm77's having
4 bit for sign? If that means that all 4 bits will always be the same,
that's something we can use for identification.

>The LM77
>has support for a T_high and T_low, but I'm not sure if anyone would
>need that.

Well, why not. We have other chips doing this, it perfectly fits in our
interface.

>Maybe we could check for the existence T_high and T_low registers?

We cannot. LM75 chips will not answer with an error if you try to read
these registers. It will return a value, just that this value isn't
relevant. I cannot remember exactly what it returns... Possible the
value of register 0x03.

What we may use OTOH are:
* unused bits in config register if they differ;
* unused bits in temperature registers; they differ, and it should be
sufficent since it's VERY unlikely that ALL 4 low bits of all
temperature values are 0 on a LM77 (while the same bits will read 0 on a
LM75). That should be a good thing to start with;
* try to learn what the LM75 would return for T_high and T_low;

Do we have a dump of a LM75 chip? I think I remember Mark Hoffman has
access to such a chip. Hopefully, LM75 compatible chips such as the DS75
and DS1775 will behave likewise.

>That's right, I'm not interested in user-space tools and can live
>without having it in the stock kernel if it turns out that noone needs
>it. However these embedded boards seem to be pretty popular nowadays
>(see eg. http://www.pcengines.ch for a vendor) and they have quite
>complete support in the kernel apart from this one little thing...

Apart from the fact that you are not interested, will you have the
possibility to test things like sensors-detect (perl script) or i2cdump
on the box?

Thanks,
Jean Delvare
