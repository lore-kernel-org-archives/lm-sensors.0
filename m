From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: [PATCH] 1/4 WIP I2C kernel patches-config
Message-Id: <3CEC120C.601FDF28@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE20AD5.5554A03@bellsouth.net>
In-Reply-To: <3CE20AD5.5554A03@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

- Should it go into drivers/i2c or into arch/... ?
- Do we need resolve the license with the people listed at the top of the files,
  there is no GPL boilerplate at the top of the 8xx.[ch] ?
- As far as we know the rest works under 2.5, of course they haven't all been tested.
  If you _know_ it doesn't work under 2.5 (I think that's what you said) then
  shouldn't it be fixed first?


Tom Rini wrote:
> 
> On Wed, May 22, 2002 at 05:33:01PM -0400, Mark Studebaker wrote:
> 
> > If it doesn't work in 2.5 we shouldn't include it in a 2.5 patch.
> 
> Yes, but it will be working at somepoint in 2.5.  Unless someone has
> gone and re-tested all of these under 2.5 (which isn't a bad idea
> really...) the 8xx drivers should be in the same state as the rest of
> the group.
> 
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
