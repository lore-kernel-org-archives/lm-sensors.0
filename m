From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Oct 2010 17:33:06 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] hwmon: (lm90) Add support for
Message-Id: <20101006173306.GD13958@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
On Wed, Oct 06, 2010 at 12:07:09PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 5 Oct 2010 08:38:28 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/lm90.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 files changed, 92 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > index 1913f8a..520e4a1 100644
> > --- a/drivers/hwmon/lm90.c
> > +++ b/drivers/hwmon/lm90.c
> > @@ -151,6 +151,10 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
> >  #define MAX6659_REG_R_LOCAL_EMERG	0x17
> >  #define MAX6659_REG_W_LOCAL_EMERG	0x17
> >  
> > +#define LM90_DEF_CONVRATE_RVAL	6	/* Def conversion rate register value */
> > +#define LM90_MAX_CONVRATE_RVAL	10	/* Max conversion rate register value */
> 
> You shouldn't need this, as each device knows its max value. See below.
> 
You are right. I'll change the code it.

[ ...] 

> > +/*
> > + * Set conversion rate.
> > + * client->update_lock must be held when calling this function (unless we are
> > + * in detection or initialization steps).
> > + */
> > +static void lm90_set_convrate(struct i2c_client *client, struct lm90_data *data,
> > +			      unsigned int interval)
> > +{
> > +	int i;
> > +	unsigned int update_interval;
> > +
> > +	/* find the nearest update rate */
> > +	for (i = 0, update_interval = LM90_MAX_CONVRATE_MS;
> > +	     i < LM90_MAX_CONVRATE_RVAL;
> > +	     i++, update_interval >>= 1)
> > +		if (i >= data->max_convrate
> > +		    || interval >= update_interval * 3 / 4)
> > +			break;
> 
> Why not just:
> 
> 	for (i = 0, update_interval = LM90_MAX_CONVRATE_MS;
> 	     i < data->max_convrate;
> 	     i++, update_interval >>= 1)
> 		if (interval >= update_interval * 3 / 4)
> 			break;
> 
> The result is the same as far as I can see, and you avoid an arbitrary
> constant.
> 
Consider it changed.

> Note that your algorithm always rounds interval down, even when the
> closest integer would be up. Proper rounding would need a different
> algorithm to avoid accumulating rounding errors, I think.
> 
> As it stands, requesting a 21 ms update interval will lead to a 31.250

I think you mean 23 ms, not 21 ms. 21 will report as 15 (you almost got me there).

> ms update interval (register value 0x9), reported as 31 ms through
> sysfs, while it should preferably lead to a 15.625 ms update interval
> (register value 0xa), currently reported as 15 ms but ideally reported
> as 16 ms: this is a 7.375 ms error instead of a 8.250 ms error. You may
> decide this is unimportant though, I leave it up to you.
> 
I figured this is really a corner case (it really only applies to the 23 ms setting),
and yields less than 1ms error. Everything else I came up with seemed to be too complicated.

I could change the update_interval calculation to
	update_interval = (LM90_MAX_CONVRATE_MS + ((1 << i) >> 1)) >> i;

That would take care of the 15ms vs. 16ms reporting error, and round 62.5 up to 63.
Not sure if it is worth it, though. Seems to be a bit complicated.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
