From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: i2c-algo-bit timing
Message-Id: <3DE51498.C6898A12@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The last time I used a scope on the i2c bus (quite a while ago), I was
surprised to see that
the clock was not a 50/50 duty cycle. But that's what the code does.
I don't think it's correct, or at least it isn't optimal.

If I'm looking at your 2nd picture correctly, it looks like it
implements
a 50/50 duty cycle. That looks right to me.
I don't understand why there are udelays() in the sdalo() and sdahi()
functions.

I just recently added some comments to i2c-algo-bit.h about the units,
(I kept forgetting myself, and others would ask periodically too)
and made some fixes to the drivers to handle HZ != 100.

What the comment I added says, and it isn't strictly true,
is that clock rate = 500,000 / udelay. It does mean that
the minimum half-cycle time (either high _or_ low) is = udelay.

Chip datasheets generally specify maximum I2C clock rate.
They _dont_ specify minimums for clock low or clock high,
it is implied to be = 1 / (2 *  maximum rate).

We don't want to violate that. If udelay = 5, 
(which implies a 100 KHz clock) that should
be the minimum time high _or_ low for the clock.
So I don't think your third picture below should be implemented.

I agree that any latency assurance should be in the setsda() and
setscl() functions.
Earlier this year (after reading a great paper "How NOT to write kernel
drivers"
by Arjan van de Ven of Red Hat - it has an i2c example!), I added
PCI posted write flushes to our PCI algo-bit drivers
(i2c-hydra, -i810, -savage4, -voodoo3), in setsda() and setscl().
This isn't necessary for standard I/O ("ISA") drivers,
I/O writes can't be posted.

Maybe I could do some testing in December. I can probably get a 'scope .

mds


Kyosti Malkki wrote:
> 
> I have no scope around to check this, but looking into i2c-algo-bit.c,
> adap->udelay is used where it is not necessary. As an example, udelay=3
> would look roughly like 25/75 duty cycle:
> 
> SDA: -._________---._________---.------------.-
> SCL: _.___---______.___---______.___---______.-
>         ^     ^  ^   ^     ^  ^   ^     ^  ^
> 
> Dots just point out where sw goes for next bit, others 1 us wide each.
> That is, all bus transitions use adap->udelay, where a rise/fall delay
> of 1 us (or less) would do.
> 
> Removing the unnecessary 2us marked ^ _above_ :
> 
> SDA: -._____-._____-.------.-
> SCL: _._---__._---__._---__.-
>             ^ ^      ^    ^
> 
> When successive bits to put on bus are equal, SDA rise/fall may be
> omitted.
> 
> SDA: -._____.____-.-----.-
> SCL: _._---_.---__.---__.-
> 
> Interrupt service and PCI latency may add to the delay time.  Any
> decrease is not possible, if write-read sequence is used in
> setscl() and setsda(). Right ?
> 
> In the process I tested using nominal 1us delay everywhere, and
> i2c_adap->udelay only to clock bits in and out.  I believe it does not
> violate specs, but will likely fail with higher bus capacitance.
> This changes duty-cycle and might break some support, so I won't commit
> it now. It does improve the speed upto 333 kbps, using adap->udelay=1.
> 
> I have an unrelated patch for i2c-algo-bit just about ready to commit.
> 
> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi
