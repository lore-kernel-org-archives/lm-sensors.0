From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: Super-IO
Message-Id: <20040229094305.202636c1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> khali,
> this worked fine for me on my vt1211 board.
> mds

Great.

Looks to me like the "code doesn't handle multiple devid regs yet"
comment is out-of-date and should be removed.

Also, why is the IT8705 entry disabled? A few fixes and it could work.
According to the docs I have, enter sequence is "0x87, 0x01, 0x55, 0x55"
(same as IT8712), and the exit sequence would be the same too, contrary
to what the comment suggests (the datasheet says "Set bit 1 (...) to 1"
which means writing 0x02, not 0x01, if I'm not mistaking.

BTW, why are we prepending "0x2e, 0xaa" to the IT87xx exit sequence?
Looks like some compatibility measure with Winbond chips, but since we
overwrite the value right after, I don't much see the point. Shouldn't
we instead *append* it to the exit sequence?

Actually I wonder if we shouldn't have two different exit sequences. One
if the chip has been detected, and one if the chip hasn't. The way
things are done for now, we'll always write a value to register 0x02
during the IT87xx detection, even if the detection failed so we know we
probably do *not* have an IT chip. It would sound safer to me to issue
the "usual" exit sequence in that case (which doesn't write to any
register). OK, things go a bit more complex if we want to handle both
the IT8712 and the IT8705 because a "failure between both (ie trying to
detect the 8712 and it actually is a 8705, or the contrary) would not
issue the correct exit sequence. However it seems less intrusive to not
reset a chip than to arbitrarily try to write to a register.

Comments welcome (I'm not quite used to Super-IO, although still much
more than two days ago ;))

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
