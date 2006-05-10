From: tandrews@grok.co.za (Thomas Andrews)
Date: Wed, 10 May 2006 18:36:26 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060510183626.GD30963@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Fri, May 05, 2006 at 10:39:50AM -0400, Jim Cromie wrote:

[...]

> Im looking for the right way to coordinate use of Super-IO control
> ports amongst the drivers that would use them.  While you and I dont
> actually compete for the same port (mines at 2E,2F), you clearly have
> a clue about these things, and could either; - provide me with one (if
> you see that I need it ;-) - add it into your thinking on your driver
> (so that its easy to fit in a port-lock-coordinator later) - tell me
> that Ive more or less thought of everything that seems relevant.  - or
> some combo of them..

I've had a look at the links you gave, and it made a lot of sense to me
because I've been worrying about collisions in usage of the SIO. I'm
pretty sure I can make good use of your module.

One thing that I must mention though, is that in order to discover the
actual SIO address, I have had to access other regions, and these are
not always the same; the actual address depends on a) the bootloader,
and b) how pins are strapped.

The long and short of this is that I will need to make use of your
locking mechanism on all of the addresses, not just on the SIO address.
Looking at your code, that doesn't seem to be a problem though. I only
need to lock 3 or 4 addresses briefly.

If my explanation is too vague, I'll send you my module, and you can
have a look to see how I do it, but it's not very readable unless you
have the sc1100 data-sheet close at hand. Just shout if you want to see
it.
 
[...]

> Im still on the hook for giving your code a compile, load, try.  I
> might need some guidance on the try part, I'll email on that if/when I
> do.

Thanks. But you could also hang on until I submit a more final version,
because I've drastically improved the discovery of the SIO address now,
plus got interrupt-driven mode working nicely.

> btw, wheres za ?

South Africa - Down at the very bottom in a town called Cape Town

Cheers,
Thomas

