From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 22 May 2011 00:52:13 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Fix checkpatch errors
Message-Id: <20110522005213.GB31671@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305902880-11414-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1305902880-11414-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 21, 2011 at 04:30:30AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 20 May 2011 07:48:00 -0700, Guenter Roeck wrote:
> > Fix remaining checkpatch errors in the coretemp driver.
> 
> Most of these aren't actually reported by checkpatch. But I'm fine with
> the fixes nevertheless. A few comments:
> 
Maybe I should have said "coding style violations".

> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Durgadoss R <durgadoss.r@intel.com>
> > ---
> >  drivers/hwmon/coretemp.c |   66 +++++++++++++++++++++++++--------------------
> >  1 files changed, 37 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index ece3b7d..649d87d 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -37,7 +37,7 @@
> >  #include <linux/pci.h>
> >  #include <asm/msr.h>
> >  #include <asm/processor.h>
> > -#include <asm/smp.h>
> > +#include <linux/smp.h>
> 
> Then please move it up to the <linux/*> group.
> 
> > (...)
> > @@ -259,8 +264,10 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
> >  		} else if (eax & 0x40000000) {
> >  			tjmax = tjmax_ee;
> >  		}
> > -	/* if we dont use msr EE it means we are desktop CPU (with exeception
> > -	   of Atom) */
> > +	/*
> > +	 * if we dont use msr EE it means we are desktop CPU (with exeception
> 
> While you're here, capital "I" please, and s/dont/don't/.
> 
> > +	 * of Atom)
> > +	 */
> >  	} else if (tjmax = 100000) {
> >  		dev_warn(dev, "Using relative temperature scale!\n");
> >  	}
> > (...)
> 
> Then,
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
All done (including the one you mentioned in the other e-mail).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
