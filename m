From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Sep 2011 17:13:29 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <1315847609.2455.184.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-09-12 at 12:18 -0400, Jean Delvare wrote:
> Hi Guenter, Durgadoss,
> 
> Sorry for the very late comment.
> 
> On Wed, 13 Jul 2011 13:48:11 -0700, Guenter Roeck wrote:
> > On Tue, 2011-07-12 at 07:07 -0400, Durgadoss R wrote: 
> > > This patch adds the core and pkg support to coretemp.
> > > These thresholds can be configured via the sysfs interfaces tempX_max
> > > and tempX_max_hyst. An interrupt is generated when CPU temperature reaches
> > > or crosses above tempX_max OR drops below tempX_max_hyst.
> > > 
> > > This patch is based on the documentation in IA Manual vol 3A, that can be
> > > downloaded from here:
> > > http://download.intel.com/design/processor/manuals/253668.pdf
> > > 
> > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > 
> > Looks like it is working now, so I applied the patch to -next.
> 
> Working, really? That's not how it looks like from here.
> 
Frankly, I don't remember how I tested it - though I remember that I
did. I re-tested it on a Xeon C5528 and got the same results :(. Maybe I
was mentally unstable at the time or something. Sorry for that - should
not happen.

Question is what to do - back it out ? I don't have time to look into it
more right now.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
