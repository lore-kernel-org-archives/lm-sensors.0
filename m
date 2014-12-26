From: Tony Lindgren <tony@atomide.com>
Date: Fri, 26 Dec 2014 16:17:57 +0000
Subject: Re: [lm-sensors] [PATCH] add omap34xx temperature monitoring support
Message-Id: <20141226161757.GD12409@atomide.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141226102933.GA28778@amd>
 <20141226155456.GB12409@atomide.com>
In-Reply-To: <20141226155456.GB12409@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org

* Tony Lindgren <tony@atomide.com> [141226 07:57]:
> * Pavel Machek <pavel@ucw.cz> [141226 02:32]:
> > --- /dev/null
> > +++ b/drivers/hwmon/omap34xx_temp.c
> > @@ -0,0 +1,263 @@
> > +/*
> > + * omap34xx_temp.c - Linux kernel module for OMAP34xx hardware monitoring
> > + *
> > + * Copyright (C) 2008 Nokia Corporation
> > + *
> > + * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
> > + *
> > + * Inspired by k8temp.c
> > + *
> > + * This file is subject to the terms and conditions of the GNU General
> > + * Public License. See the file "COPYING" in the main directory of this
> > + * archive for more details.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/module.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +
> > +#include "../../arch/arm/mach-omap2/control.h"
> 
> No need to do this, you can use syscon here like pbias-regulator.c
> is doing.

Oh looks like you're already using syscon, nice. What defines do you
need from control.h?

Those should be in the driver if private to the driver, or else we
should have some minimal header in include/linux somewhere if some
control.h defines really need to be exposed.

Regards,

Tony

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
