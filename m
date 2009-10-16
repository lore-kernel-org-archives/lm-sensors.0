From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Oct 2009 19:58:42 +0000
Subject: Re: [lm-sensors] lm-sensors 3.1.1-3 not detecting sensors on Intel
Message-Id: <20091016215842.4573e816@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0910131743530.5034@p34.internal.lan>
	<alpine.DEB.2.00.0910140403150.15961@p34.internal.lan>
	<alpine.DEB.2.00.0910140856190.19307@p34.internal.lan>
	<20091015100557.22243433@hyperion.delvare>
	<alpine.DEB.2.00.0910150422400.21030@p34.internal.lan>
	<20091016111504.5d9cb0ba@hyperion.delvare>
	<alpine.DEB.2.00.0910160553221.2841@p34.internal.lan>
	<20091016125353.1c8795f4@hyperion.delvare>
	<alpine.DEB.2.00.0910160838500.31450@p34.internal.lan>
	<20091016204155.377fe67d@hyperion.delvare>
In-Reply-To: <20091016204155.377fe67d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 16 Oct 2009 20:41:55 +0200, Jean Delvare wrote:
> On Fri, 16 Oct 2009 09:40:51 -0400 (EDT), Justin Piszcz wrote:
> > Ok, luckily it does not appear to have caused any issues:
> > 
> > # i2cdump 0 0x2c b
> > WARNING! This program can confuse your I2C bus, cause data loss and worse!
> > I will probe file /dev/i2c-0, address 0x2c, mode byte
> > Continue? [Y/n] y
> >       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 10: 00 00 00 00 00 00 00 00 00 00 80 80 80 04 7e 10    ..........????~?
> > 20: 75 51 c0 c3 c3 80 28 2d bd 0f de 0f 3b 1d a9 16    uQ????(-????;???
> > 30: 33 4d 4d c2 81 00 c2 00 ff ff ff e6 7b fb 41 6f    3MM??.?....?{?Ao
> > 40: 35 90 40 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    5?@...........??
> > 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 0a a2 a2 ca    ????........????
> > 60: 8a 8a e0 aa 33 4c 4c 5a 2d 2d 64 41 41 04 42 00    ????3LLZ--dAA?B.
> > 70: 00 00 00 00 00 00 6c 60 f0 00 00 55 01 00 00 00    ......l`?..U?...
> > 80: 00 00 00 00 00 00 ff ff 00 00 fb 64 64 64 00 00    ..........?ddd..
> > 90: 00 59 59 59 00 00 00 00 00 00 00 00 00 00 00 00    .YYY............
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > #
> 
> Smells like an Analog Devices chip, but not one we know... And I can't
> see it on the web site you mentioned. Please search for a small-size
> chip named ADTxxxx (more likely ADT74xx).

Ah, ADT7490. Please try:

http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

We don't have support for that chip, but the datasheet suggests some
form of compatibility with the ADT7473 and ADT7475, which we do have
support for. So support for the ADT7490 is probably not too far away.

The presence of this monitoring ASIC explains why the hardware
monitoring features of the W83677HG super-I/O are disabled.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
