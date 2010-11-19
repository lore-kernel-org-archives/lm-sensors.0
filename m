From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 19 Nov 2010 16:01:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lis3lv02d_i2c) Fix compile
Message-Id: <20101119160135.GB25724@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101119145510.1c59d6c4@endymion.delvare>
In-Reply-To: <20101119145510.1c59d6c4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 19, 2010 at 10:49:29AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 19 Nov 2010 06:59:53 -0800, Guenter Roeck wrote:
> > This commit fixes the following compile warnings.
> > 
> > From v2.6.37-rc2/m68k/m68k-allmodconfig, v2.6.37-rc2/powerpc/powerpc-randconfig:
> > drivers/hwmon/lis3lv02d_i2c.c:222: warning: 'lis3_i2c_runtime_suspend' defined but not used
> > drivers/hwmon/lis3lv02d_i2c.c:231: warning: 'lis3_i2c_runtime_resume' defined but not used
> 
> Your patch definitely fixes that one.
> 
> > 
> > From v2.6.37-rc2/sh4/sh-allyesconfig:
> > drivers/hwmon/lis3lv02d_i2c.c:191: warning: 'lis3lv02d_i2c_suspend' defined but not used
> > drivers/hwmon/lis3lv02d_i2c.c:201: warning: 'lis3lv02d_i2c_resume' defined but not used
> 
> But that one? I doubt it. If CONFIG_PM is set but CONFIG_PM_SLEEP
> isn't, it's still present. I don't think it can happen on x86, but
> apparently on sh4 it can.
> 
One never stops learning. Looks like I'll have to use #ifdef CONFIG_PM_SLEEP.

Guenter

> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > Resent. Previous post did not make it to the mailing list. Also added the fixed
> > warnings.
> > 
> >  drivers/hwmon/lis3lv02d_i2c.c |    8 +++-----
> >  1 files changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> > index 9f4bae0..16c1f48 100644
> > --- a/drivers/hwmon/lis3lv02d_i2c.c
> > +++ b/drivers/hwmon/lis3lv02d_i2c.c
> > @@ -213,12 +213,9 @@ static int lis3lv02d_i2c_resume(struct device *dev)
> >  
> >  	return 0;
> >  }
> > -#else
> > -#define lis3lv02d_i2c_suspend	NULL
> > -#define lis3lv02d_i2c_resume	NULL
> > -#define lis3lv02d_i2c_shutdown	NULL
> > -#endif
> > +#endif /* CONFIG_PM */
> >  
> > +#ifdef CONFIG_PM_RUNTIME
> >  static int lis3_i2c_runtime_suspend(struct device *dev)
> >  {
> >  	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
> > @@ -236,6 +233,7 @@ static int lis3_i2c_runtime_resume(struct device *dev)
> >  	lis3lv02d_poweron(lis3);
> >  	return 0;
> >  }
> > +#endif /* CONFIG_PM_RUNTIME */
> >  
> >  static const struct i2c_device_id lis3lv02d_id[] = {
> >  	{"lis3lv02d", 0 },
> 
> 
> -- 
> Jean Delvare

-- 
Guenter Roeck
Distinguished Engineer
PDU IP Systems

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
