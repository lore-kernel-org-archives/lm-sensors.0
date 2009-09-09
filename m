From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 09 Sep 2009 08:06:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Texas Instruments
Message-Id: <20090909010625.4c8780e9.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090905_120834_010267.tomaz.mertelj@guest.arnes.si>
	<20090908170649.855dd1ff.akpm@linux-foundation.org>
	<20090909093435.60531d95@hyperion.delvare>
In-Reply-To: <20090909093435.60531d95@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: tomaz.mertelj@guest.arnes.si, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 9 Sep 2009 09:34:35 +0200 Jean Delvare <khali@linux-fr.org> wrote:

> > Also, the checkpatch warning
> > 
> > WARNING: consider using strict_strtol in preference to simple_strtol
> > #381: FILE: drivers/hwmon/amc6821.c:228:
> > +       int val = simple_strtol(buf, NULL, 10); \
> > 
> > is valid.  The problem with simple_strtol() is that it will treat input
> > of the form "43foo" as "43".  Even though the input was invalid.  A
> > minor thing, but easily fixed too.
> 
> Is there any legitimate use of simple_strtol then?

Probably not, unless it's known that the input is a legit decimal
string.

> I'm wondering why we
> don't just get rid of it and rename strict_strtol to just strtol.

Well.  The calling convention is pretty different, the callers need to
be changed to handle errors.  But the main problem is that changing
existing interfaces to use strict_strtol() could break existing
userspace.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
