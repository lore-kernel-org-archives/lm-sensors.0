From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 30 Jul 2008 07:46:15 +0000
Subject: Re: [lm-sensors] [RESEND x9+ patch 2.6.26-git 1/2] lm75: cleanup
Message-Id: <20080730004615.f0686916.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807251523.28242.david-b@pacbell.net>
	<20080729233231.0ced6d9b.akpm@linux-foundation.org>
	<48901BF7.9050601@hhs.nl>
In-Reply-To: <48901BF7.9050601@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, 30 Jul 2008 09:44:55 +0200 Hans de Goede <j.w.r.degoede@hhs.nl> wrote:

> > > Minor cleanup and reorg of the lm75 code.
> >
> > This patch (and the other) have been in Mark's tree for a month or so. 
> > (linux-next <- useful!)
>  >
> > Mark has been pretty, umm, low-key lately.  I've attached the full
> > git-hwmon changelog below and the authors of all those changes are
> > cc'ed.
> >
> > Could people please confirm that what is in linux-next is still the
> > latest and greatest version of their changes?  If so, I shall plan on
> > fishing those changes out of there and getting them into -rc2.
> 
> Andrew,
> 
> I see that atleast this patch:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-July/023629.html
> 
> Is missing which is a minor yet somewhat important bugfix to the abituguru3 
> driver, see:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-July/023630.html
> 
> For my: "Acked-by: Hans de Goede <j.w.r.degoede at hhs.nl>" Line (I'm the 
> maintainer of that driver).
> 
> It would be nice if this fix could make 2.6.27.
> 

OK.  Can you please email me any patches which you think should be in
2.6.27 in the usual manner, with the appropriate mailing list cc's?  Add
your own signed-off-by: if needed.  I'll get it all lined up.

Or Jean can do it if he'd prefer - the main thing is to not let
people's reviewed, tested and merged code fall out of 2.6.27.

> 
> Also Jean has been doing a lot of patches for all i2c hwmon driver to convert 
> them to new style driver binding, and I've reviewed and Acked the entire bunch.
> So all in all it looks like we're dropping patches, does anyone know whats up 
> with Mark, holiday or ... ?

He did mention a while ago that he had little time, but I don't know
whether that is a temporary state.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
