From: se.witt@gmx.net (Sebastian Witt)
Date: Fri, 10 Jun 2005 13:11:51 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <42A975D4.50105@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <429CEBC2.80609@hasw.net>
In-Reply-To: <429CEBC2.80609@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> 
> First, there is a big pending patch for it87 which updates the driver to
> make use of the new sysfs callbacks. I wouldn't want your patch to
> collide with this one, so I'd like you to build your patch on top of
> this one.
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012597.html
> 
> This will also have the advantage that you'll see how the new sysfs
> callbacks can be written, and this should hopefully make your code much
> more simple.

Ok, is this patch against 2.6.12-rc5? Because it fails to apply.

> Second, your interface doesn't quite comply with the standard automatic
> PWM interface as defined in Documentation/i2c/sysfs-interface. Please
> take a look. The interface basically defines trip points (PWM,
> temperature "coordinates"). You should come to something similar to what
> you have already by just renaming a few files, except for the slope/step
> concept which won't fit directly in, so I think you'll have to add some
> arithmetics (compute the slope from the requested trip point
> "coordinates", and vice-versa).

Yes, no problem.

> Third, the old datasheets for the IT8712F and IT8705F suggest that the
> first revisions of both chips had a different SmartGuardian
> implementation, trip-point based. If this is confirmed, then you will
> have to check the revision of the chip before enabling your interface.
> Which revision to you have yourself? I'll try to experiment on my
> IT8705F rev.2.

it87: Found IT8705F chip at 0x290, revision 3

> Can you provide a dump of your chip at startup (before loading the it87
> driver)?

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 13 00 ff 00 ff ff fd 00 00 00 3f 5b 00 48 ff ff
10: ff ff ff 30 00 00 00 00 00 ff ff ff ff ff ff ff
20: 44 a1 cb b6 b6 ba ca b3 ff 23 16 03 51 c1 c1 c1
30: ff ff ff ff ff ff ff ff ff fd ff ff ff ff ff ff
40: 3f 7f 3f 7f 3f 7f ff ff 2d ff ff ff ff ff ff ff
50: ff 2a 7f 7f 7f ff 5d 89 90 5d f9 12 80 00 00 00
60: 7f 7f 7f 00 00 ff ff ff 7f 7f 7f 00 00 ff ff ff
70: 7f 7f 7f 00 00 ff ff ff ff ff ff ff ff ff ff ff
80: 13 00 00 00 ff ff fd 00 00 00 3f 5b 00 48 ff ff
90: ff ff ff 30 00 00 00 00 00 ff ff ff ff ff ff ff
a0: 44 a1 cb b6 b6 ba ca b3 ff 23 16 03 51 c1 c1 c1
b0: ff ff ff ff ff ff ff ff ff fd ff ff ff ff ff ff
c0: 3f 7f 3f 7f 3f 7f ff ff 2d ff ff ff ff ff ff ff
d0: ff 2a 7f 7f 7f ff 5d 89 90 5d f9 12 80 00 00 00
e0: 7f 7f 7f 00 00 ff ff ff 7f 7f 7f 00 00 ff ff ff
f0: 7f 7f 7f 00 00 ff ff ff ff ff ff ff ff ff ff ff

Regards,
Sebastian

