From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Apr 2008 11:53:07 +0000
Subject: Re: [lm-sensors] [PATCH 02/10] hwmon: (lm85) Coding-style cleanups
Message-Id: <20080429135307.1e8e2b7c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412195507.4933f6ca@hyperion.delvare>
In-Reply-To: <20080412195507.4933f6ca@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

Thanks for the review.

On Mon, 28 Apr 2008 22:03:40 -0700, Juerg Haefliger wrote:
> >  /* These are the zone temperature range encodings in .001 degree C */
> > -static int lm85_range_map[] = {   
> > -		2000,  2500,  3300,  4000,  5000,  6600,
> > -		8000, 10000, 13300, 16000, 20000, 26600,
> > -		32000, 40000, 53300, 80000
> > -	};
> > -static int RANGE_TO_REG( int range )
> > +static int lm85_range_map[] = {
> > +	2000,  2500,  3300,  4000,  5000,  6600,
> > +	8000, 10000, 13300, 16000, 20000, 26600,
> > +	32000, 40000, 53300, 80000
> 
> Inconsistent alignment. Either use a single space between values on the 
> 1st line or align to the 3rd line, i.e, move the first two lines to the 
> right by one space.

Good catch, I'll go for the first option, and while I'm here, the
values fit on 2 lines so I'll do that.

> > (...)
> >  static ssize_t show_in_min(struct device *dev,  struct device_attribute *attr,
> 
> Double spaces before struct.

Fixed.

> > (...)
> > @@ -1171,82 +1172,81 @@ static int lm85_detect(struct i2c_adapte
> >  	/* If auto-detecting, Determine the chip type. */
> >  	if (kind <= 0) {
> >  		dev_dbg(&adapter->dev, "Autodetecting device at %d,0x%02x ...\n",
> > -			i2c_adapter_id(adapter), address );
> > -		if( company = LM85_COMPANY_NATIONAL
> > -		    && verstep = LM85_VERSTEP_LM85C ) {
> > -			kind = lm85c ;
> > -		} else if( company = LM85_COMPANY_NATIONAL
> > -		    && verstep = LM85_VERSTEP_LM85B ) {
> > -			kind = lm85b ;
> > -		} else if( company = LM85_COMPANY_NATIONAL
> > -		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC ) {
> > +			i2c_adapter_id(adapter), address);
> > +		if (company = LM85_COMPANY_NATIONAL
> > +		    && verstep = LM85_VERSTEP_LM85C) {
> > +			kind = lm85c;
> > +		} else if (company = LM85_COMPANY_NATIONAL
> > +		    && verstep = LM85_VERSTEP_LM85B) {
> > +			kind = lm85b;
> > +		} else if (company = LM85_COMPANY_NATIONAL
> > +		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
> >  			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
> >  				" Defaulting to LM85.\n", verstep);
> > -			kind = any_chip ;
> > -		} else if( company = LM85_COMPANY_ANALOG_DEV
> > -		    && verstep = LM85_VERSTEP_ADM1027 ) {
> > -			kind = adm1027 ;
> > -		} else if( company = LM85_COMPANY_ANALOG_DEV
> > +			kind = any_chip;
> > +		} else if (company = LM85_COMPANY_ANALOG_DEV
> > +		    && verstep = LM85_VERSTEP_ADM1027) {
> > +			kind = adm1027;
> > +		} else if (company = LM85_COMPANY_ANALOG_DEV
> >  		    && (verstep = LM85_VERSTEP_ADT7463
> > -			 || verstep = LM85_VERSTEP_ADT7463C) ) {
> > -			kind = adt7463 ;
> > -		} else if( company = LM85_COMPANY_ANALOG_DEV
> > -		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC ) {
> > +			 || verstep = LM85_VERSTEP_ADT7463C)) {
> > +			kind = adt7463;
> > +		} else if (company = LM85_COMPANY_ANALOG_DEV
> > +		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
> >  			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
> > -				" Defaulting to Generic LM85.\n", verstep );
> > -			kind = any_chip ;
> > -		} else if( company = LM85_COMPANY_SMSC
> > +				" Defaulting to Generic LM85.\n", verstep);
> 
> Leading space should go to the end of the previous line. This is also 
> true for other strings throughout the code.
>
>
> > +			kind = any_chip;
> > +		} else if (company = LM85_COMPANY_SMSC
> >  		    && (verstep = LM85_VERSTEP_EMC6D100_A0
> > -			 || verstep = LM85_VERSTEP_EMC6D100_A1) ) {
> > +			 || verstep = LM85_VERSTEP_EMC6D100_A1)) {
> >  			/* Unfortunately, we can't tell a '100 from a '101
> >  			 * from the registers.  Since a '101 is a '100
> >  			 * in a package with fewer pins and therefore no
> >  			 * 3.3V, 1.5V or 1.8V inputs, perhaps if those
> >  			 * inputs read 0, then it's a '101.
> >  			 */
> > -			kind = emc6d100 ;
> > -		} else if( company = LM85_COMPANY_SMSC
> > +			kind = emc6d100;
> > +		} else if (company = LM85_COMPANY_SMSC
> >  		    && verstep = LM85_VERSTEP_EMC6D102) {
> > -			kind = emc6d102 ;
> > -		} else if( company = LM85_COMPANY_SMSC
> > +			kind = emc6d102;
> > +		} else if (company = LM85_COMPANY_SMSC
> >  		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC) {
> >  			dev_err(&adapter->dev, "lm85: Detected SMSC chip\n");
> >  			dev_err(&adapter->dev, "lm85: Unrecognized version/stepping 0x%02x"
> > -			    " Defaulting to Generic LM85.\n", verstep );
> > -			kind = any_chip ;
> > -		} else if( kind = any_chip
> > +			    " Defaulting to Generic LM85.\n", verstep);
> 
> Same here.

