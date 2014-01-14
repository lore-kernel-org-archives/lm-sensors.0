From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 14 Jan 2014 16:07:51 +0000
Subject: Re: [lm-sensors] Call for lm-sensors 3.3.5
Message-Id: <CAAek22FNZZ_C_Uh+vB4ut_9Ok7NS_3iuvvcf10qMybo4G7nGCw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140114165101.4958fc13@endymion.delvare>
In-Reply-To: <20140114165101.4958fc13@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

AMD announced Kaveri boxed proc availability today.
http://finance.yahoo.com/news/amd-revolutionizes-compute-ultrahd-entertainment-130000053.html

K10temp needs a new PCI table entry for this proc.  I've tested and it
gives readings that change as expected. PCI ID is already in mainline
PCI-ids.h

If I post patch today could it make this release?

Or did I misunderstand and you are talking about userspace?

Phil P.

On Tuesday, January 14, 2014, Jean Delvare wrote:

> I was thinking maybe it would be the right time to release lm-sensors
> 3.3.5, 8 months after the previous release?
>
> --
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org <javascript:;>
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


-- 
Philip Pokorny, RHCE
Chief Technical Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
