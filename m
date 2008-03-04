From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Mar 2008 15:03:51 +0000
Subject: Re: [lm-sensors] [RFC/PATCH] hwmon: fix common race conditions,
Message-Id: <20080304160351.0e261f27@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080304145440.GE2892@jupiter.solarsys.private>
In-Reply-To: <20080304145440.GE2892@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Tue, 4 Mar 2008 09:54:40 -0500, Mark M. Hoffman wrote:
> Hi all:
> 
> Here is the first in a batch of patches which aim to fix a common class
> of race conditions in most hwmon drivers.  Credit goes to Herbert
> Valerio Riedel for pointing this out, here:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/022014.html
> 
> To actually trip on any of these race conditions in practice would be
> *exceedingly* rare.  In fact, I don't think we've ever seen a report for
> such a case.  OTOH, one can see by looking at this patch that the fixes
> are not always completely trivial.
> 
> I will concentrate on cranking out the remaining patches as I have time.
> But of course I would like thorough reviews, especially from the driver
> author/maintainer if possible.  To all potential reviewers: look not
> just at the patch itself; please also scan the entire driver to see if
> there are any races that I missed.  Testing is also much appreciated.
> 
> Thanks & regards,
> 
> commit 2475ee13652b392d9720b39f274205c815979557
> Author: Mark M. Hoffman <mhoffman@lightlink.com>
> Date:   Mon Mar 3 23:35:52 2008 -0500
> 
>     hwmon: fix common race conditions, batch 1
>     
>     Most hwmon drivers have one or more race conditions that could cause the driver
>     to display incorrect data; in the absolute worst case, these races could allow
>     divide-by-zero/OOPS.  The most common of these involves a race between setting
>     a fan divider and displaying the fan data (RPMs).  This patch fixes these race
>     conditions by taking the update lock (or equivalent) as necessary.
>     
>     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

I would appreciate if your hwmon patches included a diffstat output.
This would make it much easier for me to figure out what drivers are
affected and whether I can help with testing and/or review.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
