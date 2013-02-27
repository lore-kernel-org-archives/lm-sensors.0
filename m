From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Feb 2013 10:27:03 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/7] hwmon: (pmbus/ltc2978) Fix temperature reporting
Message-Id: <20130227112703.232cbab0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130226233606.GA17484@roeck-us.net>
In-Reply-To: <20130226233606.GA17484@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 27 Feb 2013 11:12:20 +0100, Jean Delvare wrote:
> On Tue, 26 Feb 2013 15:36:06 -0800, Guenter Roeck wrote:
> > diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> > index a58de38..a729c1c 100644
> > --- a/drivers/hwmon/pmbus/ltc2978.c
> > +++ b/drivers/hwmon/pmbus/ltc2978.c
> > @@ -59,7 +59,7 @@ enum chips { ltc2978, ltc3880 };
> >  struct ltc2978_data {
> >  	enum chips id;
> >  	int vin_min, vin_max;
> > -	int temp_min, temp_max;
> > +	int temp_min, temp_max[8];
> 
> I'm confused. LTC2978 only has 1 temperature, LTC3880 has 3, so why
> have room for 8? I'm not even sure you need 2, as I suspect LTC3880's
> TEMP2 doesn't actually support peak recording, so 2 should be enough?

I'm not paying attention it seems ;) The last sentence above should
read:

  I'm not even sure you need 3, as temp2 has its own attribute for max
  peak recording, so 2 should be enough?

Conclusion is the same though.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
