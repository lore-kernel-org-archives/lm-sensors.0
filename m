From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: i2c_force_data
Message-Id: <20041111012539.GB26899@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041109005252.GA26855@kroah.com>
In-Reply-To: <20041109005252.GA26855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 09, 2004 at 05:27:39PM +0100, Jean Delvare wrote:
> I'm not diving into the LKML archives today. I think I remember of
> threads about how to standardize the way devices are numbered and
> identified among the various bus types so that the hotplug stuff can be
> kept simple. I guess this is what you refer to. I were not aware that
> other busses had device id forcing requirements like we have for I2C
> though.

You can now add pci ids on the fly through sysfs, which causes drivers
to accept new devices from what they were originally compiled with.

We're extending that logic to say, "try to bind this driver to that
device" from userspace through sysfs, which should be sufficient to
replace this force logic, right?

> > Speed really isn't an issue, as device probing will soon be
> > multithreaded within the kernel.  It would just be a thread off doing
> > the probing while everything else happens like normal.
> 
> I'm more concerned about bus load. We have seen poor hardware
> implementations and messy BIOSes causing SMBus locks on high load. We
> don't want this to happen at boot time.

Hm, I'll have to think about this.  I really don't want a white/black
list of busses that this will work on, as if you look at the kernel code
today, we already scan all addresses for validity in i2c_detect() before
handing off to the chip driver (yeah, that's a bit different from
scanning all addresses, I agree, but conceptually it's the same.)

Wonder if we just sleep for a second or two between bus address probes,
if that will help out or not :)
	
> If I understand correctly, the information the kernel would transmit to
> hotplug would be "a client chip was found at I2C address (N, M)", and
> it would be left to the user-space to probe that address (sensors-detect
> like) and load the appropriate module?

Exactly.  Hm, it will really be even simpler, it will just be a "this
address was found" type hotplug event that today gets generated when we
add a chip device to the sysfs tree.  We will just be adding the devices
to sysfs _before_ binding them to a driver, which is the "proper" order
in which to do this (unlike today, where I cheated and did it the other
way around...)

> > I agree, I'll go slowly, and I know everyone here will be sure to tell
> > me when I get things wrong :)
> 
> True. Feel free to share your code and thoughts as you go, in case I
> could be of some help.

I will do that.  Looks like I'm signing myself up to rework the whole
locking model in the driver core to fix some of these issues first, so
it might be a while before I get back to i2c work :(

thanks,

greg k-h
