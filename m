From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Feb 2011 20:11:14 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hp_accel: Fix driver name
Message-Id: <20110219211114.384ed584@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219142832.1516d1ee@endymion.delvare>
In-Reply-To: <20110219142832.1516d1ee@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 19 Feb 2011 10:20:16 -0800, Guenter Roeck wrote:
> On Sat, Feb 19, 2011 at 08:28:32AM -0500, Jean Delvare wrote:
> > I suspect that the "lis3lv02d" driver name is a legacy from before
> > the split into several modules. Use a specific name for the hp_accel
> > driver, for better error messages and easier investigation of issues.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Eric Piel <eric.piel@tremplin-utc.net>
> > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > Not tested due to lack of hardware.
> > 
> >  drivers/platform/x86/hp_accel.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-2.6.38-rc5.orig/drivers/platform/x86/hp_accel.c	2011-02-19 13:28:46.000000000 +0100
> > +++ linux-2.6.38-rc5/drivers/platform/x86/hp_accel.c	2011-02-19 13:39:49.000000000 +0100
> > @@ -39,7 +39,7 @@
> >  #include <acpi/acpi_drivers.h>
> >  #include "../../misc/lis3lv02d/lis3lv02d.h"
> >  
> > -#define DRIVER_NAME     "lis3lv02d"
> > +#define DRIVER_NAME     "hp_accel"
> >  #define ACPI_MDPS_CLASS "accelerometer"
>
> Not sure if you can do that, given the close interrelation with lis3lv02d.c.

I was a little worried about this at first, but then noticed that the
string is (almost) only used as the name of the acpi driver and device.
The lis3lv02d core driver doesn't deal with ACPI at all, so it
shouldn't make a difference. Also, the lis3lv02d_i2c and lis3lv02d_spi
drivers do have different driver name strings, which implies that there
is no requirement for a common driver name string.

> That really asks for testing on a real system.

I agree still. The only problem I can think of is if user-space expects
a specific ACPI driver and/or device name. Note that, in the event this
one patch causes trouble, I'll simply drop it. I noticed what I think
is an improper driver name while working on the driver, but what I
really care about is moving these drivers out of drivers/hwmon, i.e.
the first 3 patches of the set.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
