From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jun 2008 09:52:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080605115221.029ceb95@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 05 Jun 2008 12:17:32 +0300, Riku Voipio wrote:
> Ben Hutchings wrote:
> >  struct lm87_data {
> > -	struct i2c_client client;
> >  	struct device *hwmon_dev;
> >  	struct mutex update_lock;
> >  	char valid; /* zero until following fields are valid */
> >  	unsigned long last_updated; /* In jiffies */
> >  
> > -	u8 channel;		/* register value */
> > +	struct lm87_settings set;
> > +	struct lm87_values val;
> >  
> > -	u8 in[8];		/* register value */
> > -	u8 in_max[8];		/* register value */
> > -	u8 in_min[8];		/* register value */
> >  	u16 in_scale[8];
> >  
> > -	s8 temp[3];		/* register value */
> > -	s8 temp_high[3];	/* register value */
> > -	s8 temp_low[3];		/* register value */
> >  	s8 temp_crit_int;	/* min of two register values */
> >  	s8 temp_crit_ext;	/* min of two register values */
> >  
> > -	u8 fan[2];		/* register value */
> > -	u8 fan_min[2];		/* register value */
> > -	u8 fan_div[2];		/* register value, shifted right */
> > -	u8 aout;		/* register value */
> > -
> > -	u16 alarms;		/* register values, combined */
> > -	u8 vid;			/* register values, combined */
> >   
>
> The transition of these values to val/set structs causes noise in almost 
> every function.
> It would be more cleaner to have separate patches for moving to set/val 
> structs (big patch but easy to review since no functional changes ) and
> adding  new-style driver (small patch with few functional changes).

I fully agree. Plus, it would give you a chance to explain why this
noisy change is needed. At a quick glance I admit I don't quite get the
point.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
