From: david-b@pacbell.net (David Brownell)
Date: Thu, 26 May 2005 22:57:35 +0000
Subject: [lm-sensors] Re: [patch 2.6.12-rc3+] i2c driver for TPS6501x
Message-Id: <200505261356.38186.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505051618.34980.david-b@pacbell.net>
In-Reply-To: <200505051618.34980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 26 May 2005 12:15 pm, Rudolf Marek wrote:
> 
> Sorry not this way. The driver is too complicated for me and Jean.

Complicated?  Heh!  What's complicated about it?  It's common
for drivers to use IRQs and workqueues, and expose APIs to other
drivers.  Not for "sensors" drivers, true; most of them don't
expose APIs to other parts of the system (except by sysfs).

From an I2C list I'd expect feedback about I2C issues more than
about how it relates to system booting and power management.

Or maybe about how much simpler such drivers can be when I2C
finally gets an async message based API ... though this is not
one of the drivers that'd _really_ benefit from that, IMO.  ;)


> Others seems to be more busy these days so nobody who could
> be qualified for review responded.

Well, the folk working various boards that rely on this driver
to boot haven't been complaining.  In fact they've found it
straightforward to add new capabilities as needed.  Those are
the folk I'd normally call "most qualified" to comment, on
anything except maybe I2C-specific issues.

In general this would seem to be a "new type" of I2C driver,
because of the system role it serves.  I brought it up on
the linux-pm list a month or two ago in response to a question
about how Linux should handle such chips ... there are a few
other chips like it, used in cell phones and other battery
powered devices, but this seems to be the first such driver
that's generally available.  (And there's a new CEA standard
for such chips, combining battery and voltage management with
USB OTG transceiver.  Also using I2C ... the OTG parts really
crave an async I2C API, it's unnatural to force that into the
current synchronous model.  If you were to call the OTG stuff
complicated, I'd agree!)


> I suggest you to make sure that coding style is OK.
> Check the Documentation/CodingStyle file please.

Did you have any specific issue to raise?  Otherwise
I'm not going to bother; it's quite conformant already,
and any minor differences are well within the accepted
level of variability for kernel code.


> Then you can continue with SubmittingPatches.
> 
> I2C subsystem handles Greg Kroah  greg@kroah.com
> 
> So I'm suggesting to ask people for review on LKML

Hmm, Greg already said he'd merge it, though I see
he's not had time to do it yet.

Greg -- do you think this needs review on LKML?
That is, _before_ merging.

- Dave

