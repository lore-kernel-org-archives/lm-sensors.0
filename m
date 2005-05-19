From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: i2c_force_data
Message-Id: <20041109153124.GC27269@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041109005252.GA26855@kroah.com>
In-Reply-To: <20041109005252.GA26855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 09, 2004 at 10:11:57AM +0100, Jean Delvare wrote:
> 
> Hi Greg,
> 
> >Ick, does anyone still use i2c_force_data?
> 
> Yes, we do.

Ok, thanks for the descriptions.  But moving the structure out of the
i2c_address_data field shouldn't be a problem, as long as I retain the
original functionality, right?

Also, a lot of this will be done with sysfs, and not as module
paramaters, to make it more uniform accross bus types (see the various
odd threads on lkml about trying to unify the "add a device id" to a bus
type for more details.)

> >I'd really like to get rid of that structure (hint, it's the last thing
> >standing between the current code probe mess, and automatic chip driver
> >loading when adapters are loaded, like the pci and usb and ieee1394 and
> >pnp subsystems...)
> 
> Beware. Fully automatic detection of I2C clients is technically
> impossible.

Oh, I know this is not going to work for all people on all platforms.  I
will be careful :)

> If you are going to try ALL client drivers on all addresses,
> this will mean a LOT of register probings and some I2C clients really
> don't like this. This would basically mean running a
> sensors-detect-like process on each boot. See how slow and I2c-bus
> intensive it is?

Speed really isn't an issue, as device probing will soon be
multithreaded within the kernel.  It would just be a thread off doing
the probing while everything else happens like normal.

> You'll also notice that some chips are supported by
> more than just one driver (but with varying feature support levels), so
> the driver order will matter much (and possibly no order will be
> efficient enough for older chips). In most cases the sensors-detect
> script knows about that (it uses confidence levels, not booleans) but we
> don't want to move the whole sensors-detect code into kernel space, do
> we?

Heh, no.

All I want to do is have the address that chip drivers support be
exported to userspace throught the MODULE_DEVICE_ID interface.  Then, if
the user wants it, basically do the same thing as i2c-detect does
(testing all addresses for a valid answer).  If it looks like there is a
chip there, create a device, which creates a hotplug event, which lets
userspace look up what driver it wants to have loaded, if any.

The logic about detecting which driver for which device still remains in
userspace, where it belongs.

Although moving some of the sensors-detect logic into a hotplug script
might be useful in the end, but I'll worry about that when we get there.
I really just want the MODULE_DEVICE_ID() stuff done first.  More fun
can happen after that.

> BTW, I don't say that we shouldn't consider automating things at all.
> Just that we better be very careful and go by small steps, and accept
> the idea that it may not work all the time. 

I agree, I'll go slowly, and I know everyone here will be sure to tell
me when I get things wrong :)

> In particular, if we go that
> direction, I think we would start by listing which chips can safely be
> automatically detected and which do not, and only attempt to autoload
> safe drivers (or, more precisely, safe devices within a driver). As a
> rule of thumb, most recent chips are safe (they have chip ID and
> manufacturer ID at relatively standard locations), but older are not.

That would be great, do we have such a list anywhere already?

thanks,

greg k-h
