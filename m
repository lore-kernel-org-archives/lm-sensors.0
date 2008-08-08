From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 Aug 2008 16:19:29 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] lm90: Changes to support sfc hardware
Message-Id: <20080808181929.7074ca89@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1215701481.git.bhutchings@solarflare.com>
In-Reply-To: <cover.1215701481.git.bhutchings@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Fri, 11 Jul 2008 13:37:39 +0100, Ben Hutchings wrote:
> I wrote:
> > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > index b1858e2..c502587 100644
> > --- a/drivers/hwmon/lm90.c
> > +++ b/drivers/hwmon/lm90.c
> > @@ -657,9 +657,6 @@ static int lm90_detect(struct i2c_client *new_client, int kind,
> >  			 && (reg_config1 & 0x1B) = 0x00
> >  			 && reg_convrate <= 0x0A) {
> >  				kind = adt7461;
> > -				/* Check Temperature Range Select */
> > -				if (reg_config1 & 0x04)
> > -					data->flags |= LM90_FLAG_ADT7461_EXT;
> >  			}
> >  		} else
> >  		if (man_id = 0x4D) { /* Maxim */
> > @@ -796,6 +793,10 @@ static void lm90_init_client(struct i2c_client *client)
> >  	}
> >  	config_orig = config;
> >  
> > +	/* Check Temperature Range Select */
> > +	if (config & 0x04)
> 
> Of course this condition needs to be changed to:
> 
>     if (data->kind = atd7461 && config & 0x04)
> 
> > +		data->flags |= LM90_FLAG_ADT7461_EXT;
> > +

You are right. hwmon-lm90-convert-to-new-style.patch is upstream now,
and I have merged the changes above into
hwmon-lm90-06-support-adt7461-in-extended-mode.patch so that the lm90
driver builds again.

What about your patch adding support for the MAX6646,  MAX6647 and
MAX6649? According to my notes, I was waiting for a last iteration of
it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
