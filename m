From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Mar 2012 08:01:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Add support for AT30TS00, TS3000GB2, TSE2002GB2, and MCP9804
Message-Id: <20120308090105.661724de@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 7 Mar 2012 09:18:13 -0800, Guenter Roeck wrote:
> On Wed, 2012-03-07 at 11:51 -0500, Jean Delvare wrote:
> > I'm not even sure why we defined that many different prefixes in the
> > first place when we treat them all the same, and autodetection doesn't
> > even bother setting the prefix right. All these chips are
> > register-compatible by definition, so I really wouldn't mind dropping
> > all these different prefixes (which I don't think anyone is using
> > today) and going with "jc42" for everyone.
> 
> Thinking about it and looking into NetBSD code - some of the chips have
> fixed sensor resolution, others have configurable resolution. In the
> latter case, the NetBSD driver configures it. Before I drop the
> capability to separate chips based on the prefix, it might make sense to
> first determine if that is something we want or should support.
> 
> Thoughts ?

Isn't this all standardized in the capability and resolution registers,
and thus independent of the vendor and device ID?

Whether we set the resolution or not, is the same issue we have with
all other temperature sensor chips. Resolution has an impact on
measurement times and power consumption. Changing that arbitrarily in
the driver is discussable, my opinion has always been that drivers
should let the BIOS/firmware/hardware defaults alone. If anyone really
needs to change that, this should be done through platform data or a
sysfs attribute. We already have update_interval, but using it to also
control the resolution isn't necessarily smart as it isn't intuitive
and also hides the power consumption factor. I wouldn't mind
introducing a new attribute for resolution, but a number of details
will need discussion first, in particular the attribute name and unit
and whether it is global or per input.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
