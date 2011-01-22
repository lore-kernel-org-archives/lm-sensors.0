From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 22 Jan 2011 21:18:14 +0000
Subject: Re: [lm-sensors] 2.6.38-rc1/-2: applesmc lockdep warning
Message-Id: <20110122211814.GA22465@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110122134513.1e1d512a@stein>
 <20110122200002.GA1677@polaris.bitmath.org>
 <20110122204050.GB22252@ericsson.com>
 <20110122205254.GA2854@polaris.bitmath.org>
In-Reply-To: <20110122205254.GA2854@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jan 22, 2011 at 03:52:54PM -0500, Henrik Rydberg wrote:
> > I can take it.
> 
> Great, thanks.
> 
> > Looks pretty straightforward. Do you think it is ready for upstream,
> > or should I wait for verification ?
> 
> I was able to reproduce the problem, but a verification would still be
> good, just in case - if possible. AFAICT, it will be another week
> before rc3, so there seems to be no rush.
> 
Ok, let's do it that way: I applied it, but won't submit to Linus yet.
This way we get some basic coverage through linux-next for a couple of days.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
