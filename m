From: david.knierim@gmail.com (David Knierim)
Date: Wed, 06 Jul 2005 17:40:59 +0000
Subject: [lm-sensors] LM93 PWM polarity bit "flips" state
Message-Id: <84ab3f2e05070514194eb61773@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <84ab3f2e05063007382e7e8f86@mail.gmail.com>
In-Reply-To: <84ab3f2e05063007382e7e8f86@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/1/05, Mark M. Hoffman <mhoffman@lightlink.com> wrote:
> Hi David:
> 
> * David Knierim <david.knierim@gmail.com> [2005-06-30 10:38:02 -0400]:
> > We have a bunch of servers based on the Intel 7520 chipset with
> > ESB6300 south bridge (which is capable of block transfers).   The
> > server uses an LM93 and an LM87 for sensors.
> >
> > The servers are all running the sernsors and i2c version 2.9.1.  The
> > OS is CentOS 3.4, which is basically Red Hat Enterprise Linux 3,
> > update 4.
> >
> > We have a diagnostic suite based on CTCS
> > (http://sourceforge.net/projects/va-ctcs/) with some additional tests
> > for sensors added.  One of these tests changes the PWM settings of the
> > LM93 and verifies that the fan speeds change.
> >
> > When running this test, occationally the PWM polarity bit "flips"
> > state.  Once this happens, the fans change speed, but not in the
> > direction that is intended.   If the test is run long enough, the
> > polarity bit that is wrong will usually flip back to the correct
> > value.  The changing of the polarity bit status seems to be random.
> > However, it does not seem to occur if the server is not heavily loaded
> > (or it takes much longer to occur).
> >
> > Changing the bit using i2cset works and will cause the test to work
> > correctly again.
> 
> Just to be clear: you're talking about bit 1 "INV" (0x02) of registers
> 0xc9 and 0xcd, yes?  Does it happen to both PWM channels?  At the same
> time?  Or separately and at random?

Yes, I am referring to those registers.   Your description of
"separately and at random" describes the behavior perfectly.

> 
> > The lm93 driver is loaded using the disable_block=1 option.  I can
> > retest using block mode if it is felt that this may help isolate the
> > issue.
> 
> Some time ago, the bug that was preventing block transfers from working
> was found and fixed (thanks to MDS).  So, it should be safe to use them
> now, but I doubt it will help the immediate problem.  Though, block
> transfers will make the driver more efficient w.r.t. SMBus usage.
> 
> > I am concerned that this issue is a symptopm of a larger problem.
> 
> Why?  Is there something else you noticed?

I haven't noticed anything specific.   I just get paranoid when bits
are changing in registers when they shouldn't be.   I have been having
ongoing issues with occational bad reads.   I suspect that a bad read
is at the root of this problem.

> 
> > This problem has been observed on at least 6 different servers, so
> > it's not just a hardware issue with a single server.
> >
> > I'm also unsure how to proceed.   Any suggestions??
> 
> Well, there's only one line in the whole driver that (purposefully) writes
> to those registers (line 1332 in CVS).  You could instrument that line with
> a printk to see if it ever does the wrong thing.

That makes sense.

> 
> Looking at it more closely, I don't think it's possible for the variable
> "ctl2" in the function lm93_pwm to have any of the least 4 bits set (during
> an operation = SENSORS_PROC_REAL_WRITE), unless they were already set in
> the hardware.
> 
> So maybe it would be good to also printk ctl2 following the statement at
> line 1313-1314, to see if you read CTL2 back with the INV bit set just
> before you write it for the first time.

I'd say we are on the same page here...
> 
> A more drastic option would be to add temporary "trace" printks to your
> SMBus driver or even to the I2C core itself, and then grep through the
> capture looking for a bad write (i.e. to 0xc9 or 0xcd with bit 1 set).
> You should then be able to correlate that to some part of the driver
> based on the context of the other reads/writes surrounding the bad one.
> 
> At one time, I was planning to write an i2c-trace module, that acted
> as a proxy between a client and real I2C bus driver, and which captured
> a trace of all the bus activity, without mucking about recompiling drivers.
> Haven't gotten to it though, sorry.
> 
> If you do add some printks and trace the SMBus activity that way, go ahead
> and post it and I'll have a look.

Thanks for the offer.  I'm not sure how much time I'll get to work on
this, so don't expect anything very quickly.

Thanks so much for your feedback.   It is very helpful.

David

> 
> Regards,
> 
> --
> Mark M. Hoffman
> mhoffman@lightlink.com
> 
>
