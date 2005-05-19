From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: 2.4.22 kernel patches available
Message-Id: <20030907182130.541bf643.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030831172730.775fb950.khali@linux-fr.org>
In-Reply-To: <20030831172730.775fb950.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I noticed that new I2C drivers exist there: i2c-sibyte (plus
> > i2c-algo-sibyte) and i2c-max1617. Why they end up there without us
> > even hearing about it is a complete mystery to me. The max1617
> > driver is crappy (polling + working only with the sibyte bus) and
> > completely useless since we already support that chip for years. The
> > bus driver probably should have been built into a single module. And
> > none of these modules will even compile since they use I2C IDs that
> > are not defined.
> > 
> > My 2.4.22 patch simply wipe them out. I can't understand how they
> > were accepted into the main kernel tree. I couldn't find anything
> > related to them in the kernel changelog nor in LKML archives.
> 
> These all came in from the merge with the MIPS maintainer.  Bitkeeper
> is nice :)

Oh, OK. Not used to bitkeeper yet (and no time for this now).

> > I feel like we should complain about that, but unfortunately I don't
> > have time for that right now. Greg, you have more contact with the
> > kernel people than any of us here, do you have any information we
> > don't have?
> 
> Why complain?  What is it hurting?  The cvs code sure isn't in the
> kernel tree so what do we have to base our complaint on?  :)

The I2C architecture as we know it has been defined some years ago,
IIRC. And the i2c subsystem is regularly updated from our CVS repository
AFAIK (although it has been some time since it was last done). People
needing I2C IDs should know they have to ask. People wanting to write
I2C drivers should read our docs and follow the guidelines. Or why are
we writing docs?

> So I'm guessing that some people with MIPS platforms actually use this
> driver.  Good for them.  I would not recommend that your patches "wipe
> them out" for that reason.

I wiped them out because they would not *compile* and I don't want
people to think that our patch is faulty, while it isn't. I think that
we should preserve the sibyte driver (and algo). But I want the
i2c-max1617 driver out, because we *do* have a driver for that chip for
a very long time, which respects the overall architecture, with procfs
and libsensors support. So we just don't need another, poor max1617
driver.

We'll have to define the required IDs for the sibyte driver and algo
(BTW, shouldn't the algo be included into the driver? Is it likely to be
reused?), since that's them missing that prevent the modules from
compiling.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
