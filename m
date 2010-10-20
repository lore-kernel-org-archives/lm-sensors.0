From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 20 Oct 2010 18:03:28 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: Use pr_fmt and pr_<level>
Message-Id: <20101020180328.GB22819@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287530020.10409.594.camel@Joe-Laptop>
 <20101020032938.GA20095@ericsson.com>
 <1287545658.10409.606.camel@Joe-Laptop>
 <20101020035346.GA20178@ericsson.com>
 <1287547662.10409.618.camel@Joe-Laptop>
 <20101020093438.07b129c8@endymion.delvare>
 <20101020144608.GA21937@ericsson.com>
 <20101020183835.202989c9@endymion.delvare>
 <20101020164343.GA22572@ericsson.com>
 <20101020184640.0df26e35@endymion.delvare>
In-Reply-To: <20101020184640.0df26e35@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Joe Perches <joe@perches.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, Alistair John Strachan <alistair@devzero.co.uk>, Henrik Rydberg <rydberg@euromail.se>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Luca Tettamanti <kronos.it@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Juerg Haefliger <juergh@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, Jim Cromie <jim.cromie@gmail.com>, Roger Lucas <vt8231@hiddenengine.co.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Oct 20, 2010 at 12:46:40PM -0400, Jean Delvare wrote:
> On Wed, 20 Oct 2010 09:43:43 -0700, Guenter Roeck wrote:
> > On Wed, Oct 20, 2010 at 12:38:35PM -0400, Jean Delvare wrote:
> > > But first of all, I really would like the pr_fmt issue do be sorted
> > > out. I don't like the idea of having to redefine it in every driver,
> > > when it seems easy to avoid that. Joe?
> >
> > Agreed, especially since it doesn't seem to be used in many of the drivers.
> 
> As I understand it, it's used silently by all pr_*() calls.

I don't really understand the resistance to add the module name to the default
pr_fmt in kernel.h, and I really don't like the idea to spread pr_fmt defines
throughout the code instead.

Maybe I am missing something, but to me the result of this cleanup is less clean 
code than before.

What is your take ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
