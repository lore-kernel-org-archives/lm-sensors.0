From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Sun, 30 Sep 2007 14:54:29 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070930145429.GA16963@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 30 Sep 2007, Jean Delvare wrote:
> libsensors wouldn't cope with that anyway, so I'm glad you're not doing
> it. libsensors probes for available features at initialization time.

We better document that in the kernel docs, then.  Because AFAIK sysfs
interfaces are actually supposed to make those attributes come and go when
possible.

> After that, the feature list doesn't change and applications can count
> on it not changing. Of course, applications can run sensors_init()
> again to get a fresher view of the hardware state, but this is pretty
> expensive and not something that we want applications to do every other
> second.

I've seen that cause endless problems in ACPI drivers (thinkpad-acpi has
this issue on some deprecated codepaths).  It is really something to avoid
if at all possible.

> I agree it would be nice to have some form of hotplug support in
> libsensors, not just for features being added or removed, but primarily
> for _devices_ being added or removed. But I didn't have the time to
> think about it. It was hard enough (and long enough) to get lm-sensors
> 3.0.0 ready to be released, I just can't do more myself.

Fair enough.

> > Retrying on EINTR is pretty much needed, AFAIK.  If the library doesn't do
> > retries by itself, we must return a separate return code so that the library
> > user can.  I have never heard of EINTR being anything but a very temporary
> > condition, though.
> 
> I just don't understand when -EINTR is supposed to be returned, sorry.
> I don't think we have any hardware monitoring driver returning this at
> the moment, do we?

I know of thinkpad-acpi, but I didn't search for others.

> > (...)
> > Drivers *do* often retry, if the hardware is busy.  But if they get a
> > signal, what should they do, then?  AFAIK at least for stuff like sysfs, one
> > is to return to userspace with EINTR to let userspace handle its signals,
> > and resubmit the request if it wants to.
> > 
> > My sources of EINTR in thinkpad-acpi are from mutex_lock_interruptible.
> 
> I really need you to explain in details how and why EINTR is generated
> and what we are supposed to do with it. I can't implement anything in
> libsensors as long as I don't understand what we are dealing with.
> Ideally, you would even be writing the libsensors patch, as you seem to
> understand the needs much better than I do.

I am not completely sure I do understand EINTR, mind you.  But here's a
typical path in thinkpad-acpi that can return EINTR as per the
mutex_lock_interruptible documentation:

static ssize_t hotkey_mask_show(struct device *dev,
                           struct device_attribute *attr,
                           char *buf)
{
        int res;

        res = mutex_lock_interruptible(&hotkey_mutex);
        if (res < 0)
                return res;
        res = hotkey_mask_get();
        mutex_unlock(&hotkey_mutex);

        return (res)?
                res : snprintf(buf, PAGE_SIZE, "0x%08x\n", hotkey_mask);
}

It may return -EINTR from mutex_lock_interruptible, or -EIO from
hotkey_mask_get (a function internal to thinkpad-acpi).

AFAIK, all cases I have seen for EINTR on the kernel allow one to do
something like this in userspace:

rc = -EINTR;
while (rc = -EINTR) {
	(check if any of our signal handlers have signalled that a signal
         was receivied, e.g. sigterm)
	(kernel operation that can return EINTR);
}

Because EINTR is something that is one-shot.  You get it when a signal is
delivered, and that's it.  Many syscalls can even be told to restart
themselves in case of an EINTR (but I don't know much about that, sorry).

Thinking a bit more about it, it looks to me like libsensors4 needs to be
able to pass EINTR down the chain, and must let its user (the application)
do the retries.  So, as you said, no retries within libsensors4... but we
need an extra status code for EINTR.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
