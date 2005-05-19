From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <Pine.LNX.4.53.0312201543320.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 20 Dec 2003, Jean Delvare wrote:

> This is an API change, that replaces a small bug (the race condition)
> with a big one (module reference counting is plain dead broken, as you
> and I underline below).

These are two independent issues.

Seems i2c-proc, i2c_register_entry is "fixed,debugged,fixed,merged and
still broken". The .owner is a direct replacement of passing
controlling_mod (THIS_MODULE from chip driver).

> I can't see any call to with try_inc_mod_count() in our sources. Is it
> supposed to be automatically called as soon as you use the
> .owner=THIS_MODULE trick?

When you open a file in procfs, yes. For some time, I have not reviewed
video4linux, or other i2c drivers. They really should call
i2c_use/release_client before referencing the client structure or
using the client->driver->command() method for inter-module calls.

> > A problem I see there is procfs allowing only one module reference per
> > opened file. In terms of i2c architecture, we need to hold both
> > adapter and driver modules in place. Currently neither is done and I
> > think it will oops if you enter a directory under
> > /proc/sys/dev/sensors and rmmod either of the two hw interface
> > modules.
>
> Yes, I could oops the kernel doing so. Went to the
> proc/dev/sys/sensors/somechip directory, removed the chip driver, the
> directory was still there and empty. Moved away, removed the bus driver,
> moved back to the proc/.../somechip directory, *oops*.
>
> As a comparison, doing the same with the older module count method (i2c
> and lm_sensors 2.7.0), removing the chip module while standing in its
> directory wouldn't be possible. OTOH, removing the bus driver module
> would be possible, resulting in the proc/.../somechip going empty but
> not being deleted of course. Moving out of the proc tree would let me
> remove the chip driver. There must be a bug somewhere though since
> i2c-proc now has a refcount of 1 instead of 0 so that I can't remove it
> anymore. But at least there is no oops.

Strange that you found any difference, in either case it will call
unregister_sysctl_table with a busy table. Somewhere deep in procfs
this fails, but we go ahead and free the table anyway in
i2c_deregister_entry.

Solution: Prevent chip detach while sysctl table is busy, means
reference counting both the bus and the chip modules. This needs an API
change on the user side: Move ... sensors/somechip-0-2d to
sensors/bus-0/somechip-2d. That way bus module is referenced on the
path.

> > The fill_inode from days of 2.2.x does not seem either.
>
> What do you mean?

Does not seem _correct_ either. A call to i2c_fill_inode increments only
i2c-proc module reference. It was already counted as soon as you entered
/proc/sys/dev/sensors/.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
