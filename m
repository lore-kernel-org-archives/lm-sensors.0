From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 12 Oct 2012 16:14:15 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] hwmon: (coretemp) Use model table instead of if/else to identify CPU mo
Message-Id: <20121012161415.GA6300@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349816943-17697-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1349816943-17697-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 12, 2012 at 11:12:04AM +0200, Jean Delvare wrote:
> On Tue,  9 Oct 2012 14:09:00 -0700, Guenter Roeck wrote:
> > Make the code easier to extend and easier to adjust by using a model table
> > listing CPU models, stepping/mask, and associated TjMax.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/coretemp.c |   36 ++++++++++++++++++++++--------------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> I like the idea. Just a couple things about the implementation:
> 
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index 1937cd4..7107096 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -208,6 +208,23 @@ static const struct tjmax __cpuinitconst tjmax_table[] = {
> >  	{ "CPU  330", 125000 },
> >  };
> >  
> > +struct tjmax_model {
> > +	u8 model;
> > +	u8 mask;
> > +	int tjmax;
> > +};
> > +
> > +static const struct tjmax_model __cpuinitconst tjmax_model_table[] = {
> > +	{ 0x1c, 10, 100000 },	/* D4xx, N4xx, D5xx, N5xx */
> > +	{ 0x1c, 0, 90000 },	/* Z5xx, N2xx, 230, 330, others	*/
> 
> I don't think the 230 and 330 should be listed there, as they are
> overridden by an earlier match in tjmax_table[].
> 
I rephrased it:
				/* Z5xx, N2xx, possibly others
                                 * Note: Also matches 230 and 330,
				 * which are covered by tjmax_table
				 */

> > +	{ 0x26, 0, 90000 },	/* Atom Tunnel Creek (Exx), Lincroft (Z6xx)
> > +				 * Note: TjMax for E6xxT is 110C, but CPU type
> > +				 * is undetectable by software
> > +				 */
> > +	{ 0x27, 0, 90000 },	/* Atom Medfield (Z2460) */
> > +	{ 0x36, 0, 100000 },	/* Atom Cedar Trail/Cedarview (N2xxx, D2xxx) */
> > +};
> 
> Using 0 as a special value may be problematic, as I think it is a
> possible stepping value:
> 
> http://openbenchmarking.org/system/1109120-IV-TSCP1539338/tscp1/cpuinfo
> 
> (I agree model name looks odd, not sure if it is a public model or some
> engineering sample.)
> 
> In hwmon-vid we have:
> 
> #define ANY 0xFF
> 
Good idea. I changed the code to use ANY.

> and we use that when the stepping doesn't matter. Note that we also
> support stepping ranges there, maybe we'll need it for coretemp too
> some day, but I guess we can add it then.
> 
Agreed.

> > +
> >  static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
> >  				  struct device *dev)
> >  {
> > @@ -226,20 +243,11 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
> >  			return tjmax_table[i].tjmax;
> >  	}
> >  
> > -	/* Atom CPUs */
> > -
> > -	if (c->x86_model = 0x1c) {
> > -		/*
> > -		 * TjMax for stepping 10 CPUs (N4xx, N5xx, D4xx, D5xx)
> > -		 * is 100 degrees C, for all others it is 90 degrees C.
> > -		 */
> > -		if (c->x86_mask = 10)
> > -			return 100000;
> > -		return 90000;
> > -	} else if (c->x86_model = 0x26 || c->x86_model = 0x27) {
> > -		return 90000;
> > -	} else if (c->x86_model = 0x36) {
> > -		return 100000;
> > +	for (i = 0; i < ARRAY_SIZE(tjmax_model_table); i++) {
> > +		const struct tjmax_model *tm = &tjmax_model_table[i];
> > +		if (c->x86_model = tm->model &&
> > +		    (!tm->mask || c->x86_mask = tm->mask))
> > +			return tm->tjmax;
> >  	}
> >  
> >  	/* Early chips have no MSR for TjMax */
> 
> Other than these implementation details:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
