From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 30 Sep 2007 12:10:31 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070930141031.2d8714e5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Sat, 29 Sep 2007 21:56:18 -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 29 Sep 2007, Jean Delvare wrote:
> > > I think we should differentiate ENXIO (sensor is not there right now) from
> > > EIO (real IO error).
> > 
> > ENXIO should probably not be returned in the first place. Missing,
> > disabled or otherwise non-working sensors are reported through
> > fooN_fault files. When a fault is reported, user-space doesn't make use
> > of the (invalid or missing) input sensor value.
> 
> This is not what I was told in this list in the past,

Sorry about that. I remember you asking about this problem some times
ago, and indeed I forgot to mention the "fault flag" mechanism. Well,
back then, fooN_fault files did not exist as such, but at least I
should have mentioned the concept. I simply did not realize that your
problem wasn't something completely new. My bad.

>                                                       which is why I return
> ENXIO if one tries to access a hotplug thermal sensor in a thinkpad.  If the
> EC would notify me when sensors come and go, I could add/remove the
> attributes from sysfs and avoid the whole issue, but that's wishful
> thinking.

libsensors wouldn't cope with that anyway, so I'm glad you're not doing
it. libsensors probes for available features at initialization time.
After that, the feature list doesn't change and applications can count
on it not changing. Of course, applications can run sensors_init()
again to get a fresher view of the hardware state, but this is pretty
expensive and not something that we want applications to do every other
second.

I agree it would be nice to have some form of hotplug support in
libsensors, not just for features being added or removed, but primarily
for _devices_ being added or removed. But I didn't have the time to
think about it. It was hard enough (and long enough) to get lm-sensors
3.0.0 ready to be released, I just can't do more myself.

> (...)
> Retrying on EINTR is pretty much needed, AFAIK.  If the library doesn't do
> retries by itself, we must return a separate return code so that the library
> user can.  I have never heard of EINTR being anything but a very temporary
> condition, though.

I just don't understand when -EINTR is supposed to be returned, sorry.
I don't think we have any hardware monitoring driver returning this at
the moment, do we?

> (...)
> Drivers *do* often retry, if the hardware is busy.  But if they get a
> signal, what should they do, then?  AFAIK at least for stuff like sysfs, one
> is to return to userspace with EINTR to let userspace handle its signals,
> and resubmit the request if it wants to.
> 
> My sources of EINTR in thinkpad-acpi are from mutex_lock_interruptible.

I really need you to explain in details how and why EINTR is generated
and what we are supposed to do with it. I can't implement anything in
libsensors as long as I don't understand what we are dealing with.
Ideally, you would even be writing the libsensors patch, as you seem to
understand the needs much better than I do.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
