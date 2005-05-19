From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: 2.6 - sysfs sensor nameing inconsistency
Message-Id: <20030922222910.GA306@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307152214.38825.arvidjaar@mail.ru> <200308192319.01895.arvidjaar@mail.ru> <20030819194533.GA5738@kroah.com> <200308312025.41472.arvidjaar@mail.ru>
In-Reply-To: <200308312025.41472.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Sun, Aug 31, 2003 at 08:25:41PM +0400, Andrey Borzenkov wrote:
> On Tuesday 19 August 2003 23:45, Greg KH wrote:
> > That's what you are going to have to set the name file to in the
> > i2c_client structure, much like your patch did.  Then look at the
> > different name files in each device directory to see what kind of device
> > it is (chip, subclient, etc.)
> >
> 
> OK attached patch sets all names to just chip name for chips themselves and 
> "chipname subclient" when subclient ios registered.

Thanks, I've applied this and will send it off to Linus in a bit.


> > > 3. libsensors asks for hysteresis value. This one does not exist in sysfs
> > > (so all temp readings fail). Is it emulated by kernel or read off chip?
> >
> > The kernel is exporting all of the info that it knows about through
> > sysfs.
> 
> it just arbitrarily (re-)names them. "min" is not hysteresis; name is badly 
> chosen.

Do you have a proposed change to the current
Documentation/i2c/sysfs-interface document?  If you can think of better
names that make more sense, I'd be glad to change things to make it
easier.

> [...]
> > > 4. I do not have the slightest idea how ISA adapters look like in sysfs
> > > and where they are located. Anyone can give me example?
> >
> > They show up on the legacy bus:
> >
> > $ tree /sys/class/i2c-adapter/i2c-1/
> > /sys/class/i2c-adapter/i2c-1/
> >
> > |-- device -> ../../../devices/legacy/i2c-1
> >
> 
> This does not help much. Libsensors expects as adapter identification either 
> "i2c-N" or "isa". If I set it to "isa" I do not have any way to determine 
> sysfs path except by rescanning /sys/class/i2c-adapter every time. Having 
> /sys/class/i2-adapter/isa/... would be better, apparently it is assumed that 
> only one such adapter can exist.

No, we internally do not differentiate between isa and non-isa adapters,
so why should we force that on the user?  They work the same as far as
users notice, and now we are consistant in our naming.

thanks,

greg k-h
