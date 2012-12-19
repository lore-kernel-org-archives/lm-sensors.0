From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Dec 2012 21:35:02 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (emc6w201) Fix DIV_ROUND_CLOSEST problem with unsigned divisors
Message-Id: <20121219223502.41ffe6a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355932908-22131-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1355932908-22131-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 19 Dec 2012 17:27:33 +0100, Jean Delvare wrote:
> On Wed, 19 Dec 2012 08:26:10 -0800, Guenter Roeck wrote:
> > On Wed, Dec 19, 2012 at 05:17:00PM +0100, Jean Delvare wrote:
> > > Hi Guenter,
> > > 
> > > On Wed, 19 Dec 2012 08:01:48 -0800, Guenter Roeck wrote:
> > > > Result of DIV_ROUND_CLOSEST is undefined for negative dividends if the divisor
> > > > variable type is unsigned. Fix by declaring divisor as signed variable.
> > > > 
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> > > > v2: Fix by changing divisor variable type instead of dividend variable type
> > > > 
> > > >  drivers/hwmon/emc6w201.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
> > > > index a98c917..789bd4f 100644
> > > > --- a/drivers/hwmon/emc6w201.c
> > > > +++ b/drivers/hwmon/emc6w201.c
> > > > @@ -187,7 +187,7 @@ static struct emc6w201_data *emc6w201_update_device(struct device *dev)
> > > >   * Sysfs callback functions
> > > >   */
> > > >  
> > > > -static const u16 nominal_mv[6] = { 2500, 1500, 3300, 5000, 1500, 1500 };
> > > > +static const s16 nominal_mv[6] = { 2500, 1500, 3300, 5000, 1500, 1500 };
> > > >  
> > > >  static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
> > > >  	char *buf)
> > > 
> > > Applied, thanks.
> > 
> > Can you take the kernel.h patch as well ?
> 
> Yes I can. I'm sending my hwmon patches to Linus tonight.
> 
> For clarity: both patches are needed but they are otherwise
> independent, right?

Note: I finally refrained from including both commits in my pull
request, I want to take a closer look first. If nothing else, to decide
whether they should go to stable trees or not.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
