From: Christian Krafft <krafft@de.ibm.com>
Date: Wed, 08 Oct 2008 14:33:14 +0000
Subject: Re: [lm-sensors] [PATCH 09/12] ibmpex: Automatically load on IBM
Message-Id: <20081008163314.53dcadd3@schleppi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
	<20081007011909.12701.96969.stgit@elm3a70.beaverton.ibm.com>
	<20081008140158.5a2e1184@hyperion.delvare>
In-Reply-To: <20081008140158.5a2e1184@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-scsi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi,

On Wed, 8 Oct 2008 14:01:58 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Darrick,
> 
> On Mon, 06 Oct 2008 18:19:09 -0700, Darrick J. Wong wrote:
> > 
> > Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> > ---
> > 
> >  drivers/hwmon/ibmpex.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
> > index 4e9b19c..6e3a2c4 100644
> > --- a/drivers/hwmon/ibmpex.c
> > +++ b/drivers/hwmon/ibmpex.c
> > @@ -608,3 +608,9 @@ MODULE_LICENSE("GPL");
> >  
> >  module_init(ibmpex_init);
> >  module_exit(ibmpex_exit);
> > +
> > +MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3650*");
> > +MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3550*");
> > +MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3655*");
> > +MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3755*");
> > +MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3350*");
> 
> Is there no way to have an alias at the IPMI level? That is, alias on
> the device itself rather than the systems it is in? This would avoid the
> foreseeable requirement to add entries every time new machines are
> released.

First foreseeable requirement would come from my side.
IBM's cell blades QS21/QS22 also support AEM/PEX.
On Power we don't have DMI information, but a slof device tree.

One could also add the open firmware path to the ipmi device.
But to avoid autoloading on other slof based machines with ipmi one would have to add compatible attributes for each machine.

So autoloading based on available ipmi sensors would be much better.

> 
> But if there is no such way then I am fine applying this patch (except
> that I'd sort the entries). I also suspect that the last "*" should
> actually be ":*"?
> 


-- 
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
Linux Kernel Development
IBM Systems & Technology Group
Phone: +49-07031-16-2032

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaetsfuehung:		Herbert Kircher
Sitz der Gesellschaft:		Boelingen
Registergericht:		Amtsgericht Stuttgart, HRB 243294

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
