From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sun, 16 Sep 2012 22:30:03 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <20120916223003.GA2160@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1209151834120.2271@ubuntu>
 <20120915225841.GA3816@roeck-us.net>
 <alpine.DEB.2.02.1209151918210.2271@ubuntu>
 <alpine.DEB.2.02.1209152323490.2088@ubuntu>
 <20120916043116.GA4477@roeck-us.net>
 <20120916093520.GA5623@polaris.bitmath.org>
 <alpine.DEB.2.02.1209161712070.14838@ubuntu>
In-Reply-To: <alpine.DEB.2.02.1209161712070.14838@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org

Hi Parag,

> > On Sat, Sep 15, 2012 at 09:31:16PM -0700, Guenter Roeck wrote:
> > > That looks terribly complicated. Better keep the loop, and just replace
> > > 	udelay(us);
> > > with something like
> > > 	usleep_range(us, us << 1);
> > > 
> > > Alternatively, just use a constant such as
> > > 	usleep_range(us, us + APPLESMC_MIN_WAIT);
> > 
> Well I don't think there is anything terribly complicated there - but I 
> tried to make it simpler. Below patch seems to work better for me for my 
> normal workload - I got no failures or other oddities with the default 
> 32ms timeout. I haven't tried very hard to get to the corner cases which 
> earlier required a higher timeout.

What exact model is this?

In addition to Guenter's comments, it is not clear what part of this
patch makes things work for you. Is it a) the doubling of the wait
time, or b) the zero initial wait? Or c) just randomly a little bit
better?

If a), that is very valuable information, and the patch can be
simplified further. If b), just crank up the wait time and be done
with it. If c), well, then we don't have a case for a patch.

Also, it is not enough to test this on one machine, for fairly obvious
reasons. I don't mind testing on a couple of machines close by (MBA3,1
MBP10,1), once the comments have been addressed. However, a machine
from around 2008 should be tested as well, since they behave
differently.

> Henrik - if the below patch still results in failures we can 
> revisit the long  wait cases. For now I am satisfied that there aren't any 
> normal case failures like before.

Well, I am satisfied once I know the patch will work on all supported
models.

Thanks.
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
