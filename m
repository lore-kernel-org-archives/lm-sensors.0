From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Feb 2013 16:28:24 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/7] hwmon: (pmbus/ltc2978) Fix temperature reporting
Message-Id: <20130227162824.GB7987@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130226233606.GA17484@roeck-us.net>
In-Reply-To: <20130226233606.GA17484@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 27, 2013 at 11:27:03AM +0100, Jean Delvare wrote:
> On Wed, 27 Feb 2013 11:12:20 +0100, Jean Delvare wrote:
> > On Tue, 26 Feb 2013 15:36:06 -0800, Guenter Roeck wrote:
> > > diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> > > index a58de38..a729c1c 100644
> > > --- a/drivers/hwmon/pmbus/ltc2978.c
> > > +++ b/drivers/hwmon/pmbus/ltc2978.c
> > > @@ -59,7 +59,7 @@ enum chips { ltc2978, ltc3880 };
> > >  struct ltc2978_data {
> > >  	enum chips id;
> > >  	int vin_min, vin_max;
> > > -	int temp_min, temp_max;
> > > +	int temp_min, temp_max[8];
> > 
> > I'm confused. LTC2978 only has 1 temperature, LTC3880 has 3, so why
> > have room for 8? I'm not even sure you need 2, as I suspect LTC3880's
> > TEMP2 doesn't actually support peak recording, so 2 should be enough?
> 
> I'm not paying attention it seems ;) The last sentence above should
> read:
> 
>   I'm not even sure you need 3, as temp2 has its own attribute for max
>   peak recording, so 2 should be enough?
> 
I wanted to be able to use the loop at the end of the chip specific
initialization code to initialize the limit. So I figured I'd just use
the maximum size for all arrays and waste a bit of memory. Another reason
was that I wanted to avoid the risk of forgetting to increase it when
new chips are added (LTC2974 needs four). Happened before, after all ;).
You'll notice that I added a constant for the maximum array size
in the patch adding support for LTC2974 and LTC3883, and use it for all
array variables.

I could save some of the 'wasted' memory by using u16 instead of int for
the variables; that might make more sense than limiting each array to
the actual per-attribute maximum and writing device specific code to
initialize it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
