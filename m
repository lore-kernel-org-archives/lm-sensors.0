From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Jul 2011 17:00:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Improve auto-detection of
Message-Id: <1309885239.2343.66.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309877664-25351-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309877664-25351-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-07-05 at 12:45 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 5 Jul 2011 07:54:24 -0700, Guenter Roeck wrote:
> > It is possible that a PMBus device supports the READ_TEMPERATURE2 and/or
> > READ_TEMPERATURE3 registers but does not support READ_TEMPERATURE1.
> > Improve temperature status register detection to address this condition.
> > 
> > Reported-by: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/pmbus.c |   17 ++++++++++++-----
> >  1 files changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus.c b/drivers/hwmon/pmbus.c
> > index 931d940..4a1f217 100644
> > --- a/drivers/hwmon/pmbus.c
> > +++ b/drivers/hwmon/pmbus.c
> > @@ -59,16 +59,17 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
> >  		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_34))
> >  			info->func[0] |= PMBUS_HAVE_STATUS_FAN34;
> >  	}
> > -	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_1)) {
> > +	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_1))
> >  		info->func[0] |= PMBUS_HAVE_TEMP;
> > -		if (pmbus_check_byte_register(client, 0,
> > -					      PMBUS_STATUS_TEMPERATURE))
> > -			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
> > -	}
> >  	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_2))
> >  		info->func[0] |= PMBUS_HAVE_TEMP2;
> >  	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
> >  		info->func[0] |= PMBUS_HAVE_TEMP3;
> > +	if (info->func[0] & (PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> > +			     | PMBUS_HAVE_TEMP3)
> > +	    && pmbus_check_byte_register(client, 0,
> > +					 PMBUS_STATUS_TEMPERATURE))
> > +			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
> >  
> >  	/* Sensors detected on all pages */
> >  	for (page = 0; page < info->pages; page++) {
> 
> So far so good, and
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> > @@ -177,6 +178,12 @@ static const struct i2c_device_id pmbus_id[] = {
> >  	{"bmr454", 1},
> >  	{"ltc2978", 8},
> >  	{"pmbus", 0},
> > +	{"zl2004", 1},
> > +	{"zl2006", 1},
> > +	{"zl2008", 1},
> > +	{"zl2106", 1},
> > +	{"zl6100", 1},
> > +	{"zl6105", 1},
> >  	{}
> >  };
> >  
> 
> OTOH I very much doubt that this change was supposed to be included in
> that patch.
> 
Oops ... definitely not ... thanks, I'll take it out.

Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
