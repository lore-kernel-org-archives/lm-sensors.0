From: "Premi, Sanjeev" <premi@ti.com>
Date: Mon, 11 Jul 2011 13:22:44 +0000
Subject: Re: [lm-sensors] [PATCH] mfd: twl4030: Fix mismatch in mutex
Message-Id: <B85A65D85D7EB246BE421B3FB0FBB593024DA7AA59@dbde02.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310129879-4748-1-git-send-email-premi@ti.com>
 <20110709085124.401dba10@endymion.delvare>
In-Reply-To: <20110709085124.401dba10@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org] 
> Sent: Saturday, July 09, 2011 12:21 PM
> To: Premi, Sanjeev
> Cc: lm-sensors@lm-sensors.org; linux-omap@vger.kernel.org
> Subject: Re: [lm-sensors] [PATCH] mfd: twl4030: Fix mismatch 
> in mutex lock-unlock
> 
> On Fri, 8 Jul 2011 18:27:59 +0530, Sanjeev Premi wrote:
> > A mutex is locked on entry into twl4030_madc_conversion().
> > Immediate return on some error conditions leaves the
> > mutex locked.
> > 
> > This patch ensures that mutex is always unlocked before
> > leaving the function.
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > Cc: Keerthy <j-keerthy@ti.com>
> > ---
> > 
> >  Compile tested only.
> > 
> > 
> >  drivers/mfd/twl4030-madc.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> > index 3941ddc..b5d598c 100644
> > --- a/drivers/mfd/twl4030-madc.c
> > +++ b/drivers/mfd/twl4030-madc.c
> > (...)
> 
> Wrong list. This isn't a hwmon driver, so lm-sensors isn't suitable.
> scripts/get_maintainer.pl says that you should send this patch to:
> Samuel Ortiz <sameo@linux.intel.com>

[sp] I picked the list from the patch where this functionality was first
     introduced. Assumed that Samuel would on this list itself...

     sorry for noise :(

~sanjeev

> 
> Thanks,
> -- 
> Jean Delvare
> 
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
