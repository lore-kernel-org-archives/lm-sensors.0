From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <1072175772.3fe81a9c32551@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Jean, here is something to start with. Tested to apply cleanly
> over 2.4.23 after your set of 4 patches.
> 
> Patch -km-1 :
> 
> Remove code for KERNEL_VERSION tests.

Great. This was on my TODO list. I think I'll tweak it a bit, to remove
version.h includes which aren't necessary anymore (I guess) and merge
empty lines where it applies. Also, this patch might conflict with the
one I wrote on posted to the list yesterday (which cleans modules
init/exit handling). But basically you got it, this is something I
wanted to send to Marcelo.

> Patch -km-2 :
> 
> This has .owner and .inc/dec_use for reference counting. Also, C99
> initializers and initcalls are imported from i2c CVS head.

What are initcalls.

> No new drivers, SMBus commands or driver ID's.

Good point.

> This is about 1/4 of changes needed to bring 2.4.24 in-sync with i2c
> 2.8.2.

Sure this is an important part, this is even the reason why all these
started.

But there's a problem. As discussed on the list the last few days, i2c
as of CVS head does not handle module reference counting correctly. So
we cannot possibly send this patch to Marcelo before this issue is
fixed. Since you seem to know how to fix it, please commit the
necessary changes to CVS head (I don't think it is a good idea to
branch the CVS, it's just not worth it). I do well understand that,
even with the fix, the reference counting will be broken, but at least
it won't be worse than in the previous implementation (that is, moving
into /proc/.../somechip/ increases the chip use count, but not the bus
use count). This is required before we can send any inc/dec-to-owner
patch to Marcelo.

> At least i2c-proc is not yet in sync with 2.8.0, so sensor chips
> will not build.

This was expected. They don't build either as of now anyway ;)

> I probably forgot some tiny parts elsewhere too but seems
> you were working on similar cleanups so maybe this is some
> assistance.

Your help is very appreciated, since there is much much work to do and
we are runnign out of time.

> We cannot get 200kB+ patches through anyway.

Yes, that's the idea (and I don't consider it a problem, since this
ensures that what we are sending is valid and doesn't bring any
regression into the kernel tree).

> I'll prepare some more patches today. Driver ID's, SMBus commands,
> and i2c-proc. The in-file revision tag $id has not been in sync with
> CVS files for ages and I plan to unexpand them with a separate
> patch.

IDs is an easy and independant patch, I should be able to go with it if
you don't.

New SMBus commands are not to be commited for now, if ever. They are
new
functionalities, I doubt Marcelo will want them into Linux 2.4.

The i2c-proc patches (and anything related to the core or spread over
all drivers) are what is more important, both because it might need to
be done before other minor changes, and because I don't understand it
too well, so that's where your help will be really precious.

Thanks a lot for providing assistance in backporting CVS to Linux 2.4.
Keep in mind that all changes have to be as sliced as possible if we
want them accepted.

I will be submitting a new wave of patches to Marcelo rather soon, which
should include (list is not definitive):
- init/exit cleanups (me)
- compatibility cleanups (you)
- velleman doc (me)
- algo debug stuff removal (me)

I'll let you know as soon as I'm working on other patches so that we can
merge our efforts efficiently.

Thanks again.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
