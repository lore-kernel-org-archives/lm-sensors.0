From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: 11-bit temperature problem
Message-Id: <20030812000544.71047b61.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

I'm in the process of writing a driver for the LM90 (we have at least
two users waiting for it). I am now facing a problem related to 11-bit
temperatures the LM90 handles for the remote temperature. The 11 bits
are splitted over two different bytes. This means that reading from
these two bytes in sequence could, in a few cases, read the high byte of
a conversion and the low byte of another conversion. This is bad and
unwanted. Other high precision chipsets (the LM75 comes to mind) don't
have the problem because you read a word, so it all happens in a single
operation and the above-mention case can't happen.

Here's what National Semiconductor say in the datasheet:

"When retrieving all 10 bits from a previous remote diode temperature
measurement, the master must insure that all 10 bits are from the same
temperature conversion. This may be achieved by using one-shot mode or
by setting the conversion rate and monitoring the busy bit so that no
conversion occurs in between reading the MSB and LSB of the last
temperature conversion."

To me, both proposed solution are bad. In the first case, you'll have to
wait for the full conversion each time you want to read the value. The
I2C bus is slow enough, the hell if we want to wait even more each time
we read a value. In the second case, I think it just doesn't work
because reading the busy bit isn't different from reading the second
temperature byte. Reading that the busy bit is set doesn't help us. What
will we do? Read the first byte again, then busy again, until the busy
bit isn't set? It is possible that the conversion occurs between us
reading the first byte and us reading the busy flag, so we don't see the
flag and read the second byte, although it doesn't match the fisrt byte.
Or I am missing obvious?

Is there another driver that has the same kind of probleme, so that I
can take a look at the proposed solution?

The solution I have come to is:

Read first byte, read second byte, read first byte again. If the new
first byte matches the old one, it's ok, we have our reading (most
cases). If not, read the second byte once again. If the conversion rate
is low enough (and I'll make sure it is) the second try should not fail.
The good point there is that we don't have to wait for any event nor
monitor any flag. The bad point is a 50 to 100% overhead. Still I
believe it's overall better than the other possibilities (if you can
call them that way).

Note that if we can't get to a solution everyone is happy with, I'll
plain *drop* support for the extra resolution registers. After all,
what's the point in a 0.125 degree resolution when the sensor has a +/-
3 degrees accuracy? I just don't get it. Who on earth wants to know it's
CPU temperature with a 0.125 degrees resolution anyway? And it makes the
driver *much* more complicated.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
