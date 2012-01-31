From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 31 Jan 2012 23:31:17 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: (hwmon-vid) Determine vrm during initialization, and add vrm
Message-Id: <1328052677.2261.85.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, 2012-01-31 at 16:38 -0500, Jean Delvare wrote:

[ ... ]

> >  /*
> >   * vrm is the VRM/VRD document version multiplied by 10.
> >   * val is the 4-bit or more VID code.
> >   * Returned value is in mV to avoid floating point in the kernel.
> >   * Some VID have some bits in uV scale, this is rounded to mV.
> > + *
> > + * Note: vrm is passed for legacy reasons to avoid API changes,
> > + * but no longer used.
> 
> I don't see the point of preserving the API. We usually don't do that.
> The API was wrong, you're fixing it, let's adjust all drivers
> accordingly and be done with it.
> 
I started looking into this.

Problem is that some callers pass a fixed vrm value to vid_from_reg().
See lm87.c or lm93.c. Can we safely ignore this, or do we have to retain
the parameter and use it if provided (ie if it is != 0) ?

On the plus side, if we retain the parameter and use it to override the
configured/calculated value, we can retain the API, and I can submit a
series of patches to remove vrm usage from the various drivers, instead
of a single large patch which does it all in one go. So this would have
some benefits.

[ ... ]

> > +}
> >  EXPORT_SYMBOL(vid_which_vrm);

> There should be no user left for this function if you don't attempt to
> preserve the API.
> 
Actually, turns out there is at least one user - the value is used in
w83627ehf.c to configure the chip. Not sure how to do that if the driver
can not retrieve the vrm value.

Then there is vid_to_reg(), which is currently an inline function. Guess
I'll have to move that to hwmon-vid.c and export it.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
