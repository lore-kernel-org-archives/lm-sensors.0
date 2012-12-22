From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Dec 2012 22:59:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: detect i2c bus errors before scnprintf()
Message-Id: <20121222225944.GA7867@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 22, 2012 at 01:48:26PM -0800, Chris Verges wrote:
> On Sat, Dec 22, 2012 at 3:07 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Fri, Dec 21, 2012 at 11:37:29PM -0800, Chris Verges wrote:
> >> Related to the lm73, but off the main topic ...
> >>
> >> Any advice for whether to go forth with these changes?
> >
> > All 1s would be invalid per spec - bit 0 and 1 of the returned value
> > should always be 0. You could check for that and return an error (-EIO
> > ?) if this condition is seen. Usually I'd say that kind of thing is so
> > unlikely not to bother, but if you see a transfer error every 100
> > readings who knows.
> 
> OK, I'll add it to the "if I touch the driver again, take a look at it"
> category.  Though it will likely happen since I'll probably take on the
> resolution / alarm stuff below.
> 
> >> I'd also like to find a way to expose the variable precision control
> >> available to the driver.  I submitted a patch previously, but it was a
> >> first pass and not well conceived.  Does hwmon have a standard way of
> >
> > But then you didn't even reply to my comments as far as I can see ...
> 
> I didn't reply at the time, but I did see them.  I've actually been
> pondering the best way to handle this since then.  (Not a lot of time
> was spent on these musings, as I was heavily on other projects.)  This
> is why there hasn't been an updated patch sent.
> 
> > Your options are:
> > - Platform data
> > - Device tree data (or better both)
> > - Use the update_interval attribute. Not directly applicable, but the
> >   resolution impacts the conversion time so the case could be made.
> >   And resolution does impact conversion time, so the only reason for
> >   not selecting 14 bit resolution all the time would be its impact on
> >   conversion time. The datasheet also specifically mentions that the
> >   reason for the configurable resolution is its impact on conversion
> >   time. Might as well specify it directly.
> > - Add a resolution sysfs attribute. There are other chips with a
> >   configurable resolution, so again the case could be made to
> >   introduce that. As I said earlier, that would have to be
> >   standardized and consistent, though.
> >
> > Would this ever be changed at runtime, or is it a startup
> > configuration option ?  In the latter case, platform and/or device
> > tree data would be the better choice.  Since you suggested
> > Kconfig/module option above, which does suggest startup configuration,
> > platform and/or device tree data might be your answer.
> 
> Your points about Kconfig and module options are well heard.  I agree
> that it needs to be sensor-specific, not shared across all sensors on a
> system.
> 
> I'll take a stab at platform data and device tree data at a minimum.
> Support for both should be easy enough.
> 
> I do see the reason to make it configurable at runtime.  Using the
> update_interval attribute is an interesting idea.  There is perhaps a
> concern about intuitiveness of the interface being a problem.  Not all
> users looking for more precision will necessarily think of adjusting
> conversion time at first.  However, in lack of a "resolution" attribute
> being available, perhaps this is the next best step.  I'll give it a
> shot and we can rip apart the code proposal.
> 
It would be unusual, though, to have both dt/platform data _and_ an attribute.
Having an attribute makes platform data redundant.

As for the attribute name, question is really what people are looking for.
There are multiple possible reasons for configuring the resolution and/or
conversion time.

- optimize for power consumption
- optimize for resolution
- optimize for conversion time

The LM73 datasheet mentions the last two. For other chips, it is possible
to configure the conversion time to reduce power consumption.

There is always a trade-off; either it is power consumption vs. conversion
time, or it is resolution vs. conversion time. The common attribute for both
trade-offs seems to be conversion time (or update interval).
Given that, using conversion time as common atribute doesn't seem too
far off track.

We _could_ of course support both attributes, but that seems to be redundant.

> > From an overall functionality perspective, adding support for alarm
> > flags might be more or at least equally important, though. Hint hint
> > ;)
> 
> That's simple enough.  I assume using the sysfs_notify() mechanism to
> allow epoll support would be wanted.  We'd need the platform/device tree
> to specify the IRQ to use, so it would have to be one of those
> "specify-if-desired" features.
> 
epoll and notification support is nice to have, but not mandatory. Most drivers
don't support it. Question is if we can come up with a common mechanism. It
isn't just that the interrupt needs to be specified - it may also make sense or
even be necessary to be able to specify gpio pins (which would then be used as
interrupt source). I'll have to check how other drivers handle this.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
