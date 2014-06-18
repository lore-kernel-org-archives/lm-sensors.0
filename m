From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 18 Jun 2014 17:03:46 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (wm831x) Convert to	devm_hwmon_device_register_with_groups
Message-Id: <20140618170346.GB3412@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403017855.5292.1.camel@phoenix>
In-Reply-To: <1403017855.5292.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 18, 2014 at 07:37:08AM -0700, Guenter Roeck wrote:
> On 06/17/2014 08:10 AM, Axel Lin wrote:
> > Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> > simplify the code a bit.
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> 
> Looks good to me. Applied to -next to get some exposure.
> 
> Guenter

They both look good to me too (sorry about being a bit slow
looking at these):

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
