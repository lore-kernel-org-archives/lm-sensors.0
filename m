From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Wed, 03 Oct 2007 11:38:41 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071003113841.GA9553@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 03 Oct 2007, Jean Delvare wrote:
> On Sun, 30 Sep 2007 11:54:29 -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 30 Sep 2007, Jean Delvare wrote:
> > > libsensors wouldn't cope with that anyway, so I'm glad you're not doing
> > > it. libsensors probes for available features at initialization time.
> > 
> > We better document that in the kernel docs, then.
> 
> Send a patch?

Will do, later.

> > interfaces are actually supposed to make those attributes come and go when
> > possible.
> 
> According to what standard?

I'd have to hunt it down. I'll see if I can find where I got that from.

> > > After that, the feature list doesn't change and applications can count
> > > on it not changing. Of course, applications can run sensors_init()
> > > again to get a fresher view of the hardware state, but this is pretty
> > > expensive and not something that we want applications to do every other
> > > second.
> > 
> > I've seen that cause endless problems in ACPI drivers (thinkpad-acpi has
> > this issue on some deprecated codepaths).  It is really something to avoid
> > if at all possible.
> 
> I don't understand you. What should be avoided exactly?

Stuff that will only work if the device is present at boot up/module
load/library init.

> > > > (...)
> > > > Drivers *do* often retry, if the hardware is busy.  But if they get a
> > > > signal, what should they do, then?  AFAIK at least for stuff like sysfs, one
> > > > is to return to userspace with EINTR to let userspace handle its signals,
> > > > and resubmit the request if it wants to.
> > > > 
> > > > My sources of EINTR in thinkpad-acpi are from mutex_lock_interruptible.
[...]
> > Because EINTR is something that is one-shot.  You get it when a signal is
> > delivered, and that's it.  Many syscalls can even be told to restart
> > themselves in case of an EINTR (but I don't know much about that, sorry).
> > 
> > Thinking a bit more about it, it looks to me like libsensors4 needs to be
> > able to pass EINTR down the chain, and must let its user (the application)
> > do the retries.  So, as you said, no retries within libsensors4... but we
> > need an extra status code for EINTR.
> 
> Why are you using mutex_lock_interruptible() rather than just
> mutex_lock() as all the other hwmon drivers do?

Because I don't want to get anything stuck in D state and not responding to
signals.  Apart from bugs in thinkpad-acpi or ACPI subsystem that could
cause weirdness, there is also the case where an application wants to use
timers and I see no reason to interfere with that.

It is extremely easy to do kernel-side, it looks like the safer and more
friendly-to-your-neighbours path, and userspace is supposed to be able to
deal with syscalls returning EINTR, so why not sysfs operations?  Or did I
get the whole idea incorrectly?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
