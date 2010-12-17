From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Fri, 17 Dec 2010 21:57:08 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] applesmc: Use PnP rather
Message-Id: <20101217215708.GA10995@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292513589-14651-1-git-send-email-mjg@redhat.com> <20101216170018.GA8140@ericsson.com>
In-Reply-To: <20101216170018.GA8140@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "rydberg@euromail.se" <rydberg@euromail.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Dec 16, 2010 at 09:00:18AM -0800, Guenter Roeck wrote:

> I am having trouble applying this patch to my -next tree. The driver there
> (and in the official -next tree) has subtle differences to your version.
> What tree is your patch based on ? Can you rebase it to the -next tree and resubmit ?

My mistake - I'd pulled the patches from LKML, but it looks like there 
was a later version of one or two.

> Couple of comments below; not necessarily complete, since I can not apply the patch.
> I hope Henrik can comment on the merits of the patch itself, ie if it is known to work
> with all systems.

> > +struct pnp_dev *pdev;
> > +struct applesmc_pnp_device *pnp_device;
> > +
> Please make those variables static.

Oops! Yup.

> Just wondering ...  applesmc_pnp_device doesn't seem to be necessary. 
> Why not just use the global variable directly if you have it anyway ?

This ended up left over as part of an attempt to get rid of the 
globals...

> > +       pnp_set_drvdata(dev, applesmc_pnp_device);
> > +
> 
> ... but then since you assign it to drvdata, can you get rid of the global variable 
> and use pnp_get_drvdata() whereever it is needed instead ?

But then I ran into some awkward issue and decided to leave it. And then 
failed to clean everything up. I'll repost without that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
