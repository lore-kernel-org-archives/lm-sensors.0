From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Mon, 17 Sep 2012 19:14:16 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <20120917191416.GA598@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1209152323490.2088@ubuntu>
 <20120916043116.GA4477@roeck-us.net>
 <20120916093520.GA5623@polaris.bitmath.org>
 <alpine.DEB.2.02.1209161712070.14838@ubuntu>
 <20120916223003.GA2160@polaris.bitmath.org>
 <alpine.DEB.2.02.1209161957490.2808@ubuntu>
 <20120917162705.GA2854@polaris.bitmath.org>
 <alpine.DEB.2.02.1209171356340.3412@ubuntu>
 <20120917184954.GA349@polaris.bitmath.org>
 <alpine.DEB.2.02.1209171446390.1963@ubuntu>
In-Reply-To: <alpine.DEB.2.02.1209171446390.1963@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org

On Mon, Sep 17, 2012 at 02:54:25PM -0400, Parag Warudkar wrote:
> 
> 
> On Mon, 17 Sep 2012, Henrik Rydberg wrote:
> 
> > So the question is, does this patch work equally well for you?
> > 
> > 
> > diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> > index 2827088..8bf9011 100644
> > --- a/drivers/hwmon/applesmc.c
> > +++ b/drivers/hwmon/applesmc.c
> > @@ -56,7 +56,7 @@
> >  /* wait up to 32 ms for a status change. */
> >  #define APPLESMC_MIN_WAIT      0x0010
> >  #define APPLESMC_RETRY_WAIT    0x0100
> > -#define APPLESMC_MAX_WAIT      0x8000
> > +#define APPLESMC_MAX_WAIT      0x10000
> >  
> >  #define APPLESMC_READ_CMD      0x10
> >  #define APPLESMC_WRITE_CMD     0x11
> > 
> 
> That was something that I tried originally and it still resulted in 
> failures - albeit lesser in number.

Good, just wanted to touch base here, so we know what we are doing.

> I had to bump it to 0x20000 (effective wait of 65536) with the original 
> loop termination logic and  udelay() in order to get it to reduce to 
> zero.
> 
> Note that with usleep_range - each sleep is potentially more than the 
> minimum - that's may be why 32ms works with usleep_range but not with 
> udelay which is precise.

Yes, so if you also change APPLESMC_MIN_WAIT to 0x0020, what happens?

> So bottomline, I suspect we will need to bump to 0x20000 if you want to 
> keep the current loop termination and udelay().

That is just crazy, since your code works with a 32ms maximum.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
