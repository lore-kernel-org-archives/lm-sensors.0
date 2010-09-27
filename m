From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 27 Sep 2010 11:48:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (coretemp): Fix build breakage if
Message-Id: <20100927114801.GA31757@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285530603-2510-1-git-send-email-guenter.roeck@ericsson.com>
 <20100927062510.GA17825@elte.hu>
In-Reply-To: <20100927062510.GA17825@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>

On Mon, Sep 27, 2010 at 02:25:10AM -0400, Ingo Molnar wrote:
> 
> * Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> 
> > Commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f introduced
> > a build breakage if CONFIG_SMP is undefined. This patch
> > fixes the problem.
> > 
> > Reported-by: Ingo Molnar <mingo@elte.hu>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > ---
> >  drivers/hwmon/coretemp.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index baa842a..58a3c2d 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -503,9 +503,11 @@ static void coretemp_device_remove(unsigned int cpu)
> >  		list_del(&p->list);
> >  		mutex_unlock(&pdev_list_mutex);
> >  		kfree(p);
> > +#ifdef CONFIG_SMP
> >  		for_each_cpu(i, cpu_sibling_mask(cpu))
> >  			if (i != cpu && !coretemp_device_add(i))
> >  				break;
> > +#endif
> 
> Wont this result in an 'unused variable i' compiler warning?
> 
Sigh. Yes, of course. Must have been blind when I compiled it. Serves me right, 
for pushing this out in a hurry. You'll see rev2 of the patch in a minute.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
