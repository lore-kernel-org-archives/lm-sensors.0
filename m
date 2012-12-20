From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Dec 2012 11:48:20 +0000
Subject: Re: [lm-sensors] [PATCH v2] linux/kernel.h: Fix DIV_ROUND_CLOSEST with unsigned divisors
Message-Id: <20121220124820.0069aa66@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355928015-26212-1-git-send-email-linux@roeck-us.net>
	<20121219232115.727a2e91@endymion.delvare>
	<20121219230144.GB26863@roeck-us.net>
In-Reply-To: <20121219230144.GB26863@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, Juergen Beisert <jbe@pengutronix.de>

On Wed, 19 Dec 2012 15:01:44 -0800, Guenter Roeck wrote:
> On Wed, Dec 19, 2012 at 11:21:15PM +0100, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Wed, 19 Dec 2012 06:40:15 -0800, Guenter Roeck wrote:
> > > Commit 263a523 fixes a warning seen with W=1 due to change in
> > > DIV_ROUND_CLOSEST. Unfortunately, the C compiler converts divide operations
> > > with unsigned divisors to unsigned, even if the dividend is signed and
> > > negative (for example, -10 / 5U = 858993457). The C standard says "If one
> > > operand has unsigned int type, the other operand is converted to unsigned
> > > int", so the compiler is not to blame.
> > 
> > This is surprising to say the least. But if the C standard says so...
>
> Agreed, but it is how it is.
> 
> > I wouldn't be surprised if there are bugs because of this in the kernel
> > and in other projects.
>
> Might easily be. This might make a good interview question - I suspect many
> if not most engineers would fail it. At least I would have until yesterday :).

Neither did I. And I'm not sure I'll remember it in one year from now.

> > (...)
> > Thinking a bit more about this... Documenting the non-working cases is
> > great, however I don't really expect all developers to pay attention. I
> > can also imagine variable types changing from signed to unsigned later,
> > and never thinking this can introduce a bug.
> > 
> > So, is there nothing we can do to spot at least the second issue at
> > build time? For regular division there's nothing we can do (although I
> > don't understand why gcc doesn't warn...) but here we get the
> > opportunity to report the issue, let's take it.
> > 
> > And given that the divisor is almost always a constant,
> > maybe we can check for negative divisors too, this would be safer and
> > the code size increase would probably be very small in practice.
> > Opinions?
>
> Agreed, though we should fix the problem now and think about reporting
> afterwards.

Yes, that's a good plan.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
