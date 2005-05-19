From: derek@totalphase.com (Derek Fung)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: Donation of an I2C host adapter to lm_sensors
Message-Id: <1095440355.2037.45.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1095095083.3132.28.camel@localhost.localdomain>
In-Reply-To: <1095095083.3132.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

This is a very interesting use-case for the Aardvark adapter. 
Unfortunately, we would not be able to directly support development of
this, but here are some thoughts:

1) aardvark.so is very complex and cannot easily be ported into kernel
space.

2) We are unable to release the source code to aardvark.so for IP
reasons.

3) But here is an idea for how the Aardvark adapter can be used from
kernel mode:

- Create a /usr/src/linux/drivers/i2c/i2c-aardvark.c kernel module

- The driver will register a /dev/i2c-aardvark0, /dev/i2c-aardvark1, ...

- Write a user mode program (i.e. 'aardvarkd') that opens the
/dev/i2c-aardvark[0-9] for read/write

- The user mode program blocks on read, takes simple I2C commands from
the device file, and writes results back

- The kernel driver (i2c-aardvark) performs the appropriate wait queuing
to communicate through the /dev/i2c-aardvark[0-9] with the user mode
program (aardvarkd).

This way, the kernel driver is very simple, the user mode program is
easy to debug, and it can be kept up to date with the latest Aardvark
software releases.  The user mode program can even be written to comply
with one of the standard I2C controller protocols to make it easier to
write the kernel driver.  Also, any connection issues with the Aardvark
adapter will not cause kernel panics, since the communication is handled
in user mode.

In the end, I don't know how helpful our product really is to lm_sensors
since we cannot support the development on this project.  If you are
still interested in receiving the hardware, please let us know.

Best Regards,
-Derek

On Thu, 2004-09-16 at 20:07, Mark Studebaker wrote:
> My assumption (which I didn't state in my email, sorry),
> was that the aardvark would be most useful to us if we wrote a kernel "bus" driver for it,
> so that it appeared as a native i2c bus to the system.
> 
> Then, we could attach chips to the aardvark, 
> which would enable us to write and debug standard "chip" kernel drivers
> for those chips. This would be quite useful (to us and your customers, perhaps?).
> To do that we would probably need to talk directly to the usb device
> and would need the information to be able to do that.
> 
> Working through the userspace API may still be of some value but would
> be much less attractive. Agreed that the bus monitor may also be helpful.
> Would you be willing to provide the information required to write a kernel driver?
> 
> thanks
> mds
> 
> 
> 
> Derek Fung wrote:
> > Hi Mark,
> > 
> > Sorry for the confusion.  We don't expect the Aardvark I2C/SPI Host
> > Adapter to be incorporated into lm_sensors at all.  As you correctly
> > point out, that would not be wise.  We just thought that our adapter
> > would make a good debug tool, especially with the I2C bus monitor
> > capabilities.  
> > 
> > If you are still interested, let me know.  We'd be happy to send you an
> > Aardvark adapter and a split cable to help you hook it up to a
> > motherboard.
> > 
> > Best Regards,
> > -Derek
> > 
> > 
> > 
> > On Thu, 2004-09-16 at 16:54, Mark Studebaker wrote:
> > 
> >>thanks for the offer.
> >>I briefly reviewed the information about the product on your website.
> >>It is a USB device, correct?
> >>
> >>We'd like to know more about the software work required.
> >>Must an i2c driver talk to the device through the "aardvark dll"
> >>or will it work directly with the USB device?
> >>Will the source for the DLL, or the API, be available and GPL'ed?
> >>
> >>All our drivers are kernel modules. I'm not sure it's feasible or wise
> >>to try and interface to a binary userspace library from a kernel driver.
> >>In fact I'm sure it isn't.
> >>
> >>If you could describe or sketch the SW and the interfaces, and what
> >>software you'll be providing to us, and what you have in mind, 
> >>we'll then like to discuss further how best to get involved.
> >>
> >>thanks
> >>mds
> >>
> >>
> >>
> >>Derek Fung wrote:
> >>
> >>>Hi everyone on lm_sensors,
> >>>
> >>>My company, Total Phase, would like to make a donation to your cause.
> >>>We make the Aardvark I2C/SPI Host Adapter.  It is one of the few
> >>>fully cross-platform I2C host adapters on the market for Linux.  
> >>>
> >>>I know that lm_sensors is geared primarily to access I2C-based
> >>>sensors that are already on motherboards and not the development of
> >>>de novo systems.  But, we are sure that a Linux compatible I2C host
> >>>adapter can help developers hack their hardware and see what's going
> >>>on under the hood.
> >>>
> >>>We have just released a version 3.00 of our product.  Some of the
> >>>features that you guys might be interested in are:
> >>>- I2C Bus Monitor
> >>>- Rosetta Language Bindings for C/C++ and Python 
> >>>- Batch Scripting Capabilities in the GUI
> >>>
> >>>Please let us know where we can send this adapter.  If you guys find
> >>>it useful, we would appreciate a mention or a link on your website.
> >>>
> >>>Looking forward to hearing from you.
> >>>
> >>>Best Regards,
> >>>Derek
> >>>
-- 
Derek Fung 
Total Phase, Inc. 
http://www.totalphase.com/
