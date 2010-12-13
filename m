From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Dec 2010 16:53:43 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Compute MAX_SUBFEATURES
Message-Id: <20101213165343.GA26581@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101213135842.73b08221@endymion.delvare>
In-Reply-To: <20101213135842.73b08221@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 13, 2010 at 10:51:32AM -0500, Jean Delvare wrote:
> On Mon, 13 Dec 2010 07:20:56 -0800, Guenter Roeck wrote:
> > On Mon, Dec 13, 2010 at 07:58:42AM -0500, Jean Delvare wrote:
> > > Reference: http://www.lm-sensors.org/ticket/2378
> > > 
> > > This is a candidate patch to let libsensors compute MAX_SUBFEATURES
> > > dynamically. This should avoid accidental overflows when we add new
> > > subfeatures.
> > > 
> > > An alternative is to keep it a constant and add code to check for
> > > overflows. I had a patch ready, but if we are going to add code, I'd
> > > rather add code that get things right than code which only spots when
> > > things are wrong.
> > > 
> > > Then we can discuss what do to with the other constants.
> > > 
> > > MAX_MAIN_SENSOR_TYPES and MAX_OTHER_SENSOR_TYPES could be easily
> > > computed in the same loops which now compute MAX_SUBFEATURES. It's only
> > > a few code lines to add. OTOH it can be discussed whether they are
> > > worth the runtime cost, given that adding a new feature is a rare
> > > event, so we should be able to deal with it. I would like to hear
> > > opinions about this.
> > > 
> > Added runtime cost is really negligible, so that isn't really an argument for me.
> > But it is a really rare event, so it doesn't seem to be worth the effort - at least
> > as long as compilation fails if the limit is exceeded.
> 
> Unfortunately, no, the compilation doesn't fail, and this is the
> problem. A bug would lead to an overflow at run-time.
> 
> Adding a run-time check preventing the overflow (and basically ignoring
> the new features) could be done. But then again, if we add code, we
> might as well add code which computes things dynamically, rather than
> code to work around our mistakes.
> 
> At the moment, when one adds a entry to enum sensors_feature_type in
> sensors.h, he or she has to think of increasing MAX_MAIN_SENSOR_TYPES
> or MAX_OTHER_SENSOR_TYPES in sysfs.c. We could put a note in sensors.h
> about it, but OTOH I don't like to mention internal implementation
> details in a public header file.
> 
> But looking at sensors.h... maybe I have an idea how to solve this
> elegantly. Let me give it a try.
> 
If that doesn't work, or ends up being complicated, I'd suggest to go with
runtime detection after all. Or, in other words, KISS should be the deciding
factor.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
