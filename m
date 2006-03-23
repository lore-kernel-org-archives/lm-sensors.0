From: mgreer@mvista.com (Mark A. Greer)
Date: Thu, 23 Mar 2006 20:38:43 +0000
Subject: [lm-sensors] [PATCH 1/1] i2c: m41txx driver for ST i2c RTC chips
Message-Id: <20060323203843.GA18912@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060217011359.GA16247@mag.az.mvista.com>
In-Reply-To: <20060217011359.GA16247@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 23, 2006 at 09:08:56PM +0100, Jean Delvare wrote:
> Hi Mark,
> 
> > > > So I'd suggest that you do not rename the driver, it it's not too late.
> > > 
> > > Okay, that makes sense.  I'll change the name back to m41t00 and submit that
> > > patch in the next day or so.
> > 
> > It looks like in the 2.6.16-rc6-mm1 tree I should really be putting the
> > m41t00 driver into drivers/rtc but I need to check if it will work okay
> > for ppc.  In the meantime, here is a patch that keeps it in
> > drivers/i2c/chips.  I hope it is easier to review and is acceptable.
> 
> Yes that's the right way to do it, I think.
> 
> > Replace the old m41t00-specific driver with a more generic driver for
> > the ST family of i2c RTC chips.  Currently, the m41t00, m41t81, and
> > m41t85 chips are supported but only the m41t00 and m41t85 have been
> > tested.
> 
> I still have a problem with your patch (sorry). It's really doing to
> many things at once. Namely, it adds support for new chips, converts
> from tasklet to workqueue, cleans up a few things (e.g. BIN2BCD instead
> of BIN_TO_BCD, which is a good move), and also includes some whitespace
> changes (some of which is NOT OK, please don't attempt to align equal
> signs with spaces in regular code!)

You mean things like the following?

	sec  =  buf[m41t00_chip->sec]  & 0x7f;
	min  =  buf[m41t00_chip->min]  & 0x7f;
	hour = buf[m41t00_chip->hour]  & 0x3f;

I just want to make sure I change the right code.

> I would also object to the configuration symbol change. I think it'll
> be less confusing if you change it when moving the driver to the RTC
> subsystem.

Okay.

> So I'd like you to split this large patch in shorter chunks. The most
> important and urgent one is obviously the tasklet/workqueue
> replacement, as it fixes a bug in -mm (and possibly mainline too). Then
> maybe one patch with all the good cleanups, and a third one adding
> support for the new chips?

Makes sense.

> I know it means more work for you and I'm sorry about that, but it's
> also the only way for me to give proper review to all the changes.

No problem, Jean.  Thanks for the comments.  I'll post the new patches
asap.

Mark

