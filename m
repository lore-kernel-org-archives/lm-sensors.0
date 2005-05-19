From: arvidjaar@mail.ru (Andrey Borzenkov)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: 2.6 - sysfs sensor nameing inconsistency
Message-Id: <200311022150.48638.arvidjaar@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307152214.38825.arvidjaar@mail.ru> <200308312025.41472.arvidjaar@mail.ru> <20030922222910.GA306@kroah.com>
In-Reply-To: <20030922222910.GA306@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tuesday 23 September 2003 02:29, Greg KH wrote:
>
> Thanks, I've applied this and will send it off to Linus in a bit.
>

thank you.

> > it just arbitrarily (re-)names them. "min" is not hysteresis; name is
> > badly chosen.
>
> Do you have a proposed change to the current
> Documentation/i2c/sysfs-interface document?  If you can think of better
> names that make more sense, I'd be glad to change things to make it
> easier.
>

it is probably too late now to change sysfs names when some programs already 
use it. I'll check sysfs-interface, thank you for pointer.

> > > > 4. I do not have the slightest idea how ISA adapters look like in
> > > > sysfs and where they are located. Anyone can give me example?
> > >
> > > They show up on the legacy bus:
> > >
> > > $ tree /sys/class/i2c-adapter/i2c-1/
> > > /sys/class/i2c-adapter/i2c-1/
> > >
> > > |-- device -> ../../../devices/legacy/i2c-1
> >
> > This does not help much. Libsensors expects as adapter identification
> > either "i2c-N" or "isa". If I set it to "isa" I do not have any way to
> > determine sysfs path except by rescanning /sys/class/i2c-adapter every
> > time. Having /sys/class/i2-adapter/isa/... would be better, apparently it
> > is assumed that only one such adapter can exist.
>
> No, we internally do not differentiate between isa and non-isa adapters,
> so why should we force that on the user?  They work the same as far as
> users notice, and now we are consistant in our naming.
>

Well, I just tried to match what users get out of libsensors on 2.4. The 
reason was compatibility with /etc/sensors.conf where "isa" can possibly be 
used as part of chip name. But I'd like that someone from sensors developers 
comment on this.

thank you for your comments.

-andrey
