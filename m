From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Thu, 18 Nov 2010 18:45:29 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] Print the status of fault register at
Message-Id: <20101118184529.GB11832@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CE5595B.60300@RuggedCom.com>
In-Reply-To: <4CE5595B.60300@RuggedCom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 18, 2010 at 10:23:08AM -0800, Guenter Roeck wrote:
> On Thu, Nov 18, 2010 at 12:45:34PM -0500, Richard Retanubun wrote:
> > > I can not comment on ltc4215 behavior, but ltc4261 tends to have alarm bits
> > > set after boot. To display that would simply add noise and not provide any value.
> > > If the ltc4215 does the same, adding the log message would only (and unnecessarily)
> > > cause users to be concerned. This in turn would subject the mailing list, and thus
> > > the maintainers, to e-mails such as "I get this message during boot, is this
> > > a problem ?".
> > >
> > > I don't like the proposed change, unless someone can convince me that it adds value
> > > and not just noise (and maybe volunteers to forever reply to the resulting e-mails).
> > >
> > Agreed, the print at boot may not be a good idea, I am working on adding this as
> > an attribute that can be checked via sysfs and stop printing this at boot.
> > 
> That would violate the sysfs abi.
> 
> > > So the EN bit changed state, which might just mean that the chip was enabled at some point
> > > in the past. What would be the value of displaying that information ?
> > 
> > Consider this scenario:
> > If the SW reboots the system, and it does so by toggling EN-bit when this happens the ltc4125 cuts out the voltage it is regulating and (most) of the components reboots,
> > but because it is still alive (its VDD is still good) it will set the EN-toggled-bit, which will be detected at next-boot.
> > 
> > If the system actually loses power, the ltc4215 itself is powered down, and at next-boot the EN-toggle-bit will not be set.
> > 
> > Using this, one can differentiate a "SW-reboot" Vs "A real power-down because external power is cut lost"
> > 
> Lots of context knowledge. That applies to one specific system doing this, but not to all the others.
> Some other system may have the EN toggled bit set after a power on reboot because of the way it is enabled
> after power on. 
> 
> A more common and chip independent solution to such scenarios would be to have a dedicated register
> in the system to log reboot reasons. This can be anything - nvram, a chip register, or something else.
> I don't think it is a good idea to make assumptions about reboot reasons based on the behavior
> of one specific chip.
> 

I can offer some insight on how I'd handle this, if the LTC4215 EN bit
was the method used to detect SW reset on my board.

I use the U-Boot bootloader to load Linux. I have no need to access the
chip while the bootloader is running. It would be very easy to have the
bootloader read the value and cache it somewhere. Some possibilities
include the U-Boot environment, or an unused register (I use a mpc83xx
chip, which has two of these).

Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
