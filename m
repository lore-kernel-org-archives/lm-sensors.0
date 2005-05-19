From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: Question:Re: [patch] 2.5.25 I2C driver id and Config updates boundar
Message-Id: <3D30458F.9399689A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In my opinion all three numbers (udelay, mdelay{not used?], timeout)
should be
absolute times, not related to jiffies.
I guess it's supposed to be 10 ms units for timeout.
udelay is obviously the half-clock time (i2c clock freq = 1,000,000 / (2
* udelay))

Whatever the answer is, we should put it as a comment in i2c-algo-bit.h.
We do periodically get asked what the units for the 3 vaules are.

Most drivers have timeout = 100. That's 1 second. That's forever,
as you have found out if you ever probed a stuck bus.

As Dori Eldar points out (see my mail from a couple of weeks ago,
or TODO in i2c), i2c has no minimum frequency but smbus has
a min. frequency of 10 kHz. There's no way to enforce that in
i2c-algo-bit today. It would be nice to have some way to
tell i2c-algo-bit to enforce SMBus timing rules.
What mechanism could be used to set a timeout
of 100 microsec?


Albert Cranford wrote:
> 
> Thanks for review.  I'll pass your questions on to the
> group to clarify/answer.
> 
> The current I2C CVS tree looks like:
> if (start+adap->timeout <= jiffies) {
>         return -ETIMEDOUT;
> }
> but I think I was told not to submit the change since
> Linus's tree was correct.
> if (time_after_eq(jiffies, start+adap->timeout)) {
>         return -ETIMEDOUT;
> }
> Albert
> 
> Petr Vandrovec wrote:
> >
> > On 11 Jul 02 at 1:26, Albert Cranford wrote:
> > > Hello Linus,
> > > Could you please apply these 3 patches toward 2.5.26.
> > > They include Config.in updates, additions in i2c-id.h
> > > for "Video for Linux" and a compatibility fix for
> > > i2c-algo-bit.c
> >
> > Hi,
> >   is timeout field in i2c_algo_bit_data supposed to be in jiffies
> > (like it is currently used) or in 10ms units? If it is supposed
> > to be in jiffies (other algos do not care about timeout field),
> > there is dozen of places (all callers of i2c_bit_add_bus) which
> > get it wrong.
> >
> >   Next suspicious thing is that 'timeout' field from i2c_adapter
> > structure is not used at all - only i2c_control is willing to
> > set it, but nobody reads this field. Should not i2c_bit_add_bus
> > copy its timeout into this field, and then use adap->timeout instead
> > of bitadap->timeout in its sclhi() procedure?
> >                                         Thanks,
> >                                                 Petr Vandrovec
> >                                                 vandrove@vc.cvut.cz
> >
> 
> --
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net
