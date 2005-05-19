From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: i2c_force_data
Message-Id: <20041112001134.GD11301@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041109005252.GA26855@kroah.com>
In-Reply-To: <20041109005252.GA26855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 11, 2004 at 08:39:17AM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> > You can now add pci ids on the fly through sysfs, which causes drivers
> > to accept new devices from what they were originally compiled with.
> > 
> > We're extending that logic to say, "try to bind this driver to that
> > device" from userspace through sysfs, which should be sufficient to
> > replace this force logic, right?
> 
> So basically we would load the driver first, it wouldn't recognize the
> device at first, then we would write something to sysfs and the driver
> would attempt to recognize the device again, successfully this time?

Yes.

> This matches the "force" module parameter we have pretty well. However
> we also have e.g. force_w83782d, force_lm84 etc... which not only
> forcibly bind a driver to a device, but also invite the driver to handle
> that chip in a specific way. Will this be doable as well?

Yeah, I've been thinking about this too.  We might have to break those
types of drivers out into multiple "drivers" within sysfs.  Should be
easy to do, and will let sysfs work just fine.

> > > I'm more concerned about bus load. We have seen poor hardware
> > > implementations and messy BIOSes causing SMBus locks on high load.
> > > We don't want this to happen at boot time.
> > 
> > Hm, I'll have to think about this.  I really don't want a white/black
> > list of busses that this will work on, as if you look at the kernel
> > code today, we already scan all addresses for validity in i2c_detect()
> > before handing off to the chip driver (yeah, that's a bit different
> > from scanning all addresses, I agree, but conceptually it's the same.)
> 
> That's not quite what I was thinking about. My point was that
> sensors-detect will issue dozens of register reads for each responsive
> address, including several reads on the very same registers.

No, I'm talking about doing something like i2cdetect.c in the kernel to
just loop over all of the addresses on the bus and do a small "ping".
If we get a response back, create the sysfs device, and that causes
userspace to get the event and look up what driver to try to load for
that device.

Does that make more sense?

> > Wonder if we just sleep for a second or two between bus address
> > probes, if that will help out or not :)
> 
> You must be kidding, right?

I've seen worse workarounds in the past before :)

thanks,

greg k-h
