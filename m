From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 20 Oct 2010 14:46:08 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: Use pr_fmt and pr_<level>
Message-Id: <20101020144608.GA21937@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287530020.10409.594.camel@Joe-Laptop>
 <20101020032938.GA20095@ericsson.com>
 <1287545658.10409.606.camel@Joe-Laptop>
 <20101020035346.GA20178@ericsson.com>
 <1287547662.10409.618.camel@Joe-Laptop>
 <20101020093438.07b129c8@endymion.delvare>
In-Reply-To: <20101020093438.07b129c8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Joe Perches <joe@perches.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, Alistair John Strachan <alistair@devzero.co.uk>, Henrik Rydberg <rydberg@euromail.se>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Luca Tettamanti <kronos.it@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Juerg Haefliger <juergh@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, Jim Cromie <jim.cromie@gmail.com>, Roger Lucas <vt8231@hiddenengine.co.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Oct 20, 2010 at 03:34:38AM -0400, Jean Delvare wrote:
[ ... ]
> 
> * This isn't the kind of fixes we want to cherry-pick from. We're not
>   fixing any bug here, are we? I certainly hope that a real bug fix
>   wouldn't be hidden within a larger patch, but would have the separate
>   patch it deserves. At which point we no longer care if the rest is
>   one large patch or one patch per driver.
> 
Actually, I do this kind of thing all the time when backporting.
It is easier to apply all patches applied to a driver than skipping
the cleanup patches, to avoid conflicts when cherry-picking functional
patches. The tendency for large cleanup patches affecting several drivers
and modules created trouble for me several times already.

> * I don't see us reverting that kind of patch either. If we don't like
>   the changes for whatever reason, we don't take them in the first
>   place. Once in, we're not going to change our minds.
> 
> * 32 patches for a simple cleanup is actually a lot more work for me
>   than a single large patch. It's cheaper for me to do minor
>   adjustments to a large patch than to apply 32 patches individually.
> 
Good point. I am using git all the time, so it isn't that much of a
problem for me. Our mailer problems (the tabs replacing stuff) are
much more annoying.

> * That being said, now that the hwmon subsystem maintainer is a shared
>   duty between Guenter and myself, there's no single place where we can
>   keep a patch touching many drivers and ensure it doesn't conflict
>   with the changes in the other tree. But I would think   this is
>   something for Gunter and myself to sort out, not patch contributors.
> 
> I currently have pending patches to the following hwmon drivers in my
> tree: adt7475, ams, asc7621, hdaps, it87, k8temp, lm75, lm85, lm90,
> pcf8591, s3c-hwmon, w83795. Two of these are affected by Joe's
> patch(es). Guenter, what about you?
> 
coretemp, pkgtemp, via-cputemp, ltc4261 (new), lis3, hp_accel

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
