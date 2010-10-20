From: Joe Perches <joe@perches.com>
Date: Wed, 20 Oct 2010 16:08:10 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: Use pr_fmt and pr_<level>
Message-Id: <1287590890.1813.166.camel@Joe-Laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287530020.10409.594.camel@Joe-Laptop>
	 <20101020032938.GA20095@ericsson.com>
	 <1287545658.10409.606.camel@Joe-Laptop>
	 <20101020035346.GA20178@ericsson.com>
	 <1287547662.10409.618.camel@Joe-Laptop>
	 <20101020093438.07b129c8@endymion.delvare>
	 <20101020144608.GA21937@ericsson.com>
In-Reply-To: <20101020144608.GA21937@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, Alistair John Strachan <alistair@devzero.co.uk>, Henrik Rydberg <rydberg@euromail.se>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Luca Tettamanti <kronos.it@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Juerg Haefliger <juergh@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, Jim Cromie <jim.cromie@gmail.com>, Roger Lucas <vt8231@hiddenengine.co.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, 2010-10-20 at 07:46 -0700, Guenter Roeck wrote:
> > * That being said, now that the hwmon subsystem maintainer is a shared
> >   duty between Guenter and myself, there's no single place where we can
> >   keep a patch touching many drivers and ensure it doesn't conflict
> >   with the changes in the other tree. But I would think   this is
> >   something for Gunter and myself to sort out, not patch contributors.

Perhaps allow both maintainers read/write access to hwmon-next?

> > I currently have pending patches to the following hwmon drivers in my
> > tree: adt7475, ams, asc7621, hdaps, it87, k8temp, lm75, lm85, lm90,
> > pcf8591, s3c-hwmon, w83795. Two of these are affected by Joe's
> > patch(es). Guenter, what about you?
> > 
> coretemp, pkgtemp, via-cputemp, ltc4261 (new), lis3, hp_accel

I did these against next which includes 'hwmon-staging/hwmon-next'.

Shouldn't these patches apply without modification or do I need
to do something else?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
