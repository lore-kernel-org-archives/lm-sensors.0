From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 Sep 2007 13:39:19 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070929153919.0f522233@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 28 Sep 2007 17:13:35 -0300, Henrique de Moraes Holschuh wrote:
> I am assuming that any distro that is going to change stuff for lm-sensors
> 3.0.0 ahead of upstream will also ship with lm-sensors 3.0.0 (so userland
> support will be there), and a new enough kernel in their next stable
> release.  If I am wrong, then yes, one should not remove old
> ibm-acpi/thinkpad-acpi procfs support.

Your assumptions are about right, however the added support for
lm-sensors 3.0.0 will be sent upstream quickly, while a patch removing
support for the old interface can't be sent upstream, so distributions
would have to maintain it forever. My experience is that
distributions avoid that kind of patch and extra work as much as
possible, especially when this doesn't add significant value (the extra
code is simply unused).

> > libsensors4 returns -SENSORS_ERR_KERNEL ("Kernel interface error")
> > if it can't read a value from a sysfs attribute file.
> > -SENSORS_ERR_ACCESS_R ("Can't read") would probably be preferable. It
> > doesn't read the actual error value returned by the underlying driver,
> > so all errors are handled the same way. The application could probably
> > check the value of errno to find out, but this is not documented, and
> > mixing proprietary error codes with standard ones could be confusing.
> > 
> > Do you think that we should allocate new proprietary error codes for
> > specific errors returned by the drivers on failed reads?
> 
> I think we should differentiate ENXIO (sensor is not there right now) from
> EIO (real IO error).

ENXIO should probably not be returned in the first place. Missing,
disabled or otherwise non-working sensors are reported through
fooN_fault files. When a fault is reported, user-space doesn't make use
of the (invalid or missing) input sensor value.

>                       We can tack missing sysfs attributes along with ENXIO
> as they are about the same thing, I think.

What "missing sysfs attributes"? libsensors gets the list of attributes
from sysfs, it doesn't expect any file (except "name") to be there. So,
unless files disappear afterwards, attributes can't be missing.

>                                             I don't know about what should
> be done on EBUSY and EINTR/EAGAIN.  Probably the lib should retry by itself
> on EINTR/EAGAIN (if it doesn't do it already -- I didn't read the code), and
> just return an error on EBUSY.

No, libsensors doesn't retry on EBUSY and EINTR/EAGAIN (as I said it
ignores the returned error code at the moment), and I don't think it
should. For how long would it wait? How many times would it retry
before giving up? If we are going to hard-code a policy in libsensors,
giving applications no control, then we might as well let the drivers
handle the retries by themselves, at least they know how much they
should wait between retries and when to give up depending on the
hardware (some drivers do that already, e.g. w83l785ts.)

Most monitoring applications are repeatedly polling the sensor values
every few seconds anyway, so if one measurement is missing, it will
probably be back on the next cycle. In other words, the retry mechanism
is already in place there, at the application level. Reimplementing it
in libsensors sounds wrong to me.

> > Rejected writes are silently ignored. Not good. We should detect these
> > and return some error code. I'll commit a fix for that.
> 
> Yeah, we definately need to know in userspace if a write fails, and often we
> need to know why, too.  I can think of at least three classes of errors to
> differentiate for userland: "not there (file not found and ENXIO)", IO
> errors, and "permission denied" errors.  EINTR/EAGAIN should be handled by
> the lib itself, I think.

I've committed my fix now. Permission denied is notified by
-SENSORS_ERR_KERNEL, other errors (including invalid value and I/O
error) are notified by -SENSORS_ERR_ACCESS_W. File not there is
unlikely (as explained above) and would be handled as a permission
problem.

So, from the above, it seems that what we both agree on is that a
separate error value for I/O errors would be needed. I'll work up a
patch implementing this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
