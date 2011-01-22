From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 22 Jan 2011 20:40:50 +0000
Subject: Re: [lm-sensors] 2.6.38-rc1/-2: applesmc lockdep warning
Message-Id: <20110122204050.GB22252@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110122134513.1e1d512a@stein>
 <20110122200002.GA1677@polaris.bitmath.org>
In-Reply-To: <20110122200002.GA1677@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jan 22, 2011 at 03:00:02PM -0500, Henrik Rydberg wrote:
> > BUG: key f4891a1c not in .data!
> [...]
> > Any ideas where this may come from?
> 
> The patch below seems to fix the problem, but a verification would be most
> welcome. Gunther, do you want to take it, or should it route it through
> my tree?
> 
I can take it.

Looks pretty straightforward. Do you think it is ready for upstream,
or should I wait for verification ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
