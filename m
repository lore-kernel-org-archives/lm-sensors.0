From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <20031221103126.3347b6a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > This is an API change, that replaces a small bug (the race
> > condition) with a big one (module reference counting is plain dead
> > broken, as you and I underline below).
> 
> These are two independent issues.

I don't think you call label them as independant. They are different,
but related issues. The problem is that I cannot send a patch to Marcelo
that fixes a small bug and adds a big one. That the two bugs are
"independant" doesn't matter.

> For some time, I have not reviewed video4linux, or other i2c drivers.
> They really should call i2c_use/release_client before referencing the
> client structure or using the client->driver->command() method for
> inter-module calls.

Other i2c drivers (in Linux 2.4 world) still use the i2c interface as of
2.6.1. This is precisely why the recent structure change is causing so
much trouble.

We'd better have our own drivers handle references correctly before ever
thinking of merging the change into Linux 2.4 and fixing all other i2c
drivers.

> Strange that you found any difference, in either case it will call
> unregister_sysctl_table with a busy table. Somewhere deep in procfs
> this fails, but we go ahead and free the table anyway in
> i2c_deregister_entry.
> 
> Solution: Prevent chip detach while sysctl table is busy, means
> reference counting both the bus and the chip modules. This needs an
> API change on the user side: Move ... sensors/somechip-0-2d to
> sensors/bus-0/somechip-2d. That way bus module is referenced on the
> path.

Do you seriously think we should do that? This sounds like a very big
change for a near-end-of-life kernel tree. OK, I think I understand this
would be the only way to have references handled correctly. But for now
we don't handle them at all. What about handling chip drivers counts
correctly and forget about bus drivers counts? That's the way things
were done with the old method (up to i2c 2.7.0) so I would feel less
uncomfortable sending such a patch to Marcelo, since there would be no
regression anymore, and still the race condition fixed.

Also, I confirm that I would possibly obtain a segfault using 2.7.0 if I
remove a bus driver while in some /proc/.../somechip directory, move
elsewhere, remove the chip driver and come back. I guess this was
expected.

Ky?sti, what would it take to restore correct module reference counting
on chip drivers? Does it require to update only i2c-core and i2c-proc,
or would we have to update all drivers? Please help me with this. This
is required in order to have any serious patch sent to Marcelo, and
you're the one of us all understanding all these things at best, it
seems.

> Does not seem _correct_ either. A call to i2c_fill_inode increments
> only i2c-proc module reference. It was already counted as soon as you
> entered /proc/sys/dev/sensors/.

Is it something that should be fixed, or that already was, or neither?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
