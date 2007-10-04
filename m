From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Thu, 04 Oct 2007 12:49:30 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071004124930.GB27275@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 04 Oct 2007, Jean Delvare wrote:
> > Stuff that will only work if the device is present at boot up/module
> > load/library init.
> 
> Libsensors has worked that way for 9 years and nobody ever complained
> about that particular point or even suggested that it could cause

Fair enough.  We just document it and go ahead.  If we ever meet something
that *really* needs it, we reconsider.

> > > Why are you using mutex_lock_interruptible() rather than just
> > > mutex_lock() as all the other hwmon drivers do?
> > 
> > Because I don't want to get anything stuck in D state and not responding to
> > signals.  Apart from bugs in thinkpad-acpi or ACPI subsystem that could
> > cause weirdness, there is also the case where an application wants to use
> > timers and I see no reason to interfere with that.
> 
> Stuck in D state? I don't understand. Won't the signal simply be
> delayed until the lock is released?

The point is, what if the lock is NOT released (for a long time/at all)?
There would be no need for mutex_lock_interruptible to exist if that was not
an issue.  The real question is, could this happen in thinkpad-acpi or other
hwmon chip drivers?

Of course, locks not being released are the sign of huge bugs on most of
hwmon that do operations that are bounded and fast in the first place, but
for complex drivers that call into the ACPI interpretor, that is not so
clear.

There is also the (probably quite minor) issue of latency.  While I can't
protect the full path properly (ACPI doesn't return the equivalent to EINTR,
so I end up doing what libsensors do if it gets an EINTR: it becomes an IO
error, and what the appplication gets in the end is an IO error, which it
won't retry), at least it means that most concurrent access to the sensors
interface in thinkpad-acpi will be protected against huge delays caused by
the ACPI serialization from letting signals get delivered.

By using mutex_lock_interruptible I just don't have to worry at all about
all those problems, as signals will not be too delayed because of my code.
Other code might do it, but that's outside my control.

So far I have looked at mutex_lock as something to use only when you cannot
use mutex_lock_interruptible (e.g. you have no way to return an error to
userspace at that stage).

Note that this is in part based on the fact that open/read/write operations
DO return EINTR, which glibc passes along back to the caller, so anything in
userspace that calls them in generic files/pipes/devices/sockets already has
to handle it (this is not the case of libsensors, of course -- libsensors
only talks to hwmon).

> > It is extremely easy to do kernel-side, it looks like the safer and more
> > friendly-to-your-neighbours path, and userspace is supposed to be able to
> > deal with syscalls returning EINTR, so why not sysfs operations?  Or did I
> > get the whole idea incorrectly?
> 
> I don't know. I was asking simply because this has never been a
> problem in the past, so I was curious why your driver was different,
> or, as it turns out, why applications would start doing things that
> they seemingly weren't doing before. I guess that I won't understand
> why all this complexity is needed until you can present a real-world
> case where these events you describe really happen. For now, I will
> just wait for you to send patches if you think they are needed.

I'd send the patches, yes.  But so far, I could not make heads-and-tails of
the libsensors code.  I am studying it.  I will have more time after the
merge window for 2.6.24 closes.

As for proving to you that this complexity is needed, well, I don't have any
latency-sensitive loads here, nor do I play with real-time audio.  But I
will be sure to tell you if I meet an easily reproducible scenario involving
libsensors.  I *know* first hand of such scenarios when dealing, e.g., with
/dev/hwrandom, which stalls for long times on slow hardware rngs.  But even
ACPI EC access is not supposed to stall for that long unless it is broken...

And I am certainly not advocating that other drivers go around doing
mutex_lock_interruptible if they know they don't need it.  I'd just like
libsensors4 to allow drivers who do want to, to be able to return EINTR.

One hwmon driver which is *slow* like all heck, at least the last time I
tried it about two years ago, is the sensors driver for IPMI BMCs.  That one
might have a better case for returning EINTR...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
