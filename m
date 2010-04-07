From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 07 Apr 2010 11:57:11 +0000
Subject: Re: [lm-sensors] regulator: regulator_get behaviour without
Message-Id: <20100407115710.GB13576@rakim.wolfsonmicro.main>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100402184403.2ea1263e@hyperion.delvare>
 <20100402185138.GA12817@opensource.wolfsonmicro.com>
 <20100402213010.4a64e50f@hyperion.delvare>
 <20100402204503.GA15237@opensource.wolfsonmicro.com>
 <20100403173745.2bf17ee6@hyperion.delvare>
 <20100405132347.GA6580@rakim.wolfsonmicro.main>
 <1270567639.3229.56.camel@odin>
 <4BBB6083.2070903@cam.ac.uk>
 <1F9C625F-0467-4C6D-B57F-2E4FCAC76031@opensource.wolfsonmicro.com>
 <4BBC6B52.5030908@cam.ac.uk>
In-Reply-To: <4BBC6B52.5030908@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Jean Delvare <khali@linux-fr.org>, lm-sensors <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Apr 07, 2010 at 12:24:02PM +0100, Jonathan Cameron wrote:
> On 04/06/10 19:19, Mark Brown wrote:

> > TBH this seems like a very vanilla use case - there may be some small
> > advantage to representing the internal regulator via the regulator API
> > but that's about the only thing I can think might be a bit odd.

> I wasn't thinking of representing the internal regulator using the regulator
> framework (though if it is externally available I guess that would make sense
> though probably only if anyone is actually using this to supply something else
> - most likely case I can think of is daisy chaining multiple adc's and ensuring
> they have the same reference value).

Like I say, I think this is likely to be a small benefit from that.  The
rest of what you're doing seems very vanilla.

> Nothing new here, but there will be a number of consumers that care about changes
> in voltage (rather than typically controlling it.)  Hence I'm welcoming the change
> just agreed upon.

Note that you're not going to see any difference you can actually use
here - you still have to handle the possibility that you've got an
actual regulator but for some reason fail to read a voltage from it
which is the same behaviour that you see from the dummy regulator.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
