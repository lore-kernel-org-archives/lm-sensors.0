From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <20031220122718.34b59835.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> For kernel 2.2 : MOD_INC/DEC_USE_COUNT and necessary callbacks in the
> i2c structs. I _think_ there was some race condition of calling rmmod
> to release the module and another process half-way to MOD_INC_COUNT.

I read about that.

> For kernel 2.4 : Replace MOD_INC_COUNT with try_inc_mod_count(),
> this may fail if the module in question is about to be removed from
> kernel. The callback in i2c_adapter and i2c_driver is void
> (*inc_use)() so the choice of exporting .owner=THIS_MODULE to i2c-core
> as was already done in 2.5 tree seemed like the correct choice. This
> is the essential question whether the cleanup is just an api change or
> a real bugfix.

This is an API change, that replaces a small bug (the race condition)
with a big one (module reference counting is plain dead broken, as you
and I underline below).

I can't see any call to with try_inc_mod_count() in our sources. Is it
supposed to be automatically called as soon as you use the
.owner=THIS_MODULE trick?

> A problem I see there is procfs allowing only one module reference per
> opened file. In terms of i2c architecture, we need to hold both
> adapter and driver modules in place. Currently neither is done and I
> think it will oops if you enter a directory under
> /proc/sys/dev/sensors and rmmod either of the two hw interface
> modules.

Yes, I could oops the kernel doing so. Went to the
proc/dev/sys/sensors/somechip directory, removed the chip driver, the
directory was still there and empty. Moved away, removed the bus driver,
moved back to the proc/.../somechip directory, *oops*.

As a comparison, doing the same with the older module count method (i2c
and lm_sensors 2.7.0), removing the chip module while standing in its
directory wouldn't be possible. OTOH, removing the bus driver module
would be possible, resulting in the proc/.../somechip going empty but
not being deleted of course. Moving out of the proc tree would let me
remove the chip driver. There must be a bug somewhere though since
i2c-proc now has a refcount of 1 instead of 0 so that I can't remove it
anymore. But at least there is no oops.

So the new code can be seen as a regression when compared with the old
one, and I won't possibly send this to Marcelo until it is fixed.

> The fill_inode from days of 2.2.x does not seem either.

What do you mean?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
