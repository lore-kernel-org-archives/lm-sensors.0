From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Fri, 28 Sep 2007 20:13:35 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070928201335.GA5301@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 28 Sep 2007, Jean Delvare wrote:
> > When you do, *please* make sure to rip out any ibm-acpi/thinkpad-acpi procfs
> > support from those applications.  I have *never* seen perfect ibm-acpi
> > procfs parsing code in my life, and I tried to track down every app that
> > could do it... most of it is either thruly hideous, or broken in minor ways.
> > 
> > I don't want to see any app ever touching the ibm-acpi/thinkpad-acpi procfs
> > interface again.  That interface is crap, and needs to die.  And most of the
> > userspace code talking to it is even worse crap.
> 
> The code may be ugly, however you can't ask people to drop support for
> the old interface to ibm-acpi/thinkpad-acpi now while the new interface
> is not even released. Your driver changes have not reached upstream yet,
> and when they do, only lm-sensors 3 (of which there is only a RC
> available for now) will support them, lm-sensors 2 doesn't. So you
> should expect user-space applications to keep their support for the old
> interface for some time, for compatibility reasons.

I am assuming that any distro that is going to change stuff for lm-sensors
3.0.0 ahead of upstream will also ship with lm-sensors 3.0.0 (so userland
support will be there), and a new enough kernel in their next stable
release.  If I am wrong, then yes, one should not remove old
ibm-acpi/thinkpad-acpi procfs support.

> libsensors4 returns -SENSORS_ERR_KERNEL ("Kernel interface error")
> if it can't read a value from a sysfs attribute file.
> -SENSORS_ERR_ACCESS_R ("Can't read") would probably be preferable. It
> doesn't read the actual error value returned by the underlying driver,
> so all errors are handled the same way. The application could probably
> check the value of errno to find out, but this is not documented, and
> mixing proprietary error codes with standard ones could be confusing.
> 
> Do you think that we should allocate new proprietary error codes for
> specific errors returned by the drivers on failed reads?

I think we should differentiate ENXIO (sensor is not there right now) from
EIO (real IO error).  We can tack missing sysfs attributes along with ENXIO
as they are about the same thing, I think.  I don't know about what should
be done on EBUSY and EINTR/EAGAIN.  Probably the lib should retry by itself
on EINTR/EAGAIN (if it doesn't do it already -- I didn't read the code), and
just return an error on EBUSY.

> Rejected writes are silently ignored. Not good. We should detect these
> and return some error code. I'll commit a fix for that.

Yeah, we definately need to know in userspace if a write fails, and often we
need to know why, too.  I can think of at least three classes of errors to
differentiate for userland: "not there (file not found and ENXIO)", IO
errors, and "permission denied" errors.  EINTR/EAGAIN should be handled by
the lib itself, I think.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
