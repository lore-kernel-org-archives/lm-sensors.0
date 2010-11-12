From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 12 Nov 2010 22:06:40 +0000
Subject: Re: [lm-sensors] Location for thermal drivers
Message-Id: <1289599600.22931.406.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289594026.22931.388.camel@groeck-laptop>
	 <AANLkTimERGh2yGGX_E_N4ajxg_-0QTFS54QSKj2+AAfF@mail.gmail.com>
In-Reply-To: <AANLkTimERGh2yGGX_E_N4ajxg_-0QTFS54QSKj2+AAfF@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Pokorny <ppokorny@penguincomputing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, 2010-11-12 at 16:53 -0500, Phil Pokorny wrote:
> On Fri, Nov 12, 2010 at 12:33 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > I think a better location for the driver would be drivers/thermal.
> > drivers/hwmon is not really a good fit, since hwmon support for thermal
> > drivers is optional. Potential problem with drivers/thermal is that
> > there are no thermal drivers in there (yet), and there does not seem to
> > be a maintainer.
> 
> What is the difference between a "thermal" sensor and a "temperature"
> sensor?  Aren't they the same thing?
> 
The thermal framework is much more extensive than the hwmon framework.
See Documentation/thermal/sysfs-api.txt for details.

> Why does drivers/thermal exist if there are no drivers in it and no maintainer?
> 
The framework resides there. Drivers supporting it are in various
platform directories.

As for why there are no drivers - only the framework - in
drivers/thermal, and why there is no maintainer - no idea.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
