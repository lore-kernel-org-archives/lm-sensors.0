From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Jan 2012 08:12:44 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: fix trailing whitespace
Message-Id: <20120106091244.7db2c3c7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Fri, 6 Jan 2012 08:32:43 +0100, Frans Meulenbroeks wrote:
> 2012/1/6 Guenter Roeck <guenter.roeck@ericsson.com>
> > Your other patches are fine, but this one has checkpatch errors and
> > warnings:
> >
> > ERROR: code indent should use tabs where possible
> > #793: FILE: drivers/hwmon/hwmon-vid.c:122:
> > +^I^I                       1850 - val * 25;$
> >
> > ERROR: code indent should use tabs where possible
> > #812: FILE: drivers/hwmon/hwmon-vid.c:137:
> > +^I^I                     2050 - (val) * 50;$
> >
> > WARNING: please, no spaces at the start of a line
> > #1276: FILE: drivers/hwmon/ds1621.c:6:
> > +    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with$
> >
> > WARNING: please, no spaces at the start of a line
> > #1300: FILE: drivers/hwmon/g760a.c:8:
> > +      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf$
> >
> > total: 2 errors, 2 warnings, 607 lines checked
> >
> > NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
> >      scripts/cleanfile
> >
> > While those were already there in the original files, it doesn't really
> > help much
> > to only remove the spaces at the end of the line. And newly submitted
> > patches should
> > not have any checkpatch errors or warnings.
> (...)
> Probably i should explain a little bit on my way of working.
> For me the most efficient way to tackle this is to only fix one error type
> at a time.
> This reduces the chance of mistakes (like mixing up simple_strtoul and
> strict_strtoul), and also makes doing the edits simpler.

That's a bad example IMHO. These two changes should really go in the
same commit, as they are so similar. You can easily generate them
separately and then merge them together before sending.

> However the side effect of this is that not all problems in a file are
> solved.

I definitely prefer doing it the other way around: take one driver and
fix all (or most) style issues. While it is slightly more time
consuming to review, it has advantages:
* When backporting a driver to an older kernel, you can pick all
  patches touching the driver, without having to filter out all changes
  affecting other drivers.
* Checkpatch is happy on every patch, which compensates for the harder
  review.
* Per-driver patches are easier for me and Guenter to handle. We tend
  to each concentrate on a subset of the drivers for each release
  cycle, so that our trees don't collide in linux-next. With
  cross-driver patches we can't do that, which basically puts all the
  handling burden on a single one of us for the whole release cycle.
* It makes the history of each individual driver much easier to read.
  Having 10 patches in the history to clean up 10 different style
  issues doesn't exactly help.

> PS: note that I don't own most of the hardware, so i cannot really run-time
> verify my work, only do a compile-test.

And so:
* Testing by people with the hardware is much easier.

If you still prefer cross-driver patches, I guess that's better than
not getting contributions from you at all, but then please at least
ensure that checkpatch doesn't complain about your patches, even if
that means fixing more than one issue at once. BTW, all whitespace
fixes can go in the same patch to start with, it makes sense to group
them IMHO.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
