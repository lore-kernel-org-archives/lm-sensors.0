From: Lukasz Majewski <l.majewski@samsung.com>
Date: Wed, 14 Jan 2015 15:07:53 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/8] thermal: Provide stub for thermal_cdev_update() function
Message-Id: <20150114160753.48f903da@amdc2363>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-3-git-send-email-l.majewski@samsung.com>
 <20150102184028.GA12371@developer>
In-Reply-To: <20150102184028.GA12371@developer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

Hi Eduardo,

> On Mon, Dec 22, 2014 at 05:27:42PM +0100, Lukasz Majewski wrote:
> > Odroid U3 fan can work without being registered as OF cooling device
> > (with CONFIG_THERMAL_OF disabled).
> > In this situation it can be controlled via PWM entry at
> > /sys/class/hwmon/hwmon0/pwm1.
> > 
> > Therefore, the thermal_cdev_update() function needs a stub
> > to allow clean compilation.
> 
> I am not sure I understand what you are attempting to do here. What is
> the relation that you see between CONFIG_OF_THERMAL and
> thermal_cdev_update? 

It should be CONFIG_THERMAL, not CONFIG_OF_THERMAL.

The thermal_cdev_update() is necessary since pwm-fan code can be
run without THERMAL subsystem (and such configuration is perfectly
valid).

> 
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> > Changes for v2:
> > - New patch
> > ---
> >  include/linux/thermal.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 871123c..b3515b5 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -332,6 +332,7 @@ struct thermal_cooling_device *
> >  thermal_of_cooling_device_register(struct device_node *np,
> >  				   char *type, void *devdata,
> >  				   const struct
> > thermal_cooling_device_ops *); +void thermal_cdev_update(struct
> > thermal_cooling_device *); #else
> >  static inline struct thermal_zone_device *
> >  thermal_zone_of_sensor_register(struct device *dev, int id, void
> > *data, @@ -353,6 +354,10 @@
> > thermal_of_cooling_device_register(struct device_node *np, {
> >  	return NULL;
> >  }
> > +
> > +static inline void thermal_cdev_update(struct
> > thermal_cooling_device *cdev) +{
> > +}
> >  #endif
> >  struct thermal_zone_device *thermal_zone_device_register(const
> > char *, int, int, void *, struct thermal_zone_device_ops *,
> > @@ -375,7 +380,6 @@ int thermal_zone_get_temp(struct
> > thermal_zone_device *tz, unsigned long *temp); int
> > get_tz_trend(struct thermal_zone_device *, int); struct
> > thermal_instance *get_thermal_instance(struct thermal_zone_device
> > *, struct thermal_cooling_device *, int); -void
> > thermal_cdev_update(struct thermal_cooling_device *); void
> > thermal_notify_framework(struct thermal_zone_device *, int); 
> >  #ifdef CONFIG_NET
> > -- 
> > 2.0.0.rc2
> > 


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
