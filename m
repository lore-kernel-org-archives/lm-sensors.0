From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Mar 2012 14:47:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Add support for AT30TS00, TS3000GB2, TSE2002GB2, and MCP9804
Message-Id: <20120308144721.GA30262@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, Mar 08, 2012 at 03:01:05AM -0500, Jean Delvare wrote:
> On Wed, 7 Mar 2012 09:18:13 -0800, Guenter Roeck wrote:
> > On Wed, 2012-03-07 at 11:51 -0500, Jean Delvare wrote:
> > > I'm not even sure why we defined that many different prefixes in the
> > > first place when we treat them all the same, and autodetection doesn't
> > > even bother setting the prefix right. All these chips are
> > > register-compatible by definition, so I really wouldn't mind dropping
> > > all these different prefixes (which I don't think anyone is using
> > > today) and going with "jc42" for everyone.
> > 
> > Thinking about it and looking into NetBSD code - some of the chips have
> > fixed sensor resolution, others have configurable resolution. In the
> > latter case, the NetBSD driver configures it. Before I drop the
> > capability to separate chips based on the prefix, it might make sense to
> > first determine if that is something we want or should support.
> > 
> > Thoughts ?
> 
> Isn't this all standardized in the capability and resolution registers,
> and thus independent of the vendor and device ID?
> 
The capability register is read-only. The resolution register is non-standard
and exists (as far as I can see) only on MCP98242/98243.

> Whether we set the resolution or not, is the same issue we have with
> all other temperature sensor chips. Resolution has an impact on
> measurement times and power consumption. Changing that arbitrarily in

Measurement time, in this case.

> the driver is discussable, my opinion has always been that drivers
> should let the BIOS/firmware/hardware defaults alone. If anyone really
> needs to change that, this should be done through platform data or a
> sysfs attribute. We already have update_interval, but using it to also
> control the resolution isn't necessarily smart as it isn't intuitive
> and also hides the power consumption factor. I wouldn't mind

In this case it doesn't, but that may be different for other chips.

> introducing a new attribute for resolution, but a number of details
> will need discussion first, in particular the attribute name and unit
> and whether it is global or per input.
> 
Do you know of any other chips where the resolution is configurable ?
That should probably be the deciding factor if we introduce such an attribute.

Not sure if it is worth it, though. The default resolution for the above chips
is 0.25 degrees C. That should really be good enough. I never understood why
a resolution of 0.0625 degrees C would make sense for a chip with an accuracy
of +/- 1 degree C.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
