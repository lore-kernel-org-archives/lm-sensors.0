From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: [PATCH] 1/4 WIP I2C kernel patches-config
Message-Id: <20020522220050.GA6269@opus.bloom.county>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE20AD5.5554A03@bellsouth.net>
In-Reply-To: <3CE20AD5.5554A03@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 22, 2002 at 05:47:56PM -0400, Mark Studebaker wrote:

> - Should it go into drivers/i2c or into arch/... ?

drivers/i2c/

> - Do we need resolve the license with the people listed at the top of the
>   files,
>   there is no GPL boilerplate at the top of the 8xx.[ch] ?

Add the GPL boilerplate.  Missing due to laziness.

> - As far as we know the rest works under 2.5, of course they haven't all
    been tested.
>   If you _know_ it doesn't work under 2.5 (I think that's what you said) then
>   shouldn't it be fixed first?

It, being MPC8xx support in general, doesn't work due to the 2.5.5'ish
VM changes (and the MPC8xx has hw-assisted tlb management so it's going
to require some thought to fix) and then some PPC-specific exception
handling cleanups, and I'm sure the latest round of TLB fixes need some
thought at least.  But the i2c code was known to be working when
submitted and should still be working.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
