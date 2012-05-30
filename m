From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 May 2012 18:17:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Improve support of recent Atom CPU models
Message-Id: <20120530201719.6fa55fcc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120530132956.6161d552@endymion.delvare>
In-Reply-To: <20120530132956.6161d552@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 30 May 2012 08:22:03 -0700, Guenter Roeck wrote:
> On Wed, May 30, 2012 at 07:29:56AM -0400, Jean Delvare wrote:
> > Document the new Atom series (Tunnel Creek and Medfield) as being
> > supported, and list TjMax for the Atom E600 series.
> > 
> > Also enable the Atom tjmax heuristic for these Atom CPU models.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Alexander Stein <alexander.stein@systec-electronic.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: "R, Durgadoss" <durgadoss.r@intel.com>
> 
> Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Minor comment below. Ignore it at your pleasure - I am not really sure if this is one
> we want to follow unless it is made non-strict.
> 
> Do you want me to take the patch ?

It's in my tree for now, I'll hand it over to you later if and only if
you have patches which conflict with it.

> > (...)
> > --- linux-3.1-rc4.orig/drivers/hwmon/coretemp.c	2011-09-28 14:22:44.000000000 +0200
> > +++ linux-3.1-rc4/drivers/hwmon/coretemp.c	2011-09-28 16:23:29.000000000 +0200
> > @@ -210,7 +210,8 @@ static int adjust_tjmax(struct cpuinfo_x
> >  
> >  	/* Atom CPUs */
> >  
> > -	if (c->x86_model = 0x1c) {
> > +	if (c->x86_model = 0x1c || c->x86_model = 0x26
> > +	    || c->x86_model = 0x27) {
> 
> Upstream seems to have decided about logical continuations.
> 
> groeck@groeck-laptop:~/src/linux-staging$ scripts/checkpatch.pl --strict patches/coretemp
> CHECK: Logical continuations should be on the previous line
> #63: FILE: drivers/hwmon/coretemp.c:214:
> +       if (c->x86_model = 0x1c || c->x86_model = 0x26
> +           || c->x86_model = 0x27) {

I don't use --strict.

(I don't even think it should exist... Important things shall be
enforced, unimportant things should not so as to lower the barrier for
new contributors. The above is definitely not important.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
