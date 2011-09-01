From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Sep 2011 01:49:39 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V4] hwmon: OMAP4: On die temperature
Message-Id: <20110901014939.GB21986@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
 <1314811510-15595-7-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Walmsley <paul@pwsan.com>
Cc: Keerthy <j-keerthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Aug 31, 2011 at 08:36:43PM -0400, Paul Walmsley wrote:
> Hi
> 
> Some comments.
> 
> On Wed, 31 Aug 2011, Keerthy wrote:
> 
[ ... ]
> 
> > +}
> > +
> > +/* Sysfs hook functions */
> 
> These should be conditionally compiled out if sysfs isn't compiled in.
> 
The whole point of the hwmon subsystem is to expose hardware monitoring information
to userland using sysfs. hwmon without sysfs doesn't make sense.

So, if anything, it might make sense to disable the entire hwmon tree if sysfs is disabled.
But please no conditionals in the code.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
