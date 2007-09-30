From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Sun, 30 Sep 2007 00:56:18 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070930005618.GA3164@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 29 Sep 2007, Jean Delvare wrote:
> > I think we should differentiate ENXIO (sensor is not there right now) from
> > EIO (real IO error).
> 
> ENXIO should probably not be returned in the first place. Missing,
> disabled or otherwise non-working sensors are reported through
> fooN_fault files. When a fault is reported, user-space doesn't make use
> of the (invalid or missing) input sensor value.

This is not what I was told in this list in the past, which is why I return
ENXIO if one tries to access a hotplug thermal sensor in a thinkpad.  If the
EC would notify me when sensors come and go, I could add/remove the
attributes from sysfs and avoid the whole issue, but that's wishful
thinking.

I will look for the fooN_fault file docs, and implement that post haste,
then.

> >                       We can tack missing sysfs attributes along with ENXIO
> > as they are about the same thing, I think.
> 
> What "missing sysfs attributes"? libsensors gets the list of attributes
> from sysfs, it doesn't expect any file (except "name") to be there. So,
> unless files disappear afterwards, attributes can't be missing.

Sorry, what I meant is: some sensor that is exported in sysfs because it
*might* be in the hardware, and the driver can only tell if it is there or
not when it tries to access it (otherwise the driver would not have exported
the attribute to sysfs in the first place), and the sensor can come and go
at runtime without any sort of notification.

> No, libsensors doesn't retry on EBUSY and EINTR/EAGAIN (as I said it
> ignores the returned error code at the moment), and I don't think it
> should. For how long would it wait? How many times would it retry

Retrying on EINTR is pretty much needed, AFAIK.  If the library doesn't do
retries by itself, we must return a separate return code so that the library
user can.  I have never heard of EINTR being anything but a very temporary
condition, though.

EBUSY is something else.  That one can be quite permanent, so retrying on it
is best not done I suppose.

> before giving up? If we are going to hard-code a policy in libsensors,
> giving applications no control, then we might as well let the drivers
> handle the retries by themselves, at least they know how much they
> should wait between retries and when to give up depending on the
> hardware (some drivers do that already, e.g. w83l785ts.)

Drivers *do* often retry, if the hardware is busy.  But if they get a
signal, what should they do, then?  AFAIK at least for stuff like sysfs, one
is to return to userspace with EINTR to let userspace handle its signals,
and resubmit the request if it wants to.

My sources of EINTR in thinkpad-acpi are from mutex_lock_interruptible.

> Most monitoring applications are repeatedly polling the sensor values
> every few seconds anyway, so if one measurement is missing, it will
> probably be back on the next cycle. In other words, the retry mechanism
> is already in place there, at the application level. Reimplementing it
> in libsensors sounds wrong to me.

Even for EINTR?

> So, from the above, it seems that what we both agree on is that a
> separate error value for I/O errors would be needed. I'll work up a
> patch implementing this.

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
