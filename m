From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 10 Oct 2006 09:42:47 +0000
Subject: [lm-sensors] [patch] hwmon-sysfs.h: add _RO and _RW versions of
Message-Id: <20061010114247.e2d5b0da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45292789.5000003@gmail.com>
In-Reply-To: <45292789.5000003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> 1st attachment adds _RO and _RW versions to the following macros:
> SENSOR_ATTR, SENSOR_DEVICE_ATTR,
> SENSOR_ATTR_2, SENSOR_DEVICE_ATTR_2,
> 
> with these defined, the script (2nd attachment) will convert ~800 uses
> (in 17 files) to the correct _RO/_RW version, and remove the linewraps.
> The results compile cleanly (all modules in hwmon).

What are you trying to achieve?

May you please post a sample patch as obtained by using the script
above on one arbitrary driver? So that we can see what it looks like.

> Is this something you'd consider applying ? If so, when ?

It merely depends on what our purpose is. As for "when", remember that
we have two high priority tasks for hwmon drivers now: individual alarm
files, and i2c-isa removal. I would like the first one to be done for
2.6.20, and the second in 2.6.21 but individual drivers can (should) be
converted to platform drivers before that. These will be large and
intrusive patches and I am unlikely to take other large and intrudive
patches until it's done.

> Theres obvious timing issues - since this patch touches many drivers, 
> which may have work in-queue (yours or other hackers').  Its also why
> I sent the script - the patch it yields is 94KB, so the script is far
> more inspectable, and with the script, you can chose the optimal
> time(s) w/o synchronization hassles.

Yes, sounds like a good idea, even though in this case your script is
rather frightening. I can't get why you didn't write a real perl
script? It would perform better and would certainly be somewhat more
readable too.

Thanks,
-- 
Jean Delvare

