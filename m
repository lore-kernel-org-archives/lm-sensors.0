From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jan 2013 23:50:17 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: Replace SENSORS_LIMIT with clamp_val
Message-Id: <20130109235017.GA17920@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1357750750-30512-1-git-send-email-linux@roeck-us.net>
 <20130109225800.04d0b1a1@endymion.delvare>
In-Reply-To: <20130109225800.04d0b1a1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, George Joseph <george.joseph@fairview5.com>, Juerg Haefliger <juergh@gmail.com>, Steve Glendinning <steve.glendinning@shawell.net>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>, Roger Lucas <vt8231@hiddenengine.co.uk>, Marc Hulsman <m.hulsman@tudelft.nl>, Rudolf Marek <r.marek@assembler.cz>, Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org

On Wed, Jan 09, 2013 at 10:58:00PM +0100, Jean Delvare wrote:
> On Wed,  9 Jan 2013 08:59:07 -0800, Guenter Roeck wrote:
> > SENSORS_LIMIT and the generic clamp_val have the same functionality,
> > and clamp_val is more efficient.
> > 
> > This patch reduces text size by 9052 bytes and bss size by 11624 bytes
> > for x86_64 builds.
> 
> Wow, I like it a lot! Well done!
> 
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Just one thing:
> 
> > (...)
> > diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> > index 1a003f7..81449a2 100644
> > --- a/drivers/hwmon/lm93.c
> > +++ b/drivers/hwmon/lm93.c
> > @@ -371,22 +371,22 @@ static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
> >  static u8 LM93_IN_TO_REG(int nr, unsigned val)
> >  {
> >  	/* range limit */
> > -	const long mV = SENSORS_LIMIT(val,
> > -		lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
> > +	const long mv = clamp_val(val,
> > +				  lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
> >  
> >  	/* try not to lose too much precision here */
> > -	const long uV = mV * 1000;
> > -	const long uV_max = lm93_vin_val_max[nr] * 1000;
> > -	const long uV_min = lm93_vin_val_min[nr] * 1000;
> > +	const long uv = mv * 1000;
> > +	const long uv_max = lm93_vin_val_max[nr] * 1000;
> > +	const long uv_min = lm93_vin_val_min[nr] * 1000;
> >  
> >  	/* convert */
> > -	const long slope = (uV_max - uV_min) /
> > +	const long slope = (uv_max - uv_min) /
> >  		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
> > -	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
> > +	const long intercept = uv_min - slope * lm93_vin_reg_min[nr];
> >  
> > -	u8 result = ((uV - intercept + (slope/2)) / slope);
> > -	result = SENSORS_LIMIT(result,
> > -			lm93_vin_reg_min[nr], lm93_vin_reg_max[nr]);
> > +	u8 result = ((uv - intercept + (slope/2)) / slope);
> 
> All these case changes in variable name seem a little off-topic here,
> especially for a subsystem-wide patch.
> 
Yes, you are right. Those are to avoid CamelCase checkpatch warnings, but still
don't belong into this patch. I'll take them out and maybe submit a separate
set of CamelCase cleanup patches. I'll also undo the indentation change.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
