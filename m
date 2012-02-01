From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 01 Feb 2012 14:48:54 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: (hwmon-vid) Determine vrm during initialization, and add vrm
Message-Id: <20120201144854.GA14099@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 01, 2012 at 03:01:38AM -0500, Jean Delvare wrote:
> On Tue, 31 Jan 2012 15:31:17 -0800, Guenter Roeck wrote:
> > On Tue, 2012-01-31 at 16:38 -0500, Jean Delvare wrote:
> > > I don't see the point of preserving the API. We usually don't do that.
> > > The API was wrong, you're fixing it, let's adjust all drivers
> > > accordingly and be done with it.
> > 
> > I started looking into this.
> > 
> > Problem is that some callers pass a fixed vrm value to vid_from_reg().
> > See lm87.c or lm93.c. Can we safely ignore this, or do we have to retain
> > the parameter and use it if provided (ie if it is != 0) ?
> 
> I don't see that in lm87.c, I presume you meant lm78.c. For lm78 this
> is clearly a bug, the driver was written before multiple VRM versions
> existed, and was never adapter to support other VRM versions. So you
> can ignore it.
> 
> For lm93 the hard-coded value is because the chip support relative
> Vcore voltage limits (which adjust themselves as the VID code changes)
> and that can only work if the chip itself knows how to interpret the
> codes. As the LM93 only knows of VRM 10.x, This strongly suggested that
> the chip will never be used in combinations with other CPUs, thus the
> hard-coded VRM. I don't think it was so smart though, as the LM93 could
> still be used with other CPUs, simply the dynamic Vcore limit feature
> can't be used. Also note that the driver now supports the LM94 which
> _does_ support VRD 10 and VRD 11, so the hard-coded value is really
> incorrect.
> 
> In general, if a driver wants to only support a specific VRM value, it
> should now call vid_witch_vrm() and fail loading or limit its features
> if the value isn't what it wanted.
> 
Ok, makes sense.

> > On the plus side, if we retain the parameter and use it to override the
> > configured/calculated value, we can retain the API, and I can submit a
> > series of patches to remove vrm usage from the various drivers, instead
> > of a single large patch which does it all in one go. So this would have
> > some benefits.
> 
> I think we'll end up removing the extra parameter. But if you want to
> keep it for the time being because you feel more comfortable that way
> or you believe it offers a smoother update path, that's your call.
> 
> > > > +}
> > > >  EXPORT_SYMBOL(vid_which_vrm);
> > >
> > > There should be no user left for this function if you don't attempt to
> > > preserve the API.
> >
> > Actually, turns out there is at least one user - the value is used in
> > w83627ehf.c to configure the chip. Not sure how to do that if the driver
> > can not retrieve the vrm value.
> 
> Good point, vid_which_vrm must stay.
> 
> > Then there is vid_to_reg(), which is currently an inline function. Guess
> > I'll have to move that to hwmon-vid.c and export it.
> 
> Correct.
> 
Another key question: Can I remove the vrm attribute entirely from all drivers,
and/or can I even make it read-only, without going through the feature removal 
process ? It is documented in the ABI, and libsensors supports it.

Maybe I should only apply the patch to hwmon-vid.c now, and schedule vrm removal
for something like 2013 ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