Patch 7/10 (Rework the device detection) replaces this whole section of
code by something totally different, that's why I didn't bother
cleaning up the split strings.

> > (...)
> > -			for(i = 0; i <= 4; i++)
> > -				data->in_ext[i] = ((val>>(i * 2))&0x03) << 2;
> > +			for (i = 0; i <= 4; i++)
> > +				data->in_ext[i] = ((val>>(i * 2)) & 0x03) << 2;
> 
> Missing spaces around >>.
> 
> 
> >  
> > -			for(i = 0; i <= 2; i++)
> > -				data->temp_ext[i] = (val>>((i + 4) * 2))&0x0c;
> > +			for (i = 0; i <= 2; i++)
> > +				data->temp_ext[i] = (val>>((i + 4) * 2)) & 0x0c;
> 
> Same here.

Fixed.

> 
> 
> >  		}
> >  
> >  		data->vid = lm85_read_value(client, LM85_REG_VID);
> > @@ -1480,21 +1482,21 @@ static struct lm85_data *lm85_update_dev
> >  
> >  		data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
> >  
> > -		if ( data->type = adt7463 ) {
> > -			if( data->therm_total < ULONG_MAX - 256 ) {
> > +		if (data->type = adt7463) {
> > +			if (data->therm_total < ULONG_MAX - 256) {
> >  			    data->therm_total +> > -				lm85_read_value(client, ADT7463_REG_THERM );
> > +				lm85_read_value(client, ADT7463_REG_THERM);
> >  			}
> > -		} else if ( data->type = emc6d100 ) {
> > +		} else if (data->type = emc6d100) {
> >  			/* Three more voltage sensors */
> >  			for (i = 5; i <= 7; ++i) {
> > -				data->in[i] > > -					lm85_read_value(client, EMC6D100_REG_IN(i));
> > +				data->in[i] = lm85_read_value(client,
> > +							EMC6D100_REG_IN(i));
> >  			}
> >  			/* More alarm bits */
> > -			data->alarms |> > -				lm85_read_value(client, EMC6D100_REG_ALARM3) << 16;
> > -		} else if (data->type = emc6d102 ) {
> > +			data->alarms |= lm85_read_value(client,
> > +						EMC6D100_REG_ALARM3) << 16;
> > +		} else if (data->type = emc6d102) {
> >  			/* Have to read LSB bits after the MSB ones because
> >  			   the reading of the MSB bits has frozen the
> >  			   LSBs (backward from the ADM1027).
> > @@ -1518,11 +1520,11 @@ static struct lm85_data *lm85_update_dev
> >  			data->temp_ext[2] = (ext1 >> 4) & 0x0f;
> >  		}
> >  
> > -		data->last_reading = jiffies ;
> > -	};  /* last_reading */
> > +		data->last_reading = jiffies;
> > +	}  /* last_reading */
> >  
> > -	if ( !data->valid ||
> > -	     time_after(jiffies, data->last_config + LM85_CONFIG_INTERVAL) ) {
> > +	if (!data->valid ||
> > +	     time_after(jiffies, data->last_config + LM85_CONFIG_INTERVAL)) {
> >  		/* Things that don't change often */
> >  		dev_dbg(&client->dev, "Reading config values\n");
> >  
> > @@ -1540,12 +1542,12 @@ static struct lm85_data *lm85_update_dev
> >  					  LM85_REG_IN_MAX(4));
> >  		}
> >  
> > -		if ( data->type = emc6d100 ) {
> > +		if (data->type = emc6d100) {
> >  			for (i = 5; i <= 7; ++i) {
> > -				data->in_min[i] > > -					lm85_read_value(client, EMC6D100_REG_IN_MIN(i));
> > -				data->in_max[i] > > -					lm85_read_value(client, EMC6D100_REG_IN_MAX(i));
> > +				data->in_min[i] = lm85_read_value(client,
> > +						EMC6D100_REG_IN_MIN(i));
> > +				data->in_max[i] = lm85_read_value(client,
> > +						EMC6D100_REG_IN_MAX(i));
> >  			}
> >  		}
> >  
> > @@ -1562,12 +1564,12 @@ static struct lm85_data *lm85_update_dev
> >  		}
> >  
> >  		for (i = 0; i <= 2; ++i) {
> > -			int val ;
> > +			int val;
> >  			data->autofan[i].config > >  			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
> >  			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
> > -			data->autofan[i].freq = val & 0x07 ;
> > -			data->zone[i].range = (val >> 4) & 0x0f ;
> > +			data->autofan[i].freq = val & 0x07;
> > +			data->zone[i].range = (val >> 4) & 0x0f;
> >  			data->autofan[i].min_pwm > >  			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
> >  			data->zone[i].limit > > @@ -1577,50 +1579,50 @@ static struct lm85_data *lm85_update_dev
> >  		}
> >  
> >  		i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
> > -		data->smooth[0] = i & 0x0f ;
> > -		data->syncpwm3 = i & 0x10 ;  /* Save PWM3 config */
> > -		data->autofan[0].min_off = (i & 0x20) != 0 ;
> > -		data->autofan[1].min_off = (i & 0x40) != 0 ;
> > -		data->autofan[2].min_off = (i & 0x80) != 0 ;
> > +		data->smooth[0] = i & 0x0f;
> > +		data->syncpwm3 = i & 0x10;  /* Save PWM3 config */
> > +		data->autofan[0].min_off = (i & 0x20) != 0;
> > +		data->autofan[1].min_off = (i & 0x40) != 0;
> > +		data->autofan[2].min_off = (i & 0x80) != 0;
> >  		i = lm85_read_value(client, LM85_REG_AFAN_SPIKE2);
> > -		data->smooth[1] = (i>>4) & 0x0f ;
> > -		data->smooth[2] = i & 0x0f ;
> > +		data->smooth[1] = (i>>4) & 0x0f;
> 
> Missing spaces around >>.
> 
> 
> > +		data->smooth[2] = i & 0x0f;
> >  
> >  		i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
> > -		data->zone[0].hyst = (i>>4) & 0x0f ;
> > -		data->zone[1].hyst = i & 0x0f ;
> > +		data->zone[0].hyst = (i>>4) & 0x0f;
> 
> Same here.
> 
> 
> > +		data->zone[1].hyst = i & 0x0f;
> >  
> >  		i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
> > -		data->zone[2].hyst = (i>>4) & 0x0f ;
> > +		data->zone[2].hyst = (i>>4) & 0x0f;
> 
> And here.

All fixed.

> There are also 2 spaces on line 1613 (static void  __exit 
> sm_lm85_exit(void)).

Fixed.

> And a couple of comments with double spaces after 
> periods. That's frowned upon nowadays AFAIK.

I'm not aware of any such rule, and checkpatch doesn't complain, so
I'll leave them as is.

> Some of the comments also 
> have multiple leading spaces where there shouldn't be any IMHO (like 
> line 1606).

checkpatch doesn't complain about this either, so I won't change it
(although I wouldn't do that in my own code, obviously.)

I'll submit an updated patch quickly. I guess that some of the next
patches in the series will need a refresh, too.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
