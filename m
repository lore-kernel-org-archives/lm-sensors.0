From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Oct 2007 09:45:34 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071004114534.5d22031f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 3 Oct 2007 08:38:41 -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 03 Oct 2007, Jean Delvare wrote:
> > On Sun, 30 Sep 2007 11:54:29 -0300, Henrique de Moraes Holschuh wrote:
> > > On Sun, 30 Sep 2007, Jean Delvare wrote:
> > > > After that, the feature list doesn't change and applications can count
> > > > on it not changing. Of course, applications can run sensors_init()
> > > > again to get a fresher view of the hardware state, but this is pretty
> > > > expensive and not something that we want applications to do every other
> > > > second.
> > > 
> > > I've seen that cause endless problems in ACPI drivers (thinkpad-acpi has
> > > this issue on some deprecated codepaths).  It is really something to avoid
> > > if at all possible.
> > 
> > I don't understand you. What should be avoided exactly?
> 
> Stuff that will only work if the device is present at boot up/module
> load/library init.

Libsensors has worked that way for 9 years and nobody ever complained
about that particular point or even suggested that it could cause
problem or should be improved. As far as I can see, letting chips or
features go away after initialization time would require a major
redesign of the libsensors API. Such a redesign is not scheduled before
2015, and again I don't have the time for that anyway. Whoever wants
this to work, get to work on it by him/herself.

> > Why are you using mutex_lock_interruptible() rather than just
> > mutex_lock() as all the other hwmon drivers do?
> 
> Because I don't want to get anything stuck in D state and not responding to
> signals.  Apart from bugs in thinkpad-acpi or ACPI subsystem that could
> cause weirdness, there is also the case where an application wants to use
> timers and I see no reason to interfere with that.

Stuck in D state? I don't understand. Won't the signal simply be
delayed until the lock is released?

> It is extremely easy to do kernel-side, it looks like the safer and more
> friendly-to-your-neighbours path, and userspace is supposed to be able to
> deal with syscalls returning EINTR, so why not sysfs operations?  Or did I
> get the whole idea incorrectly?

I don't know. I was asking simply because this has never been a
problem in the past, so I was curious why your driver was different,
or, as it turns out, why applications would start doing things that
they seemingly weren't doing before. I guess that I won't understand
why all this complexity is needed until you can present a real-world
case where these events you describe really happen. For now, I will
just wait for you to send patches if you think they are needed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
