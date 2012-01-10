From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jan 2012 19:06:25 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (lm63) Add support for writing
Message-Id: <20120110200625.22ce5a73@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326166923-11187-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326166923-11187-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Jan 2012 10:21:53 -0800, Guenter Roeck wrote:
> On Tue, 2012-01-10 at 12:49 -0500, Jean Delvare wrote:
> > On Mon,  9 Jan 2012 19:42:02 -0800, Guenter Roeck wrote:
> > > @@ -510,7 +534,30 @@ static struct attribute *lm63_attributes[] = {
> > >  	NULL
> > >  };
> > >  
> > > +/*
> > > + * On LM63, temp2_crit can be set only once, which should be job
> > > + * of the bootloader.
> > > + * On LM64, temp2_crit can always be set.
> > > + * On LM96163, temp2_crit can be set if bit 1 of the configuration
> > > + * register is true.
> > > + */
> > > +static mode_t lm63_attribute_mode(struct kobject *kobj,
> > > +				  struct attribute *attr, int index)
> > > +{
> > > +	struct device *dev = container_of(kobj, struct device, kobj);
> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct lm63_data *data = i2c_get_clientdata(client);
> > > +
> > > +	if (attr = &sensor_dev_attr_temp2_crit.dev_attr.attr
> > > +	    && (data->kind = lm64 || (data->kind = lm96163
> > > +				       && (data->config & 0x02))))
> > 
> > I think this would be more readable as:
> > 
> > 	    && (data->kind = lm64 ||
> > 		(data->kind = lm96163 && (data->config & 0x02))))
> > 
> > 
> Ok.
> 
> > > +		return attr->mode | S_IWUSR;
> 
> > FWIW I think you can save a few binary bytes by using instead:
> > 
> > 		attr->mode |= S_IWUSR;
> > 
> > Thanks to the single exit point.
> > 
> Unless I am missing something, that would set S_IWUSR for all instances
> of the driver. Not sure if that is a good idea. I can use a local
> variable for mode, though.

Oops, you're totally right, my bad. Just ignore my comment on this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
