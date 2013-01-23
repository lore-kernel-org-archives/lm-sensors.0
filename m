From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 23 Jan 2013 04:30:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Texas Instruments INA209
Message-Id: <20130123043032.GA30235@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090831_202450_066558.tomaz.mertelj@guest.arnes.si>
In-Reply-To: <20090831_202450_066558.tomaz.mertelj@guest.arnes.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 22, 2013 at 02:15:30PM -0800, Ira W. Snyder wrote:
> On Tue, Jan 22, 2013 at 01:43:48PM -0800, Ira W. Snyder wrote:
> > On Mon, Jan 14, 2013 at 10:04:28PM -0800, Guenter Roeck wrote:
> > > On Mon, Jan 14, 2013 at 01:17:04PM -0800, Ira W. Snyder wrote:
> > > > On Sat, Jan 12, 2013 at 04:16:04PM -0800, Guenter Roeck wrote:
> > > > > Add support for the TI / Burr-Brown INA209 voltage / current / power
> > > > > monitor.
> > > > > 
> > > > > Cc: Paul Hays <haysp@magma.net>
> > > > > Cc: Ira W. Snyder <iws@ovro.caltech.edu>
> > > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > 
> > > > Hi Guenter,
> > > > 
> > > > I didn't notice any issues with a quick review. Thanks for pushing the
> > > > driver to mainline.
> > > > 
> > > Hi Ira,
> > > 
> > > you are welcome. I actually had the code in my queue for a long time;
> > > I just found some time last weekend to finally test it.
> > > 
> > > It would be great if you can do some testing and send me a Tested-by and/or
> > > Acked-by feedback.
> > > 
> > 
> > Hi Guenter,
> > 
> > I finally got around to testing this today. The driver works great.
> > Please add my:
> > 
> > Tested-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > 
> 
> One minor suggestion below. Sorry that I didn't catch it earlier.
> 
Hi Ira,

I just sent a new version of the driver, with added devicetree support as you
suggested. Would be great if you can test it again.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
