From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 01 Sep 2011 04:09:14 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V4] hwmon: OMAP4: On die temperature
Message-Id: <alpine.DEB.2.00.1108312200260.26173@utopia.booyaka.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com> <1314811510-15595-7-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com> <20110901014939.GB21986@ericsson.com>
In-Reply-To: <20110901014939.GB21986@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Keerthy <j-keerthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, 31 Aug 2011, Guenter Roeck wrote:

> On Wed, Aug 31, 2011 at 08:36:43PM -0400, Paul Walmsley wrote:
> > Hi
> > 
> > Some comments.
> > 
> > On Wed, 31 Aug 2011, Keerthy wrote:
> > 
> [ ... ]
> > 
> > > +}
> > > +
> > > +/* Sysfs hook functions */
> > 
> > These should be conditionally compiled out if sysfs isn't compiled in.
> > 
> The whole point of the hwmon subsystem is to expose hardware monitoring information
> to userland using sysfs. hwmon without sysfs doesn't make sense.
> 
> So, if anything, it might make sense to disable the entire hwmon tree if sysfs is disabled.
> But please no conditionals in the code.

Hmm.  This IP block is more than just a sensor.  It also can interrupt the 
CPU and/or trigger a GPIO line (to shut down the chip) if the chip 
temperature crosses some thresholds.  On some OMAPs, the thresholds are 
fixed; on others, they are software-programmable.  That functionality 
shouldn't require sysfs; it's almost closer to an x86 MCE.

So based on your comments, it sounds like we should move that part of the 
code to a different driver, and just leave the basic software thermal 
monitoring here?


- Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
