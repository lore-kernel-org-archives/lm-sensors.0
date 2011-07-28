From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 05:35:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add chassis intrusion
Message-Id: <20110728053501.GA21551@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110713212507.42269295@endymion.delvare>
In-Reply-To: <20110713212507.42269295@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jul 16, 2011 at 04:45:49PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed, 13 Jul 2011 14:01:01 -0700, Guenter Roeck wrote:
> > On Wed, 2011-07-13 at 15:25 -0400, Jean Delvare wrote:
> > > Add chassis intrusion detection support for all supported devices,
> > > using the standard interface.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > ---
> > > This needs testing! The only report I have so far, says that reporting
> > > works OK but clearing the intrusion alarm does not. That case is still
> > > under investigation, as my code follows the datasheet as far as I can
> > > see, so I have no idea why it wouldn't work.
> > > 
> > >  it87.c |   29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > > 
> > > --- it87.orig/drivers/hwmon/it87.c	2011-07-11 16:09:21.000000000 +0200
> > > +++ it87/drivers/hwmon/it87.c	2011-07-13 21:10:53.000000000 +0200
> > > @@ -1172,6 +1172,32 @@ static ssize_t show_alarm(struct device
> > >  	struct it87_data *data = it87_update_device(dev);
> > >  	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
> > >  }
> > > +
> > > +static ssize_t clear_intrusion(struct device *dev, struct device_attribute
> > > +		*attr, const char *buf, size_t count)
> > > +{
> > > +	struct it87_data *data = dev_get_drvdata(dev);
> > > +	long val;
> > > +	int config;
> > > +
> > > +	if (strict_strtol(buf, 10, &val) < 0 || val != 0)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&data->update_lock);
> > > +	config = it87_read_value(data, IT87_REG_CONFIG);
> > > +	if (config < 0)
> > > +		count = config;
> > > +	else {
> > > +		config |= 1 << 5;
> > > +		it87_write_value(data, IT87_REG_CONFIG, config);
> > > +		/* Invalidate cache to force re-read */
> > > +		data->valid = 0;
> > > +	}
> > If you use { } for the else branch, you should use { } for the if branch
> > as well.
> 
> checkpatch.pl says that I can, not that I have to. But I will if that
> makes you happy...
> 
Hi Jean,

mentioned in CodingStyle, really.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
