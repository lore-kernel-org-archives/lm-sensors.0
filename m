From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: 11-bit temperature problem
Message-Id: <20030814043418.GA15093@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030812000544.71047b61.khali@linux-fr.org>
In-Reply-To: <20030812000544.71047b61.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-08-14 00:14:45 +0200]:
> * Mark M. Hoffman <mhoffman@lightlink.com>:
> > 
> > 10kHz smbus speed (conservative - spec'ed minimum according to
> > datasheet) 40 bits per read (smbus write + smbus read incl.
> > start/stop/ack bits) 22 registers to read (conservative - probably
> > need only 15)

<snip>

> Two remarks. First, when you say "10kHz smbus speed, conservative", I
> don't quite agree. To me, the conservative value is the highest possible
> bus speed. This is where the one-shot conversion will increase the
> overall time more (relatively). So, let's consider a bus speed of
> 100kHz. How do you come to 40 bits? I count 29 (3 9-bit bytes, plus 1

According to the datasheet timing diagrams on p 11...

(a) is i2c_smbus_write_byte_data() ~29 bits
(b) is i2c_smbus_write_byte() ~20 bits
(c) is i2c_smbus_read_byte() ~20 bits

I.e. i2c_smbus_read_byte_data() is not supported by this chip, so you
need to use (b) + (c) to read a register.

And I say ~40 instead of exactly 40 because there are limits to how close
one can stack transactions (the bus driver/hw should take care of that).

> start and 1 stop). There are 17 registers we want to update (3 volatile,
> 14 non-volatile). So the update time would be 4.93ms (4.06 non-volatile,
> 0.87 volatile). Now we can consider that 31.25 extra ms for the
> conversion is something significant, isn't it?
> 
> Of course you can object my reasonment is pointless, and I agree ;) We

Indeed. ;)

> don't really care what takes time as long as the overall operation fits
> in a reasonable amount of time. But I don't like the idea much, while I
> would have if the conversion time was less than the non-volatile
> registers update.
> 
> BTW is there a way we can know at what frequency the bus really works?

The simplest correct answer is "no".

A more useful answer is "look at the bus datasheet".

But this is actually not a simple topic at all.  Even if you know the
nominal bus speed, the protocol allows for the master or slaves to
"stretch" any single bit-time to arbitrary lengths (in theory).  Of course
in practice a master or slave will not wait forever; the amount of time
they *will* wait is published.  E.g. 10kHz minimum for LM90 implies
that the master better not stretch a bit-time longer than 100uS.

If I managed to get you interested about what's "on the wire", look here:
http://www.semiconductors.philips.com/buses/i2c/

> Anyway, my main objection against one-shot mode is the hardware
> protection. The LM90 is supposed to have its ALERT output wired to the
> SMBus master, and its T_CRIT_A output wired to shutdown control. It is
> obviously meant for hardware temperature regulation and overtemperature
> shutdown. If we configure the LM90 in one-shot mode, it means that the
> status registers will only be updated when someone asks the driver to
> update. What if a user loads the driver and never use it? (I do that all
> the time.) Then the hardware protections will be disabled. I don't want
> to be held responsible for that!

You're right - I withdraw my suggestion.

> > > The solution I have come to is:
> > > 
> > > Read first byte, read second byte, read first byte again. If the new
> > > first byte matches the old one, it's ok, we have our reading (most
> > > cases). If not, read the second byte once again. If the conversion
> > > rate is low enough (and I'll make sure it is) the second try should
> > > not fail. The good point there is that we don't have to wait for any
> > > event nor monitor any flag. The bad point is a 50 to 100% overhead.
> > > Still I believe it's overall better than the other possibilities (if
> > > you can call them that way).
> 
> Any objection to that? I expect this to make me read 18 (or 19)
> registers instead of 17, this ain't much of an overhead it seems.

Looks good then.

<snip>

> Thanks a lot for helping me think about all the possible solutions :)

You're welcome; regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
