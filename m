From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Jun 2014 17:47:31 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (wm831x) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140618174731.GA19515@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403017855.5292.1.camel@phoenix>
In-Reply-To: <1403017855.5292.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 18, 2014 at 06:03:46PM +0100, Charles Keepax wrote:
> On Wed, Jun 18, 2014 at 07:37:08AM -0700, Guenter Roeck wrote:
> > On 06/17/2014 08:10 AM, Axel Lin wrote:
> > > Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> > > simplify the code a bit.
> > >
> > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > > ---
> > 
> > Looks good to me. Applied to -next to get some exposure.
> > 
> > Guenter
> 
> They both look good to me too (sorry about being a bit slow
> looking at these):
> 
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
No problem; maybe I am just impatient ;-).
Thanks a lot for looking into it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
