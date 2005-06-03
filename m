From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 03 Jun 2005 05:45:40 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 2/3] i2c: new sysfs class
Message-Id: <20050603034458.GB21665@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033654.GC4906@jupiter.solarsys.private>
In-Reply-To: <20050602033654.GC4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

(liberal snips)

> On Wed, Jun 01, 2005 at 11:36:54PM -0400, Mark M. Hoffman wrote:
> > Index: linux-2.6.12-rc5-mm1/drivers/hwmon/Kconfig
> > =================================> > --- linux-2.6.12-rc5-mm1.orig/drivers/hwmon/Kconfig
> > +++ linux-2.6.12-rc5-mm1/drivers/hwmon/Kconfig
> > @@ -0,0 +1,15 @@
> > +
> > +menu "Hardware Monitoring (Sensors) support"
> > +
> > +config HWMON
> > +	tristate "Hardware Monitoring Core support"
> > +	help
> > +	  If you want hardware monitoring (sensors) support, you should
> > +	  say Y here and also to the specific driver(s) for your sensors
> > +	  chip(s) below.
> > +
> > +	  This support can also be built as a module.  If so, the module
> > +	  will be called hwmon.

* Greg KH <greg@kroah.com> [2005-06-01 23:10:45 -0700]:
> Nice, but you forgot to enable this config option for all of the i2c
> chip drivers that use it.  Without that, you get a bunch of compiler
> errors at link time :)
> 
> Care to send a patch to fix this?

Crud.  I notice this didn't make it into -rc5-mm2.  Good thing, or else some
people would be upset about this one.  Yes, I'll send a patch.

> Do you really want free-form stuff here?  more on that in the next
> patch...
> 
> > +#ifndef _HWMON_H_
> > +#define _HWMON_H_
> > +
> > +#include <linux/device.h>
> > +
> > +struct class_device *hwmon_device_register(struct device *dev, char *fmt, ...);
> > +
> > +void hwmon_device_unregister(struct class_device *cdev);
> 
> You might want to just change this to the following, if you don't want
> to change the Kconfig entries for the i2c chips:
> (...)

I think I'll just change the Kconfig stuff right away.  Please hold off from
-mm until I update it.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

