From: whereami@gmail.com (David Sharp)
Date: Sun, 18 Sep 2005 04:25:12 +0000
Subject: [lm-sensors] read()ing an i2c node results in errno=ENOSYS
Message-Id: <b4e191e70509171923a7a0b59@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4e191e7050915035768c521ef@mail.gmail.com>
In-Reply-To: <b4e191e7050915035768c521ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > my amateur reading of the
> > > kernel source supports that this should work. However, a read call
> > > results in errno=ENOSYS (Function not implemented), although on one
> > > run, i actually got EPERM, and another time resulted in SEGV.
> >
> > ENOSYS is expected. You are trying to do raw I2C transfers while the bus
> > driver (i2c-viapro) and underlying chip only offer SMBus transfers (that
> > is, a subset of I2C.) It fails.
> >
> > I'm more concerned about EPERM and SEGV, which obviously shouldn't
> > happen. Hard to say why this happens without the actual code though.
> 
> well, the SEGV i couldn't repeat, and disappeared during the time it
> took to compile gdb to try to debug it. Actually, the EPERM may have
> happened more than once, but i can't reproduce it any more. It may
> have something to do with the module loading and unloading i was doing
> in vain attempts to get it to work. I'll definitely let you know if i
> get them again, and can get more info. I suspect they may have been
> caused by bus glitches, however. Shady programming on the
> microcontrollers, maybe. We are busy now implementing some proper
> SMBus on the microcontrollers anyway.

We've now implemented simple SMBus on our microcontrollers, and it is
mostly working. block writes work perfectly, but we are having a small
problem with block reads on the PC side. It seems from the register
dumps in the kernel logs that the first byte is going to the DAT0
register instead of into the BLK, so in userspace, it appears like the
first byte is lost. (DAT1 remains 00, though). As far as we can tell,
the data on the bus is correct, but our oscilloscope is nice and old,
making it impossible to see the whole transaction.

The EPERMs reappeared as we were working, but disappeared when we
started doing things correctly on the bus. They were probably actually
a Good Thing, better than getting garbage or something more fatal, so
I don't think you should worry about it.
