From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Oct 2010 17:40:33 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (lm90) Add support for
Message-Id: <20101006174033.GE13958@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284601950-7381-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284601950-7381-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Oct 06, 2010 at 12:19:31PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for being a little slow, but...
> 
> On Wed, 15 Sep 2010 18:52:30 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/lm90 |   17 +++
> >  drivers/hwmon/Kconfig    |    4 +-
> >  drivers/hwmon/lm90.c     |  250 ++++++++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 247 insertions(+), 24 deletions(-)
> > 
> > (...)
> > @@ -154,6 +160,8 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
> >  #define LM90_HAVE_LOCAL_EXT	(1 << 2) /* extended local temperature	*/
> >  #define LM90_HAVE_REM_LIMIT_EXT	(1 << 3) /* extended remote limit	*/
> >  #define LM90_HAVE_EMERGENCY	(1 << 4) /* 3rd upper (emergency) limit	*/
> > +#define LM90_HAVE_EMERGENCY_ALARM (1 << 5)/* emergency alarm		*/
> > +#define LM90_HAVE_TEMP3		(1 << 6) /* 3rd temperature sensor	*/
> >  
> >  /*
> >   * Functions declaration
> > (...)
> > @@ -1135,7 +1321,27 @@ static struct lm90_data *lm90_update_device(struct device *dev)
> >  			lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG,
> >  				      &data->temp8[5]);
> >  		}
> > -		lm90_read_reg(client, LM90_REG_R_STATUS, &data->alarms);
> > +		lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
> > +		data->alarms = alarms;	/* save as 16 bit value */
> > +
> > +		if (data->kind = max6696) {
> 
> Wouldn't this be better written:
> 
> 		if (data->flags & LM90_HAVE_TEMP3) {
> 
> > +			lm90_select_remote_channel(client, data, 1);
> > +			lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT,
> > +				      &data->temp8[6]);
> > +			lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG,
> > +				      &data->temp8[7]);
> > +			lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
> > +				    LM90_REG_R_REMOTE_TEMPL, &data->temp11[5]);
> > +			if (!lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h))
> > +				data->temp11[6] = h << 8;
> > +			if (!lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h))
> > +				data->temp11[7] = h << 8;
> > +			lm90_select_remote_channel(client, data, 0);
> > +
> 
> and:
> 
> 		if (data->flags & (LM90_HAVE_TEMP3 | LM90_HAVE_EMERGENCY_ALARM))
> 
Possibly. I didn't do it on purpose, though, since it is not clear yet if the registers 
used to access those sensors on future chips will be the same or completely different.
I figured it is better to play safe and implement the actual register accesses
by checking ->kind instead of using the capability flags.

Later on it might end up as

	if (data->flags & LM90_HAVE_TEMP3) {
		switch (data->kind) {
		case max6696:
			...
			break;
		case newchip:
			...
			break;
		}
	}

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
