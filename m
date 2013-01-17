From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 17 Jan 2013 20:45:49 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <20130117204549.GB22045@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net>
In-Reply-To: <20121124052707.GA17392@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 16, 2013 at 08:41:45AM +0000, Jonathan Cameron wrote:
> On 16/01/13 05:49, Guenter Roeck wrote:
> >On Sat, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:
> >>On 11/24/2012 05:27 AM, Guenter Roeck wrote:
> >>>Hi all,
> >>Hi Guenter,
> >>>
> >>>What would it take to move the MAX1363 driver out of staging ?
> >>>
> >>Nothing given it is already out of staging in linux-next (though only has been
> >>for about a week)
> >>
> >>>Background is that I need a hardware monitoring driver for MAX1139, and would
> >>>like to avoid using a driver from staging if possible (after all, it might
> >>>go away anytime). Another option would be to submit a hwmon driver for it,
> >>>but that doesn't seem to be the best approach.
> >>
> >>The hwmon driver client driver for iio devices is still in staging, but mainly
> >>because I haven't had a chance to take a last look at it before posting it to
> >>the hmwon list.  IIRC you were more or less happy with what went into staging
> >>in the first place, so hopefully not too much left to do.
> >>
> >Jonathan,
> >
> >can you educate me how to actually use iio_hwmon ? I get it loaded,
> >which registers the platform driver, but I have no idea how to instantiate it.
> >
> http://marc.info/?l=linux-iio&m2933525705497&w=2
> 
> [PATCH 6/6] stargate2: example of map configuration for iio to hwmon
> example.
> 
Hi Jonathan,

In other words, I can not test it on a PC unless I write a driver to
instantiate it. Not too helpful :(. It means that iio drivers can not
be used / instantiated for hardware monitoring on PCs.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
