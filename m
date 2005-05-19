From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <Pine.LNX.4.53.0312211401170.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
> > Solution: Prevent chip detach while sysctl table is busy, means
> > reference counting both the bus and the chip modules. This needs an
> > API change on the user side: Move ... sensors/somechip-0-2d to
> > sensors/bus-0/somechip-2d. That way bus module is referenced on the
> > path.
>
> Do you seriously think we should do that? This sounds like a very big
> change for a near-end-of-life kernel tree. OK, I think I understand this
> would be the only way to have references handled correctly. But for now
> we don't handle them at all. What about handling chip drivers counts
> correctly and forget about bus drivers counts? That's the way things
> were done with the old method (up to i2c 2.7.0) so I would feel less
> uncomfortable sending such a patch to Marcelo, since there would be no
> regression anymore, and still the race condition fixed.

Let's start by fixing the chip count.

> Ky?sti, what would it take to restore correct module reference counting
> on chip drivers? Does it require to update only i2c-core and i2c-proc,
> or would we have to update all drivers? Please help me with this. This
> is required in order to have any serious patch sent to Marcelo, and
> you're the one of us all understanding all these things at best, it
> seems.

If we only get .owner in adapter and driver structure, I can keep the
changes within i2c-core and i2c-proc. Did you have a collection of
video4linux drivers, with i2c dependency, easily available ?
Seems i2c drivers in kernel tree 2.4.23 drivers/media/video handle
reference counting internally; They get reference as soon as the
client is attached to adapter. One has to rmmod bus before chip.

> > Does not seem _correct_ either. A call to i2c_fill_inode increments
> > only i2c-proc module reference. It was already counted as soon as you
> > entered /proc/sys/dev/sensors/.
>
> Is it something that should be fixed, or that already was, or neither?

Kernel 2.2 stuff. I was mistaken, there is i2c_fill_inode and
i2c_dir_fill_inode and the latter does handle chip reference, but not
the adapter. Ironically, for kernels 2.2 it would be easy to fix.


I will prepare a set of incremental patches from the CVS with minimal
changes, with compatible API. Binary compatibility not maintained.


-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
