From: Kevin Lo <kevlo@kevlo.org>
Date: Wed, 25 Jun 2014 01:48:20 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (w83l786ng) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140625014820.GA45680@ns.kevlo.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403609228.348.1.camel@phoenix>
In-Reply-To: <1403609228.348.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 25, 2014 at 09:06:17AM +0800, Axel Lin wrote:
> 
> 2014-06-24 22:38 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> > On 06/24/2014 04:27 AM, Axel Lin wrote:
> >>
> >> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> >> simplify the code a bit.
> >>
> >> The 'sensors' command never worked with this driver, fixed with this
> >> conversion.
> >>
> > Hi Axel,
> >
> > You'd have to be a bit more specific here. Why ? It is not obvious to me.
> > If you mean the 'name' attribute, that is created by the i2c subsystem.
> I thought the 'name' attribute was missing, but since it's created by the i2c
> subsystem, that would be fine.
> 
> >
> > The driver is buggy, though. It shows the current fan speed as minimum fan
> > speed.
> 
> I just sent a patch to fix this.
> 
> > Typical bug that can happen easily with function macros. But that is a
> > different
> > problem.
> >
> > The driver could also benefit from some cleanup. It wastes code space by
> > using
> > function macros instead of SENSOR_ATTR_2, and functions should be reordered
> > to get rid of forward declarations.
> 
> ok. I'll address these issues.
> Thanks for your review,

Thank you for taking the time to fix issues.
Since I've had no w83l786ng chips available for testing, I couldn't verify 
that your patch works or not.

> Axel

	Kevin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
