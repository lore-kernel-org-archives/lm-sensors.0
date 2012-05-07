From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 07 May 2012 11:17:57 +0000
Subject: Re: [lm-sensors] [PATCH, v3] hwmon: coretemp: use list instead of fixed size array for temp
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB591184EF@BGSMSX102.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336386848-31041-1-git-send-email-kirill.shutemov@linux.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591184C1@BGSMSX102.gar.corp.intel.com>
 <20120507110959.GA7339@otc-wbsnb-06>
In-Reply-To: <20120507110959.GA7339@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Andi Kleen <ak@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

[snip.]

> > > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > > index b9d5123..fa082d5 100644
> > > --- a/drivers/hwmon/coretemp.c
> > > +++ b/drivers/hwmon/coretemp.c
> > > @@ -36,6 +36,8 @@
> > >  #include <linux/cpu.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/smp.h>
> > > +#include <linux/list.h>
> > > +#include <linux/kref.h>
> >
> > I think we don't need to include kref.h now :-)
> 
> Right. :(
> Guenter, should I resend the patch or you can fix this on apply?
> 
> >
> > BTW, at some places, looks like we are using 'tdata' obtained from
> get_temp_data,
> > without checking for NULL values. Other than that, looks Ok for me.
> 
> Do you mean sysfs show methods? It should never be NULL there. If it's
> NULL, we have bug (race?) somewhere.
> 

Yes agree with you. That's fine then.

> > Acked-by: Durgadoss R <durgadoss.r@intel.com>
> 
> Thanks.

You are welcome :-)

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
