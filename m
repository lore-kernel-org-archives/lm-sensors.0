From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Mar 2013 17:26:51 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (lm75) Tune resolution and sample time per chip
Message-Id: <20130312172651.GG30269@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312155108.054dd75e@endymion.delvare>
In-Reply-To: <20130312155108.054dd75e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 12, 2013 at 05:34:11PM +0100, Jean Delvare wrote:
> On Tue, 12 Mar 2013 08:55:16 -0700, Guenter Roeck wrote:
> > On Tue, Mar 12, 2013 at 03:51:08PM +0100, Jean Delvare wrote:
> > > Most LM75-compatible chips can either sample much faster or with a
> > > much better resolution than the original LM75 chip. So far the lm75
> > > driver did not let the user take benefit of these improvements. Do it
> > > now.
> > > 
> > > I decided to almost always configure the chip to use the best
> > > resolution possible, which also means the longest sample time. The
> > > only chips for which I didn't are the DS75, DS1775 and STDS75, because
> > > they are really too slow in 12-bit mode (1.2 to 1.5 second worst case)
> > > so I went for 11-bit mode as a more reasonable tradeoff. This choice is
> > > dictated by the fact that the hwmon subsystem is meant for system
> > > monitoring, it has never been supposed to be ultra-fast, and as a
> > > matter of fact we do cache the sampled values in almost all drivers.
> > > 
> > > If anyone isn't pleased with these default settings, they can always
> > > introduce a platform data structure or DT support for the lm75. That
> > > being said, it seems nobody ever complained that the driver wouldn't
> > > refresh the value faster than every 1.5 second, and the change made
> > > it faster for all chips even in 12-bit mode, so I don't expect any
> > > complaint.
> > > 
> > I have been using update-interval to make it configurable.
> > Good example is the LM90 driver.
> 
> Indeed. The LM90 case is a little different though, as the update rate
> has an effect primarily on power consumption, and for extreme values on
> accuracy if I remember correctly (due to less/no averaging.) While in
> the LM75 case it has no effect on power consumption but on resolution.
> 
Hi Jean,

There are always multiple dimensions. Sample time, resolution, accuracy,
and power consumption all interact with each other. I have been using
update_interval so far to report/configure it all. "resolution" (or possibly
tempX_resolution) was suggested as possible additional sysfs attribute
at some point.

> Are you suggesting that I should rename lm75_data.sample_time to
> update_interval, and change it from jiffies to ms, for consistency?
> 
Would be a start.

> That I should add a read-only update_interval to report the update
> interval to user-space?
> 
> That I should make the update_interval attribute writable and change
> the resolution on the fly accordingly, on a per-chip basis? This
> would be non-trivial, as each chip have their own conversion times for
> each supported resolution.
> 
Actually that was the idea, though I did not think about complexity.
If it is too complex it might not be worth the effort.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
