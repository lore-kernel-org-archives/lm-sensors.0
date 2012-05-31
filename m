From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 31 May 2012 02:22:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Improve support of recent Atom CPU models
Message-Id: <20120531022226.GA17489@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120530132956.6161d552@endymion.delvare>
In-Reply-To: <20120530132956.6161d552@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 30, 2012 at 02:17:19PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed, 30 May 2012 08:22:03 -0700, Guenter Roeck wrote:
> > On Wed, May 30, 2012 at 07:29:56AM -0400, Jean Delvare wrote:
> > > Document the new Atom series (Tunnel Creek and Medfield) as being
> > > supported, and list TjMax for the Atom E600 series.
> > > 
> > > Also enable the Atom tjmax heuristic for these Atom CPU models.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Alexander Stein <alexander.stein@systec-electronic.com>
> > > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > > Cc: "R, Durgadoss" <durgadoss.r@intel.com>
> > 
> > Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > Minor comment below. Ignore it at your pleasure - I am not really sure if this is one
> > we want to follow unless it is made non-strict.
> > 
> > Do you want me to take the patch ?
> 
> It's in my tree for now, I'll hand it over to you later if and only if
> you have patches which conflict with it.
> 
Nothing right now, so go with it.

> > > (...)
> > > --- linux-3.1-rc4.orig/drivers/hwmon/coretemp.c	2011-09-28 14:22:44.000000000 +0200
> > > +++ linux-3.1-rc4/drivers/hwmon/coretemp.c	2011-09-28 16:23:29.000000000 +0200
> > > @@ -210,7 +210,8 @@ static int adjust_tjmax(struct cpuinfo_x
> > >  
> > >  	/* Atom CPUs */
> > >  
> > > -	if (c->x86_model = 0x1c) {
> > > +	if (c->x86_model = 0x1c || c->x86_model = 0x26
> > > +	    || c->x86_model = 0x27) {
> > 
> > Upstream seems to have decided about logical continuations.
> > 
> > groeck@groeck-laptop:~/src/linux-staging$ scripts/checkpatch.pl --strict patches/coretemp
> > CHECK: Logical continuations should be on the previous line
> > #63: FILE: drivers/hwmon/coretemp.c:214:
> > +       if (c->x86_model = 0x1c || c->x86_model = 0x26
> > +           || c->x86_model = 0x27) {
> 
> I don't use --strict.
> 
Me not either, usually. Just remembered seeing the discussion on the kernel mailing list,
otherwise I would not have mentioned it.

> (I don't even think it should exist... Important things shall be
> enforced, unimportant things should not so as to lower the barrier for
> new contributors. The above is definitely not important.)
> 
Agreed. It doesn't really make much sense to exist. Some other maintainers insist
on following it, though, so one can not completely ignore it. Of course there are
maintainers who force you to explicitly violate Documentation/CodingStyle if you
want to get your code in, so it gets tricky at times to navigate the system ;).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
