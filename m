From: david-b@pacbell.net (david-b@pacbell.net)
Date: Wed, 29 Jun 2005 03:21:55 +0000
Subject: [lm-sensors] Re: [PATCH] I2C: add i2c driver for TPS6501x
Message-Id: <20050629012048.63127C8944@blackbox.site>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050623231242.0be0c244.khali@linux-fr.org>
In-Reply-To: <20050623231242.0be0c244.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> There is a pending cleanup patch for this driver. It was posted by David
> on the lm-sensors mailing list on May 27th:
>   http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012409.html
> Greg, Can you please add this patch to your i2c tree?

I'll post a refreshed version with a signed-off-by-yours-truly line.
It may even have a bugfix for H3 boards, TBD ... :)

That same thread also has an I2C doc patch I sent, which hasn't yet
been merged.  (No point in telling folk to use the ID fields, they
aren't normallly necessary and aren't described enough to be usable.)


> Note that I am not entierly happy with this driver even after the patch
> is applied. It tries to load several times when the initial attempt
> fails. That's ugly and inefficient. The retries should be done on failed
> bus reads,

It's not clear that'd work.  It seems like a hardware startup glitch specific
to the H2 board, but nobody's had a lot of luck chasing down a better fix than
the one you don't like.  I'm told H2 boards are now available enough that some
Universities are going to have them ... maybe we can plant a bug in some
students' ears that will lead to a better software-only fix!


>	rather than reloading the driver entirely on each error, so
> that as few actions as possible are retried. Or the bus driver could be
> improved to deal with errors at a lower level.
>
> David, could you please work on a patch implementing either solution?

When I have some time I'll take another poke at the problem.  
No promises ... that is after all the best known fix.

On the other hand, it's been pointed out offline that the OMAP I2C bus
driver hasn't been submitted yet, so maybe a look at that will turn up
key issues.  It's a more traditional I2C bus driver ... not an atypical
I2C chip driver that needs to use IRQs and (in lieu of that pending async
I2C API!) workqueues, exporting an API that's more at the level of ACPI
power management internals than anything else.  :)

- Dave



