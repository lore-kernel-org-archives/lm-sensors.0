From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 16 Nov 2010 15:03:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Rewritten without using
Message-Id: <20101116150305.GA4442@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
In-Reply-To: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 11, 2010 at 01:18:56PM -0500, Davide Rizzo wrote:
> > Hi Davide,
> >
> > this looks much better, and gives me a chance for a more complete
> > review. Please see below.
> >
> > Unfortunately, I got hit with the MS Exchange server bug, meaning I can
> > not apply your patch. So I might still miss something. Next time please
> > copy lkml - that will give me a chance to retrieve the patch from
> > patchwork.kernel.org<http://patchwork.kernel.org/>.
> >
> > Thanks,
> > Guenter
> Hi Guenther, here is the driver again with requested modifies.
> What do you mean with "copy lkml" ?
> Regards
> Davide
> 
> From: Davide Rizzo <elpa.rizzo@gmail.com<mailto:elpa.rizzo@gmail.com>>
> 
> Rewriting of driver/hwmon/lm95241.c to avoid using macros
> Now it uses SENSOR_DEVICE_ATTR to distinguish similar attr.
> Signed-off-by: Davide Rizzo <elpa.rizzo@gmail.com<mailto:elpa.rizzo@gmail.com>>
> ---
> --- linux-2.6.37-rc1/drivers/hwmon/lm95241.c    2010-11-01 12:54:12.000000000 +0100
> +++ linux-2.6.37-rc1.elpa/drivers/hwmon/lm95241.c    2010-11-11 19:12:28.392515642 +0100
> @@ -1,13 +1,9 @@
>  /*
> - * lm95241.c - Part of lm_sensors, Linux kernel modules for hardware
> - *             monitoring
> - * Copyright (C) 2008 Davide Rizzo <elpa-rizzo@gmail.com<mailto:elpa-rizzo@gmail.com>>
> + * Copyright (C) 2008, 2010 Davide Rizzo <elpa.rizzo@gmail.com<mailto:elpa.rizzo@gmail.com>>
>   *
> - * Based on the max1619 driver. The LM95241 is a sensor chip made by National
> - *   Semiconductors.
> - * It reports up to three temperatures (its own plus up to
> - * two external ones). Complete datasheet can be
> - * obtained from National's website at:
> + * The LM95241 is a sensor chip made by National Semiconductors.
> + * It reports up to three temperatures (its own plus up to two external ones).
> + * Complete datasheet can be obtained from National's website at:
>   *   http://www.national.com/ds.cgi/LM/LM95241.pdf
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -25,16 +21,13 @@
>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
> 
> -#include <linux/module.h>
> -#include <linux/init.h>
>  #include <linux/slab.h>
> -#include <linux/jiffies.h>
>  #include <linux/i2c.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
> -#include <linux/mutex.h>
> -#include <linux/sysfs.h>

Removing the above includes violates SubmitChecklist rule #1. Also, please reparent to Linus'
latest tree.

Other than that, there are a only few formatting issues, but I can take care of those myself.
So please re-submit with the above changes, and we should be ready to go.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
