From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Tue, 11 May 2010 03:41:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V2] hwmon: (coretemp) Detect the
Message-Id: <20100511034138.GA19762@owl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100507095459.GA12190@owl>
 <20100510033525.GC9181@owl>
 <148928.1273495551@localhost>
In-Reply-To: <148928.1273495551@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valdis.Kletnieks@vt.edu
Cc: Huaxu Wan <huaxu.wan@linux.intel.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, huaxu.wan@intel.com, Carsten Emde <Carsten.Emde@osadl.org>

On 08:45 Mon 10 May, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 10 May 2010 11:35:25 +0800, Huaxu Wan said:
> > -
> > -		/* check if family 6, models 0xe (Pentium M DC),
> > -		  0xf (Core 2 DC 65nm), 0x16 (Core 2 SC 65nm),
> > -		  0x17 (Penryn 45nm), 0x1a (Nehalem), 0x1c (Atom),
> > -		  0x1e (Lynnfield) */
> > -		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
> > -		    !((c->x86_model = 0xe) || (c->x86_model = 0xf) ||
> > -			(c->x86_model = 0x16) || (c->x86_model = 0x17) ||
> > -			(c->x86_model = 0x1a) || (c->x86_model = 0x1c) ||
> > -			(c->x86_model = 0x1e))) {
> 
> So we remove something that checks the CPU level for a model we *expect*
> to find a thermal sensor, and only throws a KERN_WARNING if we're on a
> model we don't know about...
> 
> > + 		/* check if the CPU has thermal sensor */
> > + 		eax = cpuid_eax(0x06);
> > + 		if (!(eax & 0x01)) {
> > + 			struct cpuinfo_x86 *c = &cpu_data(i);
> > + 			printk(KERN_WARNING DRVNAME ": CPU (model=0x%x)"
> > + 				" has no thermal sensor!\n", c->x86_model);
> 
> And replace it with a totally unprotected check that's going to fire off
> a KERN_WARNING on every single CPU that Intel ever made that doesn't
> include a hardware thermal sensor - including all the family 0-5,
> and model < 0x0e hardware.

Oops! That's a bug. Thank you!

> 
> KERN_WARNING is for "We expected to find the hardware but it's gone off
> for a walk on us".  If you wanted to say "Hmm.. this CPU doesn't have one"
> you probably wanted KERN_DEBUG or *maybe* KERN_INFO.

I think the better one is KERN_INFO here. 

-- 
Thanks
Huaxu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
