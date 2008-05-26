From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Mon, 26 May 2008 15:26:01 +0000
Subject: Re: [lm-sensors] [PATCH] LM63: Add controls for configuring device
Message-Id: <20080526152601.GA16874@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Trent:

Sorry to step in to this thread so late.

* Trent Piepho <tpiepho@freescale.com> [2008-04-18 15:45:43 -0700]:
> On Sun, 13 Apr 2008, Jean Delvare wrote:
> >> If the default LM63 polarity is wrong, how is it supposed to be changed?
> >
> > I'd say firmware, platform code, or i2cset, in this order of
> 
> What firmware?
> 
> Platform code, that's a lot harder to change than user space.  You have to
> recompile and re-flash to do anything.  It's also hardest to port across
> kernel versions.
> 
> i2cset, way too manual.
> 
> > preference. Relying on user-space to configure a hardware monitoring
> > chip is somewhat dangerous, user-space might as well never come up.
> 
> The kernel might not come up either.  Generally if the kernel boots up to the
> point where i2c is around, userspace is will be ok.  Setup from userspace adds
> very little risk, especially in production use, over setup in the kernel.  Of
> course it would a lot better if the chip let you strap these options when it
> came out of reset.

I agree completely with Jean, sorry.  If you have no firmware, and refuse to
put these one-time config options in platform data... that's your choice.

If you insist on doing this in userspace, then any combination of i2c-dev +
i2cset or py-smbus or tiny C program writing to i2c-dev ioctl is your answer.

That said, there were some parts of your original patch that do make sense to
expose through the driver, as Jean pointed out.  I encourage you to respin the
patch with just those parts.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
