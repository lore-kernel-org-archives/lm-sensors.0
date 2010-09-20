From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 20 Sep 2010 14:09:05 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: twl4030: Driver for twl4030
Message-Id: <20100920140905.GB1306@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284632604-25303-1-git-send-email-j-keerthy@ti.com>
 <20100916151736.GC14165@ericsson.com>
 <FF55437E1F14DA4BAEB721A458B6701706C5991EB8@dbde02.ent.ti.com>
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706C5991EB8@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Hi,
On Mon, Sep 20, 2010 at 06:34:24AM -0400, J, KEERTHY wrote:
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> > Sent: Thursday, September 16, 2010 8:48 PM
> > To: J, KEERTHY
> > Cc: linux-omap@vger.kernel.org; lm-sensors@lm-sensors.org; Krishnamoorthy,
> > Balaji T
> > Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: twl4030: Driver for twl4030
> > madc module
> >
[...]
> > > +EXPORT_SYMBOL(twl4030_madc_conversion);
> > > +
> > If this function is going to be called  from external code, it should not
> > really be defined here. I would suggest to move it to a global location
> > such as
> > mfd instead, including all related functions.
> >
> > The existence of this function export indicates that another non-hwmon
> > driver depends on this one, which should not really be the case. Another
> > reason to have a separate common driver instead, and mfd might just be the
> > place for it.
> Few kernel modules need to perform ADC conversion to measure battery
> voltage, battery temperature, VBUS voltage via twl4030_madc_conversion.
> the_madc is needed as those drivers will not have this device pointer.
> 
The point I was trying to make is that this function (as well as the ioctl)
should not be in this driver in the first place. hwmon is about providing 
hwmon information, not about providing adc readings to another driver.

Or, in other words, hwmon should be a consumer of information from other drivers,
not a producer of information to other drivers.

There should be a higher level driver (presumably a mfd driver) to provide
adc readings to all consumers, ie to all callers of twl4030_madc_conversion().
This driver can provide all data and information needed by more than one driver,
and would also be the logical place for the ioctl providing raw adc readings 
to the user.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
