From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 25 Jul 2014 16:33:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pwm-fan) Make SENSORS_PWM_FAN depend on OF
Message-Id: <20140725163358.GB14717@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406297975.4906.1.camel@phoenix>
In-Reply-To: <1406297975.4906.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 25, 2014 at 05:55:20PM +0200, Jean Delvare wrote:
> Hi Axel,
> 
> On Fri, 25 Jul 2014 22:19:35 +0800, Axel Lin wrote:
> > This driver won't instantiate if OF is not configured, thus add OF dependency.
> > Also add COMPILE_TEST to increase build testing coverage.
> > 
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> >  drivers/hwmon/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index b93ab97..b9a2764 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1130,7 +1130,7 @@ source drivers/hwmon/pmbus/Kconfig
> >  
> >  config SENSORS_PWM_FAN
> >  	tristate "PWM fan"
> > -	depends on PWM
> > +	depends on (PWM && OF) || COMPILE_TEST
> >  	help
> >  	  If you say yes here you get support for fans connected to PWM lines.
> >  	  The driver uses the generic PWM interface, thus it will work on a
> 
> Does the driver build without PWM? If it does then the patch is correct
> and you can add:
> 
Yes, it does build. To test it, I removed the PWM dependency, disabled
PWM, and tried to build it. I did this with CONFIG_OF enabled and disabled
(with arm as target). All variants passed, so I think we should be ok.

I'll apply the patch and run it through my full suite of builds. That should
hopefully tell us if there are any problems.

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
