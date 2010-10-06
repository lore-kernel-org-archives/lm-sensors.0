From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Oct 2010 15:28:37 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Introduce chip
Message-Id: <20101006152837.GC13682@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Oct 06, 2010 at 11:05:53AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 5 Oct 2010 08:38:26 -0700, Guenter Roeck wrote:
> > Instead of using switch/case and if statements in probe, define chip specific
> > functionality in a parameter structure array.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/lm90.c |   92 ++++++++++++++++++++++++++++++++-----------------
> >  1 files changed, 60 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> > index 302d9eb..9df08e1 100644
> > --- a/drivers/hwmon/lm90.c
> > +++ b/drivers/hwmon/lm90.c
> > @@ -190,6 +190,63 @@ static const struct i2c_device_id lm90_id[] = {
> >  MODULE_DEVICE_TABLE(i2c, lm90_id);
> >  
> >  /*
> > + * chip type specific parameters
> > + */
> > +struct lm90_params {
> > +	u32 flags;		/* Capabilities */
> 
> Any reason why you don't use u16? there aren't that many flags yet, and
> u16 divides the size of lm90_params[] below by 2.
> 
Access to 32 bit variables is a bit faster on many CPUs, due to the bit masking
required otherwise. Also, the flags field in lm90_data was int and I changed
it to u32 (seemed to be cleaner for a bitfield). Seemed to make sense to use
the same type for both.

Not that it matters much here, if at all, since this is a bit mask anyway.
I am fine either way.

> > +	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
> > +				/* Upper 8 bits for max6695/96 */
> > +};
> > +
> > +static const struct lm90_params lm90_params[] = {
> > +	[adm1032] = {
> > +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> > +		.alert_alarms = 0x7c,
> > +	},
> > +	[adt7461] = {
> > +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> > +		.alert_alarms = 0x7c,
> > +	},
> > +	[lm86] = {
> > +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> > +		.alert_alarms = 0x7b,
> > +	},
> > +	[lm90] = {
> > +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> > +		.alert_alarms = 0x7b,
> > +	},
> > +	[lm99] = {
> > +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> > +		.alert_alarms = 0x7b,
> > +	},
> > +	[max6646] = {
> > +		.flags = LM90_HAVE_LOCAL_EXT,
> > +		.alert_alarms = 0x7c,
> > +	},
> > +	[max6657] = {
> > +		.flags = LM90_HAVE_LOCAL_EXT,
> > +		.alert_alarms = 0x7c,
> > +	},
> > +	[max6659] = {
> > +		.flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY,
> > +		.alert_alarms = 0x7c,
> > +	},
> > +	[max6680] = {
> > +		.flags = LM90_HAVE_OFFSET,
> > +		.alert_alarms = 0x7c,
> > +	},
> > +	[max6696] = {
> > +		.flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY
> > +		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3,
> > +		.alert_alarms = 0x187c,
> > +	},
> > +	[w83l771] = {
> > +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> > +		.alert_alarms = 0x7c,
> > +	},
> > +};
> > +
> > +/*
> >   * Client data (each client gets its own)
> >   */
> >  
> > @@ -199,7 +256,7 @@ struct lm90_data {
> >  	char valid; /* zero until following fields are valid */
> >  	unsigned long last_updated; /* in jiffies */
> >  	int kind;
> > -	int flags;
> > +	u32 flags;
> >  
> >  	u8 config_orig;		/* Original configuration register value */
> >  	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
> > @@ -1201,39 +1258,10 @@ static int lm90_probe(struct i2c_client *new_client,
> >  
> >  	/* Different devices have different alarm bits triggering the
> >  	 * ALERT# output */
> > -	switch (data->kind) {
> > -	case lm90:
> > -	case lm99:
> > -	case lm86:
> > -		data->alert_alarms = 0x7b;
> > -		break;
> > -	case max6696:
> > -		data->alert_alarms = 0x187c;
> > -		break;
> > -	default:
> > -		data->alert_alarms = 0x7c;
> > -		break;
> > -	}
> > +	data->alert_alarms = lm90_params[data->kind].alert_alarms;
> >  
> >  	/* Set chip capabilities */
> > -	if (data->kind != max6657 && data->kind != max6659
> > -	    && data->kind != max6646 && data->kind != max6696)
> > -		data->flags |= LM90_HAVE_OFFSET;
> > -
> > -	if (data->kind = max6657 || data->kind = max6659
> > -	    || data->kind = max6646 || data->kind = max6696)
> > -		data->flags |= LM90_HAVE_LOCAL_EXT;
> > -
> > -	if (data->kind != max6657 && data->kind != max6659
> > -	    && data->kind != max6646 && data->kind != max6680
> > -	    && data->kind != max6696)
> > -		data->flags |= LM90_HAVE_REM_LIMIT_EXT;
> > -
> > -	if (data->kind = max6659 || data->kind = max6696)
> > -		data->flags |= LM90_HAVE_EMERGENCY;
> > -
> > -	if (data->kind = max6696)
> > -		data->flags |= LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3;
> > +	data->flags = lm90_params[data->kind].flags;
> >  
> >  	/* Initialize the LM90 chip */
> >  	lm90_init_client(new_client);
> 
> I like this change a lot, even though it makes the binary module a
> little larger. This is a lot cleaner. Consider it applied.
> 
It makes it a bit larger, but I figured we might make up for that later on.
And, yes, it _is_ cleaner.

Do you want me to change the flags to u16, or keep as is ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
