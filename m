From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 14 Jan 2014 17:57:14 +0000
Subject: Re: [lm-sensors] Call for lm-sensors 3.3.5
Message-Id: <20140114175714.GC11586@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140114165101.4958fc13@endymion.delvare>
In-Reply-To: <20140114165101.4958fc13@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 14, 2014 at 08:07:51AM -0800, Phil Pokorny wrote:
> AMD announced Kaveri boxed proc availability today.
> http://finance.yahoo.com/news/amd-revolutionizes-compute-ultrahd-entertainment-130000053.html
> 
> K10temp needs a new PCI table entry for this proc.  I've tested and it
> gives readings that change as expected. PCI ID is already in mainline
> PCI-ids.h
> 
> If I post patch today could it make this release?
> 
Not into 3.13, but 3.14-rc1. We can Cc: stable, so it would be available
in a 3.13 maintenance release (and earlier versions if the patch applies).

Guenter

> Or did I misunderstand and you are talking about userspace?
> 
> Phil P.
> 
> On Tuesday, January 14, 2014, Jean Delvare wrote:
> 
> > I was thinking maybe it would be the right time to release lm-sensors
> > 3.3.5, 8 months after the previous release?
> >
> > --
> > Jean Delvare
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org <javascript:;>
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
> 
> 
> -- 
> Philip Pokorny, RHCE
> Chief Technical Officer
> PENGUIN COMPUTING, Inc
> www.penguincomputing.com
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
