From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jul 2011 11:28:17 +0000
Subject: Re: [lm-sensors] [v3] Add support for the Philips SA56004
Message-Id: <20110707132817.65629f1b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
	<20110626202648.GA9118@ericsson.com>
In-Reply-To: <20110626202648.GA9118@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: sdevrien@cisco.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Guenter,

On Sun, 26 Jun 2011 13:26:48 -0700, Guenter Roeck wrote:
> On Mon, Jun 06, 2011 at 10:40:45AM -0000, sdevrien@cisco.com wrote:
> > From: Stijn Devriendt <sdevrien@cisco.com>
> > 
> > Add support for the Philips SA56004, an LM86
> > compatible temperature sensor.
> > 
> > Changes since v2:
> > - Changed BUG_ON to WARN_ON
> > Changes since v1:
> > - Updated documentation
> > - Trace replaced by BUG_ON
> > - style updates
> > 
> > Signed-off-by: Stijn Devriendt <sdevrien@cisco.com>
> > Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> I don't see a reason for holding this patch up further. Applied to -next.
> If you disagree, please speak up now or be silent forever.

Sorry for the long silence, I was frightened by the long discussion
back then - it's only today that I went through it to find most of it
was actually noise.

I don't have major objections to the patch, only a few things which I
think could be improved. So it's OK that your picked the patch as is,
I'll submit incremental patches for comments and review.

Stijn, please accept my apologies for being way less reactive than I
should have been, being the lm90 driver maintainer. And big thanks to
Guenter for backing me up.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
