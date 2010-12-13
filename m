From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Dec 2010 15:51:32 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Compute MAX_SUBFEATURES
Message-Id: <20101213165132.2cc9445a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101213135842.73b08221@endymion.delvare>
In-Reply-To: <20101213135842.73b08221@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Dec 2010 07:20:56 -0800, Guenter Roeck wrote:
> On Mon, Dec 13, 2010 at 07:58:42AM -0500, Jean Delvare wrote:
> > Reference: http://www.lm-sensors.org/ticket/2378
> > 
> > This is a candidate patch to let libsensors compute MAX_SUBFEATURES
> > dynamically. This should avoid accidental overflows when we add new
> > subfeatures.
> > 
> > An alternative is to keep it a constant and add code to check for
> > overflows. I had a patch ready, but if we are going to add code, I'd
> > rather add code that get things right than code which only spots when
> > things are wrong.
> > 
> > Then we can discuss what do to with the other constants.
> > 
> > MAX_MAIN_SENSOR_TYPES and MAX_OTHER_SENSOR_TYPES could be easily
> > computed in the same loops which now compute MAX_SUBFEATURES. It's only
> > a few code lines to add. OTOH it can be discussed whether they are
> > worth the runtime cost, given that adding a new feature is a rare
> > event, so we should be able to deal with it. I would like to hear
> > opinions about this.
> > 
> Added runtime cost is really negligible, so that isn't really an argument for me.
> But it is a really rare event, so it doesn't seem to be worth the effort - at least
> as long as compilation fails if the limit is exceeded.

Unfortunately, no, the compilation doesn't fail, and this is the
problem. A bug would lead to an overflow at run-time.

Adding a run-time check preventing the overflow (and basically ignoring
the new features) could be done. But then again, if we add code, we
might as well add code which computes things dynamically, rather than
code to work around our mistakes.

At the moment, when one adds a entry to enum sensors_feature_type in
sensors.h, he or she has to think of increasing MAX_MAIN_SENSOR_TYPES
or MAX_OTHER_SENSOR_TYPES in sysfs.c. We could put a note in sensors.h
about it, but OTOH I don't like to mention internal implementation
details in a public header file.

But looking at sensors.h... maybe I have an idea how to solve this
elegantly. Let me give it a try.

> > Lastly, making MAX_SENSORS_PER_TYPE dynamic would be very nice, as it
> > would avoid allocating more memory than we need (and supporting
> > virtually unlimited channel numbers, if people have really big sensor
> > chips.) But this means reworking the discovery loop significantly, as
> > we would need a first pass to find out the maximum channel number. This
> > will come at a runtime cost which we want to minimize. And I do not
> > have the time to work on this at the moment.
>
> Not sure if that is really worth it. I would not do it.

We had to increase MAX_SENSORS_PER_TYPE recently, for the W83785G/ADG.
Users of these chips have to use lm-sensors 3.2.0 or later for proper
support. We tried hard to make it possible to run old versions of
lm-sensors with recent hardware, and this is an example of failure.

It isn't possible to say if 24 will be OK in the future. 4 years ago I
would have laughed at you if you had claimed that devices supporting
more than 16 of a given sensor type would ever exist. To play it safe,
we would increase MAX_SENSORS_PER_TYPE to 32 or even 64, but then think
of the memory we allocate on all systems which don't need it. I know
the allocation is temporary, but still. Things get worse as we add new
sensor types and new subfeatures. While each device only has a limited
set of channels, the memory allocation we do keeps growing. I don't
like this feeling that we ask for more and more memory and we don't
really control it. Making MAX_SENSORS_PER_TYPE dynamic would be one
possible answer.

But again, this isn't trivial, and I don't have the time to do it now.
So for now I'll follow your advice ;)

> 
> > ---
> >  lib/sysfs.c |   36 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 33 insertions(+), 3 deletions(-)
> > 
> > --- lm-sensors.orig/lib/sysfs.c	2010-12-13 10:50:42.000000000 +0100
> > +++ lm-sensors/lib/sysfs.c	2010-12-13 11:40:05.000000000 +0100
> > @@ -139,8 +139,8 @@ char sensors_sysfs_mount[NAME_MAX];
> >  #define MAX_MAIN_SENSOR_TYPES	6
> >  #define MAX_OTHER_SENSOR_TYPES	2
> >  #define MAX_SENSORS_PER_TYPE	24
> > -#define MAX_SUBFEATURES		8
> > -#define FEATURE_SIZE		(MAX_SUBFEATURES * 2)
> > +/* max_subfeatures is now computed dynamically */
> > +#define FEATURE_SIZE		(max_subfeatures * 2)
> >  #define FEATURE_TYPE_SIZE	(MAX_SENSORS_PER_TYPE * FEATURE_SIZE)
> >  
> >  /* Room for all 6 main types (in, fan, temp, power, energy, current) and 2
> > @@ -337,6 +337,31 @@ sensors_subfeature_type sensors_subfeatu
> >  	return SENSORS_SUBFEATURE_UNKNOWN;
> >  }
> >  
> > +static void sensors_compute_max(int *max_subfeatures)
> > +{
> 
> Maybe personal preference, but I think it would be better (and a bit more efficient)
> to return the result as function result, and not write it into a pointer.

My first attempt did exactly that. I changed my mind in preparation of
two additional pointers being passed for MAX_MAIN_SENSOR_TYPES and
MAX_OTHER_SENSOR_TYPES. But if this doesn't happen, I'll revert to the
original implementation which you'll prefer.

> Otherwise, code looks good.

Thanks for the review.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
