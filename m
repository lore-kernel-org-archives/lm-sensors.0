From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 14 Apr 2013 13:33:29 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (tmp401) Simplification and cleanup
Message-Id: <20130414133329.GA6610@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365210177-24656-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365210177-24656-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 14, 2013 at 02:51:58PM +0200, Jean Delvare wrote:
> On Sun, 14 Apr 2013 04:36:29 -0700, Guenter Roeck wrote:
> > On Sun, Apr 14, 2013 at 12:17:40PM +0200, Jean Delvare wrote:
> > > On Fri,  5 Apr 2013 18:02:55 -0700, Guenter Roeck wrote:
> > > > -static ssize_t store_temp_max(struct device *dev, struct device_attribute
> > > > -	*devattr, const char *buf, size_t count)
> > > > +static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
> > > > +			  const char *buf, size_t count)
> > > >  {
> > > > -	int index = to_sensor_dev_attr(devattr)->index;
> > > > +	int nr = to_sensor_dev_attr_2(devattr)->nr;
> > > > +	int index = to_sensor_dev_attr_2(devattr)->index;
> > > >  	struct tmp401_data *data = tmp401_update_device(dev);
> > > >  	long val;
> > > > -	u16 reg;
> > > > -
> > > > -	if (kstrtol(buf, 10, &val))
> > > > -		return -EINVAL;
> > > > +	u16 regval;
> > > 
> > > This name change is inconsistent, "reg" is used everywhere else.
> > > 
> > I know. Problem is that I need a "reg" or similar variable for the register
> > itself when adding tmp432 support, so I decided to go with regval for the
> > register value.
> > Got a better / different good name for the register variable ? 
> 
> If you use "reg" for the register value, you could use "regname" or
> "regaddr" for the register itself.
> 
I like regaddr.

Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
