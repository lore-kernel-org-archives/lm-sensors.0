From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Feb 2009 13:17:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add missing parentheses
Message-Id: <20090218141741.0e747c59@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <499AB902.1080308@gmail.com>
In-Reply-To: <499AB902.1080308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 17 Feb 2009 21:03:23 +0000, Alistair John Strachan wrote:
> On Tuesday 17 February 2009 13:17:54 Roel Kluin wrote:
> > I think this was intended? please review.
> 
> This one's been there from the beginning.
> 
> The change looks right to me. (i * count) account the previous successes, add 
> either zero or x depending on the kind of read failure (timeout/short read vs 
> other I/O error). I'm not entirely sure why i must be >0 for accounting the 
> short read.

I can't make any sense of that "i &&" either. Hans?

> Nothing calling abituguru3_read_increment_offset() checks for anything other 
> than complete success. Every caller passes count=1, and offset_count>1, so 
> both the new code and the old could never return a full count 
> (offset_count*count) when an error has occured (old returns either 0 or x, 
> x=count). Ergo, the change can't cause any regressions.
> 
> Acked-by: Alistair John Strachan <alistair@devzero.co.uk>
> 
> Jean, are you happy to take this?

Yes, but I'd like to understand why the "i &&" is there, and if there's
no good reason we should drop it.

> > --------------------------->8-------------8<------------------------------
> > Add missing parentheses
> >
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > ---
> > diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> > index e52b388..fd98685 100644
> > --- a/drivers/hwmon/abituguru3.c
> > +++ b/drivers/hwmon/abituguru3.c
> > @@ -761,7 +761,7 @@ static int abituguru3_read_increment_offset(struct
> > abituguru3_data *data, for (i = 0; i < offset_count; i++)
> >  		if ((x = abituguru3_read(data, bank, offset + i, count,
> >  				buf + i * count)) != count)
> > -			return i * count + (i && (x < 0)) ? 0 : x;
> > +			return i * count + ((i && (x < 0)) ? 0 : x);
> >
> >  	return i * count;
> >  }
> 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
