From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 07 Feb 2011 04:50:05 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110207045005.GA32310@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 06, 2011 at 10:50:02PM -0500, Andy Lutomirski wrote:
> On 02/05/2011 12:58 PM, Guenter Roeck wrote:
> > Hi,
> >
> > a standalone driver for W83667HG-I (NCT6771F, NCT6775F) and NCT6776F
> > is available for testing at http://roeck-us.net/linux/drivers/w83627ehf/.
> >
> > Please test and let me know if there are any problems.
> 
> It appears to mostly work on an Intel DH67GD (nct6775).  There are two 
> issues:
> 
> 1. The first time I ran 'sensors', my CPU fan showed 0 RPM instead of 
> the correct value (~134).  Running it again shows the correct value.
> 
If you check the log, you might see a notice that the fan divisors were modified.
Can you check ?

> 2. PWM control doesn't seem to have any effect.  (The BIOS PWM control
> settings definitely work.)
> 
Ok, I'll look into it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
