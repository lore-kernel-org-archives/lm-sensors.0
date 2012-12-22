From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Dec 2012 11:07:45 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: detect i2c bus errors before scnprintf()
Message-Id: <20121222110745.GB4269@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 21, 2012 at 11:37:29PM -0800, Chris Verges wrote:
> On Fri, Dec 21, 2012 at 10:59 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Fri, Dec 21, 2012 at 05:37:38PM -0800, Chris Verges wrote:
> >> On Fri, Dec 21, 2012 at 5:30 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >> >
> >> > Just wondering - how comes the detect function did not report the
> >> > error ?
> >>
> >> Excellent question.  I didn't debug into this any further, but it is
> >> a good area for additional investigation.
> >>
> > Depends on how it is instantiated. Is this a PC, or some embedded
> > device ?  It could be configured with devicetree, for example.
> 
> This is an embedded device.  In looking further at the BSP, it is
> defined in the i2c device list there.  (Pre-device-tree.)
> 
> > Question though is if there is some other chip on that address, and it
> > is wrongly detected as LM73. Do you know by any chance?
> 
> Definitely not another chip at that address.  This board only has lm73's
> on the i2c bus -- 2 at different addresses, in fact.  Plus, the detect
> function in the lm73 appears to be quite thorough in vetting
> LM73-specific registers.
> 
> There may be error conditions or corner cases whereby this issue could
> arise independently from the detect function.  For example:
> 
>    1. if an i2c bus adapter has a bug which causes i2c transfers to
>       terminate prematurely, this could result in the detect functioning
>       properly and the temperature poll to return an error code.
> 
>    2. if the lm73's power rail is being controlled by a
>       GPIO-connected FET, and the lm73 is powered down to save power.
>       (Admittedly, the lm73 doesn't eat up much power, but every electron
>       counts in some applications.)
> 
> I discovered this issue through a combination of the sensor not being
> connected, yet being defined statically in the i2c device list for the
> board, and then there also being an i2c bus adapter bug causing transfer

Guess that explains that.

> truncation.  So even if the sensor was connected, 1 out of every 100
> polls would return an error.  (Software blaming hardware?  Unthinkable.)
> 
Can always be a driver bug (see 1. above...).

> Related to the lm73, but off the main topic ...
> 
> There are some potential other checks which could be performed at the
> driver layer to validate the responses back.  I couldn't decide whether
> they would be valuable or not.  For example, the lm73 should only return
> temperature values inside its operating range.  If something goes
> haywire on the bus and causes all 1's to be received by the master, this
> could translate to ~256 C ... outside the 150 C spec for the sensor.
> Any advice for whether to go forth with these changes?
> 
All 1s would be invalid per spec - bit 0 and 1 of the returned value should
always be 0. You could check for that and return an error (-EIO ?) if this
condition is seen. Usually I'd say that kind of thing is so unlikely not to
bother, but if you see a transfer error every 100 readings who knows.

> I'd also like to find a way to expose the variable precision control
> available to the driver.  I submitted a patch previously, but it was a
> first pass and not well conceived.  Does hwmon have a standard way of

But then you didn't even reply to my comments as far as I can see ...

> exposing resolution settings?  Perhaps this should be a compile-time
> Kconfig option?  Or maybe a module option?
> 
Not Kconfig. module option applies to all sensors on the system, so that is not
a good idea either.

Your options are:
- Platform data
- Device tree data (or better both)
- Use the update_interval attribute. Not directly applicable, but the resolution
  impacts the conversion time so the case could be made. And resolution does
  impact conversion time, so the only reason for not selecting 14 bit resolution
  all the time would be its impact on conversion time. The datasheet also
  specifically mentions that the reason for the configurable resolution is its
  impact on conversion time. Might as well specify it directly.
- Add a resolution sysfs attribute. There are other chips with a configurable
  resolution, so again the case could be made to introduce that. As I said
  earlier, that would have to be standardized and consistent, though.

Would this ever be changed at runtime, or is it a startup configuration option ?
In the latter case, platform and/or device tree data would be the better choice.
Since you suggested Kconfig/module option above, which does suggest startup
configuration, platform and/or device tree data might be your answer.

From an overall functionality perspective, adding support for alarm flags might
be more or at least equally important, though. Hint hint ;)

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
