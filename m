From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 20 Feb 2012 23:57:33 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <20120220235733.GB24915@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 20, 2012 at 05:56:08PM -0500, Roland Stigge wrote:
> On 20/02/12 22:59, Chris wrote:
> > Patch to fix FAN_FROM_REG calculations
> > Signed-off-by: Chris D Schimp <silverchris <at> gmail.com>
> 
> Thanks for your work!
> 
> Acked-by: Roland Stigge <stigge@antcom.de>
> 
Patch #3 under the same headline .. unless I lost count :-(. I actually did
miss the original patch (thinking it was a reply), and only caught this one
since I wondered why you acked the other patch twice.

What is wrong with the original calculation ?

> > ---
> > 
> > diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/max6639.c
> > b/drivers/hwmon/max6639.c
> > --- a/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -0500
> > +++ b/drivers/hwmon/max6639.c	2012-02-20 16:36:02.553668023 -0500
> > @@ -72,8 +72,8 @@ static unsigned short normal_i2c[] = { 0
> > 
> >  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> > 
> > -#define FAN_FROM_REG(val, div, rpm_range)	((val) = 0 ? -1 : \
> > -	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / ((div + 1) * (val)))
> > +#define FAN_FROM_REG(val, rpm_range)	((val) = 0 ? -1 : \
> > +	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / val)
> >  #define TEMP_LIMIT_TO_REG(val)	SENSORS_LIMIT((val) / 1000, 0, 255)
> > 
> >  /*
> > @@ -333,7 +333,7 @@ static ssize_t show_fan_input(struct dev
> >  		return PTR_ERR(data);
> > 
> >  	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
> > -		       data->ppr, data->rpm_range));
> > +		       data->rpm_range));

This is a bit problematic. Always was, actually. If val=0 it returns a fan speed of -1,
which does not make much sense. It should either return 0, or some kind of error.

> >  }
> > 
> >  static ssize_t show_alarm(struct device *dev,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
